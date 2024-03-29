
drop view sample_300_stat cascade constraints;
create view sample_300_stat as 
	select t0.exp_run_time*1000 as tsk_len, '300' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum <= 300
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum <= 300
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_300_stat add primary key (tsk_len) disable;

drop view sample_150_stat cascade constraints;
create view sample_150_stat as 
	select t0.exp_run_time*1000 as tsk_len, '150' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum <= 150
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum <= 150
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_150_stat add primary key (tsk_len) disable;

drop view sample_75_stat cascade constraints;
create view sample_75_stat as 
	select t0.exp_run_time*1000 as tsk_len, '75' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum > 150 and iternum <= 225
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum > 150 and iternum <= 225
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_75_stat add primary key (tsk_len) disable;

drop view sample_40_stat cascade constraints;
create view sample_40_stat as 
	select t0.exp_run_time*1000 as tsk_len, '40' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum > 225 and iternum <= 265
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum > 225 and iternum <= 265
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_40_stat add primary key (tsk_len) disable;

drop view sample_20_stat cascade constraints;
create view sample_20_stat as 
	select t0.exp_run_time*1000 as tsk_len, '20' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum > 265 and iternum <= 285
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum > 265 and iternum <= 285
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_20_stat add primary key (tsk_len) disable;


drop view sample_10_stat cascade constraints;
create view sample_10_stat as 
	select t0.exp_run_time*1000 as tsk_len, '10' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum > 285 and iternum <= 295
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum > 285 and iternum <= 295
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_10_stat add primary key (tsk_len) disable;

drop view sample_5_stat cascade constraints;
create view sample_5_stat as 
	select t0.exp_run_time*1000 as tsk_len, '5' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
	from Analysis_AlgSOC_Ver2 t0, 
	     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
	      from Analysis_AlgSOC_Ver2
	      where iternum > 295 and iternum <= 300
	      group by exp_run_time) t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum > 295 and iternum <= 300
	      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- above
	      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- below
	group by t0.exp_run_time, t1.total
	order by t0.exp_run_time, t1.total;
alter view sample_5_stat add primary key (tsk_len) disable;

select t1.tsk_len,
	t1.nOutliers as ol_150, 
	t2.nOutliers as ol_75, 
	t3.nOutliers as ol_40, 
	t4.nOutliers as ol_20, 
	t5.nOutliers as ol_10, 
	t6.nOutliers as ol_5, 
	t0.nOutliers as ol_300
from sample_150_stat t1, 
     sample_75_stat t2,
     sample_40_stat t3,
     sample_20_stat t4,
     sample_10_stat t5,
     sample_5_stat t6,
     sample_300_stat t0		
where t0.tsk_len = t1.tsk_len  
and t1.tsk_len = t2.tsk_len 
and t2.tsk_len = t3.tsk_len 
and t3.tsk_len = t4.tsk_len 
and t4.tsk_len = t5.tsk_len 
and t5.tsk_len = t6.tsk_len 
order by t0.tsk_len;

select t1.tsk_len,
	t1.avg_pt as avg_150, 
	t2.avg_pt as avg_75, 
	t3.avg_pt as avg_40, 
	t4.avg_pt as avg_20, 
	t5.avg_pt as avg_10, 
	t6.avg_pt as avg_5, 
	t0.avg_pt as avg_300
from sample_150_stat t1, 
     sample_75_stat t2,
     sample_40_stat t3,
     sample_20_stat t4,
     sample_10_stat t5,
     sample_5_stat t6,
     sample_300_stat t0		
where t0.tsk_len = t1.tsk_len  
and t1.tsk_len = t2.tsk_len 
and t2.tsk_len = t3.tsk_len 
and t3.tsk_len = t4.tsk_len 
and t4.tsk_len = t5.tsk_len 
and t5.tsk_len = t6.tsk_len 
order by t0.tsk_len;

select t1.tsk_len,
	t1.std_prt as std_150, 
	t2.std_prt as std_75, 
	t3.std_prt as std_40, 
	t4.std_prt as std_20, 
	t5.std_prt as std_10, 
	t6.std_prt as std_5, 
	t0.std_prt as std_300
from sample_150_stat t1, 
     sample_75_stat t2,
     sample_40_stat t3,
     sample_20_stat t4,
     sample_10_stat t5,
     sample_5_stat t6,
     sample_300_stat t0		
