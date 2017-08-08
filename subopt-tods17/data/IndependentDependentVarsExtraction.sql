-- Create table where we calculate suboptimality as no of Std Deviations away
-- for adjacent pairs
DROP TABLE CF_Analysis_SuboptDefn_Ver1; 

CREATE TABLE CF_Analysis_SuboptDefn_Ver1 AS
SELECT qc1.experimentid, qc1.experimentname, qc1.dbms, qc1.runid, qc1.queryNum, 
  qc1.card as HighCard, qc1.med_calc_qt AS MedianHighCard, 
  qc1.std_calc_qt AS SDHighCard, qc2.med_calc_qt AS MedianLowCard, qc2.std_calc_qt AS SDLowCard, 
  qc2.card as LowCard, qc1.planid AS PlHighCard, qc2.planid PlLowCard, 
  CASE WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))< 0 THEN 0 WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))>= 0 
   AND (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))< 0 THEN 1 WHEN (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))>= 0 AND 
   (qc2.med_calc_qt-(1.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.5*qc1.std_calc_qt))< 0 THEN 2 ELSE 3 END AS Subopt 
FROM Analysis_S4_CTQatC qc1, Analysis_S4_CTQatC qc2
WHERE qc1.experimentid=qc1.experimentid
AND qc1.runid=qc2.runid
AND qc1.querynum=qc2.querynum
and ((qc1.dbms='mysql' and qc1.card=qc2.card+300)
OR (qc1.dbms!='mysql' and qc1.card=qc2.card+10000))
and qc1.planid<>qc2.planid;

-- New table 11/24/13
CREATE TABLE CF_Analysis_SuboptDefn_V1113 AS
SELECT qc1.experimentid, qc1.experimentname, qc1.dbms, qc1.runid, qc1.queryNum,
  qc1.card as HighCard, qc1.med_calc_qt AS MedianHighCard,
  qc1.std_calc_qt AS SDHighCard, qc2.med_calc_qt AS MedianLowCard, qc2.std_calc_qt AS SDLowCard,
  qc2.card as LowCard, qc1.planid AS PlHighCard, qc2.planid PlLowCard,
  CASE WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))< 0 THEN 0 WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))>= 0
   AND (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))< 0 THEN 1 WHEN (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))>= 0
   AND (qc2.med_calc_qt-(1.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.5*qc1.std_calc_qt))< 0 THEN 2 ELSE 3 END AS Subopt_SD
  , 100*(qc2.med_calc_qt-qc1.med_calc_qt)/qc1.med_calc_qt AS Subopt_rel
FROM CF_Analysis_S4_CTQatC_Ver1 qc1, CF_Analysis_S4_CTQatC_Ver1 qc2
WHERE qc1.experimentid=qc1.experimentid
AND qc1.runid=qc2.runid
AND qc1.querynum=qc2.querynum
and ((qc1.dbms='mysql' and qc1.card=qc2.card+300)
OR (qc1.dbms!='mysql' and qc1.card=qc2.card+10000))
and qc1.planid<>qc2.planid;

CREATE TABLE Ex_Analysis_SuboptDefn_V1113 AS
SELECT qc1.experimentid, qc1.experimentname, qc1.dbms, qc1.runid, qc1.queryNum,
  qc1.card as HighCard, qc1.med_calc_qt AS MedianHighCard,
  qc1.std_calc_qt AS SDHighCard, qc2.med_calc_qt AS MedianLowCard, qc2.std_calc_qt AS SDLowCard,
  qc2.card as LowCard, qc1.planid AS PlHighCard, qc2.planid PlLowCard,
  CASE WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))< 0 THEN 0 WHEN (qc2.med_calc_qt-(0.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(0.5*qc1.std_calc_qt))>= 0
   AND (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))< 0 THEN 1 WHEN (qc2.med_calc_qt-(1.0*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.0*qc1.std_calc_qt))>= 0
   AND (qc2.med_calc_qt-(1.5*qc2.std_calc_qt))-(qc1.med_calc_qt+(1.5*qc1.std_calc_qt))< 0 THEN 2 ELSE 3 END AS Subopt_SD
  , 100*(qc2.med_calc_qt-qc1.med_calc_qt)/qc1.med_calc_qt AS Subopt_rel
