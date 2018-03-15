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
                -- MATR1K, MATR4K, MATR8K 
                --13520,13540,13120,
		-- and arr.iternum <= 10 -- the first 10 
                -- MATR2K
                --13400
		--22280, 22300,22320,22340,22420,22480,21860
		23201,23261,23301,23361
	   -- and arr.iternum > 20 and arr.iternum <= 30 -- middle 10 
        )
	group by arr.algrunid, ar.exp_run_time, arr.iternum, arr.runtime, proc.processname
	order by iternum, pt desc;
ALTER TABLE MATR2_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, processname);

DROP TABLE MATR2_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Stat AS
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
	--and (algrunid IN (13520,13540,13120,13400) and iternum >= 6 and iternum <= 40)
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE MATR2_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select * from MATR2_RUN_Stat;

DROP TABLE MATR2_RUN_TASK_TIME CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_TASK_TIME AS
	SELECT sort_run.algrunid,
	       sort_run.exp_run_time,
	       round(median(sort_run.pt), 0) as task_time,
	       round(avg(sort_run.pt), 0) as avg_task_time,
	       round(stddev(sort_run.pt), 1) as std_task_time
	FROM MATR2_RUN_PROC_INFO sort_run, MATR2_RUN_Stat sort_stat
	WHERE sort_run.algrunid = sort_stat.algrunid 
	and sort_run.exp_run_time = sort_stat.exp_run_time
	and sort_run.processname = 'incr_work'
	and sort_run.pt <= (sort_stat.avg_pt+2*sort_stat.std_pt) 
	and sort_run.pt >= (sort_stat.avg_pt-2*sort_stat.std_pt) 
	having count(sort_run.iternum) > 6 --- at least 6 trials
	group by sort_run.algrunid, sort_run.exp_run_time
	order by exp_run_time;
ALTER TABLE MATR2_RUN_TASK_TIME ADD PRIMARY KEY (algrunid, exp_run_time);
--- select algrunid, exp_run_time, task_time from MATR2_RUN_TASK_TIME order by exp_run_time, algrunid asc;

  ALGRUNID EXP_RUN_TIME  TASK_TIME
---------- ------------ ----------
     13520	   1000       8421
     13400	   2000      22599
     13540	   4000     206832
     13120	   8000    1760437

  ALGRUNID EXP_RUN_TIME  TASK_TIME
---------- ------------ ----------
     22280	    250        343
     22300	    500        687
     22320	   1024       1407
     22340	   2048       2813
     22420	   4096       5626
     22480	   8192      11249
     21860	  16000      21971

  ALGRUNID EXP_RUN_TIME  TASK_TIME
---------- ------------ ----------
     23201	   1024       3027
     23261	   2048      24275
     23301	   4096     224137
     23361	   8192    6478179


