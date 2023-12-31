-- 게시글
DROP TABLE IF EXISTS sns_board RESTRICT;

-- 댓글
DROP TABLE IF EXISTS sns_board_comment RESTRICT;

-- 게시글 좋아요
DROP TABLE IF EXISTS sns_board_like RESTRICT;

-- 게시글 사진
DROP TABLE IF EXISTS sns_board_photo RESTRICT;

-- 팔로우
DROP TABLE IF EXISTS sns_follow RESTRICT;

-- 회원
DROP TABLE IF EXISTS sns_member RESTRICT;

-- 마이페이지
DROP TABLE IF EXISTS sns_mypage RESTRICT;

-- 마이페이지 좋아요
DROP TABLE IF EXISTS sns_mypage_like RESTRICT;

-- 알림 기록
DROP TABLE IF EXISTS sns_noti_log RESTRICT;

-- 알림 유형
DROP TABLE IF EXISTS sns_noti_type RESTRICT;

-- 개인 설정
DROP TABLE IF EXISTS sns_personal_option RESTRICT;

-- 마이페이지 일일 방문자 수
DROP TABLE IF EXISTS sns_today_visit_count RESTRICT;

-- 게시글 카테고리
DROP TABLE IF EXISTS sns_board_category RESTRICT;


-- 회원
CREATE TABLE sns_member (
    mno          INTEGER      NOT NULL COMMENT '회원번호', -- 회원번호
    nick         VARCHAR(50)  NOT NULL COMMENT '닉네임', -- 닉네임
    name         VARCHAR(50)  NOT NULL COMMENT '이름', -- 이름
    phone_number VARCHAR(30)  NOT NULL COMMENT '전화번호', -- 전화번호
    email        VARCHAR(40)  NULL     COMMENT '이메일', -- 이메일
    password     VARCHAR(255) NOT NULL COMMENT '비밀번호', -- 비밀번호
    filepath     VARCHAR(255) NULL     COMMENT '프로필 사진 경로' -- 프로필 사진 경로
)
    COMMENT '회원';

-- 회원
ALTER TABLE sns_member
    ADD CONSTRAINT
        PRIMARY KEY (
                     mno -- 회원번호
        );

-- 회원 유니크 인덱스2
CREATE UNIQUE INDEX UIX_sns_member2
    ON sns_member ( -- 회원
        nick ASC -- 닉네임
    );

-- 회원 유니크 인덱스3
CREATE UNIQUE INDEX UIX_sns_member3
    ON sns_member ( -- 회원
        phone_number ASC -- 전화번호
    );

-- 회원 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_member
    ON sns_member ( -- 회원
        email ASC -- 이메일
    );

ALTER TABLE sns_member
    MODIFY COLUMN mno INTEGER NOT NULL AUTO_INCREMENT COMMENT '회원번호';


-- 게시글
CREATE TABLE sns_board (
  bno        INTEGER     NOT NULL COMMENT '게시글 번호', -- 게시글 번호
  mno        INTEGER     NOT NULL COMMENT '작성자 번호', -- 작성자 번호
  title      VARCHAR(50) NOT NULL COMMENT '제목', -- 제목
  content    TEXT        NOT NULL COMMENT '내용', -- 내용
  view_count INTEGER     NOT NULL DEFAULT 0 COMMENT '조회수', -- 조회수
  likes      INTEGER     NOT NULL DEFAULT 0 COMMENT '좋아요', -- 좋아요
  category   INTEGER     NULL     COMMENT '카테고리 번호', -- 카테고리 번호
  created_at DATETIME    NOT NULL DEFAULT (current_time) COMMENT '작성일시', -- 작성일시
  updated_at DATETIME    NULL     COMMENT '수정일시' -- 수정일시
)
COMMENT '게시글';

-- 게시글
ALTER TABLE sns_board
  ADD CONSTRAINT
  PRIMARY KEY (
  bno -- 게시글 번호
  );

