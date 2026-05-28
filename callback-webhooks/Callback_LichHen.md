# Callback / Webhooks - Lịch hẹn

Mô tả dữ liệu mà đối tác nhận được khi hệ thống gửi callback liên quan đến lịch hẹn do chính đối tác tạo.

## Phạm vi dữ liệu

Chỉ truy cập những dữ liệu mà đối tác tạo ra.

## Cấu trúc payload callback

```json
{
  "callbackData": {
    "customerScheduleId": 456789,
    "licensePlates": "30A84812",
    "phone": "0382716917",
    "fullnameSchedule": "Nguyễn Văn A",
    "email": "user@example.com",
    "dateSchedule": "20260515",
    "time": "10:00",
    "notificationMethod": "SMS",
    "vehicleType": 1,
    "licensePlateColor": 1,
    "scheduleSerial": 1,
    "scheduleCode": "SCH-20260515-0001",
    "CustomerScheduleStatus": 3,
    "scheduleNote": "Ghi chú lịch hẹn",
    "scheduleType": 1,
    "scheduleHash": "abc123hash",
    "confirmStatus": 1,
    "scheduleTracking": "TRACKING_ID_001",
    "customerReceiptId": 789,
    "partnerName": "Đối tác A",
    "partnerTranID": "REQ_202605150001",
    "daySchedule": "20260515",
    "projectName": "Kiemdinhoto_StationServer",
    "createdAt": "2026-05-15T10:20:30.000Z",
    "updatedAt": "2026-05-15T10:20:40.000Z"
  }
}
```

## Dữ liệu callback

| Field | Type | Mô tả |
|---|---|---|
| customerScheduleId | number | Mã lịch hẹn (primary key) |
| licensePlates | string | Biển số xe đã đặt lịch |
| phone | string | Số điện thoại liên hệ |
| fullnameSchedule | string | Tên người đặt lịch |
| email | string | Email người dùng |
| dateSchedule | string | Ngày đặt lịch, định dạng YYYYMMDD |
| time | string | Giờ đặt lịch |
| notificationMethod | string | Kênh gửi thông báo |
| vehicleType | number | Loại phương tiện |
| licensePlateColor | number | Màu biển số |
| scheduleSerial | number | Số thứ tự lịch hẹn |
| scheduleCode | string | Mã định danh lịch hẹn |
| CustomerScheduleStatus | number | Trạng thái xử lý lịch hẹn |
| scheduleNote | string | Ghi chú cho lịch hẹn |
| scheduleType | number | Loại lịch hẹn |
| scheduleHash | string | Hash để xác thực lịch hẹn |
| confirmStatus | number | Trạng thái xác nhận |
| scheduleTracking | string | Mã theo dõi lịch hẹn |
| customerReceiptId | number | Mã hóa đơn liên quan |
| partnerName | string | Tên đối tác đặt lịch |
| partnerTranID | string | Mã giao dịch từ đối tác |
| daySchedule | string | Ngày đặt lịch (định dạng YYYYMMDD) dùng để sort |
| projectName | string | Tên hệ thống phát sinh bản ghi |
| createdAt | datetime | Thời điểm lịch hẹn được tạo |
| updatedAt | datetime | Thời điểm cập nhật gần nhất |

## Bảng liệt kê trạng thái

### CustomerScheduleStatus - Trạng thái xử lý lịch hẹn

| Giá trị | Mô tả |
|---|---|
| 0 | Chưa xác nhận |
| 10 | Đã xác nhận |
| 20 | Đã hủy |
| 30 | Đã đóng |

### scheduleType - Loại lịch hẹn

| Giá trị | Mô tả |
|---|---|
| 1 | Đăng kiểm xe cũ |
| 2 | Đăng ký dán thẻ EPASS |
| 3 | Nộp hồ sơ xe mới |
| 4 | Đổi mục đích sử dụng / đổi chủ / đổi thông tin hồ sơ |
| 5 | Thanh toán phí đường bộ |
| 7 | Đặt lịch tư vấn bảo dưỡng |
| 8 | Đặt lịch tư vấn bảo hiểm |
| 9 | Đặt lịch tư vấn hoán cải |
| 10 | Mất giấy đăng kiểm |
| 11 | Cấp lại tem đăng kiểm |
| 12 | Tư vấn đăng kiểm xe |
| 13 | Tư vấn xử lý phạt nguội |
| 14 | Tư vấn bảo hiểm TNDS xe ô tô |
| 15 | Tra cứu cảnh báo đăng kiểm |
| 16 | Hỗ trợ xử lý phạt nguội |
| 17 | Gia hạn định vị |
| 18 | Gia hạn phù hiệu xe kinh doanh |
| 19 | Gia hạn giấy tập huấn |
| 20 | Gia hạn camera hành trình |
| 21 | Đăng ký dán thẻ VETC |
| 22 | Gia hạn BH TNDS |
| 23 | Nộp hồ sơ xe mới (ngoài giờ hành chính) |
| 24 | Đăng kiểm xe (ngoài giờ hành chính) |
| 25 | Tư vấn bồi thường bảo hiểm |
| 26 | Tư vấn sức khỏe lái xe |
| 27 | Bán vé điện tử |

### vehicleType - Loại phương tiện

| Giá trị | Mô tả |
|---|---|
| 1 | Ô tô |
| 10 | Xe khác |
| 20 | Rơ moóc |

### licensePlateColor - Màu biển số

| Giá trị | Mô tả |
|---|---|
| 1 | Trắng |
| 2 | Xanh |
| 3 | Vàng |
| 4 | Đỏ |

### confirmStatus - Trạng thái xác nhận

| Giá trị | Mô tả |
|---|---|
| 0 | Chưa xác nhận |
| 1 | Đã xác nhận |
| 2 | Đã hủy |
