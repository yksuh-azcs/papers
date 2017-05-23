-- Writer      : Young-Kyoon Suh
-- Date        : 03/15/17
-- Description : Define analysis queries for new discontinous operators 
-- labshelf 5.19/6.0

-- Gather all estimated cost per operator per plan across runs
-- DiscontOp_S0: DiscontinuousOperator_Step0
column opname FORMAT A10;
column dbms FORMAT A10;
DROP TABLE DiscontOpNew_Step0;
CREATE TABLE DiscontOpNew_Step0 AS 
	select *
	from DiscontOp_S0
	--where 
	   -- runid = 252 
	--and querynum = 7
  	--   runid = 269 
	--and querynum = 8
	--   runid = 418
	--and querynum = 7
  	-- runid = 285
	---and querynum = 7
	;
ALTER TABLE DiscontOpNew_Step0 ADD PRIMARY KEY (runid,querynum,card,PLANID,opID,statName);
-- queryid = 5338, runid = 252, querynumber = 7.
--select * from DiscontOp_S0 where opname = 'ALL:Full Table Scan'

DROP TABLE DiscontOpNew_Step1;
CREATE TABLE DiscontOpNew_Step1 AS 
	select distinct 
	       t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.card, 
	       t0.planid
	from DiscontOp_S0 t0 
	--where 
	--     runid = 252 
	--and querynum = 7
	--   runid = 418
	--and querynum = 7
 	--runid = 285
	--and querynum = 7
	order by runid, querynum
	;
ALTER TABLE DiscontOpNew_Step1 ADD PRIMARY KEY (runid,querynum,card);
-- select * from DiscontOpNew_Step1 where card <= 100000 order by card asc
DROP TABLE DiscontOpNew_Step2;
CREATE TABLE DiscontOpNew_Step2 AS 
	select  t0.dbms,
		t0.runid,
		t0.querynum,
		t0.card as low_card,
		t1.card as high_card,
		t0.planid as low_plan,
		t1.planid as high_plan
	from DiscontOpNew_Step1 t0,
	     DiscontOpNew_Step1 t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.card < t1.card
	order by runid, querynum, low_card asc; 
ALTER TABLE DiscontOpNew_Step2 ADD PRIMARY KEY (runid,querynum,low_card,high_card);
-- select * from DiscontOpNew_Ste

DROP TABLE DiscontOpNew_Step3;
CREATE TABLE DiscontOpNew_Step3 AS 
	SELECT t0.dbms,
	       t1.runid,
	       t1.querynum,
	       t1.low_card,
	       t1.high_card,
	       count(distinct t0.planid) as numPlans
	FROM DiscontOpNew_Step1 t0,
	     DiscontOpNew_Step2 t1
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t0.card >= t1.low_card and t0.card <= t1.high_card  
	group by t0.dbms, t1.runid, t1.querynum, t1.low_card, t1.high_card
	order by runid, querynum, high_card desc, low_card asc;
ALTER TABLE DiscontOpNew_Step3 ADD PRIMARY KEY (runid,querynum,low_card,high_card);
--- select low_card, high_card from DiscontOpNew_Step3

--- max consecutive range with the unique plan  
DROP TABLE DiscontOpNew_Step4;
CREATE TABLE DiscontOpNew_Step4 AS 
--	SELECT distinct runid, querynum, high_card, min(low_card) as low_card
--	FROM DiscontOpNew_Step3
--	where high_card - low_card > 60000 and numPlans = 1
--	group by runid, querynum, high_card
--	order by runid, querynum, high_card desc
--	UNION
	SELECT dbms, runid, querynum, high_card, min(low_card) as low_card
	FROM
		(SELECT distinct dbms, runid, querynum, low_card, max(high_card) as high_card
		FROM DiscontOpNew_Step3
		where (dbms <> 'mysql' and high_card - low_card >= 60000 and numPlans = 1)
		or (dbms = 'mysql' and high_card - low_card >= 600 and numPlans = 1)	
		group by dbms, runid, querynum, low_card) 
	group by dbms, runid, querynum, high_card
	order by runid, querynum, high_card desc;
