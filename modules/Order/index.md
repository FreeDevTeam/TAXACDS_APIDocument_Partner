# Partner API Module: Order

## Danh sách API

1. Payment Confirm Batch
- HTML: ./PartnerOrder_PaymentConfirmBatch.html
- MD: ./PartnerOrder_PaymentConfirmBatch.md

2. Query Order Batch
- HTML: ./PartnerOrder_QueryOrderBatch.html
- MD: ./PartnerOrder_QueryOrderBatch.md

3. Query Transaction Batch
- HTML: ./PartnerOrder_QueryTransactionBatch.html
- MD: ./PartnerOrder_QueryTransactionBatch.md

## Data test tham chiếu

Nguồn: API/Order/test/OrderTest_Partner_Data.js trong server codebase.

- orderId pending: TEST_ORDER_PARTNER_PENDING_001
- orderId paid: TEST_ORDER_PARTNER_PAID_001
- orderId canceled: TEST_ORDER_PARTNER_CANCELED_001

Lưu ý cho developer:
- Đây là dữ liệu cố định phục vụ test e2e và viết tài liệu.
- Trước khi tích hợp môi trường thật, thay toàn bộ TEST_* bằng dữ liệu theo tenant/đối tác thực tế.
