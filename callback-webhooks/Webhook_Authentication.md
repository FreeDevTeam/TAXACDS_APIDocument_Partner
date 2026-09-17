# Hướng dẫn xác thực Webhook Callback (Authentication Guide)

Tài liệu tích hợp dành cho Partner.

## 1. HTTP Headers

Mỗi callback POST gửi đến Partner đều kèm theo các header sau:

| Header | Kiểu | Mô tả |
|---|---|---|
| timestamp | string | Unix Epoch Milliseconds (UTC) tại thời điểm gửi. |
| nonce | string | Chuỗi ngẫu nhiên 16 ký tự, duy nhất cho mỗi request. Dùng để chống replay attack thay cho time window. |
| signature | string | HMAC-SHA256 của signingString, encode Hex lowercase (64 ký tự). |

## 2. Cách tính Signature

### 2.1 Công thức

Ghép 3 giá trị lại với nhau, dùng ký tự `|` làm separator:

```text
signingString = clientId + "|" + apiKey + "|" + timestamp + "|" + nonce
```

Sau đó tính HMAC-SHA256 với `secretKey` làm key mã hoá, encode kết quả sang Hex lowercase:

```text
signature = HMAC-SHA256(key = secretKey, message = signingString)   // hex lowercase
```

> **⚠️ Lưu ý:** Body KHÔNG tham gia vào `signingString`. Partner không cần đọc hay xử lý body để verify.

### 2.2 Thành phần

| Thành phần | Lấy từ | Ví dụ |
|---|---|---|
| clientId | Do hệ thống cấp riêng cho từng Partner | partner_abc123 |
| timestamp | Header timestamp | 1750000000000 |
| nonce | Header nonce | a3f9b2c1d4e5f607 |
| apiKey | Do hệ thống cấp riêng cho từng Partner | sk_live_xxxxx |
| secretKey | Do hệ thống cấp riêng cho từng Partner (dùng để mã hoá) | secret_live_xxxxx |

### 2.3 Ví dụ cụ thể

Giả sử Partner nhận được POST request với:

```text
timestamp: 1750000000000
nonce:     a3f9b2c1d4e5f607
signature: 7f4a2c9e1d3b...
Body:        {...}   // bất kỳ — không dùng để verify
```

Partner tự tính lại signature như sau:

```javascript
// Bước 1: Tạo signingString
signingString = "partner_abc123|sk_live_xxxxxxxxxxxxxxxxxxxx|1750000000000|a3f9b2c1d4e5f607"

// Bước 2: Tính HMAC-SHA256
secretKey = "sk_live_xxxxxxxxxxxxxxxxxxxx"   // lấy từ config
signature = HMAC-SHA256(secretKey, signingString)
          = "7f4a2c9e1d3b..."                // 64 ký tự hex

// Bước 3: So sánh với X-Signature nhận được
"7f4a2c9e1d3b..." === "7f4a2c9e1d3b..."  →  HỢP LỆ → trả 200
```

## 3. Xác thực phía Partner

Thực hiện đúng thứ tự 3 bước.
Fail bất kỳ bước nào → trả `401` ngay, không xử lý tiếp.

| # | Kiểm tra | Điều kiện fail → 401 |
|---|---|---|
| 1 | Timestamp | `\|now_ms − X-Timestamp\| > 300,000 ms`  (5 phút) |
| 2 | Nonce | nonce đã thấy trong 10 phút vừa qua (lưu cache/DB theo clientId) |
| 3 | Signature | Tính lại signature ≠ signature (so sánh constant-time) |

> **💡 Nonce cache:** lưu `key = "clientId:nonce"`, TTL = 10 phút. Dùng Redis `SET NX EX` hoặc DB unique constraint. Nếu `SET NX` trả false (key đã tồn tại) → nonce đã dùng → 401.

## 4. Code mẫu theo ngôn ngữ

### 4.1 Node.js

```javascript
const crypto = require('crypto');

function verifyWebhook(req) {
  const clientId  = getClientIdFromConfig();
  const timestamp = req.headers['timestamp'];
  const nonce     = req.headers['nonce'];
  const signature = req.headers['signature'];

  // Bước 1: Timestamp anti-replay (±5 phút)
  if (Math.abs(Date.now() - Number(timestamp)) > 300_000) return false;

  // Bước 2: Nonce chống replay
  if (await isNonceSeen(clientId, nonce)) return false;
  await markNonceSeen(clientId, nonce, ttlMs=600_000);

  // Bước 3: Lookup apiKey, secretKey và verify signature
  const secretKey  = getSecretKeyByClientId(clientId);
  if (!secretKey) return false;

  const signingStr = clientId + '|' + apiKey + '|' + timestamp + '|' + nonce;
  const expected   = crypto.createHmac('sha256', secretKey)
                          .update(signingStr, 'utf8')
                          .digest('hex');

  return crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(signature));
}
```

## 5. HTTP Response

Partner phải trả về đúng HTTP status code theo bảng sau:

| Status | Khi nào | Hành vi hệ thống |
|---|---|---|
| 200 OK | Xác thực OK, xử lý thành công | Ghi nhận. Không retry. |
| 401 | Xác thực thất bại | Ghi log. Retry có giới hạn. |
| 500 | Lỗi nội bộ phía Partner | Retry exponential backoff. |

## 6. Lỗi thường gặp & cách fix

| Triệu chứng | Nguyên nhân | Fix |
|---|---|---|
| Signature luôn sai dù key đúng | Dùng sai separator hoặc sai thứ tự | Đảm bảo đúng: `clientId\|apiKey\|timestamp\|nonce` (ký tự `\|` ASCII 0x7C) |
| Signature đúng nhưng vẫn 401 | Timestamp lệch > 5 phút | Sync NTP, đảm bảo server time chính xác |
| Nonce bị reject liên tục | TTL cache quá ngắn hoặc nonce bị trùng khi retry | Tăng TTL lên 10 phút; hệ thống không retry với cùng nonce |
| Signature sai khi có ký tự đặc biệt | Encoding không nhất quán | Dùng UTF-8 cho toàn bộ chuỗi khi tính HMAC |

## 7. Lưu ý bảo mật

- 🔑 **secretKey server-side only** — secretKey chỉ tồn tại server-side — không để lộ ra client, mobile, hay log.
- ⏱️ **Constant-time comparison** — Luôn dùng hàm so sánh constant-time (`timingSafeEqual` / `hash_equals` / `MessageDigest.isEqual`) — không dùng `==` hay `===` để tránh Timing Attack.
- 🔒 **HTTPS bắt buộc** — Callback endpoint phải dùng HTTPS. Từ chối mọi request qua HTTP thuần.
- 🎲 **Nonce duy nhất** — Nonce phải là chuỗi ngẫu nhiên đủ entropy (≥ 16 ký tự hex). Hệ thống đảm bảo mỗi request dùng nonce khác nhau — Partner lưu và kiểm tra phía mình.
- 🔄 **Rotate secretKey** — Rotate secretKey ngay khi nghi ngờ bị lộ, liên hệ để được cấp key mới.
- 🚫 **Anti-replay** — Cửa sổ 5 phút timestamp kết hợp nonce cache bảo vệ toàn diện chống replay attack — không mở rộng time window.
