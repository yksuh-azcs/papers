-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 02/24/18
-- Description: Define tables/views for EMP evaluation on matrix multiplication programs

DROP TABLE MATR2_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_PROC_INFO AS
	SELECT arr.algrunid,
	       ar.exp_run_time,
	       arr.iternum,
	       arr.runtime,
	       proc.processname,
	       sum((proc.utime+proc.stime)/1000) as pt
	FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
	WHERE 
	    ar.algrunid = arr.algrunid
	and arr.algrunid = proc.algrunid
	and arr.datanum = proc.DATANUM
	and arr.iternum = proc.iternum 
	and (proc.utime+proc.stime) > 0
	and arr.algrunid IN (
		-- MATC1K, MATC4K, MATC8K
                --13240,12900,13020,
		-- and arr.iternum <= 10 -- the first 10 
                --MATC2K
               --13420
                -- MATC250, MATC500, MATC1K, MATC2K, MATC4K, MATC8K, MATC16K
                --22280,22300,22320,22340,22420,22480,21840
		23181,23241,23321,23401
	   -- and arr.iternum > 20 and arr.iternum <= 30 -- middle 10 
        )
	group by arr.algrunid, ar.exp_run_time, arr.iternum, arr.runtime, proc.processname
	order by iternum, pt desc;
ALTER TABLE MATR2_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, processname);
-- SELECT exp_run_time, iternum, processname, pt as PRTIME from MATR2_RUN_PROC_INFO where algrunid = 13860 and iternum IN (1,2,3,4,5,6,7,8,9,10) order by exp_run_time asc, iternum asc, pt desc
-- SELECT exp_run_time, iternum, processname, pt as PRTIME from MATR2_RUN_PROC_INFO where algrunid = 13960 and iternum IN (1,2,3,4,5,6,7,8,9,10) order by exp_run_time asc, iternum asc, pt desc

DROP TABLE MATC2_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Stat AS
	SELECT erpi.algrunid,
	       erpi.exp_run_time,
	       erpi.processname,
	       count(erpi.iternum) as numTrials,
	       round(avg(runtime), 0) as avg_et,
	       round(stddev(runtime), 1) as std_et,
	       round((round(stddev(runtime),1) / round(avg(runtime),0)), 6) as re_et,
	       round(avg(pt), 0) as avg_pt,
	       round(stddev(pt), 1) as std_pt,
	       round((round(stddev(pt),1) / round(avg(pt),0)), 6) as re_pt
	FROM MATR2_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	--and (algrunid IN (13240,13420,12900,13020) and iternum >= 6 and iternum <= 40)
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE MATC2_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select * from MATC2_RUN_Stat;

DROP TABLE MATC2_RUN_TASK_TIME CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_TASK_TIME AS
	SELECT sort_run.algrunid,
	       sort_run.exp_run_time,
	       round(median(sort_run.pt), 0) as task_time,
	       round(avg(sort_run.pt), 0) as avg_task_time,
	       round(stddev(sort_run.pt), 1) as std_task_time
	FROM MATR2_RUN_PROC_INFO sort_run, MATC2_RUN_Stat sort_stat
	WHERE sort_run.algrunid = sort_stat.algrunid 
	and sort_run.exp_run_time = sort_stat.exp_run_time
	and sort_run.processname = 'incr_work'
	and sort_run.pt <= (sort_stat.avg_pt+2*sort_stat.std_pt) 
	and sort_run.pt >= (sort_stat.avg_pt-2*sort_stat.std_pt) 
	having count(sort_run.iternum) > 6 --- at least 6 trials
	group by sort_run.algrunid, sort_run.exp_run_time
	order by exp_run_time;
ALTER TABLE MATC2_RUN_TASK_TIME ADD PRIMARY KEY (algrunid, exp_run_time);

--- select algrunid, exp_run_time, task_time from MATC2_RUN_TASK_TIME order by exp_run_time, algrunid asc

  ALGRUNID EXP_RUN_TIME  TASK_TIME
