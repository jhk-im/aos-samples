-- 'developer' 테이블에 새로운 레코드를 삽입한다.
-- age: 41 (개발자의 나이)
-- developer_level: 'SENIOR' (개발자의 경력 수준)
-- developer_skill_type: 'FULL_STACK' (개발자의 기술 유형)
-- experience_years: 14 (경력 년수)
-- member_id: 'snow.y' (멤버 ID)
-- name: 'seyol' (개발자의 이름)
-- created_at: 현재 시간 (레코드 생성 시각)
-- updated_at: 현재 시간 (레코드 업데이트 시각)
insert into developer (age, developer_level, developer_skill_type, experience_years, member_id, name, created_at, updated_at)
VALUES (41, 'SENIOR', 'FULL_STACK', 14, 'snow.y', 'seyol', now(), now());

-- 'developer' 테이블에 또 다른 새로운 레코드를 삽입한다.
-- age: 36 (개발자의 나이)
-- developer_level: 'JUNIOR' (개발자의 경력 수준)
-- developer_skill_type: 'FRONT_END' (개발자의 기술 유형)
-- experience_years: 2 (경력 년수)
-- member_id: 'sunny.flower' (멤버 ID)
-- name: 'sun' (개발자의 이름)
-- created_at: 현재 시간 (레코드 생성 시각)
-- updated_at: 현재 시간 (레코드 업데이트 시각)
insert into developer (age, developer_level, developer_skill_type, experience_years, member_id, name, created_at, updated_at)
VALUES (36, 'JUNIOR', 'FRONT_END', 2, 'sunny.flower', 'sun', now(), now());
