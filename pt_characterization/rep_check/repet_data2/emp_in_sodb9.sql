-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 03/29/17
-- Description: Define tables/views for EMP evaluation on INC programs 

DROP TABLE S9_2_INC_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE S9_2_INC_RUN_PROC_INFO AS
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
	--and arr.algrunid IN (18140,18160,18180,18200,18220,18240,18260,18280,18300,18320,18400,17980,17940)
	and arr.algrunid IN (18420,18440,18460,18480,18500,18520,18540,18560,18580,18600,18620,18640,18100,18120)
	order by iternum, pt desc;
ALTER TABLE S9_2_INC_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, procid,processname);

DROP TABLE S9_2_INC_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE S9_2_INC_RUN_Stat AS
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
	FROM S9_2_INC_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE S9_2_INC_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select exp_run_time, numTrials, avg_et, std_et, avg_pt, std_pt from S9_2_INC_RUN_Stat

EXP_RUN_TIME  NUMTRIALS     AVG_ET     STD_ET	  AVG_PT     STD_PT
------------ ---------- ---------- ---------- ---------- ----------
	   1	   1000    1002.65	  1.2	 1002.49	1.1
	   2	   1000    2004.76	  1.8	 2004.57	1.6
	   4	   1000    4009.18	  2.5	 4008.75	2.4
	   8	   1000     8019.3	  3.1	 8018.13	2.8
	  16	   1000    16036.5	  2.9	16034.55	2.2
	  32	   1000   32072.07	  2.8	 32068.4	2.8
	  64	   1000   64142.81	  3.5	64135.51	2.9
	 128	    300  128286.59	    3  128271.89	2.9
	 256	    300  256573.55	  6.1  256543.82	4.4
	 512	    300  513141.18	  7.5	513082.6	5.3
	1024	    300 1026297.99	  8.8 1026181.07	6.2
	2048	    300  2052508.7	 61.2 2052272.34       13.7
	4096	    300 4103999.86	 17.5 4103988.69	 12

8 rows selected.

--column PROCESSNAME format a15
DROP TABLE S9_2_INC_RUN_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE S9_2_INC_RUN_CUTOFF_Info AS
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_2_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_2_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_2_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_2_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from S9_2_INC_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	order by exp_run_time, iternum
	;
ALTER TABLE S9_2_INC_RUN_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, processname, iternum);
-- select distinct exp_run_time, processname, round(avg(pt),0) as avg_pt from S9_2_INC_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc
-- select distinct exp_run_time, iternum from S9_2_INC_RUN_CUTOFF_Info where exp_run_time = 1024 and iter num 
--select distinct exp_run_time, processname,  count(iternum) as numOls, min(pt) as min_pt, round(avg(pt),0) as avg_pt, round(stddev(pt),1) as std_pt from S9_2_INC_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc

select distinct exp_run_time, algrunid, iternum from S9_2_INC_RUN_CUTOFF_Info order by exp_run_time, algrunid, iternum

EXP_RUN_TIME   ALGRUNID    ITERNUM
------------ ---------- ----------
	   8	  18500        948
	  64	  18560        578
	 256	  18600 	81
	 512	  18620 	58
	 512	  18620        226
	1024	  18640 	46
	1024	  18640        130
	1024	  18640        214
	1024	  18640        299
	2048	  18100        166
	4096	  18120 	11
	4096	  18120 	32
	4096	  18120 	53
	4096	  18120 	74
	4096	  18120 	95
	4096	  18120        116
	4096	  18120        137
	4096	  18120        158
	4096	  18120        179
	4096	  18120        200
	4096	  18120        221
	4096	  18120        242
	4096	  18120        264
	4096	  18120        285
