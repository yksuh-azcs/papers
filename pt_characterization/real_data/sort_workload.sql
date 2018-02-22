-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 10/11/16
-- Description: Define tables/views for EMP evaluation on spec cpu programs 

DROP TABLE SORT_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_PROC_INFO AS
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
	--and proc.processname NOT IN ('specCpu')
	and arr.algrunid IN (
                -- SORT100K, SORT200K, SORT400K, SORT800K, SORT1600K, SORT3200K, SORT6400K
                13200,12760,13620,12800,13800,13860,13960  
        )
	group by arr.algrunid, ar.exp_run_time, arr.iternum, arr.runtime, proc.processname
	order by iternum, pt desc;
ALTER TABLE SORT_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, processname);
-- SELECT exp_run_time, iternum, processname, pt as PRTIME from SORT_RUN_PROC_INFO where algrunid = 13860 and iternum IN (1,2,3,4,5,6,7,8,9,10) order by exp_run_time asc, iternum asc, pt desc
-- SELECT exp_run_time, iternum, processname, pt as PRTIME from SORT_RUN_PROC_INFO where algrunid = 13960 and iternum IN (1,2,3,4,5,6,7,8,9,10) order by exp_run_time asc, iternum asc, pt desc

DROP TABLE SORT_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Stat AS
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
	FROM SORT_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE SORT_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select * from SORT_RUN_Stat;

DROP TABLE SORT_RUN_TASK_TIME CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_TASK_TIME AS
	SELECT sort_run.algrunid,
	       sort_run.exp_run_time,
	       round(median(sort_run.pt), 0) as task_time,
	       round(avg(sort_run.pt), 0) as avg_task_time,
	       round(stddev(sort_run.pt), 1) as std_task_time
	FROM SORT_RUN_PROC_INFO sort_run, SORT_RUN_Stat sort_stat
	WHERE sort_run.algrunid = sort_stat.algrunid 
	and sort_run.exp_run_time = sort_stat.exp_run_time
	and sort_run.processname = 'incr_work'
	and sort_run.pt <= (sort_stat.avg_pt+2*sort_stat.std_pt) 
	and sort_run.pt >= (sort_stat.avg_pt-2*sort_stat.std_pt) 
	having count(sort_run.iternum) > 6 --- at least 6 trials
	group by sort_run.algrunid, sort_run.exp_run_time
	order by exp_run_time;
ALTER TABLE SORT_RUN_TASK_TIME ADD PRIMARY KEY (algrunid, exp_run_time);

--- select algrunid, exp_run_time, task_time from SORT_RUN_TASK_TIME order by exp_run_time, algrunid asc
  ALGRUNID EXP_RUN_TIME  TASK_TIME
---------- ------------ ----------
     13200	    100       4238
     12760	    200      17226
     13620	    400      69200
     12800	    800     275089
     13800	   1600    1101066
     13860	   3200    4410719
     13960	   6400   17684424

7 rows selected.

