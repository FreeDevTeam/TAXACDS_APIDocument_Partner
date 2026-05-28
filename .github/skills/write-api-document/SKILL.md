---
name: write-api-document
description: "Dùng khi tạo mới hoặc cập nhật tài liệu HTML cho API. Trigger keywords: viết tài liệu API, tạo tài liệu HTML API, html api doc, document api, cập nhật tài liệu API."
---

# Write API Document

## Khi nào dùng skill này

- Tạo mới trang HTML tài liệu cho một hoặc nhiều API endpoint
- Cập nhật tài liệu khi route/validator/manager/response thay đổi

---

## Mandatory Inputs

Trước khi viết, thu thập đủ 4 input sau bằng cách đọc file thực tế trong repo:

1. **Route file** — endpoint URL, HTTP method, auth pre-function, header schema, body schema
2. **Manager file** — success response shape, các error code thực sự được `throw`
3. **Constants file** — đọc file constant chứa error codes (ví dụ `OrderConstant_Partner.js`) để liệt kê đúng bảng mã lỗi của API.

> Không suy diễn field hoặc error code không có trong code. Không ghi thông tin không tồn tại trong source.

---

## Cấu trúc thư mục tài liệu

```
document/Kiemdinhoto_APIDocument_Partner/
  Common.html                          ← trang quy chuẩn chung các error codes và các constant chung
  index.html / index.md                ← root index
  template/
    api-doc-template.html              ← template gốc, COPY từ đây khi tạo API doc mới
  modules/
    {ModuleName}/
      index.html / index.md            ← index của module
      {ModuleName}_{ApiName}.html      ← tài liệu từng API
```

**File đặt tên theo quy tắc:** `{ModuleName}_{ApiName}.html` — ví dụ: `PartnerOrder_PaymentConfirmBatch.html`

---

## Workflow

### Bước 1 — Đọc source code

```
Route file     → endpoint URL, method, auth pre-function
Joi validator  → field list, type, required, rules
Manager file   → response shape, throw error codes
Constants file → full list of error codes
```

### Bước 2 — Copy template

Copy `document/Kiemdinhoto_APIDocument_Partner/template/api-doc-template.html` làm file mới.  
Thay toàn bộ placeholder `{...}` bằng giá trị thực.

### Bước 3 — Viết 9 card theo thứ tự cố định

| # | Card | Nội dung |
|---|------|---------|
| 1 | **Header** | `<h1>Partner API - {API_NAME}</h1>`, short description, link `./index.html` |
| 2 | **Endpoint** | URL + Method. **Chỉ 2 row này.** Không thêm Auth, không thêm Batch size |
| 3 | **Headers schema** | Bảng 3 cột: Header \| Required \| Mô tả. Luôn có 2 row: `clientId/clientid` và `apiKey/apikey` |
| 4 | **Body schema** | Bảng 5 cột: Field \| Type \| Required \| Rule \| Mô tả. Mỗi field một row, kể cả nested dạng `items[].fieldName` |
| 5 | **Sample Request** | `<h2>` kèm nút copy icon SVG. `<pre id="curlText">` chứa curl mẫu với data test thực  |
| 6 | **Success response** | `<pre>` chứa JSON response mẫu đầy đủ |
| 7 | **Mã lỗi** | Bảng 3 cột: HTTP \| Mã lỗi \| Mô tả (xem quy tắc HTTP status bên dưới) |
| 8 | **Tham khảo** | Luôn có link `Common.html#common-error`; nếu API có `paymentStatus` thêm link `Common.html#payment-status` |
| 9 | **Data test cho developer** | Liệt kê test credentials + sample IDs; kết thúc bằng note "Cần thay bằng dữ liệu môi trường thật" |

### Bước 4 — Cập nhật index module

- Nếu `modules/{ModuleName}/index.html` chưa có entry cho API mới → thêm vào
- Nếu `modules/{ModuleName}/index.md` chưa có entry → thêm vào
- Kiểm tra root `index.html` / `index.md` có link tới module index chưa

### Bước 5 - Hoàn thiện
- Kiểm tra lại toàn bộ checklist ở phần dưới trước khi hoàn thành
- Sửa file MD nếu có hoặc bổ sung file MD nếu chưa có, nhưng ưu tiên chỉnh HTML trước vì file MD chỉ là bản mirror đơn giản của HTML.
---