ALTER TABLE DiscontOpNew_Step4 ADD PRIMARY KEY (runid,querynum,low_card,high_card);
--- select low_card, high_card from DiscontOpNew_Step4

DROP TABLE DiscontOpNew_Step4_MXD;
CREATE TABLE DiscontOpNew_Step4_MXD AS 
	SELECT dbms, max(high_card - low_card) as maxRangeDiff
	FROM DiscontOpNew_Step4
	group by dbms
	order by dbms;
ALTER TABLE DiscontOpNew_Step4_MXD ADD PRIMARY KEY (dbms);
--- select low_card, high_card from DiscontOpNew_Step4 where dbms = 'db2' and high_card-low_card = 1910000

--- select low_card, high_card from DiscontOpNew_Step4 where runid = 252 and querynum = 7;
--- select low_card, high_card from DiscontOpNew_Step4 where runid = 252 and querynum = 8;

SQL>  select low_card, high_card from DiscontOpNew_Step4 where runid = 252 and querynum = 9;

select distinct t0.low_card, t0.high_card, t1.planid
from DiscontOpNew_Step4 t0, DiscontOpNew_Step1 t1
where t0.runid = t1.runid 
and t0.querynum = t1.querynum 
and t0.low_card = t1.card
and t0.runid = 252 and t0.querynum = 6
order by low_card asc
;

  LOW_CARD  HIGH_CARD	  PLAN
---------- ---------- ----------
     50000     130000 P2
    160000     480000 P2
    490000     590000 P1
    670000    1120000 P1
   1210000    2000000 P0

DROP TABLE DiscontOpNew_Step4_mxd;
CREATE TABLE DiscontOpNew_Step4_mxd AS 
	select dbms, max(high_card-low_card) as max_diff
	from DiscontOpNew_Step4
	where (dbms = 'mysql' and (high_card - low_card) < 30000
	or dbms <> 'mysql' and (high_card - low_card) < 1990000
	)
	group by dbms
	order by dbms;
ALTER TABLE DiscontOpNew_Step4_mxd ADD PRIMARY KEY (dbms);
-- select * from DiscontOpNew_Step4_mxd;

-- second largest difference 

DBMS
--------------------------------------------------------------------------------
  MAX_DIFF
----------
db2
   1910000

mysql
     29700

oracle
   1900000

pgsql
   1980000

--- two-region sequence
DROP TABLE DiscontOpNew_Step4_2RS;
CREATE TABLE DiscontOpNew_Step4_2RS AS 
	select distinct
	       t0.runid,
	       t0.querynum,
	       t0.low_card as lowerStart,
	       t1.card as lowerEnd,
	       t1.card+10000 as upperStart,
	       t0.high_card as upperEnd
	from DiscontOpNew_Step4 t0, DiscontOpNew_Step1 t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.runid = 252 and t0.querynum = 6
	and t0.low_card = 670000 and t0.high_card = 1120000
	and t0.low_card+40000 <= t1.card 
	and t1.card+40000 < t0.high_card
	order by runid, querynum, lowerStart, lowerEnd, upperStart, upperEnd;
ALTER TABLE DiscontOpNew_Step4_2RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,upperStart,upperEnd);
-- select lowerStart,lowerEnd, upperStart,upperEnd from DiscontOpNew_Step4_2RS;

     RUNID   QUERYNUM LOWERSTART   LOWEREND UPPERSTART	 UPPEREND
---------- ---------- ---------- ---------- ---------- ----------
       252	    7	   50000      90000	100000	   200000
       252	    7	   50000     100000	110000	   200000
       252	    7	   50000     110000	120000	   200000
       252	    7	   50000     120000	130000	   200000
       252	    7	   50000     130000	140000	   200000
       252	    7	   50000     140000	150000	   200000
       252	    7	   50000     150000	160000	   200000
       252	    7	  450000     490000	500000	   540000
       252	    7	 1030000    1070000    1080000	  1140000
       252	    7	 1030000    1080000    1090000	  1140000
       252	    7	 1030000    1090000    1100000	  1140000
       252	    7	 1530000    1570000    1580000	  1630000
       252	    7	 1530000    1580000    1590000	  1630000
       252	    7	 1710000    1750000    1760000	  1850000
       252	    7	 1710000    1760000    1770000	  1850000
       252	    7	 1710000    1770000    1780000	  1850000
       252	    7	 1710000    1780000    1790000	  1850000
       252	    7	 1710000    1790000    1800000	  1850000
       252	    7	 1710000    1800000    1810000	  1850000

