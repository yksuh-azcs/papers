-- Writer      : Young-Kyoon Suh
-- Date        : 03/15/17
-- Description : Define analysis queries for new discontinous operators 
-- labshelf 5.19/6.0

-- Gather all estimated cost per operator per plan across runs
-- DiscontOp_S0: DiscontinuousOperator_Step0
column opname FORMAT A10;
column dbms FORMAT A10;
DROP TABLE DiscontOpNew_S0;
CREATE TABLE DiscontOpNew_S0 AS 
	select *
	from DiscontOp_S0
	where 
	   runid = 252 
	and querynum = 7;
ALTER TABLE DiscontOpNew_S0 ADD PRIMARY KEY (runid,querynum,card,PLANID,opID,statName);
-- queryid = 5338, runid = 252, querynumber = 7.
--select * from DiscontOp_S0 where opname = 'ALL:Full Table Scan'

DROP TABLE DiscontOpNew_CP1;
CREATE TABLE DiscontOpNew_CP1 AS 
	select distinct 
	       t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.card, 
	       t0.planid
	from DiscontOp_S0 t0 
	where runid = 252 
	and querynum = 7
	order by runid, querynum;
ALTER TABLE DiscontOpNew_CP1 ADD PRIMARY KEY (runid,querynum,card);

DROP TABLE DiscontOpNew_CP2;
CREATE TABLE DiscontOpNew_CP2 AS 
	select  t0.dbms,
		t0.runid,
		t0.querynum,
		t0.card as low_card,
		t1.card as high_card,
		t0.planid as low_plan,
		t1.planid as high_plan
	from DiscontOpNew_CP1 t0,
	     DiscontOpNew_CP1 t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.card < t1.card
	order by runid, querynum, low_card asc; 
ALTER TABLE DiscontOpNew_CP2 ADD PRIMARY KEY (runid,querynum,low_card,high_card);

DROP TABLE DiscontOpNew_CP3;
CREATE TABLE DiscontOpNew_CP3 AS 
	SELECT t0.dbms,
	       t1.runid,
	       t1.querynum,
	       t1.low_card,
	       t1.high_card,
	       count(distinct t0.planid) as numPlans
	FROM DiscontOpNew_CP1 t0,
	     DiscontOpNew_CP2 t1
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t0.card >= t1.low_card and t0.card <= t1.high_card  
	group by t0.dbms, t1.runid, t1.querynum, t1.low_card, t1.high_card
	order by runid, querynum, high_card desc, low_card asc;
ALTER TABLE DiscontOpNew_CP3 ADD PRIMARY KEY (runid,querynum,low_card,high_card);
--- select low_card, high_card from DiscontOpNew_CP3

--- max consecutive range with the unique plan  
DROP TABLE DiscontOpNew_CP4;
CREATE TABLE DiscontOpNew_CP4 AS 
--	SELECT distinct runid, querynum, high_card, min(low_card) as low_card
--	FROM DiscontOpNew_CP3
--	where high_card - low_card > 60000 and numPlans = 1
--	group by runid, querynum, high_card
--	order by runid, querynum, high_card desc
--	UNION
	SELECT dbms, runid, querynum, high_card, min(low_card) as low_card
	FROM
		(SELECT distinct dbms, runid, querynum, low_card, max(high_card) as high_card
		FROM DiscontOpNew_CP3
		where high_card - low_card > 60000 and numPlans = 1 	
		group by dbms, runid, querynum, low_card) 
	group by dbms, runid, querynum, high_card
	order by runid, querynum, high_card desc;
ALTER TABLE DiscontOpNew_CP4 ADD PRIMARY KEY (runid,querynum,low_card,high_card);
--- select low_card, high_card from DiscontOpNew_CP4

DROP TABLE DiscontOpNew_S1;
CREATE TABLE DiscontOpNew_S1 AS 
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
	FROM DiscontOpNew_S0 t0,
	     DiscontOpNew_CP4 t1
	WHERE t0.runid = t1.runid 
	  and t0.querynum = t1.querynum 
	  and t0.card >= t1.low_card and t0.card <= t1.high_card
	--group by t0.dbms, t0.runid, t0.querynum, t0.low_card, t1.high_card, t0.planid, t0.opid
	order by t0.dbms, t0.runid, t0.querynum, t1.low_card asc, t0.oporder asc;	
ALTER TABLE DiscontOpNew_S1 ADD PRIMARY KEY (runid,querynum,curr_card,opid);

DROP TABLE DiscontOpNew_S2;
CREATE TABLE DiscontOpNew_S2 AS 
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
	FROM DiscontOpNew_S1 t0
	GROUP BY dbms, runid, querynum, low_card, high_card, planid, oporder, opname
	ORDER BY dbms, runid, querynum, low_card, high_card, planid, oporder asc;
ALTER TABLE DiscontOpNew_S2 ADD PRIMARY KEY (runid,querynum,low_card,planid,oporder);

select dbms, runid, querynum, low_card, high_card, curr_card, planid, opname, oporder, cost  from discontopnew_s1 
order by dbms, runid, querynum, low_card asc, oporder asc

