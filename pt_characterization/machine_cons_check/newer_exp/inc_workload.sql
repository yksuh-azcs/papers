-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 01/11/17
-- Description: Define tables/views for EMP evaluation on INC programs 

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

DROP TABLE DIFF_INC_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE DIFF_INC_RUN_Stat AS
	SELECT erpi.algrunid,
	       erpi.exp_run_time,
	       erpi.processname,
	       count(erpi.iternum) as numTrials,
	       round(avg(runtime), 2) as avg_et,
	       round(stddev(runtime), 1) as std_et,
	       round((round(stddev(runtime),1) / round(avg(runtime),0)), 6) as re_et,
	       round(avg(pt), 2) as avg_pt,
	       round(stddev(pt), 1) as std_pt,
	       round((round(stddev(pt),1) / round(avg(pt),0)), 6) as re_pt
	FROM DIFF_INC_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE DIFF_INC_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select algrunid, exp_run_time, numTrials, avg_et, std_et, avg_pt, std_pt from DIFF_INC_RUN_Stat order by algrunid;

  ALGRUNID EXP_RUN_TIME  NUMTRIALS     AVG_ET	  STD_ET     AVG_PT	STD_PT
---------- ------------ ---------- ---------- ---------- ---------- ----------
     23921	     16       1000	16036	     8.8   16034.08	   8.8
     23941	     16       1000   16036.13	     2.4   16034.21	   2.3
     23961	     16       1000   16036.51	     1.9    16034.6	   1.7
     23981	     16       1000    16285.9	    74.9   16037.36	   1.4
     24001	     13       1000   13029.61	     7.8   13028.02	   7.7
     24021	     13       1000   13029.62	     3.1      13028	     3
     24041	     13       1000   13029.96	     1.2   13028.34	     1
     24061	     13       1000   13232.77	    72.3   13030.63	   2.4
     24081	   17.2       1000   17238.52	     8.9    17236.5	   8.9
     24101	   17.2       1000   17238.69	     2.3    17236.6	   2.1
     24121	   17.2       1000   17238.97	       2   17236.93	   1.8
     24141	   17.2       1000   17504.53	    67.6   17240.39	   1.5

--column PROCESSNAME format a15
DROP TABLE DIFF_INC_RUN_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE DIFF_INC_RUN_CUTOFF_Info AS
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from DIFF_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from DIFF_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from DIFF_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from DIFF_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from DIFF_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	order by exp_run_time, iternum
	;
ALTER TABLE DIFF_INC_RUN_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, processname, iternum);
-- select distinct exp_run_time, processname, round(avg(pt),0) as avg_pt from DIFF_INC_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc
-- select distinct exp_run_time, iternum from DIFF_INC_RUN_CUTOFF_Info where exp_run_time = 1024 and iter num 
--select distinct exp_run_time, processname,  count(iternum) as numOls, min(pt) as min_pt, round(avg(pt),0) as avg_pt, round(stddev(pt),1) as std_pt from DIFF_INC_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc

select distinct exp_run_time, algrunid, iternum from DIFF_INC_RUN_CUTOFF_Info order by exp_run_time, algrunid, iternum;

EXP_RUN_TIME   ALGRUNID    ITERNUM
------------ ---------- ----------
	17.2	  24101        633
	17.2	  24141        596


