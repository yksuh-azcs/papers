select algrunid, iternum, 
       count(procid) as numProcs, 
       round(avg(pt),2) as avg_daemon_pt
from DIFF_INC_RUN_PROC_INFO 
where pt > 0 and exp_run_time = 16
--and processname NOT IN ('incr_work', 'proc_monitor') 
having count(procid) > 1
group by algrunid, iternum 
order by algrunid asc, iternum asc;

  ALGRUNID    ITERNUM	NUMPROCS AVG_DAEMON_PT
---------- ---------- ---------- -------------
     23921	  174	       5	     4
     23921	  278	       4	     5
     23921	  486	       4	  6.25
     23921	  526	       4	     1
     23921	  555	       4	     3

     23941	  105	       4	     5
     23941	  175	       4	  2.75
     23941	  245	       4	   2.5
     23941	  280	       4	  1.75
     23941	  350	       4	  1.75
     23941	  420	       4	  1.75
     23941	  490	       4	     2

     23961	  105	       4	   4.5
     23961	  314	       4	   5.5

     23981	  280	       4	 85.75
     23981	  311	       5	  62.4
     23981	  373	       4	  77.5
     23981	  435	       4	 78.75
     23981	  466	       4	 40.25

column processname format a20
select t1.algrunid, 
       t1.iternum, 
       t1.procid,
       t1.processname,
       t1.pt
from (select algrunid, iternum, 
       count(procid) as numProcs, 
       round(avg(pt),2) as avg_daemon_pt
from DIFF_INC_RUN_PROC_INFO 
where pt > 0 and exp_run_time = 16
--and processname NOT IN ('incr_work', 'proc_monitor') 
having count(procid) > 3
group by algrunid, iternum) t0, 
DIFF_INC_RUN_PROC_INFO t1 
where t0.algrunid = t1.algrunid and t0.iternum = t1.iternum 
and t1.pt > 0 --and t1.processname NOT IN ('incr_work', 'proc_monitor') 
order by t1.algrunid, t1.iternum, t1.pt desc 


  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23921	  174	    2349 java			      15
     23921	  174	    2335 java			       2
     23921	  174	     457 md127_raid1		       1
     23921	  174	     166 kslowd000		       1
     23921	  174	     167 kslowd001		       1
     23921	  278	    2877 java			      16
     23921	  278	    2335 java			       2
     23921	  278	     166 kslowd000		       1
     23921	  278	     167 kslowd001		       1
     23921	  486	    3190 java			      21
     23921	  486	    2335 java			       2

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23921	  486	     166 kslowd000		       1
     23921	  486	     457 md127_raid1		       1
     23921	  526	     457 md127_raid1		       1
     23921	  526	     167 kslowd001		       1
     23921	  526	     166 kslowd000		       1
     23921	  526	     470 jbd2/md127-8		       1
     23921	  555	    3815 java			       8
     23921	  555	    2335 java			       2
     23921	  555	     167 kslowd001		       1
     23921	  555	     166 kslowd000		       1
     23941	  105	    6634 java			      16

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23941	  105	    6621 java			       2
     23941	  105	     167 kslowd001		       1
     23941	  105	     166 kslowd000		       1
     23941	  175	    6942 java			       7
     23941	  175	    6621 java			       2
     23941	  175	     166 kslowd000		       1
     23941	  175	     167 kslowd001		       1
     23941	  245	    7259 java			       6
     23941	  245	    6621 java			       2
     23941	  245	     166 kslowd000		       1
     23941	  245	     167 kslowd001		       1

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23941	  280	    7365 java			       3
     23941	  280	    6621 java			       2
     23941	  280	     166 kslowd000		       1
     23941	  280	     167 kslowd001		       1
     23941	  350	    7577 java			       3
     23941	  350	    6621 java			       2
     23941	  350	     166 kslowd000		       1
     23941	  350	     167 kslowd001		       1
     23941	  420	    7683 java			       3
     23941	  420	    6621 java			       2
     23941	  420	     167 kslowd001		       1

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23941	  420	     166 kslowd000		       1
     23941	  490	    7894 java			       4
     23941	  490	    6621 java			       2
     23941	  490	     166 kslowd000		       1
     23941	  490	     167 kslowd001		       1
     23961	  105	   28394 java			      14
     23961	  105	   28381 java			       2
     23961	  105	     166 kslowd000		       1
     23961	  105	     167 kslowd001		       1
     23961	  314	   28702 java			      18
     23961	  314	   28381 java			       2

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23961	  314	     455 md0_raid1		       1
     23961	  314	     167 kslowd001		       1
     23981	  280	     167 kslowd001		     154
     23981	  280	     166 kslowd000		     150
     23981	  280	   14820 java			      37
     23981	  280	   14807 java			       2
     23981	  311	     166 kslowd000		     154
     23981	  311	     167 kslowd001		     153
     23981	  311	   14807 java			       2
     23981	  311	   15653 java			       2
     23981	  311	      30 khugepaged		       1

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23981	  373	     166 kslowd000		     154
     23981	  373	     167 kslowd001		     152
     23981	  373	   14807 java			       2
     23981	  373	   15747 java			       2
     23981	  435	     166 kslowd000		     154
     23981	  435	     167 kslowd001		     153
     23981	  435	   15934 java			       6
     23981	  435	   14807 java			       2
     23981	  466	     166 kslowd000		     152
     23981	  466	   16121 java			       6
     23981	  466	   14807 java			       2

  ALGRUNID    ITERNUM	  PROCID PROCESSNAME		      PT