FROM EP_Analysis_S4_CTQatC_Ver1 qc1, EP_Analysis_S4_CTQatC_Ver1 qc2
WHERE qc1.experimentid=qc1.experimentid
AND qc1.runid=qc2.runid
AND qc1.querynum=qc2.querynum
and ((qc1.dbms='mysql' and qc1.card=qc2.card+300)
OR (qc1.dbms!='mysql' and qc1.card=qc2.card+10000))
and qc1.planid<>qc2.planid;

 

-- Add rows when there is only one plan for the query with 0 subopt
INSERT INTO CF_Analysis_SuboptDefn_ver1 
(SELECT qc1.experimentid, qc1.experimentname, qc1.dbms, qc1.runid, qc1.queryNum, 
  qc1.card as HighCard, qc1.med_calc_qt AS MedianHighCard, 
  qc1.std_calc_qt AS SDHighCard, NULL AS MedianLowCard, NULL AS SDLowCard, 
  NULL as LowCard, qc1.planid AS PlHighCard, NULL AS PlLowCard, 
  0 AS Subopt 
FROM CF_Analysis_S4_CTQatC_Ver1 qc1
WHERE 1=
(SELECT COUNT(distinct planid)
FROM CF_Analysis_S4_CTQatC_Ver1 qc2
WHERE qc1.experimentid=qc1.experimentid
AND qc1.runid=qc2.runid
AND qc1.dbms=qc2. dbms
AND qc1.querynum=qc2.querynum
GROUP BY experimentid, dbms, runid, queryNum
HAVING count(distinct planid)=1));

-- Test queries:
-- Check if any rows lost 
-- A few queries are lost because there are two plans, but because of "dropping"
-- the two plans adjacent. So, they are not added in either step above
select dbms, count(*) from
(select experimentid, experimentname, dbms, runid, querynum 
from CF_Analysis_s4_ctqatc_ver1 
group by experimentid, experimentname, dbms, runid, querynum 
MINUS 
select experimentid, experimentname, dbms, runid, querynum 
FROM CF_Analysis_SuboptDefn_Ver1
)
GROUP BY dbms;

