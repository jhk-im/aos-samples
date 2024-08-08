-- 'DEVELOPER' 테이블이 존재하면 삭제한다. 이 명령은 기존 테이블을 제거하고 새로 생성할 수 있도록 한다.
DROP TABLE IF EXISTS DEVELOPER;

-- 'RETIRED_DEVELOPER' 테이블이 존재하면 삭제한다. 이 명령은 기존 테이블을 제거하고 새로 생성할 수 있도록 한다.
DROP TABLE IF EXISTS RETIRED_DEVELOPER;

CREATE TABLE DEVELOPER
(
    -- ID 필드이다. BIGINT 타입이며, NOT NULL 제약조건이 적용된다. AUTO_INCREMENT로 자동으로 증가하는 기본 키이다.
    ID                   BIGINT NOT NULL AUTO_INCREMENT,
    -- DEVELOPER_LEVEL 필드이다. VARCHAR(25) 타입으로 최대 25자의 문자열을 저장할 수 있다.
    DEVELOPER_LEVEL      VARCHAR(25),
    -- DEVELOPER_SKILL_TYPE 필드이다. VARCHAR(25) 타입으로 최대 25자의 문자열을 저장할 수 있다.
    DEVELOPER_SKILL_TYPE VARCHAR(25),
    -- EXPERIENCE_YEARS 필드이다. INTEGER 타입으로 개발자의 경력 년수를 저장한다.
    EXPERIENCE_YEARS     INTEGER,
    -- STATUS 필드이다. VARCHAR(25) 타입으로 기본값은 'EMPLOYED'이다.
    STATUS               VARCHAR(25) DEFAULT 'EMPLOYED',
    -- MEMBER_ID 필드이다. VARCHAR(50) 타입으로 최대 50자의 문자열을 저장할 수 있다.
    MEMBER_ID            VARCHAR(50),
    -- NAME 필드이다. VARCHAR(50) 타입으로 최대 50자의 문자열을 저장할 수 있다.
    NAME                 VARCHAR(50),
    -- AGE 필드이다. INTEGER 타입으로 개발자의 나이를 저장한다.
    AGE                  INTEGER,
    -- CREATED_AT 필드이다. DATETIME 타입으로 레코드 생성 시간을 저장한다.
    CREATED_AT           DATETIME,
    -- UPDATED_AT 필드이다. DATETIME 타입으로 레코드 업데이트 시간을 저장한다.
    UPDATED_AT           DATETIME,
    -- ID 필드를 기본 키로 설정한다.
    PRIMARY KEY (ID),
    -- MEMBER_ID 필드에 대해 고유 키를 설정하여 중복된 값이 입력되지 않도록 한다.
    UNIQUE KEY `UX_MEMBERID` (`MEMBER_ID`)
);

CREATE TABLE RETIRED_DEVELOPER
(
    ID                   BIGINT NOT NULL AUTO_INCREMENT,
    -- ID 필드이다. BIGINT 타입이며, NOT NULL 제약조건이 적용된다. AUTO_INCREMENT로 자동으로 증가하는 기본 키이다.
    MEMBER_ID            VARCHAR(50),
    -- MEMBER_ID 필드이다. VARCHAR(50) 타입으로 최대 50자의 문자열을 저장할 수 있다.
    NAME                 VARCHAR(50),
    -- NAME 필드이다. VARCHAR(50) 타입으로 최대 50자의 문자열을 저장할 수 있다.
    CREATED_AT           DATETIME,
    -- CREATED_AT 필드이다. DATETIME 타입으로 레코드 생성 시간을 저장한다.
    UPDATED_AT           DATETIME,
    -- UPDATED_AT 필드이다. DATETIME 타입으로 레코드 업데이트 시간을 저장한다.
    PRIMARY KEY (ID)
    -- ID 필드를 기본 키로 설정한다.
);