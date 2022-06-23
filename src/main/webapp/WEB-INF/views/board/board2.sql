show tables;

create table board2 (
	idx			int not null auto_increment,	/* 게시글의 고유번호 */
	nickName 	varchar(20)	 not null,			/* 게시글을 올린사람의 닉네임 */
	title		varchar(100) not null,			/* 게시글의 글 제목 */
	email		varchar(100),					/* 글쓴이의 메일주소 */
	homePage	varchar(100),					/* 글쓴이의 홈페이지(블로그)주소 */
	content		text not null,					/* 글 내용 */
	wDate		datetime default now(),			/* 글 올린 날짜 */
	readNum		int default 0,					/* 글 조회수 */
	hostIp		varchar(50) not null,			/* 접속 IP 주소 */
	good		int default 0,					/* '좋아요' 횟수 누적처리 */
	mid			varchar(20) not null,			/* 회원 아이디(게시글 조회시 사용) */
	primary key (idx)							/* 게시판의 기본키 : 고유번호 */
);

desc board2;

insert into board2 values (default,'관리맨','게시판 서비스를 시작합니다.','junmo8492@naver.com','http://blog.naver.com/junmo8492','이곳은 게시판입니다.',default,default,'192.168.50.112',default,'admin');
select * from board2;

select * from board2 where idx = 5-1;	/* 현재글이 5번글인 경우 */
select * from board2 where idx = 1-1;	/* 현재글이 1번글인 경우 */
select * from board2 where idx = 21-1;
select * from board2 where idx = 21+1;

select * from board2 where idx > 5 limit 1;	/* 다음글 */
select * from board2 where idx < 5 order by idx desc limit 1;	/* 이전글 */
select idx,title from board2 where idx in (
			(select idx from board2 where idx < 5 order by idx desc limit 1),
			(select idx from board2 where idx > 5 limit 1));
select min(idx) from board2;
			
/*
	DATEDIFF(날짜1, 날짜2) : '날짜1 - 날짜2'의 결과를 반환한다.
	TIMESTAMPDIFF(단위, 날짜1, 날짜2) : '날짜2 - 날짜1'의 결과를 반환한다.
		단위 : YEAR(년)/QUARTER(분기)/MONTH(월),WEEK(주)/DAY(일)/HOUR(시)/MINUTE(분)/SECOND(초)
	:결과를 숫자로 반환한다.
 */
SELECT DATEDIFF('2022-06-22', '2022-06-01');
SELECT DATEDIFF(NOW(), '2022-06-01');

SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);
SELECT DATE_SUB(NOW(), INTERVAL 1 DAY);

SELECT * FROM board ORDER BY idx DESC;
SELECT * FROM board WHERE wDate > DATE_SUB(NOW(), INTERVAL 0 DAY) ORDER BY idx DESC;
SELECT * FROM board WHERE wDate > DATE_SUB(NOW(), INTERVAL 1 DAY) ORDER BY idx DESC;
SELECT * FROM board WHERE wDate > DATE_SUB(NOW(), INTERVAL 2 DAY) ORDER BY idx DESC;

SELECT TIMESTAMPDIFF(YEAR, '2022-06-23', '2022-06-22');
SELECT TIMESTAMPDIFF(MONTH, '2022-05-23', '2022-06-23');
SELECT TIMESTAMPDIFF(MONTH, '2022-06-22', '2022-06-23');
SELECT TIMESTAMPDIFF(MONTH, '2022-05-22', NOW());
SELECT TIMESTAMPDIFF(DAY, '2022-05-22', NOW());
SELECT TIMESTAMPDIFF(DAY, '2022-06-22', NOW());
SELECT TIMESTAMPDIFF(HOUR, '2022-06-22', NOW());
SELECT TIMESTAMPDIFF(MINUTE, '2022-06-22', NOW()) / 60;
SELECT TIMESTAMPDIFF(MINUTE, '2022-06-22', NOW()) / (60 * 24);
SELECT * FROM board ORDER BY idx DESC;

select *,cast(TIMESTAMPDIFF(MINUTE, wDate, NOW()) / 60 as signed integer) as diffTime from board2 order by idx desc limit 0, 10;

