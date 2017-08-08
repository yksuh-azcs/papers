-- Writer: Young-Kyoon Suh (yksuh@cs.arizona.edu)
-- Date: 05/31/16
-- Final Revision: 08/08/16
-- Description: Define a set of queries to generate data for the DBMS operator study.

-- DBMSes used in our analysis
-- SOOper_DMD: SOOper_DBMS_Metadata
DROP TABLE SOOper_Dmd CASCADE CONSTRAINTS;
CREATE TABLE SOOper_Dmd
(
	dbmsname	VARCHAR2(10) NULL PRIMARY KEY
);
INSERT INTO SOOper_Dmd VALUES ('db2');
INSERT INTO SOOper_Dmd VALUES ('oracle');
INSERT INTO SOOper_Dmd VALUES ('pgsql');
INSERT INTO SOOper_Dmd VALUES ('mysql');

-- Create a table for chosen labshelf 
DROP TABLE SOOper_LabShelf CASCADE CONSTRAINTS;
CREATE TABLE SOOper_LabShelf AS
	SELECT '7.0' AS version, ---- version ---	
	'username' AS username, ---- username ---	
	'password' AS password, ---- password ---
	'connect_string' as connstr
	FROM Dual;
ALTER TABLE SOOper_LabShelf ADD PRIMARY KEY (version);

-- Create a table for pk runs 
DROP TABLE SOOper_PK_Runs CASCADE CONSTRAINTS;
CREATE TABLE SOOper_PK_Runs AS
	SELECT runid 
	FROM AZDBLab_ExperimentRun
	-- runs with primary keys
	WHERE runid IN (439,438,796,897) 
	ORDER BY runid;
ALTER TABLE SOOper_PK_Runs ADD PRIMARY KEY (runid);

-- Create a table for non-pk runs
DROP TABLE SOOper_Runs CASCADE CONSTRAINTS;
CREATE TABLE SOOper_Runs AS
	SELECT runid 
	FROM AZDBLab_ExperimentRun
	-- runs without primary keys
	WHERE runid IN (228,229,230,231) 
	ORDER BY runid;
ALTER TABLE SOOper_Runs ADD PRIMARY KEY (runid);

-- Get all Q@Cs from the chosen labshelf 
-- SOOper_S0_AQatC:  SOOper_Step0_All_Query_at_Cardinalities
DROP TABLE SOOper_S0_AQatC CASCADE CONSTRAINTS;
CREATE TABLE SOOper_S0_AQatC AS
	--- non PK runs
	SELECT  c_labshelf.version,	    -- labshelf version
		ex.experimentid,
		ex.experimentname,
		er.dbmsname as dbms,
		q.runid,
		q.queryNumber AS querynum,
		qe.cardinality AS card,  
		qe.queryexecutionid AS qeid,
		qp.planid			-- for checking plans
	FROM  SOOper_LabShelf c_labshelf,
	      AZDBLab_Experiment ex, 
	      AZDBLab_Experimentrun er, 
	      SOOper_Runs c_run,
	      AZDBLab_Query q, 
	      AZDBLab_QueryExecution qe, 
	      AZDBLab_QueryExecutionHasPlan qp
	 WHERE ex.experimentid=er.experimentid AND 
	       er.runid=c_run.runid AND 
               c_run.runid=q.runid AND
	       q.queryid=qe.queryid AND qe.ITERNUM = 1 AND -- all QatCs
               qe.queryexecutionid=qp.queryexecutionid AND -- all QPs
	       er.currentstage  ='Completed' AND
               er.percentage = 100
	UNION
	--- PK runs
	SELECT  c_labshelf.version,	   
		ex.experimentid,
		ex.experimentname,
		er.dbmsname as dbms,
		q.runid,
		q.queryNumber AS querynum,
		qe.cardinality AS card,
		qe.queryexecutionid AS qeid,
		qp.planid			-- for checking plans
	FROM  SOOper_LabShelf c_labshelf,
	      AZDBLab_Experiment ex, 
	      AZDBLab_Experimentrun er, 
	      SOOper_PK_Runs c_run,
	      AZDBLab_Query q, 
	      AZDBLab_QueryExecution qe, 
	      AZDBLab_QueryExecutionHasPlan qp
	 WHERE ex.experimentid=er.experimentid AND 
	       er.runid=c_run.runid AND 
               c_run.runid=q.runid AND
	       q.QUERYNUMBER < 100 AND	-- the first 100 queries only chosen
	       q.queryid=qe.queryid AND qe.ITERNUM = 1 AND -- all QatCs
               qe.queryexecutionid=qp.queryexecutionid AND -- all QPs
	       er.currentstage  ='Completed' AND
               er.percentage = 100;
ALTER TABLE SOOper_S0_AQatC ADD PRIMARY KEY (qeid);

-- Store the number of rows (step size) in a major step table/view
-- SOOper_RowCount:  SOOper_Row_Count
DROP TABLE SOOper_RowCount CASCADE CONSTRAINTS;
CREATE TABLE SOOper_RowCount
(
	dbmsName	VARCHAR2(10),
	exprName	VARCHAR2(50),
	stepName	VARCHAR2(50),
	stepResultSize	NUMBER (10, 2),
        PRIMARY KEY (dbmsName, exprName, stepName) 
);

-- Record the result size of SOOper_Step0_AQatC
DELETE FROM SOOper_RowCount where stepname ='SOOper_S0_AQatC';
INSERT INTO SOOper_RowCount (dbmsName, exprName, stepName, stepResultSize)
	SELECT dbms as dbmsName, 
	       experimentname as exprName,
	       'SOOper_S0_AQatC' as stepName,
	       count(qeid) as stepResultSize
	FROM SOOper_S0_AQatC
	GROUP BY dbms, experimentname;

