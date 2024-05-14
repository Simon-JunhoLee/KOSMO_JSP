use shopdb;
create table goods(
	gid char(11) not null primary key,
    title varchar(500) not null,
    price int default 0,
    brand varchar(500),
    image varchar(500),
    regDate datetime default now()
);

desc goods;

select * from goods;

create table users(
	uid varchar(30) not null primary key,
    upass varchar(30) not null,
    uname varchar(30) not null
);

insert into users (uid, upass, uname) values('red', 'pass', '김레드');
insert into users (uid, upass, uname) values('jun', 'pass', '이준호');
insert into users (uid, upass, uname) values('sik', 'pass', '신준식');
insert into users (uid, upass, uname) values('sang', 'pass', '박상균');
insert into users (uid, upass, uname) values('young', 'pass', '김영훈');
