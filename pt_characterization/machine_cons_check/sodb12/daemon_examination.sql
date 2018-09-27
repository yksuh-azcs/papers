
DROP TABLE s12_inc128 CASCADE CONSTRAINTS;
CREATE TABLE s12_inc128 AS
	SELECT ar.exp_run_time as task_len,
	       arr.iternum,
	       arr.runtime,
	       proc.procid,
	       proc.processname,
	       (proc.utime+proc.stime)/1000 as pt
	FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
	WHERE 
	    ar.algrunid = arr.algrunid
	and arr.algrunid = proc.algrunid
	and arr.datanum = proc.DATANUM
	and arr.iternum = proc.iternum 
	--and (processname = 'incr_work')
	and (proc.utime+proc.stime) > 0 
	and arr.algrunid IN (17880)
	order by iternum, pt desc;
ALTER TABLE s12_inc128 ADD PRIMARY KEY (task_len, iternum, procid,processname);

DROP TABLE s12_inc128_daemons CASCADE CONSTRAINTS;
CREATE TABLE s12_inc128_daemons AS
	SELECT proc.task_len,
	       proc.iternum,
	       proc.procid,
	       proc.processname,
	       proc.pt
	FROM s12_inc128 proc
	WHERE (processname <> 'incr_work' and processname <> 'proc_monitor')
	and pt > 0
	order by iternum, pt desc;
ALTER TABLE s12_inc128_daemons ADD PRIMARY KEY (task_len, iternum, procid);

SELECT ar.exp_run_time as task_len,
       arr.iternum,
       arr.runtime,
       proc.procid,
       proc.processname,
       (proc.utime+proc.stime)/1000 as pt
FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
WHERE 
    ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
--and (processname = 'incr_work')
and (proc.utime+proc.stime) > 0 
and arr.algrunid IN (23981) 
and arr.iternum = 311
order by iternum, pt desc



select max(pt)
from s12_inc128  
where processname = 'incr_work';

select t2.iternum, 
       t2.procid,
       t2.processname,
       t2.pt
from s12_inc128 t1,
     s12_inc128_daemons t2 
where t1.task_len = t2.task_len 
and t1.iternum = t2.iternum 
and t1.pt = 128255;

select t0.iternum
from 
	(select t2.iternum,
	       t2.procid
	from s12_inc128_daemons t2 
	where t2.pt > 0) t0 
group by t0.iternum 
having count(t0.procid) > 3

   ITERNUM
----------
       138
       181
	33
       228

select iternum, 
       processname,
       procid,
       pt 
from s12_inc128_daemons
where iternum IN (33, 138,181,228) 
order by iternum asc, processname asc

-------
DROP TABLE DIFF_INC_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE DIFF_INC_RUN_PROC_INFO AS
	SELECT arr.algrunid,
	       ar.exp_run_time,
	       arr.iternum,
	       arr.runtime,
	       proc.procid,
	       proc.processname,
	       (proc.utime+proc.stime)/1000 as pt
	FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
	WHERE 
	    ar.algrunid = arr.algrunid
	and arr.algrunid = proc.algrunid
	and arr.datanum = proc.DATANUM
	and arr.iternum = proc.iternum 
	and (proc.utime+proc.stime) > 0
	and arr.algrunid IN (
				23921,23941,23961,23981,
				24001,24021,24041,24061,
				24081,24101,24121,24141
			    )
	order by iternum, pt desc;
ALTER TABLE DIFF_INC_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, procid,processname);

DROP TABLE  INC_BIN_Iters CASCADE CONSTRAINTS;
CREATE TABLE INC_BIN_Iters AS
	select algrunid, 
	       exp_run_time as task_len,
	       pt as bin,
	       iternum
	from DIFF_INC_RUN_PROC_INFO 
	where processname = 'incr_work' 
	and algrunid IN (24021,24121) 
	order by algrunid, exp_run_time, pt;
	--group by algrunid, exp_run_time, pt

DROP TABLE INC_BIN_Proc_Per_Iter CASCADE CONSTRAINTS;
CREATE TABLE INC_BIN_Proc_Per_Iter AS
	SELECT t1.algrunid,
	       t1.task_len,
	       t1.bin, 
	       t1.iternum,
	       t0.procid, 
	       t0.processname,
	       t0.pt 
	FROM DIFF_INC_RUN_PROC_INFO t0, 
	     INC_BIN_Iters t1
	WHERE t1.algrunid = t0.algrunid 
	and t1.task_len = t0.exp_run_time 
	and t1.iternum = t0.iternum 
	and t1.algrunid = t0.algrunid 
	and t0.processname <> 'incr_work' 
	and t0.pt > 0 
	--group by t1.algrunid, t1.bin, t1.iternum, t0.procid, t0.processname 
	order by t1.algrunid, t1.bin, t1.iternum, t0.pt desc, t0.procid; 
ALTER TABLE INC_BIN_Proc_Per_Iter ADD PRIMARY KEY (algrunid, task_len, bin, iternum, procid);

DROP TABLE INC_BIN_Proc_Stat CASCADE CONSTRAINTS;
CREATE TABLE INC_BIN_Proc_Stat AS
	SELECT algrunid, 
		task_len, 
		bin, 
		procid, 
		processname, 
		max(pt) as max_pt,
      		min(pt) as min_pt,
      		round(avg(pt), 2) as avg_pt,
      		round(stddev(pt), 1) as std_pt 
	FROM INC_BIN_Proc_Per_Iter 
	group by algrunid, task_len, bin, procid, processname 
	order by algrunid, task_len, bin, avg_pt desc, processname asc; 
ALTER TABLE INC_BIN_Proc_Stat ADD PRIMARY KEY (algrunid, task_len, bin, procid);

select * from INC_BIN_Proc_Stat;