-- Q@C statistics
-- Compute the total number of Q@Cs by dbms, experiment, run, query 
-- SOOper_S0_QatC_Per_Query: SOOper_Step0_QatC_Per_Query
DROP VIEW SOOper_S0_QatC_Per_Query CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_QatC_Per_Query AS
	SELECT dbms, 
	       experimentName, 
	       runid,
	       querynum,
               count(*) as numCards
	FROM (SELECT distinct 
			dbms, 
			experimentName, 
			runid, 
			querynum, 
			card 
		FROM SOOper_S0_AQatC) 
	GROUP by dbms, experimentName, runid, querynum;	
ALTER VIEW SOOper_S0_QatC_Per_Query ADD PRIMARY KEY (dbms,experimentName,runid, querynum) DISABLE;

-- Record the result size of SOOper_Step0_QatC_Per_Query
DELETE FROM SOOper_RowCount WHERE stepname = 'SOOper_S0_QatC_Per_Query';
INSERT INTO SOOper_RowCount (dbmsName, exprName, stepName, stepResultSize)
	SELECT dbms as dbmsName, 
	       experimentname as exprName,
	       'SOOper_S0_QatC_Per_Query' as stepName,
	       numCards as stepResultSize
	FROM SOOper_S0_QatC_Per_Query;

-- Compute the total number of Q@Cs by dbms, experiment, run
-- SOOper_S0_QatC_Per_Run: SOOper_Step0_QatC_Per_Run
DROP VIEW SOOper_S0_QatC_Per_Run CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_QatC_Per_Run AS
	SELECT dbms, 
	       experimentName, 
	       runid,
               count(*) as numQatCs
	FROM (SELECT distinct 
			dbms, 
			experimentName, 
			runid, 
			querynum, 
			card 
		FROM SOOper_S0_AQatC) 
	GROUP by dbms, experimentName, runid;	
ALTER VIEW SOOper_S0_QatC_Per_Run ADD PRIMARY KEY (dbms,experimentName,runid) DISABLE;

-- Record the result size of SOOper_S0_QatC_Per_Run
DELETE FROM SOOper_RowCount WHERE stepname = 'SOOper_S0_QatC_Per_Run';
INSERT INTO SOOper_RowCount (dbmsName, exprName, stepName, stepResultSize)
	SELECT dbms as dbmsName, 
	       experimentname as exprName,
	       'SOOper_S0_QatC_Per_Run' as stepName,
	       numQatCs as stepResultSize
	FROM SOOper_S0_QatC_Per_Run;

-- Roll up the number of Q@Cs by dbms
-- SOOper_S0_DTQatC: SOOper_Step0_DBMS_Total_QatC
DROP VIEW SOOper_S0_DTQatC CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_DTQatC AS
	SELECT dbms,
	       sum(numQatCs) AS totalQatCs
	FROM SOOper_S0_QatC_Per_Run
	GROUP BY dbms;
ALTER VIEW SOOper_S0_DTQatC ADD PRIMARY KEY (dbms) DISABLE;
--select * from SOOper_S0_DTQatC order by dbms

-- Compute the total number of Q@Cs across DBMSes
-- SOOper_S0_TQatC: SOOper_Step0_Total_QatC
DROP VIEW SOOper_S0_TQatC CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_TQatC AS
	SELECT sum(totalQatCs) AS totalQatCs
	FROM SOOper_S0_DTQatC;

-- Query statistics
-- Compute the total number of queries by dbms, experiment, run
DROP VIEW SOOper_S0_Q CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_Q AS
	SELECT qatc.dbms,
	       qatc.experimentName,
	       qatc.runid,
	       count(distinct qatc.querynum) as numQs
	FROM SOOper_S0_AQatC qatc
	GROUP BY (qatc.dbms, qatc.experimentName,qatc.runid);
ALTER VIEW SOOper_S0_Q ADD PRIMARY KEY (runid) DISABLE;

-- Record the result size of SOOper_S0_Q
DELETE FROM SOOper_RowCount where stepname ='SOOper_S0_Q';
INSERT INTO SOOper_RowCount (dbmsName, exprName, stepName, stepResultSize)
	SELECT dbms as dbmsName, 
	       experimentname as exprName,
	       'SOOper_S0_Q' as stepName,
	       SUM(numQs) as stepResultSize
	FROM SOOper_S0_Q
	GROUP BY dbms, experimentname;

-- Roll up the number of queries by dbms
-- SOOper_S0_DTQ: SOOper_Step0_DBMS_Total_Query
DROP VIEW SOOper_S0_DTQ CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_DTQ AS
	SELECT dbms,
	       sum(numQs) AS totalQs
	FROM SOOper_S0_Q 
	GROUP BY dbms;
ALTER VIEW SOOper_S0_DTQ ADD PRIMARY KEY (dbms) DISABLE;

-- Compute the total number of queries across DBMSes
-- SOOper_S0_TQ: SOOper_S0_Total_Query
DROP VIEW SOOper_S0_TQ CASCADE CONSTRAINTS;
CREATE VIEW SOOper_S0_TQ AS
	SELECT sum(totalQs) AS totalQs
	FROM SOOper_S0_DTQ;

-- Get all operators captured at all Q@Cs by DBMS
-- SOOper_S0_AQatC_Plan:  SOOper_Step0_All_Query_at_Cardinalities_Plan
DROP TABLE SOOper_S0_AQatC_Plan CASCADE CONSTRAINTS;
CREATE TABLE SOOper_S0_AQatC_Plan AS
	SELECT  qatc.dbms,
		qatc.runid,
		qatc.querynum,
		qatc.card,  
		qatc.qeid,
		qatc.planid,
		po.PLANOPERATORID as opid,	
		po.OPERATORNAME as opname		
	FROM  SOOper_S0_AQatC qatc, 
	      AZDBLab_PlanOperator po
	 WHERE qatc.planid = po.planid;
