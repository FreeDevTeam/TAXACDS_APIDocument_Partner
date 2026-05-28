# Callback / Webhooks - Gói dịch vụ thông báo

Mô tả dữ liệu đối tác nhận được khi hệ thống gửi callback liên quan đến gói dịch vụ thông báo mà đối tác đã bán hoặc khởi tạo.

## Phạm vi dữ liệu

Chỉ truy cập những dữ liệu mà đối tác tạo ra.

## Cấu trúc payload callback

```json
{
  "callbackData": {
    "appUserVehicleNotifyInfoId": 8888,
    "partnerTranID": "REQ_202605150001",
    "partnerName": "Đối tác A",
    "notifyType": 1,
    "notifyMethod": "SMS",
    "notifyStartDate": "20260515",
    "notifyEndDate": "20260614",
    "notifyStartDateTime": "2026-05-15 00:00:00",
    "notifyEndDateTime": "2026-06-14 23:59:59",
    "isAvailable": 1,
    "allowRenew": 1,
    "notifyNote": "Gói dịch vụ thông báo",
    "notifyInterval": 1,
    "latestViolationStatus": 0,
    "lastCheckedAt": "2026-05-15 10:30:00",
    "notifyProcessStatus": "SUCCESS",
    "intervalViolation": 1,
    "intervalNoViolation": 7,
    "lastNotifyAt": "2026-05-15 10:30:00",
    "lastNotifyViolationAt": null,
    "lastNotifyNoViolationAt": "2026-05-15 10:30:00",
    "projectName": "Kiemdinhoto_StationServer"
  }
}
```

## Dữ liệu callback

| Field | Type | Mô tả |
|---|---|---|
| appUserVehicleNotifyInfoId | number | Mã gói dịch vụ thông báo |
| partnerTranID | string | Mã giao dịch do đối tác gửi khi tạo mua gói |
| partnerName | string | Tên đối tác phát sinh dữ liệu |
| notifyType | number | Loại cảnh báo |
| notifyMethod | string | Kênh gửi thông báo |
| notifyStartDate | string | Ngày bắt đầu hiệu lực gói, định dạng YYYYMMDD |
| notifyEndDate | string | Ngày kết thúc hiệu lực gói, định dạng YYYYMMDD |
| notifyStartDateTime | datetime | Thời điểm bắt đầu hiệu lực gói |
| notifyEndDateTime | datetime | Thời điểm kết thúc hiệu lực gói |
| isAvailable | number | Trạng thái hiệu lực gói |
| allowRenew | number | Trạng thái cho phép gia hạn |
| notifyNote | string | Nội dung ghi chú của gói cảnh báo |
| notifyInterval | number | Tần suất gửi hoặc kiểm tra cảnh báo tổng quát |
| latestViolationStatus | number | Trạng thái vi phạm gần nhất của phương tiện |
| lastCheckedAt | datetime | Thời điểm kiểm tra gần nhất |
| notifyProcessStatus | string | Trạng thái xử lý gửi thông báo gần nhất |
| intervalViolation | number | Tần suất gửi khi có vi phạm |
| intervalNoViolation | number | Tần suất gửi khi không có vi phạm |
| lastNotifyAt | datetime | Thời điểm gửi thông báo gần nhất |
| lastNotifyViolationAt | datetime\|null | Thời điểm gửi gần nhất trong trường hợp có vi phạm |
| lastNotifyNoViolationAt | datetime\|null | Thời điểm gửi gần nhất trong trường hợp không có vi phạm |
| projectName | string | Tên hệ thống phát sinh bản ghi |

## Bảng liệt kê trạng thái

### notifyType - Loại cảnh báo

| Giá trị | Mô tả |
|---|---|
| 1 | Thông báo tự động vi phạm phạt nguội |

### notifyMethod - Kênh gửi thông báo

| Giá trị | Mô tả |
|---|---|
| SMS | Tin nhắn SMS |
| Email | Thư điện tử |
| ZNS | Zalo Notification Service |

### notifyProcessStatus - Trạng thái xử lý

| Giá trị | Mô tả |
|---|---|
| NO_STATION_SAVE_NOTIFY | Trạm chưa lưu thông báo |
| ALREADY_SENT_TODAY | Hôm nay đã gửi |
| NOT_IN_NOTIFY_FREQUENCY | Không đúng tuần xuất |
| SEND_NOTIFY_FAILED | Gửi thông báo thất bại |
| USER_NOT_FOUND | Người dùng không tồn tại |
| VEHICLE_NOT_FOUND | Phương tiện không tồn tại |
| PRODUCT_NOT_FOUND | Sản phẩm không tồn tại |

### isAvailable - Trạng thái hiệu lực gói

| Giá trị | Mô tả |
|---|---|
| 1 | Còn hiệu lực |
| 0 | Hết hiệu lực |

### allowRenew - Trạng thái cho phép gia hạn

| Giá trị | Mô tả |
|---|---|
| 1 | Cho phép gia hạn |
| 0 | Không cho phép gia hạn |
