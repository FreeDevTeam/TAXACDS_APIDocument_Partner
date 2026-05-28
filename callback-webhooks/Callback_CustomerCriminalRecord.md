# Callback / Webhooks - Dữ liệu vi phạm

Mô tả dữ liệu mà đối tác nhận được khi hệ thống gửi callback liên quan đến bản ghi vi phạm của phương tiện.

## Phạm vi dữ liệu

Chỉ truy cập những dữ liệu vi phạm được ghi nhận cho phương tiện mà đối tác có liên quan.

## Cấu trúc payload callback

```json
{
  "callbackData": {
    "customerCriminalRecordId": 123456,
    "customerRecordPlatenumber": "30A84812",
    "customerRecordPlateColor": 2,
    "customerRecordPlateColorDesc": "Xanh",
    "vehicleType": 1,
    "crimeRecordContent": "Vi phạm vượt đèn đỏ",
    "crimeRecordStatus": "Chưa xử phạt",
    "crimeRecordTime": "2026-05-15 10:30:00",
    "crimeRecordPIC": "Công an giao thông quận 1",
    "crimeRecordLocation": "Ngã tư Hàng Xanh, TP. HCM",
    "crimeRecordContact": "0987654321",
    "crimeRecordAgency": "Đội CSGT Quận 1",
    "crimeRecordAddressPIC": "Số 1 Lê Lợi, Quận 1, TP. HCM",
    "crimeRecordAmendmentDate": "2026-05-16",
    "projectName": "Kiemdinhoto_StationServer",
    "createdAt": "2026-05-15T10:45:00.000Z",
    "updatedAt": "2026-05-15T10:45:00.000Z"
  }
}
```

## Dữ liệu callback

| Field | Type | Mô tả |
|---|---|---|
| customerCriminalRecordId | number | Mã bản ghi vi phạm (primary key) |
| customerRecordPlatenumber | string | Biển số xe vi phạm |
| customerRecordPlateColor | number | Màu biển số xe |
| customerRecordPlateColorDesc | string | Mô tả màu biển số |
| vehicleType | number | Loại phương tiện vi phạm |
| crimeRecordContent | string | Nội dung vi phạm |
| crimeRecordStatus | string | Trạng thái xử lý vi phạm |
| crimeRecordTime | datetime | Thời gian phát hiện vi phạm |
| crimeRecordPIC | string | Cơ quan phát hiện vi phạm |
| crimeRecordLocation | string | Địa điểm phát hiện vi phạm |
| crimeRecordContact | string | Số điện thoại liên hệ của cơ quan |
| crimeRecordAgency | string | Tên đơn vị xử lý vi phạm |
| crimeRecordAddressPIC | string | Địa chỉ đơn vị phát hiện vi phạm |
| crimeRecordAmendmentDate | string | Ngày sửa đổi bổ sung bản ghi |
| projectName | string | Tên hệ thống phát sinh bản ghi |
| createdAt | datetime | Thời điểm bản ghi được tạo |
| updatedAt | datetime | Thời điểm cập nhật gần nhất |

## Bảng liệt kê trạng thái

### crimeRecordStatus - Trạng thái xử lý vi phạm

| Giá trị | Mô tả |
|---|---|
| Chưa xử phạt | Vi phạm chưa được xử phạt |
| Đã xử phạt | Vi phạm đã được xử phạt |
| Không vi phạm | Dữ liệu không phải vi phạm thực tế |
| Lỗi tra cứu | Có lỗi xảy ra khi tra cứu vi phạm |

### customerRecordPlateColor - Màu biển số

| Giá trị | Mô tả |
|---|---|
| 1 | Trắng |
| 2 | Xanh |
| 3 | Vàng |
| 4 | Đỏ |

### vehicleType - Loại phương tiện

| Giá trị | Mô tả |
|---|---|
| 1 | Ô tô |
| 10 | Xe khác |
| 20 | Rơ moóc |
| 30 | Xe máy |
| 40 | Xe điện |
