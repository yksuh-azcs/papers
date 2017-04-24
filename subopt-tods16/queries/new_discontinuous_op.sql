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

DROP TABLE DiscontOpNew_S1;
CREATE TABLE DiscontOpNew_S1 AS 
	select t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.card as low_card, 
	       t1.card as high_card, 
	       t0.planid,
	       t0.opid,
	       t0.opname,
	       t0.oporder, 
	       t0.statname,
	       t0.estCost as low_cost,
	       t1.estCost as high_cost
	from DiscontOpNew_S0 t0,
	     DiscontOpNew_S0 t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and (t1.card - t0.card) > 60000 --- 6 points
	and t0.card >= 10000
	and t0.planid IN (SELECT planid  
			  FROM DiscontOpNew_S0 t2
			  WHERE t2.runid = t1.runid 
			    and t2.querynum = t1.querynum 
			    and t2.card >= t0.card --- 10K
			    and t2.card <= t1.card --- 70K 
			  having count(distinct planid) = 1  
			 )
	and t0.opid = t1.opid
	and t0.dbms <> 'mysql'
	order by dbms, runid, querynum, low_card asc, oporder asc;
ALTER TABLE DiscontOpNew_S1 ADD PRIMARY KEY (runid,querynum,low_card,high_card,opid,low_cost,high_cost);


select planid
from 
	(SELECT distinct planid
	FROM DiscontOp_S0 t2
	WHERE t2.runid = 252
	and t2.querynum = 7
	and t2.card >= 10000
	and t2.card <= 70000) t0
having count(*) > 1



