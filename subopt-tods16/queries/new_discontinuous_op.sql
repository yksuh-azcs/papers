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
	where 
	   -- runid = 252 
	--and querynum = 7
  	--   runid = 269 
	--and querynum = 8
	--   runid = 418
	--and querynum = 7
  	 runid = 285
	and querynum = 7
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
	where 
	--     runid = 252 
	--and querynum = 7
	--   runid = 418
	--and querynum = 7
 	runid = 285
	and querynum = 7
	order by runid, querynum;
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
		where high_card - low_card >= 60000 and numPlans = 1 	
		group by dbms, runid, querynum, low_card) 
	group by dbms, runid, querynum, high_card
	order by runid, querynum, high_card desc;
ALTER TABLE DiscontOpNew_Step4 ADD PRIMARY KEY (runid,querynum,low_card,high_card);
--- select low_card, high_card from DiscontOpNew_Step4


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
	  and t0.card >= t1.low_card and t0.card <= t1.high_card
	--group by t0.dbms, t0.runid, t0.querynum, t0.low_card, t1.high_card, t0.planid, t0.opid
	order by t0.dbms, t0.runid, t0.querynum, t1.low_card asc, t0.oporder asc;	
ALTER TABLE DiscontOpNew_Step5 ADD PRIMARY KEY (runid,querynum,curr_card,opid);

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

select dbms, runid, querynum, low_card, high_card, curr_card, planid, opname, oporder, cost from discontopnew_step1
order by dbms, runid, querynum, low_card asc, oporder asc

-- generate sequences of at least five cardinalities 
DROP TABLE DiscontOpNew_Step7;
CREATE TABLE DiscontOpNew_Step7 AS 
	with atomic_seq
	(SELECT t1.runid,
	       t1.querynum,
	       t1.low_card,
	       t0.card as high_card
	FROM DiscontOpNew_Step1 t0, DiscontOpNew_Step4 t1
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.low_card+40000 <= t0.card and t0.card+10000 <= t1.high_card-40000)
	SELECT
	FROM  atomic_seq t0,
	      DiscontOpNew_Step1 t1
	WHERE 
	    t0.runid 	= t1.runid
	and t0.querynum = t1.querynum
	and t0.low_card+40000 <= t1.card and t1.card+10000 <= t0.high_card-40000)
ALTER TABLE DiscontOpNew_Step7 ADD PRIMARY KEY (runid,querynum,low_card,high_card);

-- 2 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM NSOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=2)
SELECT o1.dbms, a1.opname||', '||a2.opname AS operatorName, o1.noOperators, COUNT(*) as numQatCs
FROM operatorCard o1, NSOOper_S1_QatC_Op a1, NSOOper_S1_QatC_Op a2
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname, o1.noOperators
order by o1.dbms, numQatCs desc;



  LOW_CARD  HIGH_CARD
---------- ----------
    100000     310000 100000, 
    320000     550000
    560000     990000
   1000000    1650000
   1660000    1990000

--select low_card, high_card from DiscontOpNew_Step4
