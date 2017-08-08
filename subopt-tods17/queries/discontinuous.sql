-- Writer      : Young-Kyoon Suh
-- Date        : 03/15/17
-- Description : Define analysis queries for identifying discontinous operators 
-- labshelf 5.19/6.0

-- Gather all estimated cost per operator per plan across runs
-- DiscontOp_S0: DiscontinuousOperator_Step0
DROP TABLE DiscontOp_S0;
CREATE TABLE DiscontOp_S0 AS 
	SELECT 
		--distinct 
		er.DBMSNAME as DBMS,
		er.runid, 
		q.querynumber as querynum, 
		qe.cardinality as card, 
		qep.PLANID, 
		po.PLANOPERATORID as opID,
		po.operatorname as opname, 
		po.OPERATORORDER as oporder, 
		qes.NAME as statName, 
		qes.value as estCost
	FROM azdblab_experimentrun er,
	     azdblab_query q,
	     azdblab_queryexecution qe, 
	     AZDBLAB_QUERYEXECUTIONHASPLAN qep,
	     AZDBLAB_PLANOPERATOR po,
	     AZDBLAB_QUERYEXECUTIONHASSTAT qes
	WHERE --er.runid IN (select runid from EH_Chosen_Runs_Ver1)  -- labshelves: 5.19/6.0
	  er.runid IN (select runid from NSOExh_Runs) -- labshelf: 7.10
	  --AND q.queryid = 132
	  AND qe.ITERNUM = 1
	  AND er.runid = q.runid 
	  AND q.queryid = qe.queryid
	  AND qe.queryexecutionid = qep.QUERYEXECUTIONID
	  AND qep.PLANID = po.planid
	  AND qe.queryexecutionid = qes.QUERYEXECUTIONID
	  AND qes.PLANOPERATORID = po.PLANOPERATORID
	  --AND qe.cardinality >= 1500000 
	  AND (qes.NAME IN ('ORA_COST', -- oracle 
	  'DB2_TOTAL_COST', -- db2
	  'PG_TOTAL_COST', -- pgsql
	  'MY_ROWS')) -- mysql 
	  --AND po.operatorname = 'HASH JOIN'
	--ORDER BY runid, querynum, card asc, qep.PLANID, po.operatorname, qe.cardinality, value	
	ORDER BY runid, querynum, card asc, PLANID, opname, oporder, statname;	
ALTER TABLE DiscontOp_S0 ADD PRIMARY KEY (runid,querynum,card,PLANID,opID,statName);
--select * from DiscontOp_S0 where opname = 'ALL:Full Table Scan'
column opname FORMAT A10;
column dbms FORMAT A10;
select distinct dbms, opname from DiscontOp_S0 order by dbms, opname;
select distinct dbms, opname from DiscontOp_S3 order by dbms, opname;
-- select distinct dbms, runid, querynum, card, planid, opname, oporder from DiscontOp_S0 where runid = 252 and querynum = 7 and card = 1970000 and PLANID=3689111368748543200 order by oporder asc
-- select distinct dbms, runid, querynum, card, opname, oporder from DiscontOp_S0 where runid = 267 and querynum = 6  and card = 210000 order by oporder asc
-- select distinct dbms, runid, querynum, card, opname, oporder from DiscontOp_S0 where runid = 252 and querynum = 6  and card = 310000 order by oporder asc
DROP TABLE DiscontOp_S1;
CREATE TABLE DiscontOp_S1 AS 
	SELECT  t0.DBMS,
		t0.runid,
		t0.querynum,
		t0.card as low_card,
		t1.card as high_card,
		t0.planid as low_plan,
		t1.planid as high_plan,
		t0.opID,
		t0.opname,
		t0.oporder,
		t0.estCost as low_cost,
		t1.estCost as high_cost,
		((t1.estCost-t0.estCost)/10000) as slope
		--((t1.estCost-t0.estCost)/t0.estCost) as slope
	FROM DiscontOp_S0 t0, -- low card
	     DiscontOp_S0 t1  -- high card 
	WHERE t0.runid = t1.runid 
	AND t0.querynum = t1.querynum 
	AND (t0.card+10000 = t1.card -- adjacent cardinalities
	OR t0.card+300 = t1.card)
	AND t0.planid = t1.planid 
	AND t0.opID = t1.opID
	ORDER BY runid, querynum, high_card asc, high_plan, opID, slope;	
