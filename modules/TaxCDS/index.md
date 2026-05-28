# Partner API Module: TaxCDS

Các API tra cứu thông tin thuế dành cho đối tác.

[Quay về trang chủ](../../index.html)

---

## Danh sách API

### 1. Tra cứu mã số thuế

Endpoint:

```txt
POST /TaxCDSMstLookup/partner/lookupMst
```

Tài liệu:

- HTML: ./TaxCDSMstLookup_LookupMst.html
- MD: ./TaxCDSMstLookup_LookupMst.md

---

### 2. Tra cứu tình trạng hộ kinh doanh

Endpoint:

```txt
POST /TaxCDSMstLookup/partner/lookupHkdStatus
```

Tài liệu:

- HTML: ./TaxCDSMstLookup_LookupHkdStatus.html
- MD: ./TaxCDSMstLookup_LookupHkdStatus.md

---

### 3. Tra cứu nghĩa vụ thuế

Endpoint:

```txt
POST /TaxCDSObligationLookup/partner/lookupTaxObligation
```

Tài liệu:

- HTML: ./TaxCDSObligationLookup_LookupTaxObligation.html
- MD: ./TaxCDSObligationLookup_LookupTaxObligation.md

---

### 4. Tra cứu quyết toán thuế

Endpoint:

```txt
POST /TaxCDSFinalizationLookup/partner/lookupTaxFinalization
```

Tài liệu:

- HTML: ./TaxCDSFinalizationLookup_LookupTaxFinalization.html
- MD: ./TaxCDSFinalizationLookup_LookupTaxFinalization.md

---

### 5. Tra cứu tình trạng nộp tờ khai

Endpoint:

```txt
POST /TaxCDSDeclarationStatusLookup/partner/lookupDeclarationStatus
```

Tài liệu:

- HTML: ./TaxCDSDeclarationStatusLookup_LookupDeclarationStatus.html
- MD: ./TaxCDSDeclarationStatusLookup_LookupDeclarationStatus.md

---

## Headers chung

| Header | Required | Mô tả |
|---|---|---|
| apikey | Yes | Khóa xác thực API của đối tác |

---

## Payload chung

Các API tra cứu TaxCDS dùng chung cấu trúc payload:

```json
{
  "filter": {
    "taxCode": "8173748371"
  },
  "skip": 0,
  "limit": 10
}
```

Cần truyền ít nhất một điều kiện trong `filter`:

- `taxCode`
- `citizenIdentityNumber`
- `taxpayerName`

---

## Data test tham chiếu

- apikey: 911abff6-137a-4aa3-a836-555a1d30359b
- taxCode: 8173748371
- citizenIdentityNumber: 079183000002
- taxpayerName: Nguyễn Văn A

Cần thay bằng dữ liệu môi trường thật khi tích hợp.