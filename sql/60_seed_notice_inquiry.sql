-- =========================================================
-- 60_seed_notice_inquiry.sql
-- 역할:
--   - 공지사항 및 문의사항 시나리오 데이터 시딩
-- 포함 범위:
--   - NOTICES
--   - INQUIRIES
-- 참고:
--   - 첨부파일 시드는 제외
--   - 최근 목록과 답변 상태가 시연 화면에 자연스럽게 노출되도록 구성
-- =========================================================

INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (1, '냉장 원재료 입고 검수 기준 재안내', '최근 입고 편차가 확인되어 냉장 원재료 검수 기준을 다시 안내드립니다.' || CHR(10) || '비프패티, 베이컨, 채소류는 수령 직후 포장 상태와 온도 이상 여부를 확인한 뒤 입고 처리해 주세요.', TRUNC(DATE '2026-06-17') - 14, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (2, '주말 프로모션 매장별 준비 수량 확인 요청', '이번 주말 세트 메뉴 주문 증가가 예상됩니다.' || CHR(10) || '번, 패티, 감자튀김, 유산지 재고를 미리 점검하시고 부족 예상 품목은 수요일 발주 전에 확인 부탁드립니다.', TRUNC(DATE '2026-06-17') - 12, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (3, '마감 등록 시 폐기 수량 입력 누락 주의', '최근 일부 점포에서 마감 등록 시 폐기 수량이 0으로 저장되는 사례가 있었습니다.' || CHR(10) || '폐기 발생 품목은 실물 확인 후 반드시 폐기 수량과 메모를 함께 남겨 주세요.', TRUNC(DATE '2026-06-17') - 10, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (4, '감자튀김 보관 위치 변경 안내', '냉동고 적재 효율 개선을 위해 감자튀김 박스 적재 위치를 변경합니다.' || CHR(10) || '기존 하단 적재 방식 대신 출고 순서가 빠른 박스를 전면 배치해 주세요.', TRUNC(DATE '2026-06-17') - 8, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (5, '매장 오픈 전 음료 원재료 점검 요청', '콜라시럽 잔량이 부족한 상태에서 오픈하는 사례가 있어 사전 점검을 요청드립니다.' || CHR(10) || '오픈 전 시럽 연결 상태와 잔량을 확인하고 필요 시 금일 발주 메모에 반영해 주세요.', TRUNC(DATE '2026-06-17') - 6, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (6, '채소류 선입선출 운영 협조', '양상추와 토마토의 신선도 편차를 줄이기 위해 선입선출 운영을 다시 요청드립니다.' || CHR(10) || '당일 입고분은 기존 재고 뒤에 적재하고, 먼저 입고된 박스부터 사용해 주세요.', TRUNC(DATE '2026-06-17') - 4, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (7, '발주 승인 메모 확인 후 입고 진행 안내', '부분 승인 건은 품목별 승인 수량이 다를 수 있으니 입고 전에 승인 메모를 먼저 확인해 주세요.' || CHR(10) || '요청 수량과 승인 수량이 다를 경우, 승인 기준으로만 입고 처리 부탁드립니다.', TRUNC(DATE '2026-06-17') - 2, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (8, '우천 예보에 따른 포장 자재 확인 요청', '이번 주 후반 우천 예보로 배달 및 포장 주문 비중이 늘어날 가능성이 있습니다.' || CHR(10) || '쇼핑백, 버거박스, 유산지 재고를 우선 확인해 주시기 바랍니다.', TRUNC(DATE '2026-06-17') - 1, NULL);
INSERT INTO NOTICES (NOTICE_ID, TITLE, CONTENT, CREATED_AT, DELETED_AT) VALUES
    (9, '금일 마감 전 부족 재고 확인 요청', '오늘 마감 등록 전 안전재고 미만 품목을 다시 확인해 주세요.' || CHR(10) || '내일 오픈에 영향이 예상되는 품목은 마감 메모 또는 발주 메모에 사유를 함께 남겨 주시기 바랍니다.', TRUNC(DATE '2026-06-17'), NULL);

INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (1, '비프패티 입고 수량과 실물 수량 차이 문의', '어제 입고한 비프패티 전표는 15팩으로 확인되는데 실물은 14팩만 확인됐습니다.' || CHR(10) || '입고 처리 전에 누락 여부를 먼저 확인해야 할지 문의드립니다.', '거래처 출고 내역 확인 결과 14팩 출고가 맞아 전표를 정정 요청한 상태입니다.' || CHR(10) || '우선은 실물 기준으로 입고 처리해 주시고, 차액은 본사에서 별도로 반영하겠습니다.', TRUNC(DATE '2026-06-17') - 13 + (15 / 24), TRUNC(DATE '2026-06-17') - 12 + (9 / 24), NULL, 1);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (2, '감자튀김 박스 일부 파손 건 처리 문의', '냉동 감자튀김 1박스 외부 포장이 찢어진 상태로 도착했습니다.' || CHR(10) || '내부 포장은 유지되고 있는데 사용 가능 여부와 보고 절차를 확인 부탁드립니다.', '내부 밀봉이 유지되면 사용은 가능하되, 파손 사진을 촬영해 입고 메모에 남겨 주세요.' || CHR(10) || '동일 사례가 반복되면 거래처에 포장 개선 요청을 진행하겠습니다.', TRUNC(DATE '2026-06-17') - 11 + (13 / 24), TRUNC(DATE '2026-06-17') - 10 + (10 / 24), NULL, 2);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (3, '토마토 사용 가능 기한 표기 확인 요청', '오늘 들어온 토마토 박스 라벨이 좀 번져서 사용 권장일이 잘 안 보입니다.' || CHR(10) || '같은 LOT로 보고 그냥 써도 되는지 먼저 확인 부탁드립니다.', '공급사 확인 결과 동일 LOT는 오늘 입고분 전체가 같은 출고분입니다.' || CHR(10) || '육안 상태 이상 없으면 사용 가능하며, 다음 입고부터는 라벨 상태를 다시 점검 요청하겠습니다.', TRUNC(DATE '2026-06-17') - 9 + (11 / 24), TRUNC(DATE '2026-06-17') - 8 + (14 / 24), NULL, 3);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (4, '마감 후 재고 조정 입력 위치 문의', '마감 등록 후 실사 차이가 확인된 경우 재고 조정을 다시 입력해야 하는지 문의드립니다.' || CHR(10) || '마감 메모만 남기면 되는지 확인 부탁드립니다.', '실사 차이가 마감 중 확인된 경우에는 마감 수량에 반영하시면 되고, 마감 완료 후 추가 발견된 차이는 재고 조정으로 입력해 주세요.' || CHR(10) || '사유는 추후 확인할 수 있도록 메모에 함께 남겨 주시면 됩니다.', TRUNC(DATE '2026-06-17') - 8 + (16 / 24), TRUNC(DATE '2026-06-17') - 7 + (11 / 24), NULL, 1);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (5, '케첩 디스펜서 교체 주기 문의', '점심 피크 시간대에 케첩 디스펜서 토출이 일정하지 않았습니다.' || CHR(10) || '노즐 세척으로 해결 가능한 수준인지, 교체 대상인지 확인 부탁드립니다.', '우선 노즐 분해 세척 후 다시 사용해 보시고, 동일 증상이 반복되면 예비 디스펜서로 교체해 주세요.' || CHR(10) || '교체 후에도 같은 증상이 있으면 설비 점검 요청을 접수하겠습니다.', TRUNC(DATE '2026-06-17') - 7 + (12 / 24), TRUNC(DATE '2026-06-17') - 6 + (10 / 24), NULL, 2);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (6, '행사 배너 설치 위치 문의', '매장 입구 배너 위치 관련 문의를 남겼으나 행사 일정이 변경되어 더 이상 확인이 필요하지 않습니다.', NULL, TRUNC(DATE '2026-06-17') - 6 + (9 / 24), NULL, TRUNC(DATE '2026-06-17') - 5 + (18 / 24), 3);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (7, '유산지 사용량 급증에 따른 추가 발주 기준 문의', '최근 포장 주문이 늘면서 유산지 사용량이 예상보다 빠르게 줄고 있습니다.' || CHR(10) || '안전재고 아래로 내려가기 전에 어느 시점에서 추가 발주 잡는 게 좋을지 문의드립니다.', '현재 사용량이면 안전재고 도달 전에 다음 회차 발주에 포함하시는 게 맞습니다.' || CHR(10) || '금요일 발주 시에는 주말 사용량까지 반영해 여유 있게 요청해 주세요.', TRUNC(DATE '2026-06-17') - 4 + (14 / 24), TRUNC(DATE '2026-06-17') - 3 + (10 / 24), NULL, 1);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (8, '부분 승인 발주 건 입고 기준 확인 요청', '오늘 확인한 발주 건 중 일부 품목만 승인된 건이 있습니다.' || CHR(10) || '승인된 수량만 먼저 입고 잡고 나머지는 다시 요청하면 되는지, 이 부분만 빨리 확인 부탁드립니다.', NULL, TRUNC(DATE '2026-06-17') - 3 + (16 / 24), NULL, NULL, 3);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (9, '양상추 선입선출 표기 방법 문의', '냉장고 내부에 입고일 표기를 하고 있는데, 근무자마다 표기 방식이 조금씩 달라 혼선이 있습니다.' || CHR(10) || '권장 표기 방식이 있으면 안내 부탁드립니다.', '박스 전면 우측 상단에 입고일만 동일 형식으로 적어 주시면 됩니다.' || CHR(10) || '추가로 오래된 박스가 앞으로 오도록 위치만 정리해 주시면 운영상 큰 문제는 없습니다.', TRUNC(DATE '2026-06-17') - 2 + (10 / 24), TRUNC(DATE '2026-06-17') - 1 + (9 / 24), NULL, 2);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (10, '금일 패티 부족 예상으로 추가 승인 가능 여부 문의', '저녁 피크 전 비프패티 재고가 안전재고 아래로 내려갈 가능성이 있습니다.' || CHR(10) || '오늘 요청한 발주 건을 우선 승인 처리할 수 있을지 확인 부탁드립니다.', NULL, TRUNC(DATE '2026-06-17') - 1 + (13 / 24), NULL, NULL, 1);
INSERT INTO INQUIRIES (INQUIRY_ID, TITLE, CONTENT, ANSWER_CONTENT, CREATED_AT, ANSWERED_AT, DELETED_AT, STORE_ID) VALUES
    (11, '오픈 직후 콜라시럽 잔량 부족 보고', '금일 오전 오픈 점검 중 콜라시럽 잔량이 예상보다 적게 확인됐습니다.' || CHR(10) || '이번 주 안에 추가 입고가 가능한지, 아니면 임시로 어떻게 운영하면 될지 확인 부탁드립니다.', NULL, TRUNC(DATE '2026-06-17') + (10 / 24), NULL, NULL, 3);