DROP TABLE MATR_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE MATR_CUTOFF_Info AS
    select distinct dpi.exp_run_time,
           	    dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
	(dpi.processname = ild.PROCESSNAME and ((select task_time from MATR2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from MATR2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from MATR2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from MATR2_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from MATR2_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    order by exp_run_time, iternum;
ALTER TABLE MATR_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, iternum);
-- select * from MATR_CUTOFF_Info order by exp_run_time, iternum

EXP_RUN_TIME	ITERNUM
------------ ----------
	4096	    285
	8192	      1
	8192	     16
	8192	     28
	8192	     33
	8192	     36
	8192	     43
	8192	     45
	8192	     60
	8192	     69
	8192	     75

EXP_RUN_TIME	ITERNUM
------------ ----------
	8192	     76
	8192	     77
	8192	     82
	8192	     83
	8192	     84
	8192	     91
	8192	     92
	8192	     98
	8192	    103
	8192	    110
	8192	    114

EXP_RUN_TIME	ITERNUM
------------ ----------
	8192	    119
	8192	    127
	8192	    148
	8192	    149
	8192	    151
	8192	    153
	8192	    155
	8192	    157
	8192	    158
	8192	    159
	8192	    167

EXP_RUN_TIME	ITERNUM
------------ ----------
	8192	    173
	8192	    176
	8192	    178
	8192	    184
	8192	    187
	8192	    190
	8192	    191
	8192	    201
	8192	    210
	8192	    225
	8192	    231

EXP_RUN_TIME	ITERNUM
------------ ----------
	8192	    232
	8192	    234
	8192	    249
	8192	    254
	8192	    255
	8192	    260
	8192	    283
	8192	    288

52 rows selected.

DROP TABLE MATR2_RUN_V4_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_V4_Stat AS
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
ALTER TABLE MATR2_RUN_V4_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select * from MATR2_RUN_V4_Stat
DROP TABLE MATR2_RUN_Retained1 CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Retained1 AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.runtime as et,
		dpi.pt
	from MATR2_RUN_PROC_INFO dpi 
	where dpi.processname = 'incr_work'
	and iternum > 30 and iternum <= 40
	and dpi.iternum NOT IN (select distinct ild.iternum 
				from MATR_CUTOFF_Info ild 
				where dpi.exp_run_time = ild.exp_run_time);
ALTER TABLE MATR2_RUN_Retained1 ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE MATR2_RUN_Retained1_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Retained1_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained1,
		round(avg(dpi.et),0) as avg_et, 
		round(stddev(dpi.et),1) as std_et, 
		round(avg(dpi.pt),0) as avg_pt, 
		round(stddev(dpi.pt),1) as std_pt
	from MATR2_RUN_Retained1 dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE MATR2_RUN_Retained1_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE MATR2_RUN_Retained2_ET CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Retained2_ET AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.et
	from MATR2_RUN_Retained1 dpi, MATR2_RUN_Retained1_Stat ms
	where 
	    dpi.exp_run_time = ms.exp_run_time
	-- two std margin
	and ((dpi.et >= ms.avg_et - 2*ms.std_et) and (dpi.pt <= ms.avg_pt + 2*ms.std_et));
ALTER TABLE MATR2_RUN_Retained2_ET ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE MATR2_RUN_Retained2_PT CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Retained2_PT AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.pt
	from MATR2_RUN_Retained1 dpi, MATR2_RUN_Retained1_Stat ms
	where 
	    dpi.exp_run_time = ms.exp_run_time
	-- two std margin
	and ((dpi.pt >= ms.avg_pt - 2*ms.std_pt) and (dpi.pt <= ms.avg_pt + 2*ms.std_pt));
ALTER TABLE MATR2_RUN_Retained2_PT ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE MATR2_RUN_Retained2_ET_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Retained2_ET_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained2,
		round(avg(dpi.et),0) as avg_et, 
		round(stddev(dpi.et),1) as std_et
	from MATR2_RUN_Retained2_ET dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE MATR2_RUN_Retained2_ET_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE MATR2_RUN_Retained2_PT_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Retained2_PT_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained2,
		round(avg(dpi.pt),0) as avg_pt, 
		round(stddev(dpi.pt),1) as std_pt
	from MATR2_RUN_Retained2_PT dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE MATR2_RUN_Retained2_PT_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE MATR2_RUN_Final_ET_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Final_ET_Stat AS
	select  t0.exp_run_time as ts_len, 
		t2.numTrials, 
		(t2.numTrials-t1.numRetained1) as num1ndOls,
		(t1.numRetained1-t0.numRetained2) as num2ndOls,
		t0.numRetained2 as numRet,
		round(t0.avg_et, 0) as avg_et, 
		round(t0.std_et, 0) as std_et,
		round(t0.std_et/t0.avg_et, 6) as re_et
	from MATR2_RUN_Retained2_ET_Stat t0, 
	     MATR2_RUN_Retained1_Stat t1,
	     MATR2_RUN_V4_Stat t2
	where t0.exp_run_time = t1.exp_run_time
	and t1.exp_run_time = t2.exp_run_time
	order by ts_len asc;
ALTER TABLE MATR2_RUN_Final_ET_Stat ADD PRIMARY KEY (ts_len);
-- select ts_len,numTrials, (num1ndOls+num2ndOls) as numOls, avg_et, std_et, re_et from MATR2_RUN_Final_ET_Stat

    TS_LEN  NUMTRIALS	  NUMOLS     AVG_ET	STD_ET	    RE_ET
---------- ---------- ---------- ---------- ---------- ----------
      1000	   10	       1       8420	     3	  .000356
      2000	   10	       1      22600	     1	  .000053
      4000	   10	       0     206848	     5	  .000022
      8000	   10	       1    1760613	    15	  .000008


DROP TABLE MATR2_RUN_Final_PT_Stat CASCADE CONSTRAINTS;
CREATE TABLE MATR2_RUN_Final_PT_Stat AS
	select  t0.exp_run_time as ts_len, 
		t2.numTrials, 
		(t2.numTrials-t1.numRetained1) as num1ndOls,
		(t1.numRetained1-t0.numRetained2) as num2ndOls,
		t0.numRetained2 as numRet,
		round(t0.avg_pt,0) as avg_pt,
		round(t0.std_pt,0) as std_pt,
		round(t0.std_pt/t0.avg_pt, 6) as re_pt
	from MATR2_RUN_Retained2_PT_Stat t0, 
	     MATR2_RUN_Retained1_Stat t1,
	     MATR2_RUN_V4_Stat t2
	where t0.exp_run_time = t1.exp_run_time
	and t1.exp_run_time = t2.exp_run_time
	order by ts_len asc;
ALTER TABLE MATR2_RUN_Final_PT_Stat ADD PRIMARY KEY (ts_len);
-- select ts_len,numTrials, (num1ndOls+num2ndOls) as numOls, avg_pt, std_pt, re_pt from MATR2_RUN_Final_PT_Stat

    TS_LEN  NUMTRIALS	  NUMOLS     AVG_PT	STD_PT	    RE_PT
---------- ---------- ---------- ---------- ---------- ----------
      1000	   10	       1       8419	     3	  .000309
      2000	   10	       1      22599	     1	  .000058
      4000	   10	       0     206832	     4	  .000021
      8000	   10	       1    1760441	    13	  .000007
