--- sodb9's first run + sodb9's second run
select t0.pt, count(t0.iternum) as freq
from 
	(
	SELECT ar.exp_run_time as task_len,
	    arr.iternum,
	    ((proc.utime+proc.stime)/1000) as pt 
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
	-- INCs: 1 ~ 1024
	and (arr.algrunid IN (18140,18160,18180,18200,18220,18240,18260) -- 18280,18300,18320,18400
	or -- INCs: 3, 6, ...
	arr.algrunid IN (19180,19200,19220,19240,19260, 19280, 19300, 19320, 19060, 19340, 19360) -- 19380, 19100, 19120, 19140
	) t0 
group by t0.pt
order by t0.pt asc

-- INC2K ~ INC16K
select t0.pt, count(t0.iternum) as freq
from
        (
        SELECT ar.exp_run_time as task_len,
            arr.iternum,
            round((proc.utime+proc.stime)/1000,1) as pt
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
        -- INCs: 1 ~ 1024
        and arr.algrunid IN (17980,17940,18840,18880)
        ) t0
group by t0.pt
order by t0.pt asc

select t0.pt, count(t0.iternum) as freq
from 
	(
	SELECT ar.exp_run_time as task_len,
	    arr.iternum,
	    ((proc.utime+proc.stime)/1000) as pt 
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
	-- INCs: 1 ~ 1024
	and arr.algrunid IN (18140,18160,18180,18200,18220,18240,18260,18280,18300,18320,18400)
	or -- INCs: 2, 4, ..., 
	arr.algrunid IN (19180,19200,19220,19240,19260, 19280, 19300, 19320, 19060, 19340, 19360, 19380, 19100, 19120, 19140)
	) t0 
group by t0.pt
order by t0.pt asc