--- three-region sequence
DROP TABLE DiscontOpNew_Step4_3RS;
CREATE TABLE DiscontOpNew_Step4_3RS AS 
	select distinct
	       t0.runid,
	       t0.querynum,
	       t0.low_card as lowerStart,
	       t1.card as lowerEnd,
	       t1.card+10000 as intermStart1,
	       t2.card+40000 as intermEnd1,
	       t2.card+40000+10000 as upperStart,
	       t0.high_card as upperEnd
	from DiscontOpNew_Step4 t0, DiscontOpNew_Step1 t1, DiscontOpNew_Step1 t2
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.runid = 252 and t0.querynum = 6
	and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t0.high_card 
	and t1.card+10000 <= t2.card and t2.card <= t1.card+40000 
	and t2.card+40000 <= t0.high_card 
	and t0.high_card-t2.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd;
ALTER TABLE DiscontOpNew_Step4_3RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,upperStart,upperEnd);
-- select LOWERSTART,LOWEREND,INTERMSTART1, INTERMEND1, UPPERSTART, UPPEREND from DiscontOpNew_Step4_3RS;

-- [100-140, 150-190, 200-240, 250-500]
-- [100-150, 160-200, 210-250, 260-500]



--[490K,177K, 178K-182K,183K-187K, 188K-1920K]
--[490K,176K, 177K-181K,182K-186K, 187K-1920K]
--[490K,175K, 176K-180K,181K-185K, 186K-1920K]

--[490K,530K, 540K-580K,590K-630K, 640K-1920K]

DROP TABLE DiscontOpNew_Step4_4RS;
CREATE TABLE DiscontOpNew_Step4_4RS AS 
	select distinct
	       t0.runid,
	       t0.querynum,
	       t0.low_card as lowerStart,
	       t1.card as lowerEnd,
	       t1.card+10000 as intermStart1,
	       t2.card+40000 as intermEnd1,
	       t2.card+40000+10000 as intermStart2,
 	       t3.card+40000 as intermEnd2,
 	       t3.card+40000+10000 as upperStart,
 	       t0.high_card as upperEnd
	from DiscontOpNew_Step4 t0, DiscontOpNew_Step1 t1, DiscontOpNew_Step1 t2, DiscontOpNew_Step1 t3
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.runid = 252 and t0.querynum =6
	and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t2.runid = t3.runid
	and t2.querynum = t3.querynum 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t2.card 
	and t2.card+40000+10000 <= t3.card and t3.card+40000 <= t0.high_card 
	and t0.high_card-t3.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd; 
ALTER TABLE DiscontOpNew_Step4_4RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2,intermEnd2,upperStart,upperEnd);
-- select LOWERSTART,LOWEREND,INTERMSTART1, INTERMEND1, INTERMSTART2, intermEnd2, UPPERSTART, UPPEREND from DiscontOpNew_Step4_4RS;