ALTER TABLE sns_board
  MODIFY COLUMN bno INTEGER NOT NULL AUTO_INCREMENT COMMENT '게시글 번호';

-- 댓글
CREATE TABLE sns_board_comment (
  bcno       INTEGER  NOT NULL COMMENT '댓글 번호', -- 댓글 번호
  bno        INTEGER  NOT NULL COMMENT '게시글 번호', -- 게시글 번호
  mno        INTEGER  NOT NULL COMMENT '회원번호', -- 회원번호
  content    TEXT     NOT NULL COMMENT '내용', -- 내용
  created_at DATETIME NOT NULL DEFAULT (current_time) COMMENT '작성일시', -- 작성일시
  updated_at DATETIME NULL     COMMENT '수정일시' -- 수정일시
)
COMMENT '댓글';

-- 댓글
ALTER TABLE sns_board_comment
  ADD CONSTRAINT
  PRIMARY KEY (
  bcno -- 댓글 번호
  );

ALTER TABLE sns_board_comment
  MODIFY COLUMN bcno INTEGER NOT NULL AUTO_INCREMENT COMMENT '댓글 번호';

-- 게시글 좋아요
CREATE TABLE sns_board_like (
  mno INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  bno INTEGER NOT NULL COMMENT '게시글 번호' -- 게시글 번호
)
COMMENT '게시글 좋아요';

-- 게시글 좋아요 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_board_like
  ON sns_board_like ( -- 게시글 좋아요
    mno ASC, -- 회원번호
    bno ASC  -- 게시글 번호
  );

-- 게시글 사진
CREATE TABLE sns_board_photo (
  bpno     INTEGER      NOT NULL COMMENT '사진 번호', -- 사진 번호
  bno      INTEGER      NOT NULL COMMENT '게시글 번호', -- 게시글 번호
  filepath VARCHAR(255) NOT NULL COMMENT '파일경로' -- 파일경로
)
COMMENT '게시글 사진';

-- 게시글 사진
ALTER TABLE sns_board_photo
  ADD CONSTRAINT
  PRIMARY KEY (
  bpno -- 사진 번호
  );

ALTER TABLE sns_board_photo
  MODIFY COLUMN bpno INTEGER NOT NULL AUTO_INCREMENT COMMENT '사진 번호';

-- 팔로우
CREATE TABLE sns_follow (
  follower  INTEGER NOT NULL COMMENT '팔로워', -- 팔로워
  following INTEGER NOT NULL COMMENT '팔로잉' -- 팔로잉
)
COMMENT '팔로우';

-- 팔로우 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_follow
  ON sns_follow ( -- 팔로우
    follower ASC,  -- 팔로워
    following ASC  -- 팔로잉
  );

-- 마이페이지
CREATE TABLE sns_mypage (
  mno           INTEGER      NOT NULL COMMENT '회원번호', -- 회원번호
  state_message VARCHAR(255) NULL     COMMENT '상태 메세지', -- 상태 메세지
  birthday      DATE         NULL     COMMENT '생일', -- 생일
  gender        TINYINT      NULL     COMMENT '성별', -- 성별
  likes         INTEGER      NOT NULL DEFAULT 0 COMMENT '좋아요', -- 좋아요
  visit_count   INTEGER      NOT NULL DEFAULT 0 COMMENT '총 방문자 수', -- 총 방문자 수
  created_date  DATE         NOT NULL DEFAULT (current_date) COMMENT '가입일' -- 가입일
)
COMMENT '마이페이지';

-- 마이페이지
ALTER TABLE sns_mypage
  ADD CONSTRAINT
  PRIMARY KEY (
  mno -- 회원번호
  );

-- 마이페이지 좋아요
CREATE TABLE sns_mypage_like (
  mno  INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  mpno INTEGER NOT NULL COMMENT '마이페이지 번호' -- 마이페이지 번호
)
COMMENT '마이페이지 좋아요';

