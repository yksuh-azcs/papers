
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

DROP TABLE s12_matr8k CASCADE CONSTRAINTS;
CREATE TABLE s12_matr8k AS
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
	and (proc.utime+proc.stime) > 0 
	and arr.algrunid IN (23361)
	order by iternum, pt desc;
ALTER TABLE s12_matr8k ADD PRIMARY KEY (task_len, iternum, procid,processname);

DROP TABLE s12_matr8k_daemons CASCADE CONSTRAINTS;
CREATE TABLE s12_matr8k_daemons AS
	SELECT proc.task_len,
	       proc.iternum,
	       proc.procid,
	       proc.processname,
	       proc.pt
	FROM s12_matr8k proc
	WHERE (processname <> 'incr_work' and processname <> 'proc_monitor')
	and pt > 0
	order by iternum, pt desc;
ALTER TABLE s12_matr8k_daemons ADD PRIMARY KEY (task_len, iternum, procid);

select max(pt)
from s12_matr8k
where processname = 'incr_work';

select * 
from s12_matr8k 
where iternum = 

select t0.iternum
from 
	(select t2.iternum,
	       t2.procid
	from s12_matr8k_daemons t2 
	where t2.pt > 0) t0 
group by t0.iternum 
having count(t0.procid) > 13

   ITERNUM
----------
       210
       249
       119
	36
       216

select iternum, procid, processname, pt  
from s12_matr8k 
where iternum IN (36,119,210,216,249) 
order by iternum asc, pt desc

   ITERNUM PROCESSNAME				PROCID	       PT
---------- -------------------------------- ---------- ----------
	36 kslowd001				   167	    16959
	36 kslowd000				   166	    16707
	36 md0_raid1				   482	       19
	36 sshd 				 17398	       18
	36 jbd2/md0-8				   495	       13
	36 bash 				 17400		7
	36 flush-9:0				   718		3
	36 java 				 17234		2
	36 kblockd/0				    16		2
	36 grep 				 17406		1
	36 sshd 				 17399		1

   ITERNUM PROCESSNAME				PROCID	       PT
---------- -------------------------------- ---------- ----------
	36 events/0				     7		1
	36 bash 				 17403		1
	36 khugepaged				    30		1
       119 kslowd000				   166	    16839
       119 kslowd001				   167	    16784
       119 md0_raid1				   482	       16
       119 jbd2/md0-8				   495	       13
       119 sshd 				 17773		7
       119 sshd 				 17771		7
       119 kblockd/0				    16		4
       119 events/0				     7		3

   ITERNUM PROCESSNAME				PROCID	       PT
---------- -------------------------------- ---------- ----------
       119 flush-9:0				   718		3
       119 java 				 17234		2
       119 sshd 				 17772		2
       119 sshd 				  2148		1
       119 sshd 				 17774		1
       119 java 				 17768		1
       210 kslowd001				   167	    16812
       210 kslowd000				   166	    16759
       210 md0_raid1				   482	       22
       210 sshd 				 18184	       16
       210 jbd2/md0-8				   495	       12

   ITERNUM PROCESSNAME				PROCID	       PT
---------- -------------------------------- ---------- ----------
       210 bash 				 18186		6
       210 flush-9:0				   718		4
       210 events/0				     7		2
       210 kblockd/0				    16		2
       210 java 				 17234		2
       210 sshd 				 18185		1
       210 java 				 18181		1
       210 bash 				 18189		1
       210 grep 				 18192		1
       216 kslowd001				   167	    16836
       216 kslowd000				   166	    16679

   ITERNUM PROCESSNAME					PROCID	       PT
---------- -------------------------------- ---------- ----------
       216 md0_raid1				   482	       18
       216 jbd2/md0-8				   495		8
       216 kblockd/0				    16		6
       216 sshd 				 18221		6
       216 sshd 				 18219		6
       216 sshd 				 18222		2
       216 sshd 				 18220		2
       216 java 				 17234		2
       216 java 				 18216		1
       216 abrt-dump-oops			  2484		1
       216 events/0				     7		1

   ITERNUM PROCESSNAME				PROCID	       PT