ALTER TABLE SOOper_S0_AQatC_Plan ADD PRIMARY KEY (qeid,planid,opid);

-- Compute the per-run stat for used query operators
-- SOOper_S0_Stat_Per_Run: Subopt_Operator_Step0_Stats_Per_Run
DROP TABLE SOOper_S0_Stat_Per_Run CASCADE CONSTRAINTS;
CREATE TABLE SOOper_S0_Stat_Per_Run AS
	SELECT  dbms,
		runid,
		opname, 
		count(*) as numUsed	
	FROM  SOOper_S0_AQatC_Plan
	GROUP BY dbms, runid, opname;
	--ORDER BY t0.dbms, t0.runid, t0.numUsed desc
ALTER TABLE SOOper_S0_Stat_Per_Run ADD PRIMARY KEY (dbms, runid, opname);

-- Compute the total stat for used query operators
-- SOOper_S0_Stat: Subopt_Operator_Step0_Statistics
DROP TABLE SOOper_S0_Stat CASCADE CONSTRAINTS;
CREATE TABLE SOOper_S0_Stat AS
	SELECT dbms,
	       opname, 
	       sum(numUsed) as totalUsed
	FROM SOOper_S0_Stat_Per_Run t0
	GROUP BY t0.dbms, opname
	ORDER BY t0.dbms, sum(numUsed) desc, opname;
ALTER TABLE SOOper_S0_Stat ADD PRIMARY KEY (dbms, opname);

-- Get each operator per DBMS
-- SOOper_S0_DBMS_Op: Subopt_Operator_Step0_DBMS_Operators
DROP TABLE SOOper_S0_DBMS_Op;
CREATE TABLE SOOper_S0_DBMS_Op AS
	SELECT  dbms,
		opname
	FROM SOOper_S0_Stat
	ORDER BY dbms, opname;
ALTER TABLE SOOper_S0_DBMS_Op ADD PRIMARY KEY (dbms, opname);

-- Get an operator per Q@C per DBMS
-- SOOper_S1_QatC_Op: Subopt_Operator_Step1_DBMS_Operators
DROP TABLE SOOper_S1_QatC_Op
CREATE TABLE SOOper_S1_QatC_Op AS
	SELECT  distinct 
		dbms,
		runid,
		querynum,
		card,
		opname
	FROM SOOper_S0_AQatC_Plan
	ORDER BY dbms, runid, querynum, card, opname;
ALTER TABLE SOOper_S1_QatC_Op ADD PRIMARY KEY (runid, querynum, card, opname);	 

-- Figure out generation per DBMS
-- Written by Sabah
-- 1 operator:
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=1)
SELECT o1.dbms, a1.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
GROUP BY o1.dbms, a1.opname, o1.noOperators;

-- 2 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=2)
SELECT o1.dbms, a1.opname||', '||a2.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname, o1.noOperators;

-- 3 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=3)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname, o1.noOperators;

-- 4 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=4)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3, SOOper_S1_QatC_Op a4
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
AND a1.dbms = a4.dbms
AND a1.runid = a4.runid
AND a1.querynum = a4.querynum
AND a1.card = a4.card
AND a1.opname>a4.opname 
AND a2.opname>a4.opname 
AND a3.opname>a4.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname, o1.noOperators;

-- 5 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=5)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3, SOOper_S1_QatC_Op a4, SOOper_S1_QatC_Op a5
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
AND a1.dbms = a4.dbms
AND a1.runid = a4.runid
AND a1.querynum = a4.querynum
AND a1.card = a4.card
AND a1.opname>a4.opname 
AND a2.opname>a4.opname 
AND a3.opname>a4.opname 
AND a1.dbms = a5.dbms
AND a1.runid = a5.runid
AND a1.querynum = a5.querynum
AND a1.card = a5.card
AND a1.opname>a5.opname 
AND a2.opname>a5.opname 
AND a3.opname>a5.opname 
AND a4.opname>a5.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname, o1.noOperators;

-- 6 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=6)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3, SOOper_S1_QatC_Op a4, SOOper_S1_QatC_Op a5, SOOper_S1_QatC_Op a6
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
AND a1.dbms = a4.dbms
AND a1.runid = a4.runid
AND a1.querynum = a4.querynum
AND a1.card = a4.card
AND a1.opname>a4.opname 
AND a2.opname>a4.opname 
AND a3.opname>a4.opname 
AND a1.dbms = a5.dbms
AND a1.runid = a5.runid
AND a1.querynum = a5.querynum
AND a1.card = a5.card
AND a1.opname>a5.opname 
AND a2.opname>a5.opname 
AND a3.opname>a5.opname 
AND a4.opname>a5.opname 
AND a1.dbms = a6.dbms
AND a1.runid = a6.runid
AND a1.querynum = a6.querynum
AND a1.card = a6.card
AND a1.opname>a6.opname 
AND a2.opname>a6.opname 
AND a3.opname>a6.opname 
AND a4.opname>a6.opname 
AND a5.opname>a6.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname, o1.noOperators;