DROP TABLE DiscontOpNew_Step4_5RS;
CREATE TABLE DiscontOpNew_Step4_5RS AS 
	select distinct
	       t0.runid,
	       t0.querynum,
	       t0.low_card as lowerStart,
	       t1.card as lowerEnd,
	       t1.card+10000 as intermStart1,
	       t2.card+40000 as intermEnd1,
	       t2.card+40000+10000 as intermStart2,
 	       t3.card+40000 as intermEnd2,
	       t3.card+40000+10000 as intermStart3,
 	       t4.card+40000 as intermEnd3,
	       t4.card+40000+10000 as upperStart,
 	       t0.high_card as upperEnd
	from DiscontOpNew_Step4 t0, DiscontOpNew_Step1 t1, DiscontOpNew_Step1 t2, DiscontOpNew_Step1 t3, DiscontOpNew_Step1 t4
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.runid = 252 and t0.querynum =6
	and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t2.runid = t3.runid
	and t2.querynum = t3.querynum 
	and t3.runid = t4.runid
	and t3.querynum = t4.querynum 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t2.card 
	and t2.card+40000+10000 <= t3.card and t3.card+40000+10000 <= t4.card and t4.card+40000 <= t0.high_card 
	and t0.high_card-t4.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd; 
ALTER TABLE DiscontOpNew_Step4_5RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2,intermEnd2,intermStart3,intermEnd3,upperStart,upperEnd);
-- select LOWERSTART,LOWEREND,INTERMSTART1, INTERMEND1, INTERMSTART2, intermEnd2, INTERMSTART3, intermEnd3, UPPERSTART, UPPEREND from DiscontOpNew_Step4_5RS;


DROP TABLE DiscontOpNew_Step4_6RS;
CREATE TABLE DiscontOpNew_Step4_6RS AS 
	select distinct
	       t0.runid,
	       t0.querynum,
	       t0.low_card as lowerStart,
	       t1.card as lowerEnd,
	       t1.card+10000 as intermStart1,
	       t2.card+40000 as intermEnd1,
	       t2.card+40000+10000 as intermStart2,
 	       t3.card+40000 as intermEnd2,
	       t3.card+40000+10000 as intermStart3,
 	       t4.card+40000 as intermEnd3,
	       t4.card+40000+10000 as intermStart4,
	       t5.card+40000 as intermEnd4,
	       t5.card+40000+10000 as upperStart,
 	       t0.high_card as upperEnd
	from DiscontOpNew_Step4 t0, DiscontOpNew_Step1 t1, DiscontOpNew_Step1 t2, DiscontOpNew_Step1 t3, DiscontOpNew_Step1 t4, DiscontOpNew_Step1 t5
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.runid = 252 and t0.querynum =6
	and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t2.runid = t3.runid
	and t2.querynum = t3.querynum 
	and t3.runid = t4.runid
	and t3.querynum = t4.querynum 
	and t4.runid = t5.runid
	and t4.querynum = t5.querynum 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t2.card 
	and t2.card+40000+10000 <= t3.card and t3.card+40000+10000 <= t4.card 
	and t4.card+40000+10000 <= t5.card and t5.card+40000 <= t0.high_card
	and t0.high_card-t5.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd; 
ALTER TABLE DiscontOpNew_Step4_6RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2,intermEnd2,intermStart3,intermEnd3,intermStart4,intermEnd4,upperStart,upperEnd);

-- select LOWERSTART,LOWEREND,INTERMSTART1, INTERMEND1, INTERMSTART2, intermEnd2, INTERMSTART3, intermEnd3, INTERMSTART4, intermEnd4, UPPERSTART, UPPEREND from DiscontOpNew_Step4_6RS;


DROP TABLE DiscontOpNew_Step5;
CREATE TABLE DiscontOpNew_Step5 AS 
	SELECT  distinct
		t0.dbms,
		t0.runid,
		t0.querynum,
		t1.low_card,  -- start point of a range
		t1.high_card, -- end point of a range
		t0.card as curr_card,
		t0.planid,
		t0.opid,
		t0.opname,
		t0.oporder, 
		t0.statname,
		t0.estCost as cost
	FROM DiscontOpNew_Step0 t0,
	     DiscontOpNew_Step4 t1
	WHERE t0.runid = t1.runid 
	  and t0.querynum = t1.querynum 
	  and t0.runid = 252 and t0.querynum = 7
	  and t0.card >= t1.low_card and t0.card <= t1.high_card
	--group by t0.dbms, t0.runid, t0.querynum, t0.low_card, t1.high_card, t0.planid, t0.opid
	order by t0.dbms, t0.runid, t0.querynum, t1.low_card asc, t0.oporder asc;	
