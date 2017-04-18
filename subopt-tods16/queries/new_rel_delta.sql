
-- fixed relative delta
DROP TABLE NSO_Calc_RD2 CASCADE CONSTRAINTS;
CREATE TABLE NSO_Calc_RD2  AS
	-- upper plan is a newer generation
	SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.upper_gen as newer_gen_num,
	       --t0.lower_gen as lower_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case 
		--when t0.upper_ep_cqt < 0 then round(((t0.upper_cqt) / t0.upper_cqt), 2)
		--when t0.upper_ep_cqt > t0.upper_cqt then round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_ep_cqt), 2)
		--else round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_cqt), 2)
	       when t0.upper_ep_cqt > t0.upper_cqt then round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_ep_cqt), 2) -- not suboptimal
	       else  round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_cqt), 2)
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM NSO_Upper_EQT t0
	WHERE t0.upper_ep_cqt >= 0
	UNION  
	-- lower plan is a newer generation
	SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.lower_gen as newer_gen_num,
	       --t0.upper_gen as upper_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case
	       --when t0.lower_ep_cqt < 0 then round(((t0.lower_cqt) / t0.lower_cqt), 2) 
	       when t0.lower_ep_cqt > t0.lower_cqt then round(((t0.lower_ep_cqt - t0.lower_cqt) / t0.lower_ep_cqt), 2) 
	       else round(((t0.lower_ep_cqt - t0.lower_cqt) / t0.lower_cqt), 2) 
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM NSO_Lower_EQT t0
	WHERE t0.lower_ep_cqt >= 0
	ORDER BY dbms, runid, querynum, upper_card desc;
ALTER TABLE NSO_Calc_RD2 ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

select count(*) from NSO_Calc_RD2;

  COUNT(*)
----------
      3101

SQL> select count(*) from NSO_Calc_RD2 where rel_delta = -1;

  COUNT(*)
----------
	 2

SQL> select count(*) from NSO_Calc_RD2 where rel_delta = 1; 

  COUNT(*)
----------
	11

select count(*) 
from NSO_Upper_EQT t0
WHERE t0.upper_ep_cqt < 0 

  COUNT(*)
----------
	 1


SELECT count(*)
FROM NSO_Lower_EQT t0
WHERE t0.lower_ep_cqt < 0

  COUNT(*)
----------
	 9

select count(*) 
from
	(SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.upper_gen as newer_gen_num,
	       --t0.lower_gen as lower_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case 
		--when t0.upper_ep_cqt < 0 then round(((t0.upper_cqt) / t0.upper_cqt), 2)
		--when t0.upper_ep_cqt > t0.upper_cqt then round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_ep_cqt), 2)
		--else round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_cqt), 2)
	       when t0.upper_ep_cqt > t0.upper_cqt then round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_ep_cqt), 2) -- not suboptimal
	       else  round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_cqt), 2)
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM NSO_Upper_EQT t0
	WHERE t0.upper_ep_cqt >= 0) 
where rel_delta < 0 and rel_delta > -1

  COUNT(*)
----------
       583 


select count(*) 
from
	(SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.lower_gen as newer_gen_num,
	       --t0.upper_gen as upper_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case
	       --when t0.lower_ep_cqt < 0 then round(((t0.lower_cqt) / t0.lower_cqt), 2) 
	       when t0.lower_ep_cqt > t0.lower_cqt then round(((t0.lower_ep_cqt - t0.lower_cqt) / t0.lower_ep_cqt), 2) 
	       else round(((t0.lower_ep_cqt - t0.lower_cqt) / t0.lower_cqt), 2) 
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM NSO_Lower_EQT t0
	WHERE t0.lower_ep_cqt >= 0) 
where rel_delta < 0 and rel_delta > -1

  COUNT(*)
----------
       795 

select count(*) 
from
	(SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.upper_gen as newer_gen_num,
	       --t0.lower_gen as lower_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case 
		--when t0.upper_ep_cqt < 0 then round(((t0.upper_cqt) / t0.upper_cqt), 2)
		--when t0.upper_ep_cqt > t0.upper_cqt then round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_ep_cqt), 2)
		--else round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_cqt), 2)
	       when t0.upper_ep_cqt > t0.upper_cqt then round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_ep_cqt), 2) -- not suboptimal
	       else  round(((t0.upper_ep_cqt - t0.upper_cqt) / t0.upper_cqt), 2)
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM NSO_Upper_EQT t0
	WHERE t0.upper_ep_cqt >= 0) 
where rel_delta >= 0 and rel_delta < 1

  COUNT(*)
----------
       492 
 