-- 7 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=7)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname||', '||a7.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3, SOOper_S1_QatC_Op a4, SOOper_S1_QatC_Op a5, SOOper_S1_QatC_Op a6, SOOper_S1_QatC_Op a7
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
AND a1.dbms = a4.dbms
AND a1.runid = a4.runid
AND a1.querynum = a4.querynum
AND a1.card = a4.card
AND a1.opname>a4.opname 
AND a2.opname>a4.opname 
AND a3.opname>a4.opname 
AND a1.dbms = a5.dbms
AND a1.runid = a5.runid
AND a1.querynum = a5.querynum
AND a1.card = a5.card
AND a1.opname>a5.opname 
AND a2.opname>a5.opname 
AND a3.opname>a5.opname 
AND a4.opname>a5.opname 
AND a1.dbms = a6.dbms
AND a1.runid = a6.runid
AND a1.querynum = a6.querynum
AND a1.card = a6.card
AND a1.opname>a6.opname 
AND a2.opname>a6.opname 
AND a3.opname>a6.opname 
AND a4.opname>a6.opname 
AND a5.opname>a6.opname 
AND a1.dbms = a7.dbms
AND a1.runid = a7.runid
AND a1.querynum = a7.querynum
AND a1.card = a7.card
AND a1.opname>a7.opname 
AND a2.opname>a7.opname 
AND a3.opname>a7.opname 
AND a4.opname>a7.opname 
AND a5.opname>a7.opname 
AND a6.opname>a7.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname||', '||a7.opname, o1.noOperators;


-- 8 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=8)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname||', '||a7.opname||', '||a8.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3, SOOper_S1_QatC_Op a4, SOOper_S1_QatC_Op a5, SOOper_S1_QatC_Op a6, SOOper_S1_QatC_Op a7, SOOper_S1_QatC_Op a8
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
AND a1.dbms = a4.dbms
AND a1.runid = a4.runid
AND a1.querynum = a4.querynum
AND a1.card = a4.card
AND a1.opname>a4.opname 
AND a2.opname>a4.opname 
AND a3.opname>a4.opname 
AND a1.dbms = a5.dbms
AND a1.runid = a5.runid
AND a1.querynum = a5.querynum
AND a1.card = a5.card
AND a1.opname>a5.opname 
AND a2.opname>a5.opname 
AND a3.opname>a5.opname 
AND a4.opname>a5.opname 
AND a1.dbms = a6.dbms
AND a1.runid = a6.runid
AND a1.querynum = a6.querynum
AND a1.card = a6.card
AND a1.opname>a6.opname 
AND a2.opname>a6.opname 
AND a3.opname>a6.opname 
AND a4.opname>a6.opname 
AND a5.opname>a6.opname 
AND a1.dbms = a7.dbms
AND a1.runid = a7.runid
AND a1.querynum = a7.querynum
AND a1.card = a7.card
AND a1.opname>a7.opname 
AND a2.opname>a7.opname 
AND a3.opname>a7.opname 
AND a4.opname>a7.opname 
AND a5.opname>a7.opname 
AND a6.opname>a7.opname 
AND a1.dbms = a8.dbms
AND a1.runid = a8.runid
AND a1.querynum = a8.querynum
AND a1.card = a8.card
AND a1.opname>a8.opname 
AND a2.opname>a8.opname 
AND a3.opname>a8.opname 
AND a4.opname>a8.opname 
AND a5.opname>a8.opname 
AND a6.opname>a8.opname 
AND a7.opname>a8.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname||', '||a7.opname||', '||a8.opname, o1.noOperators;

-- 9 operators
WITH operatorCard AS 
(SELECT dbms, runid, querynum, card, COUNT(*) AS noOperators
FROM SOOper_S1_QatC_Op
GROUP BY dbms, runid, querynum, card
HAVING COUNT(*)=9)
SELECT o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname||', '||a7.opname||', '||a8.opname||', '||a9.opname AS operatorName, o1.noOperators, COUNT(*)
FROM operatorCard o1, SOOper_S1_QatC_Op a1, SOOper_S1_QatC_Op a2, SOOper_S1_QatC_Op a3, SOOper_S1_QatC_Op a4, SOOper_S1_QatC_Op a5, SOOper_S1_QatC_Op a6, SOOper_S1_QatC_Op a7, SOOper_S1_QatC_Op a8, SOOper_S1_QatC_Op a9
WHERE a1.dbms = o1.dbms
AND a1.runid = o1.runid
AND a1.querynum = o1.querynum
AND a1.card = o1.card 
AND a1.dbms = a2.dbms
AND a1.runid = a2.runid
AND a1.querynum = a2.querynum
AND a1.card = a2.card
AND a1.opname>a2.opname 
AND a1.dbms = a3.dbms
AND a1.runid = a3.runid
AND a1.querynum = a3.querynum
AND a1.card = a3.card
AND a1.opname>a3.opname 
AND a2.opname>a3.opname 
AND a1.dbms = a4.dbms
AND a1.runid = a4.runid
AND a1.querynum = a4.querynum
AND a1.card = a4.card
AND a1.opname>a4.opname 
AND a2.opname>a4.opname 
AND a3.opname>a4.opname 
AND a1.dbms = a5.dbms
AND a1.runid = a5.runid
AND a1.querynum = a5.querynum
AND a1.card = a5.card
AND a1.opname>a5.opname 
AND a2.opname>a5.opname 
AND a3.opname>a5.opname 
AND a4.opname>a5.opname 
AND a1.dbms = a6.dbms
AND a1.runid = a6.runid
AND a1.querynum = a6.querynum
AND a1.card = a6.card
AND a1.opname>a6.opname 
AND a2.opname>a6.opname 
AND a3.opname>a6.opname 
AND a4.opname>a6.opname 
AND a5.opname>a6.opname 
AND a1.dbms = a7.dbms
AND a1.runid = a7.runid
AND a1.querynum = a7.querynum
AND a1.card = a7.card
AND a1.opname>a7.opname 
AND a2.opname>a7.opname 
AND a3.opname>a7.opname 
AND a4.opname>a7.opname 
AND a5.opname>a7.opname 
AND a6.opname>a7.opname 
AND a1.dbms = a8.dbms
AND a1.runid = a8.runid
AND a1.querynum = a8.querynum
AND a1.card = a8.card
AND a1.opname>a8.opname 
AND a2.opname>a8.opname 
AND a3.opname>a8.opname 
AND a4.opname>a8.opname 
AND a5.opname>a8.opname 
AND a6.opname>a8.opname 
AND a7.opname>a8.opname 
AND a1.dbms = a9.dbms
AND a1.runid = a9.runid
AND a1.querynum = a9.querynum
AND a1.card = a9.card
AND a1.opname>a9.opname 
AND a2.opname>a9.opname 
AND a3.opname>a9.opname 
AND a4.opname>a9.opname 
AND a5.opname>a9.opname 
AND a6.opname>a9.opname 
AND a7.opname>a9.opname 
AND a8.opname>a9.opname 
GROUP BY o1.dbms, a1.opname||', '||a2.opname||', '||a3.opname||', '||a4.opname||', '||a5.opname||', '||a6.opname||', '||a7.opname||', '||a8.opname||', '||a9.opname, o1.noOperators;

