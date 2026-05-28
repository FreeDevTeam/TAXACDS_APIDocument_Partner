# Partner API - Order Payment Confirm Batch

API xác nhận thanh toán hàng loạt đơn hàng của đối tác. Hỗ trợ tối đa 100 đơn hàng trong một yêu cầu.

[Về module Order](./index.html)

---

## Endpoint

| | |
|---|---|
| URL | /PartnerAPI/Order/paymentConfirmBatch |
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
| items | array | Yes | min 1, max 100 | Danh sách đơn hàng cần xác nhận thanh toán |
| items[].requestId | string | Yes | bắt buộc | Mã định danh duy nhất cho yêu cầu (idempotency key) |
| items[].orderId | string | Yes | bắt buộc | Mã đơn hàng cần xác nhận |
| items[].amount | integer | Yes | >= 1 | Số tiền thanh toán (đơn vị: VNĐ) |
| items[].paymentStatus | string | Yes | bắt buộc | Trạng thái thanh toán. Xem danh sách hợp lệ tại [Quy chuẩn chung → Order Payment Status](../../Common.html#payment-status). |

---

## Sample Request

```bash
curl --location '{HOST_NAME}/PartnerAPI/Order/paymentConfirmBatch' \
  --header 'Content-Type: application/json' \
  --header 'clientId: TESTCLIENT' \
  --header 'apiKey: 07e73e61-0dce-4b39-8ecf-06ef70b35c08' \
  --data '{
    "items": [
      {
        "requestId": "TEST_REQ_CONFIRM_PAYMENT_001",
        "orderId": "TEST_ORDER_PARTNER_PENDING_001",
        "amount": 91000,
        "paymentStatus": "Success"
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
      "requestId": "TEST_REQ_CONFIRM_PAYMENT_001",
      "status": "00"
    }
  ]
}
```

Trường `status` theo chuẩn [Quy chuẩn chung → Partner Order Error Code](../../Common.html#order-error-code): `"00"` = thành công, các giá trị khác = thất bại kèm trường `error`.

**Response khi item gặp lỗi (vẫn trả HTTP 200):**

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Success",
  "data": [
    {
      "index": 0,
      "orderId": "TEST_ORDER_PARTNER_PAID_001",
      "requestId": "TEST_REQ_CONFIRM_PAYMENT_001",
      "status": "04",
      "error": "ALREADY_PAID"
    }
  ]
}
```

---

## Mã lỗi

**Lỗi cấp batch (trả HTTP khác 200):**

| HTTP | Mã lỗi | errorCode | Mô tả |
|---|---|---|---|
| 400 | _Validation Error_ | — | Payload không đúng schema (thiếu field bắt buộc, sai kiểu, vượt giới hạn). |
| 429 | `QUOTA_EXCEEDED` | — | apiKey không hợp lệ, không tồn tại, hoặc vượt quota. |
| 500 | `UNKNOWN_ERROR` | `99` | Lỗi không xác định. |

**Lỗi cấp item (trả HTTP 200, mỗi item trong `data` có `status` và `error`):**

| status | error | Mô tả |
|---|---|---|
| `00` | (không có) | Xác nhận thành công. |
| `03` | `ORDER_NOT_FOUND` | Không tìm thấy đơn hàng theo `orderId` đã cung cấp. |
| `04` | `ALREADY_PAID` | Đơn hàng đã xử lý, không thể xác nhận lại. |
| `05` | `AMOUNT_MISMATCH` | Số tiền trong request không khớp với tổng tiền của đơn hàng. |
| `06` | `INVALID_ORDER` | Đơn hàng đã bị hủy. |
| `99` | `SYSTEM_ERROR` | Lỗi hệ thống khi xử lý item. |

---

## Tham khảo

- [Quy chuẩn chung → Common Error](../../Common.html#common-error) — danh sách mã lỗi hệ thống trả về trong trường `error`.
- [Quy chuẩn chung → Partner Order Error Code](../../Common.html#order-error-code) — bảng mã số `errorCode` đi kèm response lỗi.
- [Quy chuẩn chung → Order Payment Status](../../Common.html#payment-status) — danh sách giá trị hợp lệ của trường `paymentStatus`.

---

## Data test cho developer

- requestId: TEST_REQ_CONFIRM_PAYMENT_001
- orderId hợp lệ: TEST_ORDER_PARTNER_PENDING_001
- amount hợp lệ: 91000

Cần thay bằng dữ liệu môi trường thật khi tích hợp.
