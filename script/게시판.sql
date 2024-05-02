use jspdb;

create table users(
	uid varchar(20) not null primary key,
    upass varchar(200) not null,
    uname varchar(20) not null,
    phone varchar(20),
    address1 varchar(500),
    address2 varchar(500),
    photo varchar(200),
    jdate datetime default now()
);

drop table users;
insert into users(uid, upass, uname) values('blue', 'qmffn', '김블루');
insert into users(uid, upass, uname) values('sky', 'gksmf', '강하늘');
insert into users(uid, upass, uname) values('purple', 'vjvmf', '박보라');
insert into users(uid, upass, uname) values('jun', 'ho', '이준호');
insert into users(uid, upass, uname) values('code', 'master', '최코드');

select * from users;

update users set address1 = '인천 서구 경서동', phone='010-1234-5678', address2='101동 206호' where uid = 'purple';

alter table users add column udate datetime;

create table bbs(
	bid int auto_increment primary key,
    title varchar(1000) not null,
    contents text,
    writer varchar(20) not null,
    bdate datetime default now(),
    foreign key(writer) references users(uid)
);

insert into bbs(title,contents,writer)
value('What is Lorem Ipsum?','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','blue');
insert into bbs(title,contents,writer)
value('16년차 개발자가 말하는 Node.js를 선택해야 하는 이유','Node.js의 장점은 무엇일까요? 앞으로 취업 전망은 괜찮을까요? 현직 개발자에게 물어봤습니다.','red');
insert into bbs(title,contents,writer)
value('Node js란, 개념부터 특징까지 기업들이 사용하는 이유를 알려드립니다.','과거에 Java Script는 프론트 엔드 분야에서만 실행되는 언어로 취급되었지만 Node.js라는 런타임 환경이 등장함에 따라 프론트엔드와 백엔드 모두를 아우르는 언어가 되었는데요. 이와 같은 Node.js의 등장은 웹 개발 내에 혁신을 일으켰으며 생산성을 향상시키는 원동력이 되어 주었습니다. ','sky');
insert into bbs(title, contents, writer)
value('우래옥 평양냉면 맛집 예약 주차 대기','주소: 서울 중구 창경궁로 62-29(주교동 118-1번지) 전화: 02-2265-0151~2 영업시간: 11:30~21:00 (라스트 오더-20:40), 매주 월요일 정기휴무 우래옥은 평양냉면뿐 아니라 불고기, 육회, 등심, 갈비 맛집으로도 유명해요. 우래옥 메뉴판 우래옥 메뉴판 가장 마음에 드는 것은 모든 재료를 국내산으로만 사용합니다.','blue');
insert into bbs(title, contents, writer)
values('블로그 누적 1,000만 조회수 후기', '2024.02.12에 블로그의 누적 조회수가 1,000만이 되었다. 전체글은 585개가 되었다. 2015.1.31에 첫 글을 작성했으니, 약 9년만에 1,000만이 되었다. 예전에는 6개월에 100만씩 증가했다면, 요즘은 7개월에 100만씩 증가하고 있다. 아무래도 기술 문제를 해결한 사례보다는 현재의 내 생각을 계속 정리하다보니 구글...', 'blue');
insert into bbs(title, contents, writer)
values('[JAVA] 자바 컬렉션', '사용할 수는 있겠지만, 알고리즘의 속도와 안정성에 있어 자바 언어 개발진들이 수십년에 걸쳐 JVM(자바 가상 머신)에 최적화시켜 개량해왔기 때문에, 만일 자바 프로그래밍에서 자료 구조를 사용할 일이 있다면 Collectoin Framework를 가져와 사용하면 된다. 컬렉션 프레임워크 장점 자바만의 컬렉션 프레임워크의...', 'red');
insert into bbs(title, contents, writer)
values('Node의 모듈', 'Node.js에서 모듈이란? 프로그래밍에서 가장 기본적이 개념이 바로 모듈인데요! 프로그램을 작은 기능 단위로 쪼개고 파일 형태로 저장해 놓은 것을 모듈이라고 한답니다. ➡️즉, 이렇게 기능별로 만들어 놓은 함수를 모듈이라고 해요. CommonJS 모듈 시스템과 ES 모듈 시스템 자바스크립트에는 두가지의 모듈 시스템이...', 'sky');
insert into bbs(title, contents, writer)
values('리액트 컴파일러 (React Compiler) 알아보기', '이 문서는 React Compiler가 무엇인지 알아보기 위해 여러 자료들을 수집해서 정리해 놓은 것입니다. React Compiler가 무엇인지 궁금하신 분들에게 도움이 되었으면 합니다. React Compiler 소식 많은 사람들이 React Compiler는 React 19에 등장할 것이라고 예상했습니다. 하지만 리액트 팀의 Joe Savona는 React...', 'blue');

select * from bbs;

create view view_bbs as
select bbs.*, uname, photo
from bbs, users
where uid=writer;

insert into 

select * from view_bbs WHERE title LIKE '%리%' order by bid desc;