ALTER TABLE DiscontOpNew_Step5 ADD PRIMARY KEY (runid,querynum,curr_card,opid);

DROP TABLE DiscontOpNew_Step5_2RS;
CREATE TABLE DiscontOpNew_Step5_2RS AS 
	SELECT  distinct
		t0.dbms,
		t0.runid,
		t0.querynum,
		t1.lowerStart,  -- start point of a range
		t1.lowerEnd, -- end point of a range
		t0.card as curr_card,
		t0.planid,
		t0.opid,
		t0.opname,
		t0.oporder, 
		t0.statname,
		t0.estCost as cost,
		t1.upperStart,
		t1.upperEnd,
		t2.card as curr_card2,
		t2.planid as planid2,
		t2.opid as opid2,
		t2.opname as opname2,
		t2.oporder as oporder2,
		t2.statname as statname2,
		t2.estCost as cost2
	FROM DiscontOpNew_Step0 t0, DiscontOpNew_Step0 t2,
	     DiscontOpNew_Step4_2RS t1
	WHERE t0.runid = t1.runid 
	  and t0.querynum = t1.querynum	
	  and t1.runid = t2.runid
	  and t1.querynum = t2.querynum
	  and t0.runid = 252 and t0.querynum = 7
	  and t0.card >= t1.lowerStart and t0.card <= t1.lowerEnd
	 and t2.card >= t1.upperStart and t2.card <= t1.upperEnd
	;
ALTER TABLE DiscontOpNew_Step5_2RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,curr_card,opid,upperStart,upperEnd,curr_card2,opid2);

DROP TABLE DiscontOpNew_Step6;
CREATE TABLE DiscontOpNew_Step6 AS 
	SELECT	t0.dbms,
		t0.runid,
		t0.querynum,
		t0.low_card,
		t0.high_card,
		t0.planid,
		t0.oporder,
		--t0.opid,
		t0.opname,
		--t0.statname,
		round(REGR_SLOPE(curr_card, cost),3) as slope,
		round(REGR_R2(curr_card, cost),3) as rsqr
	FROM DiscontOpNew_Step5 t0
	GROUP BY dbms, runid, querynum, low_card, high_card, planid, oporder, opname
	ORDER BY dbms, runid, querynum, low_card, high_card, planid, oporder asc;
ALTER TABLE DiscontOpNew_Step6 ADD PRIMARY KEY (runid,querynum,low_card,planid,oporder);

DROP TABLE DiscontOpNew_Step6_2RS;
CREATE TABLE DiscontOpNew_Step6_2RS AS 
		SELECT	t0.dbms,
			t0.runid,
			t0.querynum,
			t0.lowerStart,
			t0.lowerEnd,
			t0.upperStart,
			t0.upperEnd,
			t0.planid,
			t0.oporder,
			--t0.opid,
			t0.opname,
			--t0.statname,
			round(REGR_SLOPE(curr_card, cost),3) as lower_slope,
			round(REGR_R2(curr_card, cost),3) as lower_rsqr
		FROM DiscontOpNew_Step5_2RS t0
		GROUP BY dbms, runid, querynum, lowerStart, lowerEnd, planid, oporder, opname) t0
	
		SELECT	t0.dbms,
			t0.runid,
			t0.querynum,
			t0.lowerStart,
			t0.lowerEnd,
			t0.upperStart,
			t0.upperEnd,
			t0.planid,
			t0.oporder,
			--t0.opid,
			t0.opname,
			--t0.statname,
			round(REGR_SLOPE(curr_card, cost),3) as lower_slope,
			round(REGR_R2(curr_card, cost),3) as lower_rsqr
		FROM DiscontOpNew_Step5_2RS t0
		GROUP BY dbms, runid, querynum, lowerStart, lowerEnd, planid, oporder, opname


	ORDER BY dbms, runid, querynum, low_card, high_card, planid, oporder asc;
ALTER TABLE DiscontOpNew_Step5_2RS ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,curr_card,opid,upperStart,upperEnd,curr_card2,opid2);
