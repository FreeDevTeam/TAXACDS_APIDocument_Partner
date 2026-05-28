# Partner API - Tra cứu mã số thuế

Tra cứu thông tin mã số thuế theo mã số thuế, CCCD/CMND hoặc tên người nộp thuế.

[Về module TaxCDS](./index.html)

---

## Endpoint

| | |
|---|---|
| URL | `/TaxCDSMstLookup/partner/lookupMst` |
| Method | `POST` |

---

## Headers schema

| Header | Required | Mô tả |
|---|---|---|
| apikey | Yes | Khóa xác thực API của đối tác |

---

## Body schema

| Field | Type | Required | Rule | Mô tả |
|---|---|---|---|---|
| filter | object | Yes | Bắt buộc | Nhóm điều kiện tra cứu. |
| filter.taxCode | string | No | Có thể rỗng | Mã số thuế cần tra cứu. |
| filter.citizenIdentityNumber | string | No | Có thể rỗng | Số CCCD/CMND cần tra cứu. |
| filter.taxpayerName | string | No | Có thể rỗng, hỗ trợ tìm gần đúng | Tên người nộp thuế cần tra cứu. |
| skip | number | No | Mặc định 0, nhỏ nhất 0 | Số bản ghi bỏ qua. |
| limit | number | No | Mặc định 20, lớn nhất 100 | Số bản ghi tối đa trả về. |
| startDate | string | No | Chuỗi ngày tháng | Lọc bản ghi tạo từ ngày. |
| endDate | string | No | Chuỗi ngày tháng | Lọc bản ghi tạo đến ngày. |
| order.key | string | No | Mặc định createdAt | Tên trường dùng để sắp xếp. |
| order.value | string | No | asc hoặc desc, mặc định desc | Chiều sắp xếp. |

Cần truyền ít nhất một điều kiện tra cứu trong `filter`: `taxCode`, `citizenIdentityNumber` hoặc `taxpayerName`.

---

## Sample Request

```bash
curl --location 'http://localhost:4001/TaxCDSMstLookup/partner/lookupMst' \
  --header 'Content-Type: application/json' \
  --header 'apikey: 911abff6-137a-4aa3-a836-555a1d30359b' \
  --data '{
  "filter": {
    "taxCode": "0317545179"
  },
  "skip": 0,
  "limit": 10
}'
```

---

## Success response

```json
{
  "statusCode": 200,
  "error": null,
  "message": "Success",
  "data": {
    "data": [
      {
        "taxCDSMstLookupId": 1,
        "taxCode": "0317545179",
        "citizenIdentityNumber": "074183774928",
        "taxpayerName": "Công ty TNHH ABC",
        "taxDepartment": "Chi cục Thuế khu vực",
        "mstStatus": "ACTIVE",
        "statusTitle": "Đang hoạt động",
        "statusDescription": "Mã số thuế đang hoạt động.",
        "updatedAt": "2026-05-27T04:00:00.000Z",
        "createdAt": "2026-05-27T04:00:00.000Z",
        "isHidden": 0,
        "isDeleted": 0
      }
    ],
    "totalNextPage": 0
  }
}
```

---

## Mã lỗi

| HTTP | Mã lỗi | Mô tả |
|---|---|---|
| 400 | _Validation Error_ | Payload không đúng schema, thiếu field bắt buộc, sai kiểu hoặc vượt giới hạn. |
| 429 | `QUOTA_EXCEEDED` | apikey không hợp lệ hoặc vượt quota. |
| 500 | `MISSING_LOOKUP_FIELD` | Thiếu điều kiện tra cứu: cần ít nhất một trong các trường MST, CCCD/CMND hoặc tên người nộp thuế. |
| 500 | `UNKNOWN_ERROR` | Lỗi không xác định. |

---

## Tham khảo

- [Quy chuẩn chung → Common Error](../../Common.html#common-error) — danh sách mã lỗi hệ thống trả về trong trường `error`.

---

## Data test cho developer

- apikey: 911abff6-137a-4aa3-a836-555a1d30359b
- taxCode: 0317545179
- citizenIdentityNumber: 074183774928
- taxpayerName: Công ty TNHH ABC

Cần thay bằng dữ liệu môi trường thật khi tích hợp.