---------- ---------- ---------- -------------------- ----------
     23981	  466	      16 kblockd/0		       1

78 rows selected.

drop table incr_stat;
create table incr_stat as 
	select algrunid,
	       max(pt) as max_pt,
	       avg(pt) as avg_pt,
	       stddev(pt) as sd_pt
	from DIFF_INC_RUN_PROC_INFO 
	where exp_run_time = 16
	and processname IN ('incr_work') 
	group by algrunid

drop table daemon_stat;
create table daemon_stat as 
	select algrunid, iternum, 
	       procid,
	 	processname,
		pt
	from DIFF_INC_RUN_PROC_INFO 
	where pt > 0 and exp_run_time = 16
	--and processname NOT IN ('incr_work', 'proc_monitor') 

drop table outlier_iter;
create table outlier_iter as 
	select t1.algrunid, 
	       t1.iternum
	from DIFF_INC_RUN_PROC_INFO t1, 
	     incr_stat t0
	where t0.algrunid = t1.algrunid 
	and t1.pt > t0.avg_pt+2*t0.sd_pt 
	and t1.processname = 'incr_work';


	select t1.algrunid, 
	       t1.iternum
	from DIFF_INC_RUN_PROC_INFO t1, 
	     incr_stat t0
	where t0.algrunid = t1.algrunid 
	and t1.pt = t0.max_pt
	order by algrunid, iternum;

  ALGRUNID    ITERNUM
---------- ----------
     23921	  745
     23921	  964
     23941	    5
     23941	   46
     23941	  105
     23941	  111
     23941	  117
     23941	  129
     23941	  153
     23941	  159
     23941	  201

  ALGRUNID    ITERNUM
---------- ----------
     23941	  231
     23941	  237
     23941	  249
     23941	  255
     23941	  296
     23941	  321
     23941	  346
     23941	  352
     23941	  358
     23941	  364
     23941	  389

  ALGRUNID    ITERNUM
---------- ----------
     23941	  395
     23941	  414
     23941	  420
     23941	  426
     23941	  507
     23941	  513
     23941	  532
     23941	  538
     23941	  544
     23941	  563
     23941	  625

  ALGRUNID    ITERNUM
---------- ----------
     23941	  644
     23941	  650
     23941	  669
     23941	  694
     23941	  700
     23941	  719
     23941	  725
     23941	  731
     23941	  737
     23941	  750
     23941	  756

  ALGRUNID    ITERNUM
---------- ----------
     23941	  762
     23941	  812
     23941	  870
     23941	  921
     23941	  940
     23941	  997
     23961	  558
     23981	  101
     23981	  496

53 rows selected.

select * from outlier_iter order by algrunid, iternum;

select t1.algrunid, 
       t1.iternum, 
       t1.procid,
       t1.processname,
       t1.pt
from  
	DIFF_INC_RUN_PROC_INFO t1
where (
   (t1.algrunid = 23921 and t1.iternum IN (745, 964))
OR (t1.algrunid = 23941 and t1.iternum IN (5, 997)) 
OR (t1.algrunid = 23961 and t1.iternum IN (558)) 
OR (t1.algrunid = 23981 and t1.iternum IN (101, 496)) 
)
order by algrunid, iternum asc, pt desc

select * from incr_stat;

column processname format a20
select t1.algrunid, 
       t1.iternum, 
       t1.procid,
       t1.processname,
       t1.pt
from () t0, 
DIFF_INC_RUN_PROC_INFO t1 
where t0.algrunid = t1.algrunid and t0.iternum = t1.iternum 
and t1.pt > 0 --and t1.processname NOT IN ('incr_work', 'proc_monitor') 
order by t1.algrunid, t1.iternum, t1.pt desc 




