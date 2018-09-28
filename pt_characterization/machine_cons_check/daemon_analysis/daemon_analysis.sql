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


DROP TABLE MATR8K_runs_daemons_stat CASCADE CONSTRAINTS;
CREATE TABLE MATR8K_runs_daemons_stat AS
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
		-- MATC8K, MATR8K: sodb10, sodb12
		and arr.algrunid IN (23401,23361)
		) t0
	group by task, runID, processname
	order by task, runID, processname
	;
ALTER TABLE MATR8K_runs_daemons_stat ADD PRIMARY KEY (task, runID,processname);

column PROCESSNAME format a20;
select * from MATR8K_runs_daemons_stat order by task, processname, runID;

      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
      8192	23361 grep			    1	       1	  1
	 4

      8192	23361 kslowd000 		16540	   17033   16780.43
       300

      8192	23401 kslowd000 		  102	     107     103.33
       300


      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
      8192	23361 kslowd001 		16541	   17000   16777.18
       300

      8192	23401 kslowd001 		  102	     108     103.27
       300

      8192	23361 sshd			    1	      20       5.91
	43


      TASK	RUNID PROCESSNAME	     MIN_TIME	MAX_TIME   AVG_TIME
---------- ---------- -------------------- ---------- ---------- ----------
    NITERS
----------
      8192	23401 sshd			    1	       8       4.17
	42



7 rows selected.

