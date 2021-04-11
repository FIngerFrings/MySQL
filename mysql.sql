/* 1.取得每个部门最高薪水的人员名称*/
select e.ename, e.sal, e.deptno from emp e join (select max(sal) as maxsal, deptno from emp group by deptno) as t on e.sal = t.maxsal and e.deptno = t.deptno;

/* 2.哪些人的薪水在部门的平均薪水之上*/
select e.ename, e.sal from emp as e join (select avg(sal) as avgsal, deptno from emp group by deptno) as a on e.sal > a.avgsal and e.deptno = a.deptno;

/* 3.取得部门中（所有人的）平均的薪水等级*/
select e.deptno, avg(s.grade) as 'sal<grade>' from emp as e join salgrade as s on e.sal between losal and hisal group by deptno;

/* 4.不准用组函数（Max），取得最高薪水（给出两种解决方案）*/