where t0.tsk_len = t1.tsk_len  
and t1.tsk_len = t2.tsk_len 
and t2.tsk_len = t3.tsk_len 
and t3.tsk_len = t4.tsk_len 
and t4.tsk_len = t5.tsk_len 
and t5.tsk_len = t6.tsk_len 
order by t0.tsk_len;

select t0.exp_run_time*1000 as tsk_len, '20' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
from Analysis_AlgSOC_Ver2 t0, 
     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
      from Analysis_AlgSOC_Ver2
      where iternum > 265 and iternum <= 285
      group by exp_run_time) t1
where t0.exp_run_time = t1.exp_run_time  
      and iternum > 265 and iternum <= 285
      and t0.proc_time <= t1.avg_pt+2*t1.std_prt
group by t0.exp_run_time, t1.total
order by t0.exp_run_time, t1.total


select t0.exp_run_time*1000 as tsk_len, '300' as sp_sz, (t1.total-count(iternum)) as nOutliers, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
from Analysis_AlgSOC_Ver2 t0, 
     (select exp_run_time, count(iternum) as total, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
      from Analysis_AlgSOC_Ver2
      where iternum <= 300
      group by exp_run_time) t1
where t0.exp_run_time = t1.exp_run_time  
      and t0.iternum <= 300
      and t0.proc_time <= t1.avg_pt+2*t1.std_prt
group by t0.exp_run_time, t1.total
order by t0.exp_run_time, t1.total





















drop view sample_300_stat cascade constraints;
create view sample_300_stat as 
	select exp_run_time, 
	       count(iternum) as total, 
	      avg(proc_time) as avg_pt, 
	      stddev(proc_time) as std_prt
	from Analysis_AlgSOC_Ver2
	where iternum <= 300
	group by exp_run_time;
alter view sample_300_stat add primary key (exp_run_time) disable;

drop view up_outliers_300 cascade constraints;
create view up_outliers_300 as 
	select t0.exp_run_time, count(iternum) as nUpOutliers
	from Analysis_AlgSOC_Ver2 t0, 
	     sample_300_stat t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum <= 300
	      and t0.proc_time > t1.avg_pt+2*t1.std_prt
	group by t0.exp_run_time;
alter view up_outliers_300 add primary key (exp_run_time) disable;

drop view dn_outliers_300 cascade constraints;
create view dn_outliers_300 as 
	select t0.exp_run_time, count(iternum) as nUpOutliers
	from Analysis_AlgSOC_Ver2 t0, 
	     sample_300_stat t1
	where t0.exp_run_time = t1.exp_run_time  
	      and iternum <= 300
	      and t0.proc_time < t1.avg_pt-2*t1.std_prt
	group by t0.exp_run_time;
alter view dn_outliers_300 add primary key (exp_run_time) disable;

select t0.exp_run_time*1000 as tsk_len, 
       '300' as sp_sz, 
       (t1.total-count(iternum)) as nOutliers, 
       ceil(min(proc_time)) as best_pt, 
       round(avg(proc_time),1) as avg_pt, 
       round(stddev(proc_time),2) as std_pt, 
       round(stddev(proc_time) / avg(proc_time),6) as rel_err
from Analysis_AlgSOC_Ver2 t0, 
     sample_300 t1,
     up_outliers_300,
     dn_outliers_300
where t0.exp_run_time = t1.exp_run_time  
      and iternum <= 300
      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- below
      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- above
group by t0.exp_run_time, t1.total
order by t0.exp_run_time, t1.total



select t0.exp_run_time*1000 as tsk_len, 
       '300' as sp_sz, 
       (t1.total-count(iternum)) as nOutliers, 
       ceil(min(proc_time)) as best_pt, 
       round(avg(proc_time),1) as avg_pt, 
       round(stddev(proc_time),2) as std_pt, 
       round(stddev(proc_time) / avg(proc_time),6) as rel_err
from Analysis_AlgSOC_Ver2 t0, 
     sample_300 t1
where t0.exp_run_time = t1.exp_run_time  
      and iternum <= 300
      and t0.proc_time <= t1.avg_pt+2*t1.std_prt -- below
      and t0.proc_time >= t1.avg_pt-2*t1.std_prt -- above