---------- ------------ ----------
     22280	    250        343
     22300	    500        687
     22320	   1024       1407
     22340	   2048       2813
     22420	   4096       5626
     22480	   8192      11249
     21840	  16000      21965

  ALGRUNID EXP_RUN_TIME  TASK_TIME
---------- ------------ ----------
     23181	   1024       3014
     23241	   2048      33167
     23321	   4096     344097
     23401	   8192    2057740

DROP TABLE MATC_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE MATC_CUTOFF_Info AS
    select distinct dpi.exp_run_time,
           	    dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
	(dpi.processname = ild.PROCESSNAME and ((select task_time from MATC2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from MATC2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from MATC2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from MATC2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    order by exp_run_time, iternum;
ALTER TABLE MATC_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, iternum);
-- select * from MATC_CUTOFF_Info order by exp_run_time, iternum


select t1.exp_run_time, coalesce(count(distinct t0.iternum), 0) as numOutliers, max(t1.iternum) as numTrials
from MATR2_RUN_PROC_INFO t1 
LEFT OUTER JOIN MATC_CUTOFF_Info t0
ON t0.EXP_RUN_TIME = t1.EXP_RUN_TIME and t0.iternum > 30 and t0.iternum <= 40
WHERE t1.iternum <= 10 
group by t1.exp_run_time
order by exp_run_time

EXP_RUN_TIME NUMOUTLIERS  NUMTRIALS
------------ ----------- ----------
	1000	       0	 10
	2000	       0	 10
	4000	       0	 10
	8000	       1	 10

DROP TABLE MATC2_RUN_V4_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_V4_Stat AS
	SELECT erpi.algrunid,
	       erpi.exp_run_time,
	       erpi.processname,
	       count(erpi.iternum) as numTrials,
	       round(avg(runtime), 0) as avg_et,
	       round(stddev(runtime), 1) as std_et,
	       round((round(stddev(runtime),1) / round(avg(runtime),0)), 6) as re_et,
	       round(avg(pt), 0) as avg_pt,
	       round(stddev(pt), 1) as std_pt,
	       round((round(stddev(pt),1) / round(avg(pt),0)), 6) as re_pt
	FROM MATR2_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	and iternum > 30 and iternum <= 40
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE MATC2_RUN_V4_Stat ADD PRIMARY KEY (algrunid, exp_run_time);

DROP TABLE MATC2_RUN_Retained1 CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Retained1 AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.runtime as et,
		dpi.pt
	from MATR2_RUN_PROC_INFO dpi 
	where dpi.processname = 'incr_work'
	and iternum > 30 and iternum <= 40
	and dpi.iternum NOT IN (select distinct ild.iternum 
				from MATC_CUTOFF_Info ild 
				where dpi.exp_run_time = ild.exp_run_time);
ALTER TABLE MATC2_RUN_Retained1 ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE MATC2_RUN_Retained1_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Retained1_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained1,
		round(avg(dpi.et),0) as avg_et, 
		round(stddev(dpi.et),1) as std_et, 
		round(avg(dpi.pt),0) as avg_pt, 
		round(stddev(dpi.pt),1) as std_pt
	from MATC2_RUN_Retained1 dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE MATC2_RUN_Retained1_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE MATC2_RUN_Retained2_ET CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Retained2_ET AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.et
	from MATC2_RUN_Retained1 dpi, MATC2_RUN_Retained1_Stat ms
	where 
	    dpi.exp_run_time = ms.exp_run_time
	-- two std margin
	and ((dpi.et >= ms.avg_et - 2*ms.std_et) and (dpi.pt <= ms.avg_pt + 2*ms.std_et));
ALTER TABLE MATC2_RUN_Retained2_ET ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE MATC2_RUN_Retained2_PT CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Retained2_PT AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.pt
	from MATC2_RUN_Retained1 dpi, MATC2_RUN_Retained1_Stat ms
	where 
	    dpi.exp_run_time = ms.exp_run_time
	-- two std margin
	and ((dpi.pt >= ms.avg_pt - 2*ms.std_pt) and (dpi.pt <= ms.avg_pt + 2*ms.std_pt));
ALTER TABLE MATC2_RUN_Retained2_PT ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE MATC2_RUN_Retained2_ET_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Retained2_ET_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained2,
		round(avg(dpi.et),0) as avg_et, 
		round(stddev(dpi.et),1) as std_et
	from MATC2_RUN_Retained2_ET dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE MATC2_RUN_Retained2_ET_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE MATC2_RUN_Retained2_PT_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Retained2_PT_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained2,
		round(avg(dpi.pt),0) as avg_pt, 
		round(stddev(dpi.pt),1) as std_pt
	from MATC2_RUN_Retained2_PT dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE MATC2_RUN_Retained2_PT_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE MATC2_RUN_Final_ET_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Final_ET_Stat AS
	select  t0.exp_run_time as ts_len, 
		t2.numTrials, 
		(t2.numTrials-t1.numRetained1) as num1ndOls,
		(t1.numRetained1-t0.numRetained2) as num2ndOls,
		t0.numRetained2 as numRet,
		round(t0.avg_et, 0) as avg_et, 
		round(t0.std_et, 0) as std_et,
		round(t0.std_et/t0.avg_et, 6) as re_et
	from MATC2_RUN_Retained2_ET_Stat t0, 
	     MATC2_RUN_Retained1_Stat t1,
	     MATC2_RUN_V4_Stat t2
	where t0.exp_run_time = t1.exp_run_time
	and t1.exp_run_time = t2.exp_run_time
	order by ts_len asc;
ALTER TABLE MATC2_RUN_Final_ET_Stat ADD PRIMARY KEY (ts_len);
-- select ts_len,numTrials, (num1ndOls+num2ndOls) as numOls, avg_et, std_et, re_et from MATC2_RUN_Final_ET_Stat

    TS_LEN  NUMTRIALS	  NUMOLS     AVG_ET	STD_ET	    RE_ET
---------- ---------- ---------- ---------- ---------- ----------
      1000	   10	       1       8487	     1	  .000141
      2000	   10	       1      29070	     2	  .000055
      4000	   10	       0     274047	     4	  .000015
      8000	   10	       1    2156146	     5	  .000002

DROP TABLE MATC2_RUN_Final_PT_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATC2_RUN_Final_PT_Stat AS
	select  t0.exp_run_time as ts_len, 
		t2.numTrials, 
		(t2.numTrials-t1.numRetained1) as num1ndOls,
		(t1.numRetained1-t0.numRetained2) as num2ndOls,
		t0.numRetained2 as numRet,
		round(t0.avg_pt,0) as avg_pt,
		round(t0.std_pt,0) as std_pt,
		round(t0.std_pt/t0.avg_pt, 6) as re_pt
	from MATC2_RUN_Retained2_PT_Stat t0, 
	     MATC2_RUN_Retained1_Stat t1,
	     MATC2_RUN_V4_Stat t2
	where t0.exp_run_time = t1.exp_run_time
	and t1.exp_run_time = t2.exp_run_time
	order by ts_len asc;
ALTER TABLE MATC2_RUN_Final_PT_Stat ADD PRIMARY KEY (ts_len);
-- select ts_len,numTrials, (num1ndOls+num2ndOls) as numOls, avg_pt, std_pt, re_pt from MATC2_RUN_Final_PT_Stat

    TS_LEN  NUMTRIALS	  NUMOLS     AVG_PT	STD_PT	    RE_PT
---------- ---------- ---------- ---------- ---------- ----------
      1000	   10	       1       8486	     1	  .000165
      2000	   10	       1      29069	     2	  .000052
      4000	   10	       1     274025	     2	  .000008
      8000	   10	       2    2155927	     4	  .000002