select count(*) 
from
	(SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.lower_gen as newer_gen_num,
	       --t0.upper_gen as upper_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case
	       --when t0.lower_ep_cqt < 0 then round(((t0.lower_cqt) / t0.lower_cqt), 2) 
	       when t0.lower_ep_cqt > t0.lower_cqt then round(((t0.lower_ep_cqt - t0.lower_cqt) / t0.lower_ep_cqt), 2) 
	       else round(((t0.lower_ep_cqt - t0.lower_cqt) / t0.lower_cqt), 2) 
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM NSO_Lower_EQT t0
	WHERE t0.lower_ep_cqt >= 0) 
where rel_delta >= 0 and rel_delta < 1

  COUNT(*)
----------
      1218 

select round(avg(rel_delta),3) as avg_rd, min(rel_delta) as max_rd, count(*) as counts 
from NSO_Calc_RD 
where rel_delta > -1 and rel_delta < 0 

select round(avg(rel_delta),3) as avg_rd, max(rel_delta) as max_rd, count(*) as counts 
from NSO_Calc_RD 
where rel_delta < 1 and rel_delta >= 0 

    AVG_RD     MAX_RD	  COUNTS
---------- ---------- ----------
      .257	  .96	    1638

select round(avg(rel_delta),3) as avg_rd, min(rel_delta) as max_rd, count(*) as counts 
from NSO_Calc_RD2 
where rel_delta > -1 and rel_delta < 0 

    AVG_RD     MAX_RD	  COUNTS
---------- ---------- ----------
     -.214	 -.93	    1450



DROP TABLE NSO_RD_Stat2 CASCADE CONSTRAINTS;
CREATE TABLE NSO_RD_Stat2  AS
	-- upper plan is a newer generation
	SELECT dbms,
	       newer_gen_num,
	       round(avg(rel_delta), 2) as avg_rd
	FROM NSO_Calc_RD2
	GROUP BY dbms, newer_gen_num
	ORDER BY dbms, newer_gen_num;
ALTER TABLE NSO_RD_Stat2 ADD PRIMARY KEY (dbms, newer_gen_num);

DROP TABLE NSO_RD_SubOpt2 CASCADE CONSTRAINTS;
CREATE TABLE NSO_RD_SubOpt2  AS
	select t0.dbms, 
	       t0.runid,
	       t0.querynum,
	       t0.newer_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       t0.rel_delta
	from 
		NSO_Calc_RD2 t0,
		NSO_CP t1
	where t0.runid = t1.runid
	 and t0.querynum = t1.querynum
	 and t0.upper_card = t1.highcard
	 and t0.lower_card = t1.lowcard;
ALTER TABLE NSO_RD_SubOpt2 ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

--select count(*) from NSO_RD_SubOpt2;
  COUNT(*)
----------
       990

--select dbms, newer_gen_num, count(*) from NSO_RD_SubOpt2 where rel_delta > 0 group by dbms, newer_gen_num order by dbms, newer_gen_num
DBMS		     NEWER_GEN_NUM   COUNT(*)
-------------------- ------------- ----------
db2				 7	    1
db2				11	  220
mysql				 5	    3
oracle				 4	    1
oracle				 5	   59
oracle				 6	   34
pgsql				 5	    2
pgsql				 7	   21
pgsql				 8	   34
pgsql				10	    5
pgsql				11	   20

DBMS		     NEWER_GEN_NUM   COUNT(*)
-------------------- ------------- ----------
pgsql				12	    3


--select dbms, newer_gen_num, count(*) from NSO_RD_SubOpt2 where rel_delta <= 0 group by dbms, newer_gen_num order by dbms, newer_gen_num

DBMS		     NEWER_GEN_NUM   COUNT(*)
-------------------- ------------- ----------
db2				 7	  204
db2				 9	    1
db2				11	  111
mysql				 5	    8
oracle				 5	   39
oracle				 6	   46
pgsql				 6	   64
pgsql				 7	    8
pgsql				 8	   18
pgsql				10	    5
pgsql				11	   80
pgsql				12	    3

12 rows selected.

select newer_gen_num, sum(subOptCnt)
from (select dbms, newer_gen_num, count(*) as subOptCnt from NSO_RD_SubOpt2 where rel_delta > 0 group by dbms, newer_gen_num)
group by newer_gen_num
order by newer_gen_num

NEWER_GEN_NUM SUM(SUBOPTCNT)
------------- --------------
	    4		   1
	    5		  64
	    6		  34
	    7		  22
	    8		  34
	   10		   5
	   11		 240
	   12		   3

8 rows selected.

select newer_gen_num, sum(subOptCnt)
from (select dbms, newer_gen_num, count(*) as subOptCnt from NSO_RD_SubOpt2 where rel_delta <= 0 group by dbms, newer_gen_num)
group by newer_gen_num
order by newer_gen_num

NEWER_GEN_NUM SUM(SUBOPTCNT)
------------- --------------
	    5		  47
	    6		 110
	    7		 212
	    8		  18
	    9		   1
	   10		   5
	   11		 191
	   12		   3

8 rows selected.

