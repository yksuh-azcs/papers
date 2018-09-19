-- INC64's outlier analysis
SELECT proc.procid,
    proc.processname as procname,
    (proc.utime+proc.stime)/1000 as pt 
FROM AZDBLab_NewAlgRun2 ar, 
     AZDBLab_NewAlgRunResult2 arr, 
     AZDBLab_ProcInfo2 proc
WHERE 
ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and arr.iternum IN (125,236,795)
and (proc.utime+proc.stime) > 0
--and proc.processname = 'incr_work'
and arr.algrunid IN (18560) 
order by pt desc;


SELECT proc.procid,
    proc.processname as procname,
    (proc.utime+proc.stime)/1000 as pt 
FROM AZDBLab_NewAlgRun2 ar, 
     AZDBLab_NewAlgRunResult2 arr, 
     AZDBLab_ProcInfo2 proc
WHERE 
ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and arr.iternum = 759
and (proc.utime+proc.stime) > 0
--and proc.processname = 'incr_work'
and arr.algrunid IN (18560) 
order by pt desc;


-- INC16's outlier analysis
SELECT arr.iternum, proc.procid,
    proc.processname as procname,
    (proc.utime+proc.stime)/1000 as pt 
FROM AZDBLab_NewAlgRun2 ar, 
     AZDBLab_NewAlgRunResult2 arr, 
     AZDBLab_ProcInfo2 proc
WHERE 
ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and arr.iternum IN (77, 209, 569)
and (proc.utime+proc.stime) > 0
--and proc.processname = 'incr_work'
and arr.algrunid IN (18520) 
order by iternum asc, pt desc;

SELECT proc.procid,
    proc.processname as procname,
    (proc.utime+proc.stime)/1000 as pt 
FROM AZDBLab_NewAlgRun2 ar, 
     AZDBLab_NewAlgRunResult2 arr, 
     AZDBLab_ProcInfo2 proc
WHERE 
ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and arr.iternum = 703
and (proc.utime+proc.stime) > 0
--and proc.processname = 'incr_work'
and arr.algrunid IN (18520) 
order by pt desc;

-- INC8 in repeatability test 2

DROP TABLE INC8_r2_INFO CASCADE CONSTRAINTS;
CREATE TABLE INC8_r2_INFO AS
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
	and arr.algrunid IN (18200);
ALTER TABLE INC8_r2_INFO ADD PRIMARY KEY (task_len, iternum);

DROP TABLE INC8_r2_DPROC_INFO CASCADE CONSTRAINTS;
CREATE TABLE INC8_r2_DPROC_INFO AS
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
	and arr.algrunid IN (18200)
	;
ALTER TABLE INC8_r2_DPROC_INFO ADD PRIMARY KEY (task_len, iternum, procid);

DROP TABLE INC8_r2_DPROC_Stat CASCADE CONSTRAINTS;
CREATE TABLE INC8_r2_DPROC_Stat AS
	SELECT 'INC' || t0.task_len as task_len,
	       ' & ' || t0.pt as pt,
	       ' & ' || t1.daemon as daemon, 
	       ' & ' || min(t1.pt) as min_pt,
	       ' & ' || max(t1.pt) as max_pt,
	       ' & ' || round(avg(t1.pt),2) as avg_pt,
	       ' & ' || round(stddev(t1.pt),2) as std_pt,
	       ' & ' || count(t1.daemon) || '\\ \hline' as counts
	FROM INC8_r2_INFO t0, 
	     INC8_r2_DPROC_INFO t1 
	WHERE t0.task_len = t1.task_len 
	and t0.iternum = t1.iternum
	--and t0.task_len = 8 
	GROUP BY t0.task_len, t0.pt, t1.daemon;
ALTER TABLE INC8_r2_DPROC_Stat ADD PRIMARY KEY (task_len, pt, daemon);
select * from INC8_r2_DPROC_Stat order by task_len asc, pt asc, daemon asc;