--- DBMS operator generation
DROP TABLE SO_DBMS_Op_Gen CASCADE CONSTRAINTS;
CREATE TABLE SO_DBMS_Op_Gen
(
	dbmsName	VARCHAR2(10) NULL,
	genNum	NUMBER NULL,
	genTxt	VARCHAR2(1000) NULL
);
ALTER TABLE SO_DBMS_Op_Gen ADD PRIMARY KEY (dbmsName, genNum);	
-- for oracle 
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 1, 'SELECT STATEMENT');
-- HJOIN: hash join
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 2, 'HJOIN'); 
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 3, 'HASH');
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 4, 'SORT');
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 5, 'VIEW');
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 6, 'MERGE JOIN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('oracle', 7, 'NESTED LOOPS');
-- for mysql 
INSERT INTO SO_DBMS_Op_Gen VALUES ('mysql', 1, 'ALL:Full Table Scan');
-- AJOIN: ALL:Full Table Scan with Join
INSERT INTO SO_DBMS_Op_Gen VALUES ('mysql', 2, 'AJOIN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('mysql', 3, 'eq_ref');
-- for pgsql 
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 1, 'Seq Scan');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 2, 'Sort');
-- HJoin: Hash Join
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 3, 'HJoin');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 4, 'Hash');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 5, 'Merge Join');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 6, 'HashAggregate');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 7, 'Index Only Scan');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 8, 'Index Scan');
INSERT INTO SO_DBMS_Op_Gen VALUES ('pgsql', 9, 'Nested Loop');
-- for db2
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 1, 'TBSCAN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 2, 'RETURN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 3, 'HSJOIN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 4, 'GRPBY');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 5, 'SORT');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 6, 'IXSCAN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 7, 'FILTER');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 8, 'MSJOIN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 9, 'FETCH');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 10, 'NLJOIN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 11, 'RIDSCN');
INSERT INTO SO_DBMS_Op_Gen VALUES ('db2', 12, 'IXAND');

-- Rename a specific operator's name with the predefined name for later use
-- Will restore the renamed one with the original name later
--SOOper_S1_QatC_Ren_Op: SubOpt_Operator_Step1_QatC_Renamed_Operator
DROP TABLE SOOper_S1_QatC_Ren_Op CASCADE CONSTRAINTS;
CREATE TABLE SOOper_S1_QatC_Ren_Op AS
	-- for oracle
	SELECT dbms, runid, querynum, card, 
		case opname
			when 'HASH JOIN' then REGEXP_REPLACE(opname, 'HASH JOIN', 'HJOIN')
			else REGEXP_REPLACE(opname, 'VIEW:(.*)', 'VIEW')
		end as opname
	FROM SOOper_S1_QatC_Op t0
	WHERE dbms ='oracle'
	UNION
	-- for mysql
	SELECT dbms, runid, querynum, card, 
		case opname
			when 'ALL:Full Table Scan with Join' then REGEXP_REPLACE(opname, 'ALL:Full Table Scan with Join', 'AJOIN')
			else opname
		end as opname
	FROM SOOper_S1_QatC_Op t0
	WHERE dbms ='mysql'
	UNION
	-- for pgsql
	SELECT dbms, runid, querynum, card, 
		case 
			when opname like '%Hash Join%' then REGEXP_REPLACE(opname, 'Hash Join', 'HJoin')
			--when opname like '%HashAggregate%' then REGEXP_REPLACE(opname, 'HashAggregate', 'HAgg') 
			when opname like '%Index Scan%' then REGEXP_REPLACE(opname, 'Index Scan(.*)', 'Index Scan') 
			when opname like '%Index Only Scan%' then REGEXP_REPLACE(opname, 'Index Only Scan(.*)', 'Index Only Scan') 
			else opname
		end as opname
	FROM SOOper_S1_QatC_Op t0
	WHERE dbms ='pgsql'
	UNION
	-- for db2
	SELECT dbms, runid, querynum, card, opname
	FROM SOOper_S1_QatC_Op t0
	WHERE dbms ='db2'
	;
ALTER TABLE SOOper_S1_QatC_Ren_Op ADD PRIMARY KEY (runid, querynum, card, opname);	