## Quy tắc HTTP Status trong bảng Mã lỗi

| HTTP | Khi nào | Mã lỗi |
|------|---------|--------|
| **400** | Joi validation fail (Hapi xử lý trước manager) | `Validation Error` (dùng `<em>`) |
| **429** | Auth pre-function fail (apiKey sai / hết quota) | `QUOTA_EXCEEDED` |
| **500** | Mọi error được `throw` trong manager | Liệt kê từng code từ constants file |

- Luôn thêm row `500 / UNKNOWN_ERROR` là fallback cuối cùng
- Thứ tự row: 400 → 429 → 500 (theo thứ tự business errors) → 500 UNKNOWN_ERROR

---

## Conventions quan trọng

### Không lộ thông tin kỹ thuật nội bộ
Tài liệu này dành cho đối tác external. **Tuyệt đối không ghi:**
- Đường dẫn file source (ví dụ: `API/Order/OrderConstant_Partner.js`)
- Tên hàm/middleware nội bộ (ví dụ: `verifyApiKeyOrAdvanceUserToken`, `responsePartner.js`)
- Tên constant nội bộ (ví dụ: `PARTNER_ORDER_ERROR`, `ORDER_PAYMENT_STATUS.NEW`)
- Prefix "Nguồn: ..." trong nội dung hiển thị

### Sample Request card
- Tiêu đề là `<h2 style="display:flex;align-items:center;gap:8px;">Sample Request <button id="copySampleBtn" ...>` kèm SVG clipboard icon
- Không tạo nút "Copy cURL" hay "Tải file MD" riêng biệt
- Click copy → hiển thị Toast "Sao chép thành công" (auto-hide sau 2000ms)
- `<div id="toast">` đặt ngay trước `</body>`

### Script
Chỉ một event handler, không thêm bất cứ JS nào khác:
```js
const copySampleBtn = document.getElementById('copySampleBtn');
const curlText = document.getElementById('curlText').textContent;
copySampleBtn.addEventListener('click', async () => {
  await navigator.clipboard.writeText(curlText);
  const toast = document.getElementById('toast');
  toast.classList.add('show');
  setTimeout(() => toast.classList.remove('show'), 2000);
});
```

### Không ghi production secret
Chỉ dùng test key/clientId do user cung cấp. Không bao giờ dùng key production.

---

## Quality Checklist

Trước khi hoàn thành, kiểm tra toàn bộ:

- [ ] Không còn placeholder `{...}` chưa được thay
- [ ] 9 card đúng thứ tự, tên đúng
- [ ] Card Endpoint: đúng 2 row (URL, Method). Không có row Auth, không có Batch size
- [ ] Card Headers schema: tách riêng, có 2 row `clientId` và `apiKey`
- [ ] Card Body schema: bảng đủ 5 cột, mỗi field một row kể cả nested
- [ ] Card Sample Request: `<h2>` kèm nút icon, `<pre id="curlText">`, data test thực tế
- [ ] Card Mã lỗi: bảng 3 cột, 400 + 429 + 500s + UNKNOWN_ERROR, không có source reference
- [ ] Card Tham khảo: link `Common.html#common-error` (bắt buộc), link `Common.html#payment-status` (nếu có `paymentStatus`)  
- [ ] Script: chỉ xử lý `copySampleBtn` → toast "Sao chép thành công"
- [ ] Không lộ đường dẫn file, tên hàm, tên constant nội bộ trong nội dung hiển thị
- [ ] Giá trị `paymentStatus` trong curl đúng case (`"Success"` không phải `"SUCCESS"`)
- [ ] Index module đã được cập nhật
- [ ] Không dùng data production

---

## File tham chiếu

- **Template**: `document/Kiemdinhoto_APIDocument_Partner/template/api-doc-template.html`
- **Ví dụ chuẩn**: `document/Kiemdinhoto_APIDocument_Partner/modules/Order/PartnerOrder_PaymentConfirmBatch.html`
- **Trang quy chuẩn chung**: `document/Kiemdinhoto_APIDocument_Partner/Common.html`
