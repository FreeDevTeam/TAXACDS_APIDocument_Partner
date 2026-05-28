# Partner API Documentation - TaxCDS

Tài liệu API tra cứu thông tin thuế dành cho đối tác.

## Danh sách module

1. TaxCDS
- Module index HTML: ./modules/TaxCDS/index.html
- Module index MD: ./modules/TaxCDS/index.md

## Danh sách API TaxCDS

1. Tra cứu mã số thuế
- Endpoint: `POST /TaxCDSMstLookup/partner/lookupMst`
- HTML: ./modules/TaxCDS/TaxCDSMstLookup_LookupMst.html
- MD: ./modules/TaxCDS/TaxCDSMstLookup_LookupMst.md

2. Tra cứu tình trạng hộ kinh doanh
- Endpoint: `POST /TaxCDSMstLookup/partner/lookupHkdStatus`
- HTML: ./modules/TaxCDS/TaxCDSMstLookup_LookupHkdStatus.html
- MD: ./modules/TaxCDS/TaxCDSMstLookup_LookupHkdStatus.md

3. Tra cứu nghĩa vụ thuế
- Endpoint: `POST /TaxCDSObligationLookup/partner/lookupTaxObligation`
- HTML: ./modules/TaxCDS/TaxCDSObligationLookup_LookupTaxObligation.html
- MD: ./modules/TaxCDS/TaxCDSObligationLookup_LookupTaxObligation.md

4. Tra cứu quyết toán thuế
- Endpoint: `POST /TaxCDSFinalizationLookup/partner/lookupTaxFinalization`
- HTML: ./modules/TaxCDS/TaxCDSFinalizationLookup_LookupTaxFinalization.html
- MD: ./modules/TaxCDS/TaxCDSFinalizationLookup_LookupTaxFinalization.md

5. Tra cứu tình trạng nộp tờ khai
- Endpoint: `POST /TaxCDSDeclarationStatusLookup/partner/lookupDeclarationStatus`
- HTML: ./modules/TaxCDS/TaxCDSDeclarationStatusLookup_LookupDeclarationStatus.html
- MD: ./modules/TaxCDS/TaxCDSDeclarationStatusLookup_LookupDeclarationStatus.md

## Quy ước tài liệu

- Mỗi API có 2 file tương ứng: 1 file Markdown và 1 file HTML.
- Trang chủ có 2 file tương ứng: `index.md` và `index.html`.
- Module TaxCDS có 2 file index tương ứng: `modules/TaxCDS/index.md` và `modules/TaxCDS/index.html`.
- cURL mẫu chỉ giữ trường hợp happy case để tránh nhiễu khi tích hợp.

## Data test đang dùng cho TaxCDS

- apikey: 911abff6-137a-4aa3-a836-555a1d30359b
- taxCode: 8173748371
- citizenIdentityNumber: 079183000002
- taxpayerName: Nguyễn Văn A

Developer cần thay lại credential và dữ liệu theo môi trường thật trước khi UAT/production.