show tables;

create table guest2 (
	idx 	int not null auto_increment primary key,	/* 방명록 고유번호 */
	name 	varchar(20) not null,						/* 방문자 성명 */
	email 	varchar(60),								/* 이메일 주소 */
	homepage varchar(60),								/* 방문자의 홈페이지(블로그 주소) */
	vDate	datetime default now(),						/* 방문일자/시간 */
	hostIp	varchar(50) not null,						/* 방문자 IP */
	content text not null								/* 방문 소감 */
);

desc guest2;

insert into guest2 values(default, '관리자', 'junmo8492@naver.com','https://blog.naver.com/junmo8492',default,'192.168.0.6','방명록 서비스를 시작합니다.');
insert into guest2 values(default, '홍길동', 'hkd1234@hanmail.net','https://blog.daum.net/hkd1234',default,'192.168.0.11','귀사의 번영을 기원합니다.');
insert into guest2 values(default, '이기자', 'lkj1234@hanmail.net','https://blog.daum.net/lkg1234',default,'192.168.0.12','반갑습니다.');
insert into guest2 values(default, '오하늘', 'ohn1234@hanmail.net','https://blog.daum.net/ohn1234',default,'192.168.0.13','안녕하세요~');
insert into guest2 values(default, '홍길순', 'hks1234@naver.com','https://blog.naver.com/hks1234',default,'192.168.0.14','방명록은 처음이에요');
insert into guest2 values(default, '박수쳐', 'bsc@hanmail.net','https://blog.daum.net/bsc111',default,'192.168.0.15','모두다 박수쳐~');
insert into guest2 values(default, '호식이', 'hsk1234@hanmail.net','https://blog.daum.net/hsk1234',default,'192.168.0.16','호식이 두마리치킨입니다.');
insert into guest2 values(default, '교촌이', 'kyo1234@hanmail.net','https://blog.daum.net/kyo1234',default,'192.168.0.17','교촌치킨입니다.');
insert into guest2 values(default, '오아름', 'oar1234@hanmail.net','https://blog.daum.net/oar1234',default,'192.168.0.18','오아름입니다~~ 반가워요!');
insert into guest2 values(default, '김정은', 'kje1234@northkorea.com','https://blog.northkorea.com/kje1234',default,'192.168.0.19','탈북하고 싶어요');

select * from guest2;

update guest2 set homepage = 'https://blog.daum.net/psk1234' where idx = 4;

drop table guest2;