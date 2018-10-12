SELECT ar.exp_run_time as task,
       arr.algrunid as runID, 
       arr.iternum,
       arr.runtime,
       --proc.procid,
       proc.processname,
       (proc.utime+proc.stime)/1000 as pt
FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
WHERE 
    ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and (proc.utime+proc.stime) > 0 
and proc.processname = 'kslowd001'
and arr.algrunid IN (18880) 
and arr.iternum = 1;

select 
 case when algrunid = 18880 then 16384 
 END as INC_NUM, 
 processname, min(utime), max(stime)  
from AZDBLab_ProcInfo2 
where algrunid = 18880 
and processname like '%kslowd%'  
group by algrunid, processname;

column processname format a10;
select 
 case 
  when algrunid = 24621 then 128 
  when algrunid = 18880 then 16384 
 END as INC_NUM, 
case 
  when algrunid = 24621 then 300 
  when algrunid = 18880 then 130 
 END as NumSamples, 
 processname, count(processname) as freq, min((utime+stime)/1000) as min_pt, 
				  max((utime+stime)/1000) as max_pt, 
				  round(avg((utime+stime)/1000),2) as avg_pt
from AZDBLab_ProcInfo2 
where algrunid IN (18880, 24621) 
and processname like '%kslowd%'  
group by algrunid, processname;

   INC_NUM NUMSAMPLES PROCESSNAM       FREQ	MIN_PT	   MAX_PT     AVG_PT
---------- ---------- ---------- ---------- ---------- ---------- ----------
     16384	  130 kslowd001 	130	     0		0	   0
     16384	  130 kslowd000 	130	     0		0	   0
       128	  300 kslowd001 	300	   897	     1089     985.81
       128	  300 kslowd000 	300	   892	     1087     986.23

----
DROP TABLE inc1_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE inc1_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- INC1: sodb8, sodb9, sodb10, sodb12
		and arr.algrunid IN (17260,17280,17300,17320)
		) t0
	group by task, processname, runID
	order by task, processname, runID
	;
ALTER TABLE inc1_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);

column PROCESSNAME format a20;
select * from inc1_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
	 1	17260 kslowd000 		    1	       1	  1
	19

	 1	17280 kslowd000 		    1	       1	  1
	15

	 1	17300 kslowd000 		    1	       1	  1
	19


      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
	 1	17260 kslowd001 		    1	       1	  1
	15

	 1	17280 kslowd001 		    1	       1	  1
	18

	 1	17300 kslowd001 		    1	       1	  1
	15


6 rows selected.

DROP TABLE inc16_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE inc16_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- INC1: sodb8, sodb9, sodb10, sodb12
		and arr.algrunid IN (17520,17540,17560,17820)
		) t0
	group by task, processname, runID
	order by task, processname, runID
	;
ALTER TABLE inc16_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from inc16_runs_daemons_stat order by task, processname, runID;
      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
	16	17520 kslowd000 		    1	       1	  1
       243

	16	17540 kslowd000 		    1	       2       1.01
       242

	16	17560 kslowd000 		    1	       1	  1
       241

	16	17520 kslowd001 		    1	       1	  1
       243

	16	17540 kslowd001 		    1	       2	  1
       241

	16	17560 kslowd001 		    1	       1	  1
       243


6 rows selected.

DROP TABLE inc128_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE inc128_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- INC1: sodb8, sodb9, sodb10, sodb12
		and arr.algrunid IN (17700,17720,17740,17880)
		) t0
	group by task, processname, runID
	order by task, processname, runID
	;
ALTER TABLE inc128_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from inc128_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
       128	17700 kslowd000 		    6	       8       6.43
       300

       128	17720 kslowd000 		    6	       7       6.42
       300

       128	17740 kslowd000 		    6	       7       6.42
       300

       128	17700 kslowd001 		    6	       7       6.43
       300

       128	17720 kslowd001 		    6	       8       6.42
       300

       128	17740 kslowd001 		    6	       8       6.43
       300


6 rows selected.

DROP TABLE inc1024_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE inc1024_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- INC1024: sodb9
		and arr.algrunid IN (18640)
		) t0
	group by task, processname, runID
	order by task, processname, runID
	;
ALTER TABLE inc1024_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from inc1024_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
      1024	18640 grep			    1	       7       3.23
	13

      1024	18640 kslowd000 		   51	      53      51.37
       300

      1024	18640 kslowd001 		   51	      53      51.35
       300

      1024	18640 sshd			    1	      18       7.55
	20