group by t0.exp_run_time, t1.total
order by t0.exp_run_time, t1.total















x = read.csv(file="1000_iter_stat",head=TRUE,sep="\t")
x1 = x$TSK_LEN[1:7] / 1000
y1 = x$AVG_PT[1:7]
lm(y1~x1)

Call:
lm(formula = y1 ~ x1)

Coefficients:
(Intercept)           x1  
     0.5471    1002.1021 


=> Under 300

select t0.exp_run_time*1000 as tsk_len, '1000' as sp_sz, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
from Analysis_AlgSOC_Ver2 t0, 
     (select exp_run_time, avg(proc_time) as avg_pt, stddev(proc_time) as std_prt
      from Analysis_AlgSOC_Ver2
      where iternum <= 1000
      group by exp_run_time) t1
where t0.exp_run_time = t1.exp_run_time  
      and t0.iternum <= 1000 
      and t0.proc_time <= t1.avg_pt+2*t1.std_prt
group by t0.exp_run_time
order by t0.exp_run_time 

select exp_run_time*1000 as tsk_len, '1000' as sp_sz, ceil(min(proc_time)) as best_pt, round(avg(proc_time),1) as avg_pt, round(stddev(proc_time),2) as std_prt, round(stddev(proc_time) / avg(proc_time),6) as rel_err
from Analysis_AlgSOC_Ver2
where iternum <= 1000
group by exp_run_time
order by exp_run_time asc

SQL> select procid,
       processname,
       utime+stime as proc_time,
       BLKIO_COUNT as io_counts
from azdblab_procinfo2
where algrunid = 6278 and utime+stime > 0 and iternum = 171;  2    3    4    5    6  

    PROCID PROCESSNAME			     PROC_TIME	IO_COUNTS
---------- -------------------------------- ---------- ----------
       480 md0_raid1				  2000		0
      9174 proc_monitor 			260000		0
     10408 java 				  2000		0
     10418 incr_work			     256523000		0
     11125 sshd 				 13000		0
     11126 sshd 				  4000		0
     11127 sshd 				  2000		0
     11128 bash 				 11000		0
     11129 xauth				  2000		0
     11132 bash 				  1000		0

10 rows selected.

SQL> select procid,
       processname,
       utime+stime as proc_time,
       BLKIO_COUNT as io_counts
from azdblab_procinfo2
where algrunid = 6278 and utime+stime > 0 and iternum = 170;  2    3    4    5    6  

    PROCID PROCESSNAME			     PROC_TIME	IO_COUNTS
---------- -------------------------------- ---------- ----------
      9174 proc_monitor 			258000		0
     10408 java 				  2000		0
     10418 incr_work			     256498000		0


x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
min


select algrunid, min(runtime)









select alg.EXP_RUN_TIME as secs_task,
       iternum,
       procid,
       processname,
       utime+stime as proc_time,
       NIVCSW,
       NVCSW,
       BLKIO_COUNT as io_counts
from azdblab_newalgrun2 alg, 
     azdblab_procinfo2 proc
where alg.algrunid = proc.algrunid 
AND (proc.algrunid = 6258 and utime+stime > 0 and iternum IN (90, 104))
OR (proc.algrunid = 6278 and utime+stime > 0 and iternum IN (171,118,202,258, 257))
OR (proc.algrunid = 6338 and utime+stime > 0 and iternum IN (128,296, 298))
OR (proc.algrunid = 6318 and utime+stime > 0 and iternum IN (27,252,88,276, 24))
OR (proc.algrunid = 6378 and utime+stime > 0 and iternum IN (117, 160))
order by secs_task asc, proc_time desc