/* 
	외래키(foreign key) : 서로다른 테이블간의 연관관계를 맺어주기위한 키
		: 외래키를 설정하려면, 설정하려는 외래키는 다른테이블의 주키(기본키 : Primary key)이어야 한다.
		  즉, 외래키로 지정하는 필드는, 해당테이블의 속성과 똑같아야 한다.
*/
/* 댓글 테이블(boardReply2) */
create table boardReply2 (
	idx int not null auto_increment,	/* 댓글의 고유번호 */
	boardIdx int not null,				/* 원본글의 고유번호(외래키로 지정함) */
	mid		 varchar(20) not null,		/* 댓글 올린이의 아이디 */
	nickName varchar(20) not null,		/* 댓글 올림이의 닉네임 */
	wDate	 datetime default now(),	/* 댓글쓴 날짜 */
	hostIp	 varchar(50) not null,		/* 댓글쓴 PC의 IP */
	content	 text		 not null,		/* 댓글 내용 */
	primary key(idx),					/* 주키(기본키)는 idx */
	foreign key(boardIdx) references board2(idx)	/* board테이블의 idx를 boardReply2테이블의 외래키(boardIdx)로 설정했다. */
	on update cascade					/* 원본테이블에서의 주키의 변경에 영향을 받는다. */
	on delete restrict					/* 원본테이블에서의 주키를 삭제시키지 못하게 한다.(삭제시는 에러발생하고 원본키를 삭제하지 못함.) */
);

drop table boardReply2;

/* sub query
    : 쿼리안에 쿼리를 삽입시키는 방법(위치는 상황에 따라서 사용자가 지정해준다.) - select 문과 함께 사용..
   예) select 필드명,(서브쿼리) from 테이블명 ~ where 조건절 ~~~ .....
   	   select 필드리스트 from (서브쿼리)~~ where 조건절 ~~~ .....
   	   select 필드리스트 from 테이블명 where (서브쿼리)~~ .....
 */

-- board테이블의 목록 모두 보여주기(idx 역순으로, 자료의 개수는 5개만)
select * from board order by idx desc limit 5;

-- boardReply2 테이블의 구조?
desc boardReply2;
select * from boardReply2;
-- board테이블의 idx 37번글에 적혀있는 댓글(boardReply2테이블)의 개수는?
select count(*) from boardReply2 where boardIdx = 30;
-- board테이블의 idx 37번글에 적혀있는 댓글(boardReply2테이블)의 개수는?(단, 출력은 부모글의 고유번호와 댓글개수를 출력)
select boardIdx as 부모고유번호, count(*) from boardReply2 where boardIdx = 30;
-- board테이블의 고유번호가 30번 자료의 닉네임은?
select nickName from board where idx = 30;
-- board테이블 30번의 닉네임과 부모고유번호, board30번에 달려있는 댓글(boardReply2)의 갯수를 출력?
select (select nickName from board where idx = 30) as 닉네임, boardIdx as 부모고유번호, count(*) from boardReply2 where boardIdx = 30;
-- board테이블의 30번 작성자의 아이디와, 현재글에 달려있는 댓글(boardReply2) 사용자의 닉네임을 출력하시오?
select (select mid from board where idx = 30) as 작성자아이디, nickName from boardReply2 where boardIdx = 30;
select mid, (select nickName from boardReply2 where boardIdx = 30) as 작성자아이디 from board where idx = 30; /* 부모관점에서 보게되면 'where idx=30'의 결과는 1개만을 요구하기에 2개이상의 자료가 출력된다면 오류가 발생한다. */
-- board테이블의 30번 작성자의 아이디와, 현재글에 달려있는 댓글(boardReply2)의 개수를 출력하시오?
select mid,(select count(*) from boardReply2 where boardIdx = 30) from board where idx = 30;

-- 부모테이블(board)에 있는 자료중 뒤에서 5개를 출력하되(아이디,닉네임), 부모테이블에 달려있는 댓글(boardReply2테이블)의 수와 함께 출력하시오.
select idx,mid,nickName,(select count(*) from boardReply2 where boardIdx = board.idx) as replyCount from board order by idx desc limit 5;

-- 최근글 출력연습
select count(*) from board where date_sub(now(), interval 1 day) < wDate;
select * from board where date_sub(now(), interval 2 day) < wDate order by idx desc limit 5;

select date_sub(now(), interval 2 day);

/*
	- 테이블 설계시 제약조건(필드에 대한 제한) - constraint
	  : 생성시에 설정(create), 생성후 변경(alter table)
	1. 필드의 값 허용유무? not null
	2. 필드의 값을 중복허용하지 않겠다? primary key, unique
	3. 필드의 참조유무(다른테이블에서)? foreign key
	4. 필드의 값에 기본값을 지정? default
 */

show tables;

/* unique : 필드가 서로 다른 값을 갖도록 함.(중복할 수 없도록 제약조건설정시 사용) */
create table testStudent (
	idx int not null auto_increment,
	hakbun int not null unique,
	mid varchar(20) not null unique,
	name varchar(20) not null,
	age int default 20,
	primary key(idx, hakbun,mid)
);

drop table testStudent;

desc testStudent;

insert into testStudent values (default, 1111, 'hkd1234', '홍길동', default);
insert into testStudent values (default, 2222, 'kms1234', '김말숙', 26);
insert into testStudent values (default, 3333, 'ohn1234', '오하늘', 30);
insert into testStudent values (default, 4444, 'lkj1234', '이기자', 28);

select * from testStudent;