DROP TABLE inc16384_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE inc16384_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and (processname IN ('sshd','grep') 
                or (processname like '%kslowd%'))
		and (proc.utime+proc.stime) > 0 
		-- INC16384: sodb9
		and arr.algrunid IN (18880)
		) t0
	group by task, processname, runID
	order by task, processname, runID
	;
ALTER TABLE inc16384_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from inc16384_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
     16384	18880 grep			    0	       9	2.7
       125

     16384	18880 sshd			    0	      20       1.42
       800

DROP TABLE sort100_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE sort100_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('incr_work', 'kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- SORT100: sodb9
		and arr.algrunid IN (23101)
		) t0
	group by task, runID, processname
	order by task, runID, processname
	;
ALTER TABLE sort100_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from sort100_runs_daemons_stat order by task, processname, runID;


      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
       100	23101 kslowd000 		    1	       1	  1
	64

       100	23101 kslowd001 		    1	       2       1.02
	63

       100	23101 sshd			    2	       8	  5
	 4



DROP TABLE sort800_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE sort800_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- SORT800: sodb9
		and arr.algrunid IN (23341)
		) t0
	group by task, runID, processname
	order by task, runID, processname
	;
ALTER TABLE sort800_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from sort800_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
       800	23341 kslowd000 		   13	      15      13.78
       300

       800	23341 kslowd001 		   13	      15      13.78
       300

       800	23341 sshd			    1	       9	4.8
	 5


DROP TABLE MAT1K_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE MAT1K_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('incr_work', 'kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- MATC1K, MATR1K: sodb10, sodb12
		and arr.algrunid IN (23181,23201)
		) t0
	group by task, runID, processname
	order by task, runID, processname
	;
ALTER TABLE MAT1K_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from MAT1K_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAM   MIN_TIME   MAX_TIME	 AVG_TIME     NITERS
---------- ---------- ---------- ---------- ---------- ---------- ----------
      1024	23181 incr_work        3011	  9067	  3298.51	 300
      1024	23181 kslowd000 	  1	     1		1	  50
      1024	23181 kslowd001 	  1	     1		1	  52
      1024	23181 sshd		  1	     7	     4.25	   4
      1024	23201 incr_work        3024	  9030	  3282.89	 300
      1024	23201 kslowd000 	 38	   161	   150.85	  52
      1024	23201 kslowd001 	146	   161	   154.28	  50
      1024	23201 sshd		  1	     7		4	   4

8 rows selected.

DROP TABLE MAT8K_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE MAT8K_runs_daemons_stat AS
	SELECT task,
	       runID,
	       processname,
	       min(pt) as min_time,
	       max(pt) as max_time,
	       round(avg(pt),2) as avg_time,	
	       count(processname) as niters
	FROM
		(SELECT ar.exp_run_time as task,
		       arr.algrunid as runID, 
		       arr.iternum,
		       arr.runtime,
		       --proc.procid,
		       proc.processname,
		       (proc.utime+proc.stime)/1000 as pt
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE 
		    ar.algrunid = arr.algrunid
		and arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and processname IN ('incr_work', 'kslowd000','kslowd001','sshd','grep')
		and (proc.utime+proc.stime) > 0 
		-- MATC8K, MATR8K: sodb10, sodb12
		and arr.algrunid IN (23401,23361)
		) t0
	group by task, runID, processname
	order by task, runID, processname
	;
ALTER TABLE MAT8K_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);
column PROCESSNAME format a20;
select * from MAT8K_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAM   MIN_TIME   MAX_TIME	 AVG_TIME     NITERS
---------- ---------- ---------- ---------- ---------- ---------- ----------
      8192	23361 grep		  1	     1		1	   4
      8192	23361 incr_work     2183188    2183317 2183258.32	 300
      8192	23361 kslowd000       16540	 17033	 16780.43	 300
      8192	23361 kslowd001       16541	 17000	 16777.18	 300
      8192	23361 sshd		  1	    20	     5.91	  43
      8192	23401 incr_work     2057680    2057763 2057720.43	 300
      8192	23401 kslowd000 	102	   107	   103.33	 300
      8192	23401 kslowd001 	102	   108	   103.27	 300
      8192	23401 sshd		  1	     8	     4.17	  42