ALTER TABLE DiscontOp_S1 ADD PRIMARY KEY (runid,querynum,high_card,high_plan,opID,slope);
column opname FORMAT A20;
--select * from DiscontOp_S1 where opname = 'HASH' and high_card >= 1100000 and high_card <= 1200000
--select card from DiscontOp_S0 where opname = 'SELECT STATEMENT' 
--(select distinct card from DiscontOp_S0 where opname = 'SELECT STATEMENT' minus select high_card from DiscontOp_S1 where opname = 'SELECT STATEMENT')
--select high_card, slope from DiscontOp_S1 where opname = 'ALL:Full Table Scan'
-- select runid, querynum, low_card, high_card, low_plan, high_plan, opname, oporder, low_cost, high_cost, round(slope, 4) as slope  from DiscontOp_S1 where opname = 'HSJOIN' and DBMS = 'db2' and slope < 0 order by runid, querynum, high_card desc
-- select low_card, high_card, low_plan, high_plan, opname, oporder, low_cost, high_cost, slope from DiscontOp_S1 where opname = 'HSJOIN' and querynum = 3 and runid = 252 and slope < 0 order by runid, querynum 
-- select dbms, runid, querynum, low_card, high_card, low_plan, high_plan, opname, oporder, low_cost, high_cost, slope from DiscontOp_S1 where opname = 'HSJOIN' and slope < -122800 order by runid, querynum 
-- select dbms, runid, querynum, low_card, high_card, low_plan, high_plan, opname, oporder, low_cost, high_cost, slope from DiscontOp_S1 where opname = 'MSJOIN' and slope > 4345443 order by runid, querynum 
-- select dbms, runid, querynum, low_card, high_card, low_plan, high_plan, opname, oporder, low_cost, high_cost, slope from DiscontOp_S1 where opname = 'SORT' and slope = 0.476 order by runid, querynum 
DROP TABLE DiscontOp_S1_Stat;
CREATE TABLE DiscontOp_S1_Stat AS 
	SELECT  t0.DBMS,
		t0.runid,
		t0.querynum,
		t0.high_plan as planid,
		t0.opID,
		t0.opname,
		t0.oporder,
		avg(t0.slope) as slp_avg,
		stddev(t0.slope) as slp_std
	FROM DiscontOp_S1 t0
	GROUP BY DBMS,runid, querynum,high_plan,opID,opname,oporder 
	ORDER BY DBMS,runid, querynum,high_plan,oporder,opname;
ALTER TABLE DiscontOp_S1_Stat ADD PRIMARY KEY (runid,querynum,PLANID,opID);
-- select planid,opname, oporder, slp_avg,slp_std from DiscontOp_S1_Stat 

DROP TABLE DiscontOp_S2;
CREATE TABLE DiscontOp_S2 AS 
	SELECT	t0.DBMS,
		t0.runid,
		t0.querynum,
		t0.high_card,	
		t1.planid,
		t0.opId,
		t0.opname,
		t0.oporder,
		t0.slope
	FROM 	DiscontOp_S1 t0,
		DiscontOp_S1_Stat t1
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.high_plan = t1.planid
	and t0.opID = t1.opID 
	-- locate one > one avg + one standard dev.
	and t0.slope > t1.slp_avg+5*t1.slp_std
	--and t0.slope > t1.slp_avg+10*t1.slp_std 
        --or t0.slope < t1.slp_avg-10*t1.slp_std
	;
ALTER TABLE DiscontOp_S2 ADD PRIMARY KEY (runid,querynum,high_card,PLANID,opID);

DROP TABLE DiscontOp_S3;
CREATE TABLE DiscontOp_S3 AS 
	SELECT distinct 
	       dbms,
	       opname
	FROM (SELECT distinct 
		       dbms,
		       runid,
		       opname
		FROM DiscontOp_S2)
	ORDER BY opname desc;
ALTER TABLE DiscontOp_S3 ADD PRIMARY KEY (dbms,opname);
column opname FORMAT A20;
column dbms FORMAT A20;
select * from DiscontOp_S3;


-- select planid,opname, oporder, slp_avg,slp_std from DiscontOp_S1_Stat 
DROP TABLE DiscontOp_S1_Stat2;
CREATE TABLE DiscontOp_S1_Stat2 AS 
	SELECT	t0.DBMS,
		t0.opname,
		min(t0.slope) as slp_min,
		max(t0.slope) as slp_max,
		round(avg(t0.slope),3) as slp_avg,
		round(stddev(t0.slope),4) as slp_std
	FROM 	DiscontOp_S1 t0
	GROUP BY DBMS,opname
	ORDER BY DBMS,opname;
ALTER TABLE DiscontOp_S1_Stat2 ADD PRIMARY KEY (DBMS,opname);

DROP TABLE DiscontOp_S1_Stat3;
CREATE TABLE DiscontOp_S1_Stat3 AS 
	SELECT	t0.DBMS,
		t0.high_plan as planid,
		t0.oporder,
		t0.opname,
		min(t0.slope) as slp_min,
		max(t0.slope) as slp_max,
		round(avg(t0.slope),3) as slp_avg,
		round(stddev(t0.slope),4) as slp_std
	FROM 	DiscontOp_S1 t0
	GROUP BY DBMS,high_plan,oporder,opname
	ORDER BY DBMS,high_plan,oporder;
ALTER TABLE DiscontOp_S1_Stat3 ADD PRIMARY KEY (DBMS,planid,oporder);
-- select * from DiscontOp_S1_Stat3;


-- select * from DiscontOp_S1_Stat2;
--select DBMS, opname from DiscontOp_S1_Stat2 where slp_min < -122800
DROP TABLE DiscontOp_NS2;
CREATE TABLE DiscontOp_NS2 AS 
	SELECT	t1.*
	FROM 	DiscontOp_S1_Stat2 t1
	WHERE slp_max > 1
	;
ALTER TABLE DiscontOp_NS2 ADD PRIMARY KEY (DBMS,opname);

DROP TABLE DiscontOp_NS3;
CREATE TABLE DiscontOp_NS3 AS 
	SELECT distinct 
	       dbms,
	       opname
	FROM (
		SELECT distinct 
		       dbms,
		       opname
		FROM DiscontOp_NS2
		ORDER BY opname desc
	     )
	ORDER BY opname desc;
ALTER TABLE DiscontOp_NS3 ADD PRIMARY KEY (dbms,opname);
column opname FORMAT A20;
column dbms FORMAT A20;
select * from DiscontOp_NS3;