-- 마이페이지 좋아요 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_mypage_like
  ON sns_mypage_like ( -- 마이페이지 좋아요
    mno ASC,  -- 회원번호
    mpno ASC  -- 마이페이지 번호
  );

-- 알림 기록
CREATE TABLE sns_noti_log (
  nlno       INTEGER      NOT NULL COMMENT '알림 기록 번호', -- 알림 기록 번호
  mno        INTEGER      NOT NULL COMMENT '회원번호', -- 회원번호
  ntno       INTEGER      NOT NULL COMMENT '알림 유형 번호', -- 알림 유형 번호
  content    VARCHAR(255) NOT NULL COMMENT '알림 내용', -- 알림 내용
  url        VARCHAR(255) NOT NULL COMMENT '링크', -- 링크
  noti_state TINYINT      NOT NULL DEFAULT 0 COMMENT '알림 확인 상태' -- 알림 확인 상태
)
COMMENT '알림 기록';

-- 알림 기록
ALTER TABLE sns_noti_log
  ADD CONSTRAINT
  PRIMARY KEY (
  nlno -- 알림 기록 번호
  );

ALTER TABLE sns_noti_log
  MODIFY COLUMN nlno INTEGER NOT NULL AUTO_INCREMENT COMMENT '알림 기록 번호';

-- 알림 유형
CREATE TABLE sns_noti_type (
  ntno INTEGER     NOT NULL COMMENT '알림 유형 번호', -- 알림 유형 번호
  name VARCHAR(50) NOT NULL COMMENT '알림 유형 이름' -- 알림 유형 이름
)
COMMENT '알림 유형';

-- 알림 유형
ALTER TABLE sns_noti_type
  ADD CONSTRAINT
  PRIMARY KEY (
  ntno -- 알림 유형 번호
  );

-- 알림 유형 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_noti_type
  ON sns_noti_type ( -- 알림 유형
    name ASC -- 알림 유형 이름
  );

ALTER TABLE sns_noti_type
  MODIFY COLUMN ntno INTEGER NOT NULL AUTO_INCREMENT COMMENT '알림 유형 번호';

-- 개인 설정
CREATE TABLE sns_personal_option (
  mno               INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  like_noti_state   TINYINT NOT NULL DEFAULT 1 COMMENT '좋아요 알림 설정', -- 좋아요 알림 설정
  follow_noti_state TINYINT NOT NULL DEFAULT 1 COMMENT '팔로우 알림 설정', -- 팔로우 알림 설정
  coment_noti_state TINYINT NOT NULL DEFAULT 1 COMMENT '댓글 알림 설정', -- 댓글 알림 설정
  tag_noti_state    TINYINT NOT NULL DEFAULT 1 COMMENT '태그 알림 설정' -- 태그 알림 설정
)
COMMENT '개인 설정';

-- 개인 설정
ALTER TABLE sns_personal_option
  ADD CONSTRAINT
  PRIMARY KEY (
  mno -- 회원번호
  );

-- 마이페이지 일일 방문자 수
CREATE TABLE sns_today_visit_count (
  vcno              INTEGER NOT NULL COMMENT '일일 방문자 수 번호', -- 일일 방문자 수 번호
  mno               INTEGER NOT NULL COMMENT '회원번호', -- 회원번호
  visit_date        DATE    NOT NULL DEFAULT (current_date) COMMENT '날짜', -- 날짜
  today_visit_count INTEGER NOT NULL DEFAULT 0 COMMENT '일일 방문자 수' -- 일일 방문자 수
)
COMMENT '마이페이지 일일 방문자 수';

-- 마이페이지 일일 방문자 수
ALTER TABLE sns_today_visit_count
  ADD CONSTRAINT PK_sns_today_visit_count -- 마이페이지 일일 방문자 수 기본키
  PRIMARY KEY (
  vcno -- 일일 방문자 수 번호
  );

