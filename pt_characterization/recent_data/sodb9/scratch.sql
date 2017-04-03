-- INC8 and INC16

DROP TABLE INC816_INFO CASCADE CONSTRAINTS;
CREATE TABLE INC816_INFO AS
	SELECT ar.exp_run_time as task_len,
	    arr.iternum,
	    proc.processname as procname,
	    arr.RUNTIME as et,
	    (proc.utime+proc.stime)/1000 as pt 
	FROM AZDBLab_NewAlgRun2 ar, 
	     AZDBLab_NewAlgRunResult2 arr, 
	     AZDBLab_ProcInfo2 proc
	WHERE 
	ar.algrunid = arr.algrunid
	and arr.algrunid = proc.algrunid
	and arr.datanum = proc.DATANUM
	and arr.iternum = proc.iternum
	and (proc.utime+proc.stime) > 0
	and proc.processname = 'incr_work'
	and arr.algrunid IN (17480, 17540);
ALTER TABLE INC816_INFO ADD PRIMARY KEY (task_len, iternum);

DROP TABLE INC816_DPROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE INC816_DPROC_INFO AS
	SELECT ar.exp_run_time as task_len,
	    arr.iternum,
	    proc.procid,
	    proc.processname as daemon,
	    (proc.utime+proc.stime)/1000 as pt 
	FROM AZDBLab_NewAlgRun2 ar, 
	     AZDBLab_NewAlgRunResult2 arr, 
	     AZDBLab_ProcInfo2 proc
	WHERE 
	ar.algrunid = arr.algrunid
	and arr.algrunid = proc.algrunid
	and arr.datanum = proc.DATANUM
	and arr.iternum = proc.iternum
	and (proc.utime+proc.stime) > 0
	and proc.processname <> 'incr_work'
	and arr.algrunid IN (17480, 17540)
	;
ALTER TABLE INC816_DPROC_INFO ADD PRIMARY KEY (task_len, iternum, procid);

DROP TABLE INC816_DPROC_Stat CASCADE CONSTRAINTS;
CREATE TABLE INC816_DPROC_Stat AS
	SELECT 'INC' || t0.task_len as task_len,
	       ' & ' || t0.et as et,
	       ' & ' || t1.daemon as daemon, 
	       ' & ' || min(t1.pt) as min_pt,
	       ' & ' || max(t1.pt) as max_pt,
	       ' & ' || round(avg(t1.pt),2) as avg_pt,
	       ' & ' || round(stddev(t1.pt),2) as std_pt,
	       ' & ' || count(t1.daemon) || '\\ \hline' as counts
	FROM INC816_INFO t0, 
	     INC816_DPROC_INFO t1 
	WHERE t0.task_len = t1.task_len 
	and t0.iternum = t1.iternum
	--and t0.task_len = 8 
	GROUP BY t0.task_len, t0.et, t1.daemon;
ALTER TABLE INC816_DPROC_Stat ADD PRIMARY KEY (task_len, et, daemon);
-- select * from INC816_DPROC_Stat order by task_len asc, et asc, daemon asc;

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
--and proc.processname NOT IN ('incr_work')
and (arr.algrunid IN (5292, 5332, 5372, 5412, 5452, 5492, 5532))
--group by arr.algrunid, ar.exp_run_time, arr.iternum, arr.runtime, proc.processname
order by iternum, pt desc;