-- Query to retrieve Independent and dependent variables
-- subopt is defined as max subopt / query
SELECT distinct tempCeps.DBMS, temp.experimentname, temp.queryId, temp.querynumber, tempOpCt.opCt, tempFrom.NUMFROM, tempCeps.CEPS, 
tempSJn.NUMSELFJOIN, tempDbOp.CtDbOp, so2.SUBOPT, so2.runid , NVL(NumDiscontOperators,0) AS NumDiscontOperators, tempAgg.NumAgg, tempPK.PK_NoGroupGy, tempPK.PK_TwoSided, tempPK.PK_InGroupGy, 
tempPK.PK_InOnesideJoin, tempPK.PK_NoJoin, tempPK.PK_NotInGroupBy, tempPK.PK_NotInJoin
FROM ( 
    select experimentid, EXPERIMENTNAME, DBMS, RUNID, QUERYNUM, SUM(subopt) AS subopt from CF_Analysis_SuboptDefn_Ver1 
    GROUP BY experimentid , EXPERIMENTNAME, DBMS, RUNID, QUERYNUM 
) so2, 
    (SELECT ex.experimentname, er.starttime, qr.queryId, qr.querynumber, qr.querySQL FROM AZDBLAB_QUERY qr, AZDBLAB_EXPERIMENTRUN er, 
    AZDBLAB_EXPERIMENT ex WHERE ex.EXPERIMENTID = er.EXPERIMENTID AND er.CurrentStage = 'Completed' AND er.Percentage = 100 AND ex.experimentid = er.experimentid AND er.runid = qr.runid ) temp 
    INNER JOIN 
    (SELECT qr.queryId, COUNT(DISTINCT po.OperatorName) AS opCt FROM AZDBLAB_EXPERIMENT ex, 
    AZDBLAB_EXPERIMENTRUN er, AZDBLAB_QUERY qr, 
    azdblab_queryexecution qn, AZDBLAB_QUERYEXECUTIONHASPLAN hp, AZDBLAB_PLANOPERATOR po WHERE ex.EXPERIMENTID = er.EXPERIMENTID AND 
    er.CurrentStage = 'Completed' AND er.Percentage = 100 AND ex.experimentid = er.experimentid AND er.runid = qr.runid AND qr.queryid = qn.queryID 
    AND qn.QueryExecutionID = hp.QueryExecutionID AND hp.PlanID = po.PlanID GROUP BY qr.queryId) tempOpCt ON tempOpCt.queryId=temp.queryId 
    INNER JOIN 
    (SELECT qr.QueryID,ps.Value AS NUMFROM, qr.runId FROM AZDBLAB_QUERYHASPARAMETER ps, AZDBLAB_QUERY qr, AZDBLAB_EXPERIMENTRUN er, 
    AZDBLAB_EXPERIMENT ex WHERE ex.EXPERIMENTID = er.EXPERIMENTID AND er.CurrentStage = 'Completed' AND er.Percentage = 100 AND ex.experimentid = er.experimentid AND er.runid = qr.runid 
    AND qr.queryid = ps.QueryID AND ps.PARAMNAME = 'NUMCNFRM' ORDER BY ex.ExperimentName, qr.QueryID, NUMFROM) tempFrom 
        ON temp.queryId=tempFrom.queryId 
INNER JOIN 
    (SELECT ps.QueryID,ps.Value AS NumAgg FROM AZDBLAB_QUERYHASPARAMETER ps
 WHERE ps.PARAMNAME = 'NUMAGGREGATEFUNCTIONS') tempAgg 
        ON temp.queryId=tempAgg.queryId 
INNER JOIN 
    (SELECT qr.QueryID, ps.Value AS PK_NoGroupGy , ps1.Value AS PK_TwoSided, ps2.Value AS PK_InGroupGy, ps3.Value AS PK_InOnesideJoin, ps4.Value AS PK_NoJoin, ps5.Value AS PK_NotInGroupBy, 
            ps6.Value AS PK_NotInJoin
    FROM AZDBLAB_QUERY qr LEFT OUTER JOIN azdblab_pk_param_new ps ON (ps.PARAMNAME = 'NoGroupBy' AND qr.queryId = ps.queryId) LEFT OUTER JOIN azdblab_pk_param_new ps1 ON (ps1.PARAMNAME = 
         'PK_InBothSideJoin' AND qr.queryId = ps1.queryId) LEFT OUTER JOIN azdblab_pk_param_new ps2  ON (ps2.PARAMNAME = 'PK_InGroupBy' AND qr.queryId = ps2.queryId) LEFT OUTER JOIN 
         azdblab_pk_param_new ps3 ON (ps3.PARAMNAME = 'PK_InOnesideJoin' AND qr.queryId = ps3.queryId) LEFT OUTER JOIN azdblab_pk_param_new ps4 ON (ps4.PARAMNAME = 'PK_NoJoin' AND qr.queryId = 
         ps4.queryId) LEFT OUTER JOIN azdblab_pk_param_new ps5 ON (ps5.PARAMNAME = 'PK_NotInGroupBy' AND qr.queryId = ps5.queryId) LEFT OUTER JOIN azdblab_pk_param_new  ps6  ON (ps6.PARAMNAME = 
         'PK_NotInJoin' AND qr.queryId = ps6.queryId)
    ) tempPK 
        ON temp.queryId=tempPK.queryId 