DROP TABLE SORT_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE SORT_CUTOFF_Info AS
    select distinct dpi.exp_run_time,
           	    dpi.iternum
    from SORT_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
	(dpi.processname = ild.PROCESSNAME and ((select task_time from SORT_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from SORT_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from SORT_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from SORT_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from SORT_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from SORT_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and ((select task_time from SORT_RUN_TASK_TIME t0 where t0.exp_run_time = dpi.exp_run_time) >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    UNION
    select distinct dpi.exp_run_time,
            dpi.iternum
    from SORT_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
    where 
    (dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
    and dpi.pt > ild.cutoff_pt 
    order by exp_run_time, iternum;
ALTER TABLE SORT_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, iternum);
-- select * from SORT_CUTOFF_Info where iternum <= 10 order by exp_run_time, iternum

EXP_RUN_TIME	ITERNUM
------------ ----------
	3200	      3
	3200	      6
	3200	     10
	6400	      1
	6400	      2
	6400	      3
	6400	      4
	6400	      5
	6400	      6
	6400	      7
	6400	      8
	6400	      9
	6400	     10

13 rows selected.

select t1.exp_run_time, coalesce(count(distinct t0.iternum), 0) as numOutliers, max(t1.iternum) as numTrials
from SORT_RUN_PROC_INFO t1 
LEFT OUTER JOIN SORT_CUTOFF_Info t0
ON t0.EXP_RUN_TIME = t1.EXP_RUN_TIME and t0.iternum > 30 and t0.iternum <= 40 
WHERE t1.iternum <= 10 
group by t1.exp_run_time
order by exp_run_time

EXP_RUN_TIME NUMOUTLIERS  NUMTRIALS
------------ ----------- ----------
	 100	       0	 10
	 200	       0	 10
	 400	       0	 10
	 800	       0	 10
	1600	       0	 10
	3200	       2	 10
	6400	      10	 10

7 rows selected.

DROP TABLE SORT_RUN_V4_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_V4_Stat AS
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
	FROM SORT_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	and iternum > 30 and iternum <= 40  
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE SORT_RUN_V4_Stat ADD PRIMARY KEY (algrunid, exp_run_time);

DROP TABLE SORT_RUN_Retained1 CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Retained1 AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.runtime as et,
		dpi.pt
	from SORT_RUN_PROC_INFO dpi 
	where dpi.processname = 'incr_work'
	and iternum > 30 and iternum <= 40  
	and dpi.exp_run_time <> 6400 
	and dpi.iternum NOT IN (select distinct ild.iternum 
				from SORT_CUTOFF_Info ild 
				where dpi.exp_run_time = ild.exp_run_time)
	UNION
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.runtime as et,
		dpi.pt
	from SORT_RUN_PROC_INFO dpi 
	where dpi.processname = 'incr_work'
	and iternum > 30 and iternum <= 40   
	and dpi.exp_run_time = 6400;
ALTER TABLE SORT_RUN_Retained1 ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE SORT_RUN_Retained1_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Retained1_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained1,
		round(avg(dpi.et),0) as avg_et, 
		round(stddev(dpi.et),1) as std_et, 
		round(avg(dpi.pt),0) as avg_pt, 
		round(stddev(dpi.pt),1) as std_pt
	from SORT_RUN_Retained1 dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE SORT_RUN_Retained1_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE SORT_RUN_Retained2_ET CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Retained2_ET AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.et
	from SORT_RUN_Retained1 dpi, SORT_RUN_Retained1_Stat ms
	where 
	    dpi.exp_run_time = ms.exp_run_time
	-- two std margin
	and ((dpi.et >= ms.avg_et - 2*ms.std_et) and (dpi.pt <= ms.avg_pt + 2*ms.std_et));
ALTER TABLE SORT_RUN_Retained2_ET ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE SORT_RUN_Retained2_PT CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Retained2_PT AS
	select  dpi.exp_run_time, 
		dpi.iternum,
		dpi.pt
	from SORT_RUN_Retained1 dpi, SORT_RUN_Retained1_Stat ms
	where 
	    dpi.exp_run_time = ms.exp_run_time
	-- two std margin
	and ((dpi.pt >= ms.avg_pt - 2*ms.std_pt) and (dpi.pt <= ms.avg_pt + 2*ms.std_pt));
ALTER TABLE SORT_RUN_Retained2_PT ADD PRIMARY KEY (exp_run_time, iternum);

DROP TABLE SORT_RUN_Retained2_ET_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Retained2_ET_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained2,
		round(avg(dpi.et),0) as avg_et, 
		round(stddev(dpi.et),1) as std_et
	from SORT_RUN_Retained2_ET dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE SORT_RUN_Retained2_ET_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE SORT_RUN_Retained2_PT_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Retained2_PT_Stat AS
	select  dpi.exp_run_time, 
		count(dpi.iternum) as numRetained2,
		round(avg(dpi.pt),0) as avg_pt, 
		round(stddev(dpi.pt),1) as std_pt
	from SORT_RUN_Retained2_PT dpi 
	group by dpi.exp_run_time
	order by exp_run_time asc;
ALTER TABLE SORT_RUN_Retained2_PT_Stat ADD PRIMARY KEY (exp_run_time);

DROP TABLE SORT_RUN_Final_ET_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Final_ET_Stat AS
	select  t0.exp_run_time as ts_len, 
		t2.numTrials, 
		(t2.numTrials-t1.numRetained1) as num1ndOls,
		(t1.numRetained1-t0.numRetained2) as num2ndOls,
		t0.numRetained2 as numRet,
		round(t0.avg_et, 0) as avg_et, 
		round(t0.std_et, 0) as std_et,
		round(t0.std_et/t0.avg_et, 6) as re_et
	from SORT_RUN_Retained2_ET_Stat t0, 
	     SORT_RUN_Retained1_Stat t1,
	     SORT_RUN_V4_Stat t2
	where t0.exp_run_time = t1.exp_run_time
	and t1.exp_run_time = t2.exp_run_time
	order by ts_len asc;
ALTER TABLE SORT_RUN_Final_ET_Stat ADD PRIMARY KEY (ts_len);
-- select ts_len,numTrials, (num1ndOls+num2ndOls) as numOls, avg_et, std_et, re_et from SORT_RUN_Final_ET_Stat

    TS_LEN  NUMTRIALS	  NUMOLS     AVG_ET	STD_ET	    RE_ET
---------- ---------- ---------- ---------- ---------- ----------
       100	   10	       1       4238	     2	  .000401
       200	   10	       1      17227	     2	  .000139
       400	   10	       0      69210	     6	  .000088
       800	   10	       0     275120	     6	  .000023
      1600	   10	       0    1101200	    40	  .000036
      3200	   10	       2    4411310	    46	   .00001
      6400	   10	       0   17687026	    84	  .000005

DROP TABLE SORT_RUN_Final_PT_Stat CASCADE CONSTRAINTS;
CREATE TABLE SORT_RUN_Final_PT_Stat AS
	select  t0.exp_run_time as ts_len, 
		t2.numTrials, 
		(t2.numTrials-t1.numRetained1) as num1ndOls,
		(t1.numRetained1-t0.numRetained2) as num2ndOls,
		t0.numRetained2 as numRet,
		round(t0.avg_pt,0) as avg_pt,
		round(t0.std_pt,0) as std_pt,
		round(t0.std_pt/t0.avg_pt, 6) as re_pt
	from SORT_RUN_Retained2_PT_Stat t0, 
	     SORT_RUN_Retained1_Stat t1,
	     SORT_RUN_V4_Stat t2
	where t0.exp_run_time = t1.exp_run_time
	and t1.exp_run_time = t2.exp_run_time
	order by ts_len asc;
ALTER TABLE SORT_RUN_Final_PT_Stat ADD PRIMARY KEY (ts_len);
-- select ts_len,numTrials, (num1ndOls+num2ndOls) as numOls, avg_pt, std_pt, re_pt from SORT_RUN_Final_PT_Stat

    TS_LEN  NUMTRIALS	  NUMOLS     AVG_PT	STD_PT	    RE_PT
---------- ---------- ---------- ---------- ---------- ----------
       100	   10	       1       4238	     1	  .000283
       200	   10	       1      17225	     2	  .000139
       400	   10	       1      69200	     4	  .000056
       800	   10	       0     275088	     4	  .000015
      1600	   10	       0    1101063	     7	  .000006
      3200	   10	       3    4410727	     7	  .000002
      6400	   10	       0   17684410	    35	  .000002

7 rows selected.
