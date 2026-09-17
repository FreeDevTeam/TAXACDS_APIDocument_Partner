# Partner API - Webhook thông báo thuế

> **⚠️ QUAN TRỌNG:** Tất cả callback POST từ TaxCDS đến Partner đều phải được xác thực. Đọc [Hướng dẫn xác thực Webhook Callback (Authentication Guide)](../../callback-webhooks/Webhook_Authentication.md) để cấu hình và kiểm tra chữ ký.

Webhook được sử dụng để gửi thông báo thuế từ hệ thống TaxCDS đến hệ thống của Partner.

Khi có thông báo thuế cần gửi, TaxCDS sẽ chủ động thực hiện HTTP POST tới Webhook URL do Partner cung cấp.

[Về module TaxCDS](./index.html)

---

## Endpoint

| Thuộc tính | Giá trị |
|---|---|
| URL | Webhook URL do Partner cung cấp |
| Method | `POST` |

Partner cần cung cấp HTTPS endpoint có khả năng nhận HTTP POST từ TaxCDS.

---

## Body schema

Dữ liệu webhook gồm 3 object cấp cao nhất: `customerData`, `serviceData` và `callbackData`.

| Field | Type | Required | Rule | Mô tả |
|---|---|---|---|---|
| customerData | object | Yes | Object | Thông tin định danh người nộp thuế |
| customerData.customerIdentifier | string | Yes | Mã số thuế | Mã số thuế của người nhận thông báo |
| serviceData | object | Yes | Có thể là object rỗng | Thông tin dịch vụ liên quan; chưa có dữ liệu thì gửi `{}` |
| callbackData | object | Yes | Object | Dữ liệu thông báo thuế |
| callbackData.taxCDSTaxNotificationId | number | No | Số nguyên | ID thông báo thuế |
| callbackData.taxNotiNotificationCode | string | No | Có thể rỗng | Mã thông báo |
| callbackData.taxNotiTitle | string | No | Có thể rỗng | Tiêu đề thông báo |
| callbackData.taxNotiContent | string | No | Có thể rỗng | Nội dung thông báo |
| callbackData.taxNotiMetadata | string | No | Có thể rỗng | Metadata bổ sung của thông báo |
| callbackData.taxNotiDocumentCode | string | No | Có thể rỗng | Mã văn bản của cơ quan thuế |
| callbackData.taxNotiDocumentTitle | string | No | Có thể rỗng | Tiêu đề văn bản |
| callbackData.taxNotiPayerIdentity | string | No | CCCD/CMND | Số định danh của người nộp thuế |
| callbackData.taxNotiPayerTaxCode | string | No | Mã số thuế | Mã số thuế của người nộp thuế |
| callbackData.taxNotiPayerPhone | string | No | Có thể rỗng | Số điện thoại người nộp thuế |
| callbackData.taxNotiPayerEmail | string | No | Có thể rỗng | Email người nộp thuế |
| callbackData.taxNotiPayerName | string | No | Có thể rỗng | Tên người nộp thuế |
| callbackData.taxNotiNotificationDate | string | No | Datetime | Ngày ban hành thông báo |
| callbackData.taxNotiIssuingAuthority | string | No | Có thể rỗng | Cơ quan thuế ban hành thông báo |
| callbackData.taxNotiTaxPeriod | string | No | Có thể rỗng | Kỳ thuế |
| callbackData.taxNotiGuidanceAuthority | string | No | Có thể rỗng | Cơ quan thuế hướng dẫn |
| callbackData.taxNotiPICUnit | string | No | Có thể rỗng | Đơn vị phụ trách |
| callbackData.taxNotiPICName | string | No | Có thể rỗng | Người phụ trách |
| callbackData.taxNotiPICAddress | string | No | Có thể rỗng | Địa chỉ liên hệ |
| callbackData.taxNotiPICPhone | string | No | Có thể rỗng | Số điện thoại liên hệ |
| callbackData.taxNotiPICEmail | string | No | Có thể rỗng | Email liên hệ |
| callbackData.taxNotiDataClosingTime | string | No | Datetime | Thời điểm chốt dữ liệu |
| callbackData.taxNotiType | string | No | TB001 - TB008 | Loại thông báo thuế |
| callbackData.createdAt | string | No | Datetime | Thời điểm tạo dữ liệu |
| callbackData.updatedAt | string | No | Datetime | Thời điểm cập nhật dữ liệu |

---

## Sample Request

```bash
curl --location 'https://partner.example.com/webhooks/tax-notification' \
  --header 'Content-Type: application/json' \
  --header 'timestamp: 1787191200000' \
  --header 'nonce: a3f9b2c1d4e5f607' \
  --header 'signature: 0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef' \
  --data '{
  "customerData": {
    "customerIdentifier": "0319998888"
  },
  "serviceData": {},
  "callbackData": {
    "taxCDSTaxNotificationId": 999999,
    "taxNotiNotificationCode": "TAXCDS-NOTI-0001",
    "taxNotiTitle": "Thông báo về Tiền thuế nợ",
    "taxNotiContent": "Anh (chị) có một Thông báo về Tiền thuế nợ (mẫu 01/TTN)",
    "taxNotiDocumentCode": "123/TB-CQT",
    "taxNotiDocumentTitle": "Thông báo về Tiền thuế nợ",
    "taxNotiPayerIdentity": "079999999999",
    "taxNotiPayerTaxCode": "0319998888",
    "taxNotiPayerName": "Nguyễn Văn A",
    "taxNotiNotificationDate": "2026-08-18 00:00:00",
    "taxNotiIssuingAuthority": "Thuế cơ sở Y",
    "taxNotiTaxPeriod": "2025",
    "taxNotiGuidanceAuthority": "Thuế cơ sở Y",
    "taxNotiPICUnit": "Tổ Quản lý hộ kinh doanh số X",
    "taxNotiPICName": "Nguyễn Văn B",
    "taxNotiPICEmail": "developer@example.com",
    "taxNotiDataClosingTime": "2026-08-18 17:30:00",
    "taxNotiType": "TB005"
  }
}'
```

---

## Success response

Khi Partner xác thực và xử lý webhook thành công, Partner trả:

```text
200 OK
```

Ví dụ response:

```json
{
  "success": true
}
```

Nội dung response có thể phụ thuộc vào hệ thống Partner. TaxCDS sử dụng kết quả HTTP response để ghi nhận kết quả gửi webhook.

---

## Mã lỗi

| HTTP | Mã lỗi | Mô tả |
|---|---|---|
| 200 | — | Partner xác thực và xử lý webhook thành công |
| 401 | — | Partner từ chối request do timestamp, nonce hoặc signature không hợp lệ |
| 500 | — | Hệ thống Partner gặp lỗi trong quá trình xử lý webhook |

---

## Tham khảo

- [Quy chuẩn chung → Common Error](../../Common.html#common-error) — tham khảo quy chuẩn lỗi chung của hệ thống.

---

## Data test cho developer

- Webhook URL: `https://partner.example.com/webhooks/tax-notification`
- clientId: sử dụng credential môi trường test do TaxCDS cấp
- apiKey: sử dụng credential môi trường test do TaxCDS cấp
- secretKey: sử dụng credential môi trường test do TaxCDS cấp
- customerData.customerIdentifier: `0319998888`
- serviceData: `{}`
- taxNotiPayerIdentity: `079999999999`
- taxNotiPayerTaxCode: `0319998888`
- taxNotiType: `TB005`

Cần thay bằng dữ liệu môi trường thật khi tích hợp.