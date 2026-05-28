# Partner API - Order Query Order Batch

Truy vấn thông tin chi tiết nhiều đơn hàng trong một request (tối đa 100 đơn).

[Về module Order](./index.html)

---

## Endpoint

| | |
|---|---|
| URL | /PartnerAPI/Order/queryOrderBatch |
| Method | POST |

---

## Headers schema

| Header | Required | Mô tả |
|---|---|---|
| clientId hoặc clientid | Yes | Mã định danh đối tác |
| apiKey hoặc apikey | Yes | Khóa xác thực API của đối tác |

---

## Body schema

| Field | Type | Required | Rule | Mô tả |
|---|---|---|---|---|
| items | array | Yes | min 1, max 100 | Danh sách đơn hàng cần truy vấn |
| items[].requestId | string | No | — | Mã định danh request từ phía đối tác (tuỳ chọn) |
| items[].orderId | string | Yes | — | Mã đơn hàng cần truy vấn |
| items[].amount | integer | Yes | >= 1 | Tổng tiền đơn hàng (dùng để xác thực khớp với hệ thống) |

---

## Sample Request

```bash
curl --location '{HOST_NAME}/PartnerAPI/Order/queryOrderBatch' \
  --header 'Content-Type: application/json' \
  --header 'clientId: TESTCLIENT' \
  --header 'apiKey: 07e73e61-0dce-4b39-8ecf-06ef70b35c08' \
  --data '{
    "items": [
      {
        "requestId": "TEST_REQ_QUERY_ORDER_001",
        "orderId": "TEST_ORDER_PARTNER_PENDING_001",
        "amount": 91000
      }
    ]
  }'
```

---

## Success response

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Success",
  "data": [
    {
      "index": 0,
      "orderId": "TEST_ORDER_PARTNER_PENDING_001",
      "totalAmount": 91000,
      "discountAmount": 0,
      "taxAmount": 0,
      "paymentStatus": "New",
      "createdAt": "2026-01-01T00:00:00.000Z",
      "phoneNumber": "0900000001",
      "firstName": "Test User",
      "orderItems": [
        {
          "orderItemName": "[E2E-ORDER-PARTNER] Item #1 for queryOrderBatch detail check",
          "quantity": 1,
          "payAmount": 45500
        },
        {
          "orderItemName": "[E2E-ORDER-PARTNER] Item #2 for queryOrderBatch detail check",
          "quantity": 1,
          "payAmount": 45500
        }
      ]
    }
  ]
}
```

---

## Mã lỗi

| HTTP | Mã lỗi | errorCode | Mô tả |
|---|---|---|---|
| 400 | _Validation Error_ | — | Payload không đúng schema (thiếu field bắt buộc, sai kiểu, vượt giới hạn). |
| 429 | `QUOTA_EXCEEDED` | — | apiKey không hợp lệ hoặc vượt quota. |
| 500 | `ORDER_NOT_FOUND` | `03` | Không tìm thấy đơn hàng theo `orderId` đã cung cấp. |
| 500 | `AMOUNT_MISMATCH` | `05` | Số tiền trong request không khớp với tổng tiền của đơn hàng. |
| 500 | `INVALID_BATCH_PAYLOAD` | `02` | Cấu trúc batch không hợp lệ. |
| 500 | `UNKNOWN_ERROR` | `99` | Lỗi không xác định. |

Cấu trúc response lỗi (ví dụ `ORDER_NOT_FOUND`):

```json
{
  "statusCode": 500,
  "error": "ORDER_NOT_FOUND",
  "message": "An internal server error occurred",
  "errorCode": "03"
}
```

---

## Tham khảo

- [Quy chuẩn chung → Common Error](../../Common.html#common-error) — danh sách mã lỗi hệ thống trả về trong trường `error`.
- [Quy chuẩn chung → Partner Order Error Code](../../Common.html#order-error-code) — bảng mã số `errorCode` đi kèm response lỗi.
- [Quy chuẩn chung → Order Payment Status](../../Common.html#payment-status) — danh sách giá trị hợp lệ của trường `paymentStatus`.

---

## Data test cho developer

- requestId: TEST_REQ_QUERY_ORDER_001
- orderId (happy): TEST_ORDER_PARTNER_PENDING_001
- orderId (not found): TEST_ORDER_PARTNER_NOT_FOUND_001
- amount (happy): 91000
- amount (mismatch): 12345

Cần thay bằng dữ liệu môi trường thật khi tích hợp.
