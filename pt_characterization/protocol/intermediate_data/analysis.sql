SELECT arr.algrunid  as runID,
       proc.DATANUM as INC_NUM,
       proc.iternum,
       arr.runtime as METIME,
       (proc.utime+proc.stime)/1000 as prtime
FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
WHERE 
    ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and proc.processname in ('incr_work')
and (proc.utime+proc.stime) > 0
and arr.algrunid IN (25461)
order by INC_NUM asc, iternum asc


-- INC108
column proc_name format a15;
SELECT --arr.algrunid,
       ar.exp_run_time,
       --arr.iternum,
       arr.runtime,
       proc.procid,
       proc.processname as proc_name,
       (proc.utime+proc.stime)/1000 as pt
FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
WHERE 
    ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and proc.processname not in ('proc_monitor', 'incr_work')
and (proc.utime+proc.stime) > 0 
and arr.iternum IN (315) 
and arr.algrunid IN (24961)
order by pt desc;

EXP_RUN_TIME	RUNTIME     PROCID PROC_NAME		   PT
------------ ---------- ---------- --------------- ----------
	 108	 108308      20247 sshd 		   15
	 108	 108308      20256 sshd 		   13
	 108	 108308      20249 grep 		    9
	 108	 108308      20258 grep 		    6
	 108	 108308        167 kslowd001		    6
	 108	 108308        166 kslowd000		    5
	 108	 108308      18952 java 		    3
	 108	 108308      20253 grep 		    1
	 108	 108308      20262 grep 		    1
	 108	 108308      20248 sshd 		    1

10 rows selected.

SELECT algrunid, exp_run_time 
FROM AZDBLab_NewAlgRun2  
WHERE algrunid > 25081 
order by algrunid asc

-- INC108
SELECT --arr.algrunid,
       ar.exp_run_time,
       --arr.iternum,
       arr.runtime,
       proc.procid,
       proc.processname as proc_name,
       (proc.utime+proc.stime)/1000 as pt
FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
WHERE 
    ar.algrunid = arr.algrunid
and arr.algrunid = proc.algrunid
and arr.datanum = proc.DATANUM
and arr.iternum = proc.iternum 
and proc.processname in ('')
and (proc.utime+proc.stime) > 0 
and arr.iternum IN (315) 
and arr.algrunid IN (24961)
order by pt desc;

