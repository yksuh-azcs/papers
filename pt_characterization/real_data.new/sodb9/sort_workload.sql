-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 04/12/2018
-- Description: Define tables/views for EMP evaluation on INC programs 

DROP TABLE SRT_INC_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE SRT_INC_RUN_PROC_INFO AS
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
				 24201, 24161, 24241, 24181, 24221
			    )
	order by iternum, pt desc;
ALTER TABLE SRT_INC_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, procid,processname);

DROP TABLE SRT_INC_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE SRT_INC_RUN_Stat AS
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
	FROM SRT_INC_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE SRT_INC_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select algrunid, exp_run_time, numTrials, avg_et, std_et, avg_pt, std_pt from SRT_INC_RUN_Stat order by algrunid;

  ALGRUNID EXP_RUN_TIME  NUMTRIALS     AVG_ET	  STD_ET     AVG_PT	STD_PT
---------- ------------ ---------- ---------- ---------- ---------- ----------
     24161	    100        300    4232.03	     1.8    4231.49	   1.7
     24181	    200        300   17281.87	     1.4   17279.69	   1.4
     24201	    400        300   68908.26	   339.5   68900.24	 339.4
     24221	    800        300  277274.84	   237.3  277242.95	 236.7
     24241	   1000        161  430711.99	   223.1   430663.5	   223

--column PROCESSNAME format a15
DROP TABLE SRT_INC_RUN_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE SRT_INC_RUN_CUTOFF_Info AS
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from SRT_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from SRT_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from SRT_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from SRT_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from SRT_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	order by exp_run_time, iternum
	;
ALTER TABLE SRT_INC_RUN_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, processname, iternum);
select distinct exp_run_time, algrunid, iternum from SRT_INC_RUN_CUTOFF_Info order by exp_run_time, algrunid, iternum;

EXP_RUN_TIME   ALGRUNID    ITERNUM
------------ ---------- ----------
	 800	  24221 	 6
	1000	  24241 	 9