---------- -------------------------------- ---------- ----------
       216 init 				     1		1
       249 kslowd000				   166	    16917
       249 kslowd001				   167	    16797
       249 md0_raid1				   482	       20
       249 sshd 				 18355	       17
       249 kblockd/0				    16		8
       249 bash 				 18357		5
       249 jbd2/md0-8				   495		5
       249 flush-9:0				   718		4
       249 java 				 17234		2
       249 events/0				     7		2

   ITERNUM PROCESSNAME				PROCID	       PT
---------- -------------------------------- ---------- ----------
       249 bash 				 18360		1
       249 grep 				 18363		1
       249 sshd 				 18356		1
       249 sshd 				  2148		1

70 rows selected.


select iternum, 
       processname,
       procid,
       pt 
from s12_matr8k_daemons
where iternum IN (36,119,210,216,249) 
order by iternum asc, pt desc

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
	36	17244 incr_work 			  2183274
	36	  167 kslowd001 			    16959
	36	  166 kslowd000 			    16707
	36	14166 proc_monitor			      200
	36	  482 md0_raid1 			       19
	36	17398 sshd				       18
	36	  495 jbd2/md0-8			       13
	36	17400 bash					7
	36	  718 flush-9:0 				3
	36	17234 java					2
	36	   16 kblockd/0 				2

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
	36	17406 grep					1
	36	17399 sshd					1
	36	    7 events/0					1
	36	17403 bash					1
	36	   30 khugepaged				1
       119	17244 incr_work 			  2183217
       119	  166 kslowd000 			    16839
       119	  167 kslowd001 			    16784
       119	14166 proc_monitor			      204
       119	  482 md0_raid1 			       16
       119	  495 jbd2/md0-8			       13

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
       119	17773 sshd					7
       119	17771 sshd					7
       119	   16 kblockd/0 				4
       119	    7 events/0					3
       119	  718 flush-9:0 				3
       119	17234 java					2
       119	17772 sshd					2
       119	 2148 sshd					1
       119	17768 java					1
       119	17774 sshd					1
       210	17244 incr_work 			  2183266

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
       210	  167 kslowd001 			    16812
       210	  166 kslowd000 			    16759
       210	14166 proc_monitor			      204
       210	  482 md0_raid1 			       22
       210	18184 sshd				       16
       210	  495 jbd2/md0-8			       12
       210	18186 bash					6
       210	  718 flush-9:0 				4
       210	    7 events/0					2
       210	   16 kblockd/0 				2
       210	17234 java					2

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
       210	18185 sshd					1
       210	18181 java					1
       210	18192 grep					1
       210	18189 bash					1
       216	17244 incr_work 			  2183246
       216	  167 kslowd001 			    16836
       216	  166 kslowd000 			    16679
       216	14166 proc_monitor			      202
       216	  482 md0_raid1 			       18
       216	  495 jbd2/md0-8				8
       216	   16 kblockd/0 				6

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
       216	18221 sshd					6
       216	18219 sshd					6
       216	18222 sshd					2
       216	18220 sshd					2
       216	17234 java					2
       216	18216 java					1
       216	    7 events/0					1
       216	    1 init					1
       216	 2484 abrt-dump-oops				1
       249	17244 incr_work 			  2183258
       249	  166 kslowd000 			    16917

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
       249	  167 kslowd001 			    16797
       249	14166 proc_monitor			      204
       249	  482 md0_raid1 			       20
       249	18355 sshd				       17
       249	   16 kblockd/0 				8
       249	18357 bash					5
       249	  495 jbd2/md0-8				5
       249	  718 flush-9:0 				4
       249	17234 java					2
       249	    7 events/0					2
       249	18363 grep					1

   ITERNUM     PROCID PROCESSNAME			       PT
---------- ---------- -------------------------------- ----------
       249	18356 sshd					1
       249	18360 bash					1
       249	 2148 sshd					1

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
-- MATR8K

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
and arr.algrunid IN (23361) 
--and arr.iternum = 311
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