-- 마이페이지 일일 방문자 수 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_today_visit_count
  ON sns_today_visit_count ( -- 마이페이지 일일 방문자 수
    mno ASC ,        -- 회원번호
    visit_date DESC  -- 날짜
  );

-- 게시글 카테고리
CREATE TABLE sns_board_category (
  bcno INTEGER     NOT NULL COMMENT '카테고리 번호', -- 카테고리 번호
  name VARCHAR(50) NOT NULL COMMENT '이름' -- 이름
)
COMMENT '게시글 카테고리';

-- 게시글 카테고리
ALTER TABLE sns_board_category
  ADD CONSTRAINT PK_sns_board_category -- 게시글 카테고리 기본키
  PRIMARY KEY (
  bcno -- 카테고리 번호
  );

-- 게시글 카테고리 유니크 인덱스
CREATE UNIQUE INDEX UIX_sns_board_category
  ON sns_board_category ( -- 게시글 카테고리
    name ASC -- 이름
  );

ALTER TABLE sns_board_category
  MODIFY COLUMN bcno INTEGER NOT NULL AUTO_INCREMENT COMMENT '카테고리 번호';

-- 게시글
ALTER TABLE sns_board
  ADD CONSTRAINT FK_sns_member_TO_sns_board_1 -- FK_sns_member_TO_sns_board_1
  FOREIGN KEY (
  mno -- 작성자 번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_board_1 (
    mno -- 작성자 번호
  );

-- 댓글
ALTER TABLE sns_board_comment
  ADD CONSTRAINT FK_sns_board_TO_sns_board_comment_1 -- FK_sns_board_TO_sns_board_comment_1
  FOREIGN KEY (
  bno -- 게시글 번호
  )
  REFERENCES sns_board ( -- 게시글
  bno -- 게시글 번호
  ),
  ADD INDEX FK_sns_board_TO_sns_board_comment_1 (
    bno -- 게시글 번호
  );

-- 댓글
ALTER TABLE sns_board_comment
  ADD CONSTRAINT FK_sns_member_TO_sns_board_comment_1 -- FK_sns_member_TO_sns_board_comment_1
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_board_comment_1 (
    mno -- 회원번호
  );

-- 게시글 좋아요
ALTER TABLE sns_board_like
  ADD CONSTRAINT FK_sns_board_TO_sns_board_like_1 -- FK_sns_board_TO_sns_board_like_1
  FOREIGN KEY (
  bno -- 게시글 번호
  )
  REFERENCES sns_board ( -- 게시글
  bno -- 게시글 번호
  ),
  ADD INDEX FK_sns_board_TO_sns_board_like_1 (
    bno -- 게시글 번호
  );

-- 게시글 좋아요
ALTER TABLE sns_board_like
  ADD CONSTRAINT FK_sns_member_TO_sns_board_like_1 -- FK_sns_member_TO_sns_board_like_1
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_board_like_1 (
    mno -- 회원번호
  );

-- 게시글 사진
ALTER TABLE sns_board_photo
  ADD CONSTRAINT FK_sns_board_TO_sns_board_photo_1 -- FK_sns_board_TO_sns_board_photo_1
  FOREIGN KEY (
  bno -- 게시글 번호
  )
  REFERENCES sns_board ( -- 게시글
  bno -- 게시글 번호
  ),
  ADD INDEX FK_sns_board_TO_sns_board_photo_1 (
    bno -- 게시글 번호
  );

-- 팔로우
ALTER TABLE sns_follow
  ADD CONSTRAINT FK_sns_member_TO_sns_follow_1 -- FK_sns_member_TO_sns_follow_1
  FOREIGN KEY (
  follower -- 팔로워
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_follow_1 (
    follower -- 팔로워
  );

-- 팔로우
ALTER TABLE sns_follow
  ADD CONSTRAINT FK_sns_member_TO_sns_follow_2 -- FK_sns_member_TO_sns_follow_2
  FOREIGN KEY (
  following -- 팔로잉
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_follow_2 (
    following -- 팔로잉
  );

-- 마이페이지 좋아요
ALTER TABLE sns_mypage_like
  ADD CONSTRAINT FK_sns_member_TO_sns_mypage_like_1 -- FK_sns_member_TO_sns_mypage_like_1
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_mypage_like_1 (
    mno -- 회원번호
  );

-- 마이페이지 좋아요
ALTER TABLE sns_mypage_like
  ADD CONSTRAINT FK_sns_mypage_TO_sns_mypage_like_1 -- FK_sns_mypage_TO_sns_mypage_like_1
  FOREIGN KEY (
  mpno -- 마이페이지 번호
  )
  REFERENCES sns_mypage ( -- 마이페이지
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_mypage_TO_sns_mypage_like_1 (
    mpno -- 마이페이지 번호
  );

-- 알림 기록
ALTER TABLE sns_noti_log
  ADD CONSTRAINT FK_sns_member_TO_sns_noti_log_1 -- FK_sns_member_TO_sns_noti_log_1
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  ),
  ADD INDEX FK_sns_member_TO_sns_noti_log_1 (
    mno -- 회원번호
  );

-- 알림 기록
ALTER TABLE sns_noti_log
  ADD CONSTRAINT FK_sns_noti_type_TO_sns_noti_log_1 -- FK_sns_noti_type_TO_sns_noti_log_1
  FOREIGN KEY (
  ntno -- 알림 유형 번호
  )
  REFERENCES sns_noti_type ( -- 알림 유형
  ntno -- 알림 유형 번호
  ),
  ADD INDEX FK_sns_noti_type_TO_sns_noti_log_1 (
    ntno -- 알림 유형 번호
  );

-- 게시글
ALTER TABLE sns_board
  ADD CONSTRAINT FK_sns_board_category_TO_sns_board -- 게시글 카테고리 -> 게시글
  FOREIGN KEY (
  category -- 카테고리 번호
  )
  REFERENCES sns_board_category ( -- 게시글 카테고리
  bcno -- 카테고리 번호
  );

-- 마이페이지
ALTER TABLE sns_mypage
  ADD CONSTRAINT FK_sns_member_TO_sns_mypage_1 -- FK_sns_member_TO_sns_mypage_1
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  );

-- 개인 설정
ALTER TABLE sns_personal_option
  ADD CONSTRAINT FK_sns_member_TO_sns_personal_option_1 -- FK_sns_member_TO_sns_personal_option_1
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_member ( -- 회원
  mno -- 회원번호
  );

-- 마이페이지 일일 방문자 수
ALTER TABLE sns_today_visit_count
  ADD CONSTRAINT FK_sns_mypage_TO_sns_today_visit_count -- 마이페이지 -> 마이페이지 일일 방문자 수
  FOREIGN KEY (
  mno -- 회원번호
  )
  REFERENCES sns_mypage ( -- 마이페이지
  mno -- 회원번호
  );

  INSERT INTO sns_guestbook (title, content, likes, created_at, mno, mem_no)
VALUES
    ('첫 번째 게시물', '첫 번째 게시물 내용입니다.', 5, NOW(), 1, 2),
    ('두 번째 게시물', '두 번째 게시물 내용입니다.', 10, NOW(), 2, 1),
    ('세 번째 게시물', '세 번째 게시물 내용입니다.', 7, NOW(), 3, 4);
    ('네 번째 게시물', '세 번째 게시물 내용입니다.', 7, NOW(), 4, 3);
    ('오 번째 게시물', '세 번째 게시물 내용입니다.', 7, NOW(), 5, 6);
    ('육 번째 게시물', '세 번째 게시물 내용입니다.', 7, NOW(), 6, 5);