-- Get an operator sequence (generation) string associated per Q@C
--SO_Gen_at_QatC: SubOpt_Generation_at_QatC
DROP TABLE SO_Gen_at_QatC CASCADE CONSTRAINTS;
CREATE TABLE SO_Gen_at_QatC AS
	SELECT distinct dbms, runid, querynum, card, 
	       LISTAGG(opname, ',') WITHIN GROUP (ORDER BY opname) AS generation
	FROM SOOper_S1_QatC_Ren_Op
	group by dbms, runid, querynum, card
	order by dbms, runid, querynum, card desc;
ALTER TABLE SO_Gen_at_QatC ADD PRIMARY KEY (runid, querynum, card);	

-- Compute the maximum generation number from each string
-- SO_GenNum_at_QatC: SubOpt_GenerationNumber_at_QatC
DROP TABLE SO_GenNum_at_QatC CASCADE CONSTRAINTS;
CREATE TABLE SO_GenNum_at_QatC AS
	SELECT t0.dbms,
 		t0.runid,
 		t0.querynum,
 		t0.card,
 		max(t0.gennum) as genNum
	FROM
		(SELECT dbms,
				runid,
				querynum,
				card,
				t1.genTxt,
				t1.genNum
		FROM SO_DBMS_Op_Gen t1, 
		     SO_Gen_at_QatC t2
		WHERE t1.dbmsName = t2.dbms
		and t2.generation like CONCAT(CONCAT('%',t1.genTxt),'%')
		ORDER BY dbms, runid, querynum, card desc) t0
	GROUP BY t0.dbms, t0.runid, t0.querynum, t0.card;
ALTER TABLE SO_GenNum_at_QatC ADD PRIMARY KEY (runid, querynum, card);

-- Get measured data (planid, median calculated time, generation number, generation string) per Q@C
-- Replace some predefined terms with the corresponding original terms for each generation string
-- SO_Gen_Stat_at_QatC: SubOpt_Generation_Stat_at_QatC
DROP TABLE SO_Gen_Stat_at_QatC CASCADE CONSTRAINTS;
CREATE TABLE SO_Gen_Stat_at_QatC AS
	SELECT	t0.dbms,
	 	t0.runid,
		t0.querynum,
		t0.card,
		t1.genNum,
		t0.med_calc_qt,
		t0.planid,
		case 
		     -- for oracle
		     when t2.generation like '%HJOIN%' then REGEXP_REPLACE(t2.generation, 'HJOIN', 'HASH JOIN')
		     -- for mysql
		     when t2.generation like '%AJOIN%' then REGEXP_REPLACE(t2.generation, 'AJOIN', 'ALL:Full Table Scan with Join')
		     -- for pgsql
		     when t2.generation like '%HJoin%' then REGEXP_REPLACE(t2.generation, 'HJoin', 'Hash Join') 
		     else t2.generation
		end as generation	
	FROM	SOExpl_ACTQatC t0,
	 	SO_GenNum_at_QatC t1,
		SO_Gen_at_QatC t2
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and t0.card = t1.card 
	and t1.runid = t2.runid
	and t1.querynum = t2.querynum 
	and t1.card = t2.card;
ALTER TABLE SO_Gen_Stat_at_QatC ADD PRIMARY KEY (runid, querynum, card);

-- Locate a Q@C in which an operator in a newer generation is used at an upper cardinality
-- SO_Newer_Gen_at_Upper_Card: SubOpt_Newer_Generation_at_Upper_Cardinality
DROP TABLE SO_Newer_Gen_at_Upper_Card CASCADE CONSTRAINTS;
CREATE TABLE SO_Newer_Gen_at_Upper_Card AS
	SELECT	t0.dbms,
	 	t0.runid,
		t0.querynum,
		t0.card as upper_card,
		t1.card as lower_card,
		t0.genNum as upper_gen,
		t1.genNum as lower_gen,
		t0.planid as upper_plan,
		t1.planid as lower_plan,
		t0.med_calc_qt as upper_cqt,
		t1.med_calc_qt as lower_cqt,
		t0.generation as upper_gen_txt,
		t1.generation as lower_gen_txt
	FROM	SO_Gen_Stat_at_QatC t0,
		SO_Gen_Stat_at_QatC t1
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	and ((t0.dbms <> 'mysql' and t0.card = t1.card+10000) 
	or (t0.dbms = 'mysql' and t0.card = t1.card+300))
	and t0.genNum > t1.genNum -- upper: newer / lower: older
	;
ALTER TABLE SO_Newer_Gen_at_Upper_Card ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

-- Compute extrapolated query time at an upper cardinality
-- SO_Upper_EQT: SubOpt_Upper_Extrapolated_Query_Time
DROP TABLE SO_Upper_EQT CASCADE CONSTRAINTS;
CREATE TABLE SO_Upper_EQT  AS
	SELECT	t0.dbms,
	 	t0.runid,
		t0.querynum,
		t0.upper_gen,
		t0.lower_gen,
		t0.upper_card, 
		t0.lower_card,
		t1.card as nearest_card, 
		t0.upper_cqt,
		case t0.lower_card - t1.card
			when 0 then t0.lower_cqt
			else
