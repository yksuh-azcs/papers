-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 03/29/17
-- Description: Define tables/views for EMP evaluation on INC programs 

DROP TABLE S9_1_INC_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE S9_1_INC_RUN_PROC_INFO AS
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
	-- sodb9
	-- 			1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096
	and arr.algrunid IN (18140,18160,18180,18200,18220,18240,18260,18280,18300,18320,18400,17980,17940)
	order by iternum, pt desc;
ALTER TABLE S9_1_INC_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, procid,processname);

DROP TABLE S9_1_INC_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE S9_1_INC_RUN_Stat AS
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
	FROM S9_1_INC_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE S9_1_INC_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select exp_run_time, numTrials, avg_et, std_et, avg_pt, std_pt from S9_1_INC_RUN_Stat

EXP_RUN_TIME  NUMTRIALS     AVG_ET     STD_ET	  AVG_PT     STD_PT
------------ ---------- ---------- ---------- ---------- ----------
	   1	   1000    1002.63	  1.2	 1002.48	1.1
	   2	   1000    2004.79	  1.8	 2004.54	1.6
	   4	   1000    4009.13	  2.5	 4008.71	2.4
	   8	   1000    8019.29	  2.9	 8018.19	2.8
	  16	   1000   16036.47	  2.3	 16034.5	2.2
	  32	   1000   32072.15	  3.5	32068.39	2.8
	  64	   1000   64142.87	    3	64135.62	2.9
	 128	    300  128286.86	  4.9  128271.88	3.2
	 256	    300  256574.38	  5.9  256544.79	4.6
	 512	    300  513150.17	   99	513086.7       16.7
	1024	    300 1026281.42	   10 1026164.92	6.4
\	2048	    300 2052505.16	 13.6 2052271.61	9.4
	4096	    300 4104004.76	 18.8 4103993.89       12.4

8 rows selected.
--column PROCESSNAME format a15
DROP TABLE S9_1_INC_RUN_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE S9_1_INC_RUN_CUTOFF_Info AS
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_1_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_1_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_1_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_1_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_1_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	order by exp_run_time, iternum
	;
ALTER TABLE S9_1_INC_RUN_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, processname, iternum);
-- select distinct exp_run_time, processname, round(avg(pt),0) as avg_pt from S9_1_INC_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc
-- select distinct exp_run_time, iternum from S9_1_INC_RUN_CUTOFF_Info where exp_run_time = 1024 and iter num 
--select distinct exp_run_time, processname,  count(iternum) as numOls, min(pt) as min_pt, round(avg(pt),0) as avg_pt, round(stddev(pt),1) as std_pt from S9_1_INC_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc

select distinct exp_run_time, algrunid, iternum from S9_1_INC_RUN_CUTOFF_Info order by exp_run_time, algrunid, iternum

EXP_RUN_TIME   ALGRUNID    ITERNUM
------------ ---------- ----------
	  32	  18240        433
	 128	  18280 	26
	 256	  18300        199
	 512	  18320        114
	 512	  18320        186
	 512	  18320        285
	1024	  18400 	17
	1024	  18400        101
	1024	  18400        184
	1024	  18400        268
	4096	  17940 	 5
	4096	  17940 	26
	4096	  17940 	47
	4096	  17940 	68
	4096	  17940 	89
	4096	  17940        110
	4096	  17940        131
	4096	  17940        152
	4096	  17940        173
	4096	  17940        195
	4096	  17940        215
	4096	  17940        236
	4096	  17940        258
	4096	  17940        278
	4096	  17940        299

