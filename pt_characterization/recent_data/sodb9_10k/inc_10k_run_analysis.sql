-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 04/05/2017
-- Description: Define tables/views for the SEDONA data with 10k timings on INC8 and INC16 programs 

column PROCESSNAME format a15
DROP TABLE INC_10K_RUN_PROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE INC_10K_RUN_PROC_INFO AS
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
	-- sodb9/sodb10
	and arr.algrunid IN (18660,18680)
	order by iternum, pt desc;
ALTER TABLE INC_10K_RUN_PROC_INFO ADD PRIMARY KEY (algrunid, iternum, procid,processname);

DROP TABLE INC_10K_RUN_Stat CASCADE CONSTRAINTS;
CREATE TABLE INC_10K_RUN_Stat AS
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
	FROM INC_10K_RUN_PROC_INFO erpi
	WHERE erpi.processname = 'incr_work'
	group by erpi.algrunid, erpi.exp_run_time, erpi.processname
	order by exp_run_time;
ALTER TABLE INC_10K_RUN_Stat ADD PRIMARY KEY (algrunid, exp_run_time);
-- select exp_run_time, numTrials, avg_et, std_et, avg_pt, std_pt from INC_10K_RUN_Stat

DROP TABLE INC_10K_RUN_CUTOFF_Info CASCADE CONSTRAINTS;
CREATE TABLE INC_10K_RUN_CUTOFF_Info AS
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from INC_10K_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 3600 and ild.TASK_LEN < 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from INC_10K_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 3600 and ild.TASK_LEN = 3600) and dpi.processname IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from INC_10K_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time < 720 and ild.TASK_LEN < 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from INC_10K_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and (dpi.exp_run_time >= 720 and ild.TASK_LEN = 720) and dpi.processname IN ('rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	UNION
	select  dpi.algrunid,
		dpi.exp_run_time,
		dpi.processname, 
		dpi.iternum,
		dpi.pt
	from INC_10K_RUN_PROC_INFO dpi, IL_DAEMON_CUTOFF ild
	where 
	(dpi.processname = ild.PROCESSNAME and dpi.processname NOT IN ('flush-9:0', 'jbd2/md0-8', 'md0_raid1', 'rhnsd', 'rhsmcertd-worke', 'rhn_check'))
	and dpi.pt > ild.cutoff_pt 
	order by exp_run_time, iternum
	;
ALTER TABLE INC_10K_RUN_CUTOFF_Info ADD PRIMARY KEY (exp_run_time, processname, iternum);
-- select distinct exp_run_time, processname, round(avg(pt),0) as avg_pt from INC_10K_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc
-- select distinct exp_run_time, iternum from INC_10K_RUN_CUTOFF_Info where exp_run_time = 1024 and iter num 
--select distinct exp_run_time, processname,  count(iternum) as numOls, min(pt) as min_pt, round(avg(pt),0) as avg_pt, round(stddev(pt),1) as std_pt from INC_10K_RUN_CUTOFF_Info group by exp_run_time, processname order by exp_run_time, processname asc

select distinct exp_run_time, algrunid, iternum from INC_10K_RUN_CUTOFF_Info order by exp_run_time, algrunid, iternum

select t1.exp_run_time, coalesce(count(distinct t0.iternum), 0) as numOutliers, max(t1.iternum) as numTrials
from INC_10K_RUN_CUTOFF_Info t0, INC_10K_RUN_PROC_INFO t1
where t0.algrunid = t1.algrunid
group by t1.exp_run_time order by exp_run_time asc

select t1.exp_run_time, coalesce(count(distinct t0.iternum), 0) as numOutliers, max(t1.iternum) as numTrials
from INC_10K_RUN_PROC_INFO t1 
LEFT OUTER JOIN INC_10K_RUN_CUTOFF_Info t0
ON t0.algrunid = t1.algrunid 
group by t1.exp_run_time
order by exp_run_time