round(
-- y-intercept
t1.med_calc_qt-(((t0.lower_cqt - t1.med_calc_qt) / (t0.lower_card - t1.card))*t1.card)+
-- slope
(((t0.lower_cqt - t1.med_calc_qt) / (t0.lower_card - t1.card))*t0.upper_card)
, 1) 
		end as upper_ep_cqt,
		t0.lower_cqt,
		t1.med_calc_qt as nearest_cqt,
		t0.upper_gen_txt,
		t0.lower_gen_txt
	FROM SO_Newer_Gen_at_Upper_Card t0, 
	     SO_Gen_Stat_at_QatC t1
	WHERE t0.dbms = t1.dbms 
	and t0.runid = t1.runid 
	and t0.querynum = t1.querynum -- same query
	and t0.lower_plan = t1.planid -- same plan
	and t0.lower_card > t1.card -- lower card > nearest card
	and NOT EXISTS (SELECT * -- NOT EXISTS between lower card and nearest card (to be used for extrapolation)
			FROM SO_Gen_Stat_at_QatC t2
			WHERE t1.runid = t2.runid 
			and t1.querynum = t2.querynum
			and t1.planid = t2.planid 
			and t0.runid = t2.runid
			and t0.querynum = t2.querynum
			and t0.lower_plan = t2.planid
			-- should be no cardinality between lower card and nearest (upper) card with the same plans
			and t2.card > t1.card
			and t2.card < t0.lower_card
			)
	ORDER BY dbms, runid, querynum, lower_card desc, nearest_card desc;
ALTER TABLE SO_Upper_EQT ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

-- Locate a Q@C in which an operator in a newer generation is used at a lower cardinality
-- SO_Newer_Gen_at_Lower_Card: SubOpt_Newer_Generation_at_Lower_Cardinality
DROP TABLE SO_Newer_Gen_at_Lower_Card CASCADE CONSTRAINTS;
CREATE TABLE SO_Newer_Gen_at_Lower_Card AS
	SELECT	t0.dbms,
	 	t0.runid,
		t0.querynum,
		t0.card as upper_card,
		t1.card as lower_card,
		t0.genNum as upper_gen,
		t1.genNum as lower_gen,
		t0.planid as upper_plan,
		t1.planid as lower_plan,
		t0.med_calc_qt as upper_cqt,
		t1.med_calc_qt as lower_cqt,
		t0.generation as upper_gen_txt,
		t1.generation as lower_gen_txt
	FROM	SO_Gen_Stat_at_QatC t0,
		SO_Gen_Stat_at_QatC t1
	WHERE t0.runid = t1.runid 
	and t0.querynum = t1.querynum 
	-- t0.card: upper card, t1.card: lower card
	and ((t0.dbms <> 'mysql' and t0.card = t1.card+10000) 
	or (t0.dbms = 'mysql' and t0.card = t1.card+300))
	and t0.genNum < t1.genNum -- upper: older / lower: newer
	;
ALTER TABLE SO_Newer_Gen_at_Lower_Card ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

-- Compute extrapolated query time at a lower cardinality
-- SO_Lower_EQT: SubOpt_Lower_Extrapolated_Query_Time
DROP TABLE SO_Lower_EQT CASCADE CONSTRAINTS;
CREATE TABLE SO_Lower_EQT  AS
	SELECT	t0.dbms,
	 	t0.runid,
		t0.querynum,
		t0.upper_gen,
		t0.lower_gen,
		t1.card as nearest_card, 
		t0.upper_card, 
		t0.lower_card,
		t1.med_calc_qt as nearest_cqt,
		t0.upper_cqt,
		t0.lower_cqt,
		case t1.card - t0.upper_card
			when 0 then t0.upper_cqt
			else 
round(
-- y-intercept
(t0.upper_cqt-((t1.med_calc_qt-t0.upper_cqt)/(t1.card-t0.upper_card))*t0.upper_card+
-- slope
((t1.med_calc_qt-t0.upper_cqt)/(t1.card-t0.upper_card))*t0.lower_card), 1) 
		end as lower_ep_cqt,
		t0.upper_gen_txt,
		t0.lower_gen_txt
	FROM SO_Newer_Gen_at_Lower_Card t0, 
	     SO_Gen_Stat_at_QatC t1
	WHERE t0.dbms = t1.dbms 
	and t0.runid = t1.runid 
	and t0.querynum = t1.querynum -- same query
	and t0.upper_plan = t1.planid -- same plan
	and t1.card > t0.upper_card -- nearest card > upper card
	and NOT EXISTS (SELECT * -- NOT EXISTS between lower card and nearest card (to be used for extrapolation)
			FROM SO_Gen_Stat_at_QatC t2
			WHERE t1.runid = t2.runid 
			and t1.querynum = t2.querynum
			and t1.planid = t2.planid 
			and t0.runid = t2.runid
			and t0.querynum = t2.querynum
			and t0.upper_plan = t2.planid
			-- should be no cardinality between upper card and nearest (lower) card with the same plans
			and t2.card < t1.card
			and t2.card > t0.upper_card
			)
	ORDER BY dbms, runid, querynum, nearest_card desc;
ALTER TABLE SO_Lower_EQT ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

-- Calculate the relative delta
-- SO_Calc_RD: SubOpt_Calculate_Relative_Delta
DROP TABLE SO_Calc_RD CASCADE CONSTRAINTS;
CREATE TABLE SO_Calc_RD  AS
	-- an upper plan at a newer generation
	SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.upper_gen as newer_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case 
		when t0.upper_ep_cqt < 0 then round(((t0.upper_cqt) / t0.upper_cqt), 2) 
		else  round(((t0.upper_cqt - t0.upper_ep_cqt) / t0.upper_cqt), 2)
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM SO_Upper_EQT t0
	WHERE t0.upper_cqt > 0
	UNION
	-- a lower plan at a newer generation
	SELECT t0.dbms,
	       t0.runid,
	       t0.querynum,
	       t0.lower_gen as newer_gen_num,
	       t0.upper_card,
	       t0.lower_card,
	       case
		when t0.lower_ep_cqt < 0 then round(((t0.lower_cqt) / t0.lower_cqt), 2) 
		else round(((t0.lower_cqt - t0.lower_ep_cqt) / t0.lower_cqt), 2) 
	       end as rel_delta,
	       t0.upper_gen_txt as upper_gen_txt,
	       t0.lower_gen_txt as lower_gen_txt
	FROM SO_Lower_EQT t0
	WHERE t0.lower_cqt > 0
	ORDER BY dbms, runid, querynum, upper_card desc;
