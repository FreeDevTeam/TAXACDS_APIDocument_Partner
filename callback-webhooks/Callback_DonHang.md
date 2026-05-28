# Callback / Webhooks - Đơn hàng

Mô tả dữ liệu đối tác nhận được khi hệ thống gửi callback về trạng thái và thông tin thanh toán của đơn hàng do đối tác tạo.

## Phạm vi dữ liệu

Chỉ truy cập những dữ liệu mà đối tác tạo ra.

## Cấu trúc payload callback

```json
{
  "callbackData": {
    "orderId": 123456,
    "orderRefId": "REQ_202605150001",
    "orderName": "Đơn mua gói dịch vụ",
    "orderCode": "ORD-20260515-0001",
    "orderStatus": 3,
    "paymentStatus": "Success",
    "subTotalAmount": 91000,
    "discountAmount": 0,
    "taxAmount": 0,
    "totalAmount": 91000,
    "paidAmount": 91000,
    "extraFee": 0,
    "paymentMethodType": 13,
    "orderType": 1,
    "orderCategory": 1,
    "salesChannel": "TAMOVE",
    "orderPaymentTime": "2026-05-15 10:20:30",
    "orderPaymentInfo": "{...}",
    "createdAt": "2026-05-15T10:20:30.000Z",
    "updatedAt": "2026-05-15T10:20:40.000Z"
  }
}
```

## Dữ liệu callback

| Field | Type | Mô tả |
|---|---|---|
| orderId | number | Mã đơn hàng nội bộ |
| orderRefId | string | Mã đơn hàng/phiên giao dịch do đối tác gửi sang |
| orderName | string | Tên hiển thị của đơn hàng |
| orderCode | string | Mã định danh đơn hàng |
| orderStatus | number | Trạng thái xử lý đơn hàng |
| paymentStatus | string | Trạng thái thanh toán của đơn hàng |
| subTotalAmount | number | Tổng tiền trước thuế và giảm giá |
| discountAmount | number | Số tiền được giảm |
| taxAmount | number | Tiền thuế của đơn hàng |
| totalAmount | number | Tổng tiền cần thanh toán |
| paidAmount | number | Số tiền đã thanh toán |
| extraFee | number | Phụ phí phát sinh (nếu có) |
| paymentMethodType | number | Loại phương thức thanh toán |
| orderType | number | Loại đơn hàng |
| orderCategory | number | Nhóm phân loại đơn hàng |
| salesChannel | string | Kênh phát sinh đơn hàng |
| orderPaymentTime | datetime | Thời điểm thanh toán gần nhất |
| orderPaymentInfo | string | Thông tin thanh toán chi tiết |
| createdAt | datetime | Thời điểm bản ghi đơn hàng được tạo |
| updatedAt | datetime | Thời điểm cập nhật gần nhất |

## Bảng liệt kê trạng thái

### orderStatus - Trạng thái xử lý đơn hàng

| Giá trị | Tên | Mô tả |
|---|---|---|
| 0 | Chưa xác nhận | Đơn hàng mới được tạo |
| 10 | Đã xác nhận | Đơn hàng được xác nhận |
| 20 | Đã hủy | Đơn hàng bị hủy |
| 30 | Đã đóng | Đơn hàng hoàn thành |
| 40 | Đang xử lý | Đơn hàng đang được xử lý |

### paymentStatus - Trạng thái thanh toán

| Giá trị | Mô tả |
|---|---|
| New | Tạo mới |
| Processing | Đang xử lý thanh toán |
| Pending | Đang chờ thanh toán |
| Failed | Thanh toán thất bại |
| Success | Thanh toán thành công |
| Canceled | Đã hủy đơn hàng |

### orderType - Loại đơn hàng

| Giá trị | Mô tả |
|---|---|
| 1 | Kiểm định phương tiện |
| 2 | Thông báo tự động vi phạm phạt nguội |
| 3 | Thanh toán tiền tip |
| 4 | Đơn hàng thử nghiệm |
| 6 | Bảo hiểm TNDS Xe máy |
| 7 | Bảo hiểm TNDS Ô tô |
| 8 | Bảo hiểm Thân vỏ Ô tô |
| 9 | Đơn hàng từ bên ngoài |

### orderCategory - Phân loại đơn hàng

| Giá trị | Mô tả |
|---|---|
| 1 | Đơn hàng bình thường |
| 2 | Đơn hàng có các sản phẩm được tặng |
