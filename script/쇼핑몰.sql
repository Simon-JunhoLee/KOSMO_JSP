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
insert into users (uid, upass, uname) values('blue', 'pass', '김블루');
insert into users (uid, upass, uname) values('admin', 'pass', '관리자');

select * from users;

create table cart(
	uid varchar(30) not null,
    gid char(11) not null,
    qnt int default 0,
    primary key(uid, gid),
    foreign key(uid) references users(uid),
    foreign key(gid) references goods(gid)
);

create view view_cart as
select c.*, g.title, g.price, g.image, g.brand
from cart c, goods g
where c.gid = g.gid;

select * from view_cart;

create table favorite(
	uid varchar(30) not null,
    gid char(11) not null,
    regDate datetime default now(),
    primary key(uid, gid),
    foreign key(uid) references users(uid),
    foreign key(gid) references goods(gid)
);

insert into favorite(uid, gid) values('jun', '45885355225');
insert into favorite(uid, gid) values('jun', '84155997028');
insert into favorite(uid, gid) values('blue', '45885355225');
insert into favorite(uid, gid) values('young', '45885355225');

select * from favorite;
select * from favorite where uid = 'jun';

select *, 
(select count(*) from favorite f where uid = 'jun' and f.gid = g.gid) ucnt, 
(select count(*) from favorite f where f.gid = g.gid) fcnt
from goods g
order by f.regDate desc;