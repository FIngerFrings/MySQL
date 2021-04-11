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