x = read.csv(file="256_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 256-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="512_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 512-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="1024_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 1024-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="2048_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 2048-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()



    /***
     * DROP TABLE Analysis_AlgSOC_Ver2;
CREATE TABLE Analysis_AlgSOC_Ver2 AS 
	SELECT distinct
	       t3.exp_run_time,
	       t0.algrunid,
	       t0.iternum,
	       t0.measured_time,
	       t0.proc_time,
	       t2.total_proc_time,
	       (t0.measured_time-t0.proc_time) 	     as diff, 
	       (t0.measured_time-t2.total_proc_time) as tdiff,
	       t2.num_run_procs,
	       t1.num_procs,
	       t0.proc_utime,
           t0.proc_stime
	FROM 
		(SELECT arr.algrunid,
		       arr.iternum,
		       arr.runtime as measured_time,
                       proc.utime as proc_utime,
		       proc.stime as proc_stime,
		       ((proc.utime+proc.stime) / 1000) as proc_time
		FROM AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE arr.algrunid = proc.algrunid and arr.datanum = proc.DATANUM and arr.iternum = proc.iternum 
		and proc.PROCESSNAME = 'incr_work'
		order by arr.iternum) t0,
		(SELECT arr.algrunid,
		       arr.iternum,
		       count(procid) as num_procs
		FROM AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		group by arr.algrunid, arr.iternum) t1,
		(SELECT arr.algrunid,
			arr.iternum,
			(sum(proc.utime+proc.stime)/1000) as total_proc_time,
			count(procid) as num_run_procs
		FROM AZDBLab_NewAlgRunResult2 arr, AZDBLab_ProcInfo2 proc
		WHERE arr.algrunid = proc.algrunid
		and arr.datanum = proc.DATANUM
		and arr.iternum = proc.iternum 
		and (proc.utime+proc.stime) > 0
		group by arr.algrunid,arr.iternum) t2,
		(SELECT ar.EXP_RUN_TIME,
		        arr.algrunid
		FROM AZDBLab_NewAlgRun2 ar, AZDBLab_NewAlgRunResult2 arr
		WHERE arr.algrunid = ar.algrunid) t3
    WHERE t0.algrunid IN (5292,5332,5372,5412,5452,5532,6258,6278,6338,6318,6378) -- with turbo mode and ntp on with new proc monitor on sodb12
    and t0.algrunid = t1.algrunid
	and t1.algrunid = t2.algrunid 
	and t2.algrunid = t3.algrunid
	and t0.iternum = t1.iternum
	and t1.iternum = t2.iternum
	order by t0.algrunid, t0.iternum;
ALTER TABLE Analysis_AlgSOC_Ver2 ADD PRIMARY KEY (exp_run_time,algrunid,iternum) DISABLE;


select alg.EXP_RUN_TIME as secs_task,
       iternum,
       processname as procname,
       utime+stime as proc_time,
       NIVCSW,
       NVCSW,
       BLKIO_COUNT as io_counts
from azdblab_newalgrun2 alg, 
     azdblab_procinfo2 proc
where alg.algrunid = proc.algrunid 
AND ((proc.algrunid = 6258 and utime+stime > 0 and iternum IN (90, 202))
OR (proc.algrunid = 6278 and utime+stime > 0 and iternum IN (6,62,118,202,258))
OR (proc.algrunid = 6338 and utime+stime > 0 and iternum IN (16,44,268,296,297))
OR (proc.algrunid = 6318 and utime+stime > 0 and iternum IN (13,27,41,276,290,298))
OR (proc.algrunid = 6378 and utime+stime > 0 and iternum IN (6,13,20,117,287,294)))
order by secs_task asc, iternum, proc_time desc



select alg.EXP_RUN_TIME as secs_task,
       iternum,
       processname as procname,
       utime+stime as proc_time,
       NIVCSW,
       NVCSW,
       BLKIO_COUNT as io_counts
from azdblab_newalgrun2 alg, 
     azdblab_procinfo2 proc
where alg.algrunid = proc.algrunid 
AND ((proc.algrunid = 6258 and utime+stime > 0 and iternum IN (90, 104))
OR (proc.algrunid = 6278 and utime+stime > 0 and iternum IN (171,118,202,258, 257))
OR (proc.algrunid = 6338 and utime+stime > 0 and iternum IN (128,296, 298))
OR (proc.algrunid = 6318 and utime+stime > 0 and iternum IN (27,252,88,276, 24))
OR (proc.algrunid = 6378 and utime+stime > 0 and iternum IN (117, 160)))
order by secs_task asc, iternum, proc_time desc

drop view analysis_128_sec CASCADE CONSTRAINTS;
create view analysis_128_sec as 
	select ALGRUNID,
	       ITERNUM,
	       procid,
	       processname,
	       utime+stime as other_proc_time,
	       BLKIO_COUNT as io_counts
	from azdblab_procinfo2
	where algrunid = 6258 and processname <> 'incr_work';
alter view analysis_128_sec ADD PRIMARY KEY (procid) DISABLE; 

select iternum, 
       sum(other_proc_time) as other_total_time,
       count(procid) as other_procs
from analysis_128_sec
where other_proc_time > 0
group by algrunid, iternum
order by algrunid, iternum asc

drop view analysis_256_sec CASCADE CONSTRAINTS;
create view analysis_256_sec as 
	select ALGRUNID,
	       ITERNUM,
	       procid,
	       processname,
	       utime+stime as other_proc_time,
	       BLKIO_COUNT as io_counts
	from azdblab_procinfo2
	where algrunid = 6278 and processname <> 'incr_work';
alter view analysis_256_sec ADD PRIMARY KEY (procid) DISABLE; 


drop view analysis_512_sec CASCADE CONSTRAINTS;
create view analysis_512_sec as 
	select ALGRUNID,
	       ITERNUM,
	       procid,
	       processname,
	       utime+stime as other_proc_time,
	       BLKIO_COUNT as io_counts
	from azdblab_procinfo2
	where algrunid = 6338 and processname <> 'incr_work';
alter view analysis_512_sec ADD PRIMARY KEY (procid) DISABLE; 

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
cor(x$TDIFF, x$PRTIME)
cor(x$NRPROCS,x$PRTIME)
cor(x$NPROCS,x$PRTIME)


x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
cor(x$TDIFF, x$PRTIME)
cor(x$NRPROCS,x$PRTIME)
cor(x$NPROCS,x$PRTIME)

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
cor(x$TDIFF, x$PRTIME)
cor(x$NRPROCS,x$PRTIME)
cor(x$NPROCS,x$PRTIME)

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
cor(x$TDIFF, x$PRTIME)
cor(x$NRPROCS,x$PRTIME)
cor(x$NPROCS,x$PRTIME)


x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+2*sd(x$PRTIME))
length(x.sub$PRTIME)
write.table(x.sub,file = "128_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
setEPS()
postscript("128_sec_pt_trimmed_all.eps")
plot(x.sub$PRTIME, xlim=c(0,300), pch=19, main='PT without outliers on 128-second task', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x.sub$PRTIME, breaks = 100, plot=F)
postscript("128_sec_pt_trimmed_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, log='y', type='h', lwd=5, lend=2, main='PT frequency without outliers on 128-second task', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
#xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
#axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+2*sd(x$PRTIME))
write.table(x.sub,file = "256_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
length(x.sub$PRTIME)
setEPS()
postscript("256_sec_pt_trimmed_all.eps")
plot(x.sub$PRTIME, xlim=c(0,300), pch=19, main='PT without outliers on 256-second task', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x.sub$PRTIME, breaks = 100, plot=F)
postscript("256_sec_pt_trimmed_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, log='y', type='h', lwd=5, lend=2, main='PT frequency without outliers on 256-second task', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
#xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
#axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+2*sd(x$PRTIME))
write.table(x.sub,file = "512_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
length(x.sub$PRTIME)
min(x.sub$PRTIME)
max(x.sub$PRTIME)
median(x.sub$PRTIME)
sd(x.sub$PRTIME)

setEPS()
postscript("512_sec_pt_trimmed_all.eps")
plot(x.sub$PRTIME, xlim=c(0,300), pch=19, main='PT without outliers on 512-second task', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x.sub$PRTIME, breaks = 100, plot=F)
postscript("512_sec_pt_trimmed_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, log='y', type='h', lwd=5, lend=2, main='PT frequency without outliers on 512-second task', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
#xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
#axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+2*sd(x$PRTIME))
write.table(x.sub,file = "1024_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
length(x.sub$PRTIME)
min(x.sub$PRTIME)
max(x.sub$PRTIME)
median(x.sub$PRTIME)
mean(x.sub$PRTIME)
sd(x.sub$PRTIME)
setEPS()
postscript("1024_sec_pt_trimmed_all.eps")
plot(x.sub$PRTIME, xlim=c(0,300), pch=19, main='PT without outliers on 1024-second task', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x.sub$PRTIME, breaks = 100, plot=F)
postscript("1024_sec_pt_trimmed_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, log='y', type='h', lwd=5, lend=2, main='PT frequency without outliers on 1024-second task', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
#xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
#axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+2*sd(x$PRTIME))
write.table(x.sub,file = "2048_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
length(x.sub$PRTIME)
sd(x.sub$PRTIME)

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+sd(x$PRTIME))
write.table(x.sub,file = "2048_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
length(x.sub$PRTIME)
sd(x.sub$PRTIME)

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x.sub <- subset(x, x$PRTIME < median(x$PRTIME)+0.05*sd(x$PRTIME))
write.table(x.sub,file = "2048_sec_trimmed.dat",row.names=F,col.names=T,sep="\t", quote=FALSE)
length(x.sub$PRTIME)
sd(x.sub$PRTIME)

min(x.sub$PRTIME)
max(x.sub$PRTIME)
median(x.sub$PRTIME)
mean(x.sub$PRTIME)
sd(x.sub$PRTIME)

setEPS()
postscript("2048_sec_pt_trimmed_all.eps")
plot(x.sub$PRTIME, xlim=c(0,300), pch=19, main='PT without outliers on 2048-second task', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x.sub$PRTIME, breaks = 100, plot=F)
postscript("2048_sec_pt_trimmed_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, log='y', type='h', lwd=5, lend=2, main='PT frequency without outliers on 2048-second task', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
#xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
#axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

x = read.csv(file="256_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 256-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="512_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 512-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="1024_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 1024-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="2048_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 2048-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="128_sec_trimmed.dat",head=TRUE,sep="\t")
setEPS()
postscript("128_sec_other_total_time_wo_outliers.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time w/o Outliers on the 128-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("other_proc_2048_task_all.eps")
plot(x$TDIFF, xlim=c(0,300), pch=19, main='Other Total Time on the 2048-second task', xlab='# of executions', ylab='Other Total Time (msec)')
dev.off()

select ALGRUNID,
       ITERNUM,
       procid,
       processname,
       utime+stime as proc_time
from azdblab_procinfo2
where algrunid = 6278 and utime+stime > 0 and iternum = 171;

select sum(utime+stime)
from azdblab_procinfo2
where algrunid = 6278 and utime+stime > 0 and iternum = 1 and processname <> 'incr_work';


select iternum, 
       sum(other_proc_time) as other_total_time,
       count(procid) as other_procs
from analysis_256_sec
where other_proc_time > 0 
group by algrunid, iternum
order by algrunid, iternum asc

select iternum, 
       sum(other_proc_time) as other_total_time,
       count(procid) as other_procs
from analysis_256_sec
where other_proc_time > 0
group by algrunid, iternum
order by algrunid, iternum asc


select sum(proc_time)/300 as avg_other_time from analysis_256_sec

select sum(proc_time) / count(*) as avg_other_time from analysis_256_sec;

select sum(proc_time) / count(*) as avg_other_time from analysis_256_sec where iternum = 171;
select procid, processname, proc_time, io_counts from analysis_256_sec where iternum = 171 order by ALGRUNID, ITERNUM, proc_time desc, io_counts desc; 

drop view analysis_512_sec CASCADE CONSTRAINTS;
create view analysis_512_sec as 
	select ALGRUNID,
	       ITERNUM,
	       procid,
	       processname,
	       utime+stime as other_proc_time,
	       BLKIO_COUNT as io_counts
	from azdblab_procinfo2
	where algrunid = 6338 and processname <> 'incr_work';
alter view analysis_512_sec ADD PRIMARY KEY (procid) DISABLE; 

drop view analysis_1024_sec CASCADE CONSTRAINTS;
create view analysis_1024_sec as 
	select ALGRUNID,
	       ITERNUM,
	       procid,
	       processname,
	       utime+stime as other_proc_time,
	       BLKIO_COUNT as io_counts
	from azdblab_procinfo2
	where algrunid = 6318 and processname <> 'incr_work';
alter view analysis_1024_sec ADD PRIMARY KEY (procid) DISABLE; 



select procid,
       processname,
       utime+stime as proc_time,
       BLKIO_COUNT as io_counts
from azdblab_procinfo2
where algrunid = 6278 and utime+stime > 0 and iternum = 170;

select procid,
       processname,
       utime+stime as proc_time,
       BLKIO_COUNT as io_counts
from azdblab_procinfo2
where algrunid = 6278 and utime+stime > 0 and iternum = 258;
