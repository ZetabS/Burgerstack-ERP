-- =========================================================
-- 60_seed_notice_inquiry.sql
-- 역할:
--   - 공지사항 및 문의사항 시나리오 데이터 시딩
-- 포함 범위:
--   - NOTICES
--   - NOTICE_FILES
--   - INQUIRIES
--   - INQUIRY_FILES
-- 참고:
--   - 현재는 공지/문의 본문 중심의 기본 데이터만 포함
-- =========================================================

INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (1, '시연 계정 안내', '관리자 계정은 admin, 점주 계정은 owner01~owner03를 사용합니다.', SYSDATE - 7, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (2, '발주 상태 시연 안내', '발주 목록에는 요청, 승인, 부분 승인, 반려, 취소, 입고 완료 상태가 모두 포함되어 있습니다.', SYSDATE - 5, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (3, '재고 부족 확인', '일부 자재는 의도적으로 안전재고 미만으로 설정되어 있습니다.', SYSDATE - 2, NULL);

INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (1, '발주 승인 처리 문의', '지난주에 요청한 발주 건이 아직 승인 대기 상태로 표시됩니다. 처리 상태를 확인 부탁드립니다.', '확인 결과 일부 자재 재고 부족으로 승인 처리가 지연되었습니다. 금일 중 승인 처리 예정입니다.', SYSDATE - 10, SYSDATE - 9, NULL, 1);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (2, '안전재고 수량 변경 요청', '양상추 사용량이 증가하여 안전재고 수량을 상향하고 싶습니다. 변경 가능 여부를 문의드립니다.', '점포 재고 화면에서 안전재고 수량을 직접 변경할 수 있습니다. 변경 후 부족 재고 목록에 반영됩니다.', SYSDATE - 9, SYSDATE - 8, NULL, 2);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (3, '입고 처리 후 재고 반영 문의', '입고 처리를 완료했는데 일부 자재의 현재고가 바로 반영되지 않는 것 같습니다.', '입고 처리 내역을 확인한 결과 정상 반영되었습니다. 화면 새로고침 후에도 동일하면 다시 문의 부탁드립니다.', SYSDATE - 8, SYSDATE - 7, NULL, 3);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (4, '발주 반려 사유 확인 요청', '최근 발주 요청이 반려되었는데 상세 사유를 확인하고 싶습니다.', '해당 발주 건은 사전 승인되지 않은 대량 발주로 반려되었습니다. 수량을 조정하여 다시 요청해주시기 바랍니다.', SYSDATE - 3, SYSDATE - 2, NULL, 2);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (5, '재고 부족 알림 기준 문의', '부족 재고로 표시되는 기준이 현재고 기준인지 안전재고 기준인지 문의드립니다.', '현재고가 안전재고보다 적은 경우 부족 재고로 표시됩니다.', SYSDATE - 1, SYSDATE, NULL, 1);