LEFT OUTER JOIN 
    (SELECT queryid, SUM(NumDiscontOperatorsPerPlan) AS NumDiscontOperators
FROM
(SELECT queryid, qep.PLANID, COUNT(DISTINCT po.operatorname) AS
NumDiscontOperatorsPerPlan
FROM azdblab_queryexecution qe, AZDBLAB_QUERYEXECUTIONHASPLAN qep,
AZDBLAB_PLANOPERATOR po
WHERE qe.queryexecutionid = qep.QUERYEXECUTIONID
AND qep.PLANID = po.planid
AND po.operatorname IN ('MSJOIN', 'SORT', 'HSJOIN', 'TBSCAN', 'GRPBY',
'FILTER', 'RETURN', 'VIEW:VW_GBF_9', 'HASH', 'SORT', 'VIEW:VW_GBC_5',
'VIEW:VW_GBC_13', 'SELECT STATEMENT', 'VIEW:VW_GBF_13',
'VIEW:VW_GBC_9', 'MERGE JOIN', 'HASH JOIN', 'Hash', 'Sort', 'Hash
Join', 'ALL + Using temporary + Using filesort', 'ALL + Using where + Using join buffer')
GROUP BY queryid, qep.PLANID)
GROUP BY queryid
) discOp 
        ON temp.queryId= discOp.queryId 
    INNER JOIN (SELECT er.DBMS AS DBMS, qr.QueryID AS QID, count(DISTINCT pl.PlanID) AS CEPS FROM AZDBLAB_PLAN pl, 
    AZDBLAB_QUERYEXECUTIONHASPLAN hp, AZDBLAB_QUERYEXECUTION qn, AZDBLAB_QUERY qr, AZDBLAB_EXPERIMENTRUN er, 
    AZDBLAB_EXPERIMENT ex WHERE ex.EXPERIMENTID = er.EXPERIMENTID AND er.CurrentStage = 'Completed' 
    AND er.Percentage = 100 AND ex.experimentid = er.experimentid AND er.runid = qr.runid AND qr.queryid = qn.queryid 
    AND qn.QueryExecutionID = hp.QueryExecutionID AND hp.PlanID = pl.PlanID 
    GROUP BY (ex.ExperimentName, er.DBMS, qr.QueryID)) tempCeps ON temp.queryId=tempCeps.QID 
    INNER JOIN 
    (SELECT qr.QueryID AS QID,ps.Value AS NUMSELFJOIN FROM AZDBLAB_QUERYHASPARAMETER ps, AZDBLAB_QUERY qr, AZDBLAB_EXPERIMENTRUN er, 
    AZDBLAB_EXPERIMENT ex WHERE ex.EXPERIMENTID = er.EXPERIMENTID AND er.CurrentStage = 'Completed' 
    AND er.Percentage = 100 AND ex.experimentid = er.experimentid AND er.runid = qr.runid AND qr.queryid = ps.QueryID 
    AND ps.PARAMNAME = 'NUMSELFJOIN' ORDER BY ex.ExperimentName, qr.QueryID, NUMSELFJOIN) tempSJn ON temp.queryId=tempSJn.QID 
    INNER JOIN 
    (SELECT er.DBMS, COUNT(DISTINCT po.OperatorName) AS CtDbOp FROM AZDBLAB_EXPERIMENT ex, 
    AZDBLAB_EXPERIMENTRUN er, AZDBLAB_QUERY qr, AZDBLAB_QUERYExecution qn, AZDBLAB_QUERYEXECUTIONHASPLAN hp, 
    AZDBLAB_PLANOPERATOR po WHERE er.CurrentStage = 'Completed' AND er.Percentage = 100 
    AND ex.experimentid = er.experimentid AND er.runid = qr.runid AND qr.queryid = qn.queryID 
    AND qn.QueryExecutionID = hp.QueryExecutionID AND hp.PlanID = po.PlanID GROUP BY er.DBMS) tempDbOp 
        ON tempDbOp.DBMS=tempCeps.DBMS 
WHERE so2.EXPERIMENTNAME = temp.experimentname 
AND so2.DBMS = tempCeps.DBMS AND so2.RUNID = tempFrom.runId AND so2.QUERYNUM = temp.querynumber 
ORDER BY temp.ExperimentName, tempCeps.dbms, temp.QueryNumber;

--------------
test queries run on 11/26/13
select lowcard, count(queryNum), min(Subopt_rel), max(Subopt_rel), min(MedianHighCard), max(MedianHighCard) from CF_Analysis_SuboptDefn_V1113 group by lowcard 
order by lowcard


 select experimentid, dbms, runid, queryNum, max(Subopt_rel) as max_sor from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>0

 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 

 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=10


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=20


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=30


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=40


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=50

 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=60


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=70


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum having max(Subopt_rel)>=80

 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=90


 select experimentid, dbms, runid, queryNum, max(Subopt_rel), min(Subopt_rel) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum 
having max(Subopt_rel)>=100


 select experimentid, dbms, runid, queryNum, max(Subopt_SD), min(Subopt_SD) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum having max(Subopt_SD)>=0

 select experimentid, dbms, runid, queryNum, max(Subopt_SD), min(Subopt_SD) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum having max(Subopt_SD)>=1

 select experimentid, dbms, runid, queryNum, max(Subopt_SD), min(Subopt_SD) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum having max(Subopt_SD)>=2

 select experimentid, dbms, runid, queryNum, max(Subopt_SD), min(Subopt_SD) from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum having max(Subopt_SD)>=3


select experimentid, dbms, runid, queryNum, min(std_calc_qt), max(std_calc_qt) from CF_Analysis_S4_CTQatC_Ver1 group by experimentid, dbms, runid, queryNum
having min(std_calc_qt)=0 OR max(std_calc_qt)=0;


select dbms, count(distinct experimentid||runid||queryNum)
from CF_Analysis_SuboptDefn_V1113 group by dbms;

select dbms, count(distinct experimentid||runid||queryNum)
from CF_Analysis_SuboptDefn_V1113 
where Subopt_rel>=10
group by dbms;

select dbms, count(distinct experimentid||runid||queryNum)
from CF_Analysis_SuboptDefn_V1113 
where Subopt_rel>=20
group by dbms;

CREATE TABLE CF_QuerytimeS1_so11_13 AS
 select experimentid, dbms, runid, queryNum, max(Subopt_rel) as max_sor from CF_Analysis_SuboptDefn_V1113 group by experimentid, dbms, runid, queryNum

SELECT c1.experimentid, c1.dbms, c1.runid, c1.queryNum, MAX(c2.max_sor), MAX(c1.MEDIANHIGHCARD)
from CF_Analysis_SuboptDefn_V1113 c1, CF_QuerytimeS1_so11_13 c2
WHERE c1.experimentid = c2.experimentid
AND c1.dbms = c2.dbms
AND c1.runid = c2.runid
AND c1.queryNum = c2.queryNum
and c1.Subopt_rel = c2.max_sor
GROUP BY c1.experimentid, c1.dbms, c1.runid, c1.queryNum


SELECT c1.experimentid, c1.dbms, c1.runid, c1.queryNum, MAX(c2.max_sor), MAX(c1.MEDIANHIGHCARD)
from CF_Analysis_SuboptDefn_V1113 c1, CF_QuerytimeS1_so11_13 c2
WHERE c1.experimentid = c2.experimentid
AND c1.dbms = c2.dbms
AND c1.runid = c2.runid
AND c1.queryNum = c2.queryNum
and c1.Subopt_rel = c2.max_sor
GROUP BY c1.experimentid, c1.dbms, c1.runid, c1.queryNum
having MAX(c1.MEDIANHIGHCARD)>40;

SELECT c1.experimentid, c1.dbms, c1.runid, c1.queryNum, MAX(c2.max_sor), MAX(c1.MEDIANHIGHCARD)
from CF_Analysis_SuboptDefn_V1113 c1, CF_QuerytimeS1_so11_13 c2
WHERE c1.experimentid = c2.experimentid
AND c1.dbms = c2.dbms
AND c1.runid = c2.runid
AND c1.queryNum = c2.queryNum
and c1.Subopt_rel = c2.max_sor
GROUP BY c1.experimentid, c1.dbms, c1.runid, c1.queryNum
having MAX(c1.MEDIANHIGHCARD)>10240;


;

-- Discontinuous operators /plan
SELECT queryid, qep.PLANID, COUNT(DISTINCT po.operatorname) AS
NumDiscontOperatorsPerPlan, MIN(Cardinality), MAX(Cardinality), count(distinct Cardinality)
FROM azdblab_queryexecution qe, AZDBLAB_QUERYEXECUTIONHASPLAN qep,
AZDBLAB_PLANOPERATOR po
WHERE qe.queryexecutionid = qep.QUERYEXECUTIONID
AND qep.PLANID = po.planid
AND po.operatorname IN ('MSJOIN', 'SORT', 'HSJOIN', 'TBSCAN', 'GRPBY',
'FILTER', 'RETURN', 'VIEW:VW_GBF_9', 'HASH', 'SORT', 'VIEW:VW_GBC_5',
'VIEW:VW_GBC_13', 'SELECT STATEMENT', 'VIEW:VW_GBF_13',
'VIEW:VW_GBC_9', 'MERGE JOIN', 'HASH JOIN', 'Hash', 'Sort', 'Hash
Join', 'ALL + Using temporary + Using filesort', 'ALL + Using where + Using join buffer')
GROUP BY queryid, qep.PLANID

--Old
CREATE TABLE NumOperatorsPerCardinality AS
SELECT queryid, Cardinality, qep.PLANID, COUNT(DISTINCT po.operatorname) AS
NumOperatorsPerPlan
FROM azdblab_queryexecution qe, AZDBLAB_QUERYEXECUTIONHASPLAN qep,
AZDBLAB_PLANOPERATOR po
WHERE qe.queryexecutionid = qep.QUERYEXECUTIONID
AND qep.PLANID = po.planid
GROUP BY queryid, qep.PLANID, cardinality;

-- Revised examining impact of adding one operator.
CREATE TABLE NumOperatorsPerCardinality AS
SELECT er.experimentid, er.dbms, er.runid, qu.querynumber, qe.queryid, Cardinality, qep.PLANID, COUNT(DISTINCT po.operatorname) AS
NumOperatorsPerPlan, qc1.med_calc_qt
FROM azdblab_queryexecution qe INNER JOIN AZDBLAB_QUERYEXECUTIONHASPLAN qep ON (qe.queryexecutionid = qep.QUERYEXECUTIONID) INNER JOIN AZDBLAB_PLANOPERATOR po ON (qep.PLANID = po.planid)
INNER JOIN AZDBLAB_QUERY qu ON (qu.queryid=qe.queryid) INNER JOIN AZDBLAB_EXPERIMENTRUN er 
ON (qu.runid=er.runid) INNER JOIN CF_Analysis_S4_CTQatC_Ver1 qc1 ON (qc1.experimentid =er.experimentid AND qc1.DBMS=er.dbms AND qc1.runid=er.runid AND qc1.querynum=qu.querynumber 
AND qc1.planid=qep.planid AND qc1.card=qe.cardinality AND qc1.planid=qep.planid)
GROUP BY er.experimentid, er.dbms, er.runid, qu.querynumber, qe.queryid, qep.PLANID, cardinality, qc1.med_calc_qt;


CREATE TABLE DiffInAdjacentOperators AS
SELECT noc1.dbms, noc1.queryid, noc1.cardinality AS HighCard, noc2.cardinality AS LowCard, noc1.planid AS HighPlanId, noc2.planid AS LowPlanId, noc1.NumOperatorsPerPlan AS HighPlanNumOp,
noc2.NumOperatorsPerPlan AS LowPlanNumOp, (noc1.NumOperatorsPerPlan- noc2.NumOperatorsPerPlan) AS DiffInOperatorsCt, noc1.med_calc_qt AS HighCTime, noc2.med_calc_qt as LowCTime
FROM NumOperatorsPerCardinality noc1, NumOperatorsPerCardinality noc2
WHERE noc1.queryid=noc2.queryid
and noc1.dbms=noc2.dbms
AND noc1.Cardinality = noc2.Cardinality+10000
AND noc1.planid<> noc2.planid;

CREATE TABLE DiffInAdjacentOperatorPlans AS
SELECT dao1.dbms, dao1.queryid, dao1.HighCard as Cardinality, po.operatorname, 'HighCard' AS CardUsed, DiffInOperatorsCt
FROM DiffInAdjacentOperators dao1, AZDBLAB_PLANOPERATOR po
WHERE po.planid=dao1.Highplanid
MINUS
SELECT dao1.dbms, dao1.queryid, dao1.HighCard, po.operatorname, 'HighCard' AS CardUsed, DiffInOperatorsCt
FROM DiffInAdjacentOperators dao1, AZDBLAB_PLANOPERATOR po
WHERE po.planid=dao1.Lowplanid;

INSERT INTO DiffInAdjacentOperatorPlans 
SELECT dao1.dbms, dao1.queryid, dao1.HighCard, po.operatorname, 'LowCard' AS CardUsed, DiffInOperatorsCt
FROM DiffInAdjacentOperators dao1, AZDBLAB_PLANOPERATOR po
WHERE po.planid=dao1.Lowplanid
MINUS
SELECT dao1.dbms, dao1.queryid, dao1.HighCard, po.operatorname, 'LowCard' AS CardUsed, DiffInOperatorsCt
FROM DiffInAdjacentOperators dao1, AZDBLAB_PLANOPERATOR po
WHERE po.planid=dao1.Highplanid;


 select queryid, cardinality, cardused, count(*) from DiffInAdjacentOperatorPlans where DiffInOperatorsCt<=1 and DiffInOperatorsCt>=-1 group by  queryid, cardinality, cardused having count(*)=1;

SELECT dao1.queryid, dao1.highcard, po1.* FROM DiffInAdjacentOperators dao1, AZDBLAB_PLANOPERATOR po1  WHERE (dao1.highplanid=po1.planid OR dao1.lowplanid=po1.planid) and dao1.queryid=3855 and dao1.highcard=20000;

CREATE TABLE Add1OperatorImpact AS
SELECT dao1.dbms, dao1.queryid, dao1.highcard, dao1.DIFFINOPERATORSCT, CASE WHEN dap1.queryid IS NOT NULL THEN (lowctime-highctime)/lowctime ELSE NULL END AS RelativeTimeHighCAddOperator, CASE WHEN dap2.queryid IS NOT NULL THEN (highctime-lowctime)/highctime ELSE NULL END AS RelativeTimeLowCAddOperator, dap1.operatorName AS HighCAddOperator , dap2.operatorName AS LowCAddOperator
FROM DiffInAdjacentOperators dao1 LEFT OUTER JOIN 
(SELECT d1.* FROM DiffInAdjacentOperatorPlans d1 INNER JOIN (select queryid, cardinality, cardused from DiffInAdjacentOperatorPlans where DiffInOperatorsCt<=1 and DiffInOperatorsCt>=-1 group by  queryid, cardinality, cardused having count(*)=1) d2 ON (d1.queryid=d2.queryid AND d1.cardinality=d2.cardinality AND d1.cardused=d2.cardused)) dap1 ON (dap1.queryid=dao1.queryid AND dap1.cardused='HighCard' AND dap1.cardinality=dao1.highCard ) LEFT OUTER JOIN (SELECT d1.* FROM DiffInAdjacentOperatorPlans d1 INNER JOIN (select queryid, cardinality, cardused from DiffInAdjacentOperatorPlans where DiffInOperatorsCt<=1 and DiffInOperatorsCt>=-1 group by  queryid, cardinality, cardused having count(*)=1) d2 ON (d1.queryid=d2.queryid AND d1.cardinality=d2.cardinality AND d1.cardused=d2.cardused)) dap2 ON (dap2.queryid=dao1.queryid AND dap2.cardused='LowCard' AND dap2.cardinality=dao1.highCard )
WHERE dap1.queryid IS NOT NULL OR  dap2.queryid IS NOT NULL ;

-- Number of operators adjacent plans differed by
select DIFFINOPERATORSCT, count(*), count(distinct queryid) from 
DiffInAdjacentOperators  group by DIFFINOPERATORSCT order by DIFFINOPERATORSCT;

-- Number of change points
CREATE TABLE CF_NoChangePoints AS 
select experimentid, dbms, runid, querynum, count(*) AS NoChangePts from CF_Analysis_SuboptDefn_V1113
GROUP BY experimentid, dbms, runid, querynum;

-- No of subopt change points
CREATE TABLE CF_SuboptRelNoChangePoints AS 
select experimentid, dbms, runid, querynum, count(*) AS NoChangePts from CF_Analysis_SuboptDefn_V1113
where SUBOPT_REL>0
GROUP BY experimentid, dbms, runid, querynum;

select NoChangePts, count(*) from CF_NoChangePoints GROUP BY NoChangePts order by NoChangePts;

select NoChangePts, count(*) from CF_SuboptRelNoChangePoints GROUP BY NoChangePts order by NoChangePts;


SELECT a3.EXPERIMENTID, a3.DBMS, a3.runid, a3.querynum, SUM(NumDiscontOperatorsPerPlan), MAX(a2.Subopt_rel) 
FROM CF_Analysis_SuboptDefn_V1113 a2, 
(SELECT a1.EXPERIMENTID, a1.DBMS, a1.runid, a1.querynum, a1.card, a1.planid, COUNT(DISTINCT po.operatorname) AS
NumDiscontOperatorsPerPlan,  MIN(Card), MAX(Card), count(distinct Card)
FROM CF_Analysis_S4_CTQatC_Ver1 a1,
AZDBLAB_PLANOPERATOR po
WHERE a1.PLANID = po.planid
AND po.operatorname IN ('MSJOIN', 'SORT', 'HSJOIN', 'TBSCAN', 'GRPBY',
'FILTER', 'RETURN', 'VIEW:VW_GBF_9', 'HASH', 'SORT', 'VIEW:VW_GBC_5',
'VIEW:VW_GBC_13', 'SELECT STATEMENT', 'VIEW:VW_GBF_13',
'VIEW:VW_GBC_9', 'MERGE JOIN', 'HASH JOIN', 'Hash', 'Sort', 'Hash
Join', 'ALL + Using temporary + Using filesort', 'ALL + Using where + Using join buffer')
GROUP BY a1.EXPERIMENTID, a1.DBMS, a1.runid, a1.querynum, a1.card, a1.planid) a3
WHERE a3.EXPERIMENTID=a2.EXPERIMENTID
AND a3.DBMS=a2.DBMS
AND a3.runid=a2.runid
AND a3.querynum=a2.querynum
GROUP BY a3.EXPERIMENTID, a3.DBMS, a3.runid, a3.querynum
ORDER BY MAX(a2.Subopt_rel) ;         

SELECT queryid, COUNT(HighCard)
FROM DiffInAdjacentOperators 
WHERE HighPlanNumOp =1
OR LowPlanNumOp =1
GROUP BY queryid
-- No results

SELECT queryid, COUNT(HighCard)
FROM DiffInAdjacentOperators 
WHERE HighPlanNumOp =2
OR LowPlanNumOp =2
GROUP BY queryid
ORDER BY COUNT(HighCard);
-- 214 queries, max count =6 

SELECT * FROM DiffInAdjacentOperators 
WHERE queryid=1235;
-- has 6 change points
