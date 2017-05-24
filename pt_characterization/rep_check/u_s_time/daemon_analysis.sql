
select avg(numProcs)
from 
(select arr.algrunid, 
       arr.iternum,
       count(proc.procid) as numProcs
FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
WHERE
    ar.algrunid = arr.algrunid
    and arr.algrunid = proc.algrunid
    and arr.datanum = proc.DATANUM
    and arr.iternum = proc.iternum
and arr.algrunid IN (18120)
group by arr.algrunid, arr.iternum
order by arr.iternum asc)

SELECT arr.algrunid,
       -- arr.iternum,
        proc.processname as p_name,
        proc.procid as p_id,
        proc.utime/1000 as u_time,
        proc.stime/1000 as s_time,
        proc.MIN_FLT as min_flt,
        proc.maj_flt as maj_flt,
        proc.NIVCSW as nivcsw,
        proc.NVCSW as nvcsw,
        proc.CPU_COUNT as cpu_count,
        proc.CPU_DELAY as cpu_delay,
        proc.BLKIO_COUNT as blkio_count,
        proc.SWAPIN_COUNT as swapin_count,
        proc.SWAPIN_DELAY as swapin_delay,
        proc.FREEPGS_COUNT as FREEPGS_COUNT,
        proc.FREEPGS_DELAY as FREEPGS_DELAY,
        proc.READ_BYTES as READ_BYTES,
        proc.READ_CHAR as READ_CHAR,
        proc.READ_SYSCALLS as READ_SYSCALLS,
        proc.WRITE_BYTES as WRITE_BYTES,
        proc.WRITE_CHAR as WRITE_CHAR,
        proc.WRITE_SYSCALLS as WRITE_SYSCALLS
    FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
    WHERE
    ar.algrunid = arr.algrunid
    and arr.algrunid = proc.algrunid
    and arr.datanum = proc.DATANUM
    and arr.iternum = proc.iternum
    --and proc.iternum IN (11)
   --- and proc.iternum IN (190)
   --and proc.iternum IN (270)
   and proc.iternum IN (245)
    --and proc.iternum IN (273)
    --and proc.iternum IN (100)--235
    and (proc.utime/1000+proc.stime/1000> 0 or proc.MIN_FLT > 0)
    --and proc.processname <> 'incr_work'
    and arr.algrunid IN (18120)
    order by u_time+s_time desc