ALTER TABLE SO_Calc_RD ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

-- Compute average relative delta per generation 
-- SO_RD_Stat: SubOpt_Relative_Delta_Statistics
DROP TABLE SO_RD_Stat CASCADE CONSTRAINTS;
CREATE TABLE SO_RD_Stat  AS
	-- upper plan at a newer generation
	SELECT dbms,
	       newer_gen_num,  -- operator generation 
	       round(avg(rel_delta), 2) as avg_rd -- avg_rd < 0: suboptimal
	FROM SO_Calc_RD
	GROUP BY dbms, newer_gen_num
	ORDER BY dbms, newer_gen_num;
ALTER TABLE SO_RD_Stat ADD PRIMARY KEY (dbms, newer_gen_num);

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 

-- Define suboptimality by identification (from Sabah's subopt definitio)
-- SOExpl_SuboptDefn: SubOpt_Exploratory_SubOptimal_Definition
Drop TABLE SOExpl_SuboptDefn CASCADE CONSTRAINTS;
CREATE TABLE SOExpl_SuboptDefn AS
SELECT qc1.experimentid, qc1.experimentname, qc1.dbms, qc1.runid, qc1.queryNum,
  qc1.card as HighCard, qc1.med_calc_qt AS MedianHighCard,
  qc1.std_calc_qt AS SDHighCard, qc2.med_calc_qt AS MedianLowCard, qc2.std_calc_qt AS SDLowCard,
  qc2.card as LowCard, qc1.planid AS PlHighCard, qc2.planid PlLowCard,
  CASE WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))< 0 THEN 0 WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))>= 0
   AND (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))< 0 THEN 1 WHEN (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))>= 0
   AND (qc2.med_calc_qt-(1.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.5*qc1.std_calc_qt))< 0 THEN 2 ELSE 3 END AS Subopt_SD, 
100*(qc2.med_calc_qt-qc1.med_calc_qt)/qc1.med_calc_qt AS Subopt_rel
FROM SOExpl_S4_CTQatC qc1, SOExpl_S4_CTQatC qc2
WHERE qc1.experimentid=qc1.experimentid
AND qc1.runid=qc2.runid
AND qc1.querynum=qc2.querynum
and ((qc1.dbms='mysql' and qc1.card=qc2.card+300)
OR (qc1.dbms!='mysql' and qc1.card=qc2.card+10000))
and qc1.planid<>qc2.planid;
alter table SOExpl_SuboptDefn add primary key (runid, querynum, highcard, lowcard);

-- Locate suboptimal change points
-- SOExpl_SuboptCP: SubOpt_Exploratory_SubOptimal_Change_Point
Drop TABLE SOExpl_SuboptCP CASCADE CONSTRAINTS;
CREATE TABLE SOExpl_SuboptCP AS
	SELECT t0.*
	FROM SOExpl_SuboptDefn t0
	--WHERE Subopt_rel < 0
	-- find suboptimal change points
	WHERE t0.Subopt_SD > 0;	
alter table SOExpl_SuboptCP add primary key (runid, querynum, highcard, lowcard);

-- Find generation number associated with suboptimal change point
-- SO_SubOpt_Gen: SubOpt_Suboptimal_Generation
DROP TABLE SO_SubOpt_Gen CASCADE CONSTRAINTS;
CREATE TABLE SO_SubOpt_Gen  AS
	-- upper plan in newer generation
	select t0.dbms, 
	       t0.runid,
	       t0.querynum,
	       t0.upper_gen as gen_num,
	       t0.upper_card,
	       t0.lower_card
	from SO_Newer_Gen_at_Upper_Card t0,
	     SOExpl_SuboptCP t1
	where t0.runid = t1.runid
	 and t0.querynum = t1.querynum
	 and t0.upper_card = t1.highcard
	 and t0.lower_card = t1.lowcard
	UNION
	-- lower plan in newer generation
	select t0.dbms, 
	       t0.runid,
	       t0.querynum,
	       t0.lower_gen as gen_num,
	       t0.upper_card,
	       t0.lower_card
	from 
		SO_Newer_Gen_at_Lower_Card t0,
		SOExpl_SuboptCP t1
	where t0.runid = t1.runid
	 and t0.querynum = t1.querynum
	 and t0.upper_card = t1.highcard
	 and t0.lower_card = t1.lowcard
	;
ALTER TABLE SO_SubOpt_Gen ADD PRIMARY KEY (runid, querynum, upper_card, lower_card);

-- Count # of suboptimal change points by generation 
-- SO_RD_SubOpt: SubOpt_Generation_Statistics
DROP TABLE SO_SubOpt_Gen_Stat CASCADE CONSTRAINTS;
CREATE TABLE SO_SubOpt_Gen_Stat  AS
	select t0.dbms, 
	       t0.gen_num,
	       count(*) as subOptCnt
	from SO_SubOpt_Gen t0
	group by t0.dbms, t0.gen_num
	order by t0.dbms, t0.gen_num;
ALTER TABLE SO_SubOpt_Gen_Stat ADD PRIMARY KEY (dbms, gen_num);

--SQL> select * from SO_SubOpt_Gen_Stat;

DBMS
--------------------------------------------------------------------------------
   GEN_NUM  SUBOPTCNT
---------- ----------
db2
	 8	   59

db2
	 9	    7

db2
	10	    2

oracle
	 5	    8

oracle
	 6	    4

pgsql
	 5	    5

pgsql
	 8	    1

