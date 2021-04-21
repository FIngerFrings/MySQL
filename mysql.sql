/* 1.取得每个部门最高薪水的人员名称*/
select e.ename, e.sal, e.deptno from emp e join (select max(sal) as maxsal, deptno from emp group by deptno) as t on e.sal = t.maxsal and e.deptno = t.deptno;

/* 2.哪些人的薪水在部门的平均薪水之上*/
select e.ename, e.sal from emp as e join (select avg(sal) as avgsal, deptno from emp group by deptno) as a on e.sal > a.avgsal and e.deptno = a.deptno;

/* 3.取得部门中（所有人的）平均的薪水等级*/
select e.deptno, avg(s.grade) as 'sal<grade>' from emp as e join salgrade as s on e.sal between losal and hisal group by deptno;

/* 4.不准用组函数（Max），取得最高薪水（给出两种解决方案）*/
/* 第一种方案 降序取第一个*/
 select sal from emp order by sal desc limit 1;
 /* 第二种方案 子连接，找出a表中所有小于b表中sal的值，然后不在里面的就是最大值*/
 select sal from emp where sal not in (select distinct a.sal from emp a join emp b on a.sal < b.sal);
 
 /* 5.取得平均薪水最高的部门的部门编号（至少给出两种解决方案）*/
 /* 第一种方案 降序取第一个*/
 select deptno from (select deptno, avg(sal) as avgsal from emp group by deptno) as a order by avgsal desc limit 1
 /* 第二种方案 用max找出最大值*/
 select a.deptno, max(a.avgsal) from (select deptno, avg(sal) as avgsal from emp group by deptno) as a;
 /* 第二种方案会显示出部门编号和平均薪资，下面这一句实际上就是在上面这一句又套了一层，但能只显示出部门编号*/
 select b.deptno from (select a.deptno, max(a.avgsal) from (select deptno, avg(sal) as avgsal from emp group by deptno) as a) as b;
 /* 第三种方案 先找出最大值，然后使用where语句部门编号*/
 select a.deptno from (select deptno, avg(sal) as avgsal from emp group by deptno) as a where a.avgsal = (select max(a.avgsal) from (select deptno, avg(sal) as avgsal from emp group by deptno) as a);


/* 6.取得平均薪水最高的部门的部门名称 */
/* 该方法就是先找出平均薪资最大的部门编号，然后在dept表中找出对应的名字 */
select dname from dept where deptno = (select a.deptno from (select deptno, avg(sal) as avgsal from emp group by deptno order by avgsal desc limit 1) as a);

/* 7.求平均薪水的等级最低的部门的部门名称*/
/* 该方法就是先找出等级最低的部门编号，然后找到对应的部门名称 */
select c.dname from dept as c where c.deptno = (select a.deptno from (select deptno, avg(sal) as avgsal from emp group by deptno) as a left join salgrade as b on a.avgsal between b.losal and b.hisal order by b.grade asc limit 1);

/* 8.取得比普通员工(员工代码没有在 mgr 字段上出现的)的最高薪水还要高的领导人姓名*/
select ename, sal from emp where sal > (select max(sal) as maxsal from emp where empno not in (select distinct mgr from emp where mgr is not null));
                                                                                               
/* 9.取得薪水最高的前五名员工 */
select ename, sal from emp order by sal desc limit 5;

/* 10.取得薪水最高的第六到第十名员工 */
select ename, sal from emp order by sal desc limit 5, 5;

/* 11.取得最后入职的 5 名员工 */
select ename, hiredate from emp order by substr(hiredate, 1, 4) desc, substr(hiredate, 6, 2) desc, substr(hiredate, 9, 2) desc limit 5;

/* 12.取得每个薪水等级有多少员工*/
select b.grade, count(b.grade) from emp as a join salgrade as b on a.sal between b.losal and b.hisal group by b.grade;
