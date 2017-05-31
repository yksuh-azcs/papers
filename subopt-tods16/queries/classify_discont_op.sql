-- Writer      : Young-Kyoon Suh
-- Date        : 05/30/17
-- Description : Define analysis queries for new discontinuous operators 
-- labshelf 7.10

--- find ranges with a unique plan
DROP TABLE DiscontOpNew_Step4;
CREATE TABLE DiscontOpNew_Step4 AS 
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

--- construct two-region sequence
DROP TABLE DiscontOpNew_1RegSeq;
CREATE TABLE DiscontOpNew_1RegSeq AS 
	SELECT dbms, runid, querynum, low_card, high_card, high_card-low_card as rangeSize
	FROM DiscontOpNew_Step4
	order by runid, querynum, low_card asc;
ALTER TABLE DiscontOpNew_1RegSeq ADD PRIMARY KEY (runid,querynum,low_card,high_card);

--- compute r2 for one-region sequence
DROP TABLE DiscontOpNew_1RegSeqR2;
CREATE TABLE DiscontOpNew_1RegSeqR2 AS 
	select t0.runid, t0.querynum,t1.low_card,t1.high_card,t0.opID,coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_1RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.low_card <= t0.CARD 
	and t1.high_card >= t0.CARD 
	group by t0.runid, t0.querynum, t1.low_card, t1.high_card, t0.opID
	order by t0.runid, t0.querynum, t1.low_card asc, t0.opID asc;
ALTER TABLE DiscontOpNew_1RegSeqR2 ADD PRIMARY KEY (runid,querynum,low_card,high_card,OPID);

--- construct two-region sequence
DROP TABLE DiscontOpNew_2RegSeq;
CREATE TABLE DiscontOpNew_2RegSeq AS 
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
	--and t0.runid = 252 and t0.querynum = 6
	--and t0.low_card = 670000 and t0.high_card = 1120000
	and t0.low_card+40000 <= t1.card 
	and t1.card+40000 < t0.high_card
	order by runid, querynum, lowerStart, lowerEnd, upperStart, upperEnd;
ALTER TABLE DiscontOpNew_2RegSeq ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,upperStart,upperEnd);
-- select lowerStart,lowerEnd, upperStart,upperEnd from DiscontOpNew_Step4_2RS;

--- r2 for left subrange
DROP TABLE DiscontOpNew_2RegSeqR2_1;
CREATE TABLE DiscontOpNew_2RegSeqR2_1 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_2RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.lowerStart <= t0.CARD 
	and t1.lowerEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_2RegSeqR2_1  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,upperStart,upperEnd,OPID);

--- r2 for right subrange
DROP TABLE DiscontOpNew_2RegSeqR2_2;
CREATE TABLE DiscontOpNew_2RegSeqR2_2 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_2RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.upperStart <= t0.CARD 
	and t1.upperEnd >= t0.CARD
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_2RegSeqR2_2  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,upperStart,upperEnd,OPID);

--- compute r2 for two-region sequence 
DROP TABLE DiscontOpNew_2RegSeqR2;	
CREATE TABLE DiscontOpNew_2RegSeqR2 AS 
	SELECT  lowerRange.runid,
		lowerRange.querynum,
		lowerRange.lowerStart,
		lowerRange.lowerEnd,
		lowerRange.upperStart,
		lowerRange.upperEnd,
		lowerRange.opID,
		avg((lowerRange.r2+upperRange.r2)/2) as r2
	FROM DiscontOpNew_2RegSeqR2_2 lowerRange, DiscontOpNew_2RegSeqR2_2 upperRange 
	WHERE lowerRange.runid = upperRange.runid 
	and lowerRange.querynum = upperRange.querynum 
	and lowerRange.lowerStart = upperRange.lowerStart 
	and lowerRange.lowerEnd = upperRange.lowerEnd 
	and lowerRange.upperStart = upperRange.upperStart 
	and lowerRange.upperEnd = upperRange.upperEnd 
	and lowerRange.opID = upperRange.opID 
	group by lowerRange.runid, lowerRange.querynum, lowerRange.lowerStart, lowerRange.lowerEnd, lowerRange.upperStart, lowerRange.upperEnd, lowerRange.opID
	order by runid, querynum, lowerStart asc, opID asc;
ALTER TABLE DiscontOpNew_2RegSeqR2 ADD PRIMARY KEY (runid,querynum,lowerStart, lowerEnd, upperStart, upperEnd, OPID);

--- build three-region sequence
DROP TABLE DiscontOpNew_3RegSeq;
CREATE TABLE DiscontOpNew_3RegSeq AS 
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
	--and t0.runid = 252 and t0.querynum = 6
	--and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t0.high_card 
	and t1.card+10000 <= t2.card and t2.card <= t1.card+40000 
	and t2.card+40000 <= t0.high_card 
	and t0.high_card-t2.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd;
ALTER TABLE DiscontOpNew_3RegSeq ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,upperStart,upperEnd);

--- r2 for the leftmost subrange
DROP TABLE DiscontOpNew_3RegSeqR2_1;
CREATE TABLE DiscontOpNew_3RegSeqR2_1 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1,t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_3RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.lowerStart <= t0.CARD 
	and t1.lowerEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_3RegSeqR2_1  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,upperStart,upperEnd,OPID);

--- r2 for the intermediate subrange
DROP TABLE DiscontOpNew_3RegSeqR2_2;
CREATE TABLE DiscontOpNew_3RegSeqR2_2 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_3RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.intermStart1 <= t0.CARD 
	and t1.intermEnd1 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_3RegSeqR2_2  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1, upperStart,upperEnd,OPID);

--- r2 for the rightmost subrange
DROP TABLE DiscontOpNew_3RegSeqR2_3;
CREATE TABLE DiscontOpNew_3RegSeqR2_3 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_3RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t1.upperStart <= t0.CARD 
	and t1.upperEnd >= t0.CARD
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_3RegSeqR2_3  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,upperStart,upperEnd,OPID);

--- compute r2 for three-region sequence
DROP TABLE DiscontOpNew_3RegSeqR2;	
CREATE TABLE DiscontOpNew_3RegSeqR2 AS 
	SELECT  lowerRange.runid,
		lowerRange.querynum,
		lowerRange.lowerStart,
		lowerRange.lowerEnd,
		intermRange1.intermStart1,
		intermRange1.intermEnd1,
		lowerRange.upperStart,
		lowerRange.upperEnd,
		lowerRange.opID,
		avg((lowerRange.r2+intermRange1.r2+upperRange.r2)/3) as r2
	FROM DiscontOpNew_3RegSeqR2_1 lowerRange, DiscontOpNew_3RegSeqR2_2 intermRange1, DiscontOpNew_3RegSeqR2_3 upperRange 
	WHERE lowerRange.runid = upperRange.runid 
	and lowerRange.querynum = upperRange.querynum 
	and lowerRange.lowerStart = upperRange.lowerStart 
	and lowerRange.lowerEnd = upperRange.lowerEnd 
	and lowerRange.upperStart = upperRange.upperStart 
	and lowerRange.upperEnd = upperRange.upperEnd 
	and lowerRange.opID = upperRange.opID 
	and intermRange1.runid = upperRange.runid 
	and intermRange1.querynum = upperRange.querynum 
	and intermRange1.lowerStart = upperRange.lowerStart 
	and intermRange1.lowerEnd = upperRange.lowerEnd 
	and intermRange1.upperStart = upperRange.upperStart 
	and intermRange1.upperEnd = upperRange.upperEnd 
	and intermRange1.opID = upperRange.opID 
	group by lowerRange.runid, lowerRange.querynum, lowerRange.lowerStart, lowerRange.lowerEnd, intermRange1.intermStart1, intermRange1.intermEnd1, lowerRange.upperStart, lowerRange.upperEnd, lowerRange.opID
	order by runid, querynum, lowerStart asc, opID asc;
ALTER TABLE DiscontOpNew_3RegSeqR2 ADD PRIMARY KEY (runid,querynum,lowerStart, lowerEnd, intermStart1, intermEnd1, upperStart, upperEnd, OPID);

SQL> select count(*) from DiscontOpNew_1RegSeqR2;
  COUNT(*)
----------
      3415

SQL> select count(*) from DiscontOpNew_2RegSeqR2;
  COUNT(*)
----------
    144162


SQL> select count(*) from DiscontOpNew_3RegSeqR2;
  COUNT(*)
----------
    512603

--- build four-region sequence
DROP TABLE DiscontOpNew_4RegSeq;
CREATE TABLE DiscontOpNew_4RegSeq AS 
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
	--and t0.runid IN (252,256,250,441)
	--and t0.runid = 252 and t0.querynum =6
	--and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t2.runid = t3.runid
	and t2.querynum = t3.querynum 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t2.card 
	and t2.card+40000+10000 <= t3.card and t3.card+40000 <= t0.high_card 
	and t0.high_card-t3.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd; 
ALTER TABLE DiscontOpNew_4RegSeq ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2,intermEnd2,upperStart,upperEnd);
-- select LOWERSTART,LOWEREND,INTERMSTART1, INTERMEND1, INTERMSTART2, intermEnd2, UPPERSTART, UPPEREND from DiscontOpNew_Step4_4RS;

--- r2 for the leftmost subrange
DROP TABLE DiscontOpNew_4RegSeqR2_1;
CREATE TABLE DiscontOpNew_4RegSeqR2_1 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_4RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.lowerStart <= t0.CARD 
	and t1.lowerEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_4RegSeqR2_1  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2, upperStart,upperEnd,OPID);

--- r2 for intermediate subrange 1
DROP TABLE DiscontOpNew_4RegSeqR2_2;
CREATE TABLE DiscontOpNew_4RegSeqR2_2 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_4RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.intermStart1 <= t0.CARD 
	and t1.intermEnd1 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_4RegSeqR2_2  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2, upperStart,upperEnd,OPID);

--- r2 for intermediate subrange 2
DROP TABLE DiscontOpNew_4RegSeqR2_3;
CREATE TABLE DiscontOpNew_4RegSeqR2_3 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_4RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	and t0.runid = 252 and t0.querynum = 6
	and t1.intermStart2 <= t0.CARD 
	and t1.intermEnd2 >= t0.CARD
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_4RegSeqR2_3  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2, upperStart,upperEnd,OPID);

--- r2 for the rightmost subrange
DROP TABLE DiscontOpNew_4RegSeqR2_4;
CREATE TABLE DiscontOpNew_4RegSeqR2_4 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_4RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.upperStart <= t0.CARD 
	and t1.upperEnd >= t0.CARD
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_4RegSeqR2_4  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2, upperStart,upperEnd,OPID);

-- compute R2 for four-region sequence
DROP TABLE DiscontOpNew_4RegSeqR2;	
CREATE TABLE DiscontOpNew_4RegSeqR2 AS 
	SELECT  lowerRange.runid,
		lowerRange.querynum,
		lowerRange.lowerStart,
		lowerRange.lowerEnd,
		intermRange1.intermStart1,
		intermRange1.intermEnd1,
		intermRange2.intermStart2,
		intermRange2.intermEnd2,
		lowerRange.upperStart,
		lowerRange.upperEnd,
		lowerRange.opID,
		avg((lowerRange.r2+intermRange1.r2+intermRange2.r2+upperRange.r2)/4) as r2
	FROM DiscontOpNew_4RegSeqR2_1 lowerRange, DiscontOpNew_4RegSeqR2_2 intermRange1, DiscontOpNew_4RegSeqR2_3 intermRange2, DiscontOpNew_4RegSeqR2_4 upperRange 
	WHERE lowerRange.runid = upperRange.runid 
	and lowerRange.querynum = upperRange.querynum 
	and lowerRange.lowerStart = upperRange.lowerStart 
	and lowerRange.lowerEnd = upperRange.lowerEnd 
	and lowerRange.upperStart = upperRange.upperStart 
	and lowerRange.upperEnd = upperRange.upperEnd 
	and lowerRange.opID = upperRange.opID 
	and intermRange1.runid = upperRange.runid 
	and intermRange1.querynum = upperRange.querynum 
	and intermRange1.lowerStart = upperRange.lowerStart 
	and intermRange1.lowerEnd = upperRange.lowerEnd 
	and intermRange1.upperStart = upperRange.upperStart 
	and intermRange1.upperEnd = upperRange.upperEnd 
	and intermRange1.opID = upperRange.opID 
	and intermRange1.runid = intermRange2.runid 
	and intermRange1.querynum = intermRange2.querynum 
	and intermRange1.lowerStart = intermRange2.lowerStart 
	and intermRange1.lowerEnd = intermRange2.lowerEnd 
	and intermRange1.upperStart = intermRange2.upperStart 
	and intermRange1.upperEnd = intermRange2.upperEnd 
	and intermRange1.opID = intermRange2.opID 
	--and lowerRange.runid = 252 and lowerRange.querynum = 6
	--and lowerRange.runid IN (252,256,250,441)
	group by lowerRange.runid, lowerRange.querynum, lowerRange.lowerStart, lowerRange.lowerEnd, intermRange1.intermStart1, intermRange1.intermEnd1, intermRange2.intermStart2, intermRange2.intermEnd2,lowerRange.upperStart, lowerRange.upperEnd, lowerRange.opID
	order by runid, querynum, lowerStart asc, opID asc;
ALTER TABLE DiscontOpNew_4RegSeqR2 ADD PRIMARY KEY (runid,querynum,lowerStart, lowerEnd, intermStart1, intermEnd1,intermStart2, intermEnd2, upperStart, upperEnd, OPID);

--- build five-region sequence
DROP TABLE DiscontOpNew_5RegSeq;
CREATE TABLE DiscontOpNew_5RegSeq AS 
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
	--and t0.runid = 252 and t0.querynum =6
	--and t0.low_card = 670000 and t0.high_card = 1120000
	--and t0.runid IN (252,256,250,441)
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
ALTER TABLE DiscontOpNew_5RegSeq ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2,intermEnd2,intermStart3,intermEnd3,upperStart,upperEnd);
-- select LOWERSTART,LOWEREND,INTERMSTART1, INTERMEND1, INTERMSTART2, intermEnd2, INTERMSTART3, intermEnd3, UPPERSTART, UPPEREND from DiscontOpNew_Step4_5RS;

--- r2 for the leftmost subrange
DROP TABLE DiscontOpNew_5RegSeqR2_1;
CREATE TABLE DiscontOpNew_5RegSeqR2_1 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_5RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.lowerStart <= t0.CARD 
	and t1.lowerEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_5RegSeqR2_1  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, upperStart,upperEnd,OPID);

--- r2 for the intermediate subrange 1
DROP TABLE DiscontOpNew_5RegSeqR2_2;
CREATE TABLE DiscontOpNew_5RegSeqR2_2 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_5RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.intermStart1 <= t0.CARD 
	and t1.intermEnd1 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_5RegSeqR2_2  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, upperStart,upperEnd,OPID);

--- r2 for the intermediate subrange 2
DROP TABLE DiscontOpNew_5RegSeqR2_3;
CREATE TABLE DiscontOpNew_5RegSeqR2_3 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_5RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.intermStart2 <= t0.CARD 
	and t1.intermEnd2 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_5RegSeqR2_3  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, upperStart,upperEnd,OPID);

--- r2 for the intermediate subrange 3
DROP TABLE DiscontOpNew_5RegSeqR2_4;
CREATE TABLE DiscontOpNew_5RegSeqR2_4 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_5RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.intermStart3 <= t0.CARD 
	and t1.intermEnd3 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_5RegSeqR2_4  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, upperStart,upperEnd,OPID);

--- r2 for the rightmost subrange 
DROP TABLE DiscontOpNew_5RegSeqR2_5;
CREATE TABLE DiscontOpNew_5RegSeqR2_5 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_5RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441)
	and t1.upperStart <= t0.CARD 
	and t1.upperEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_5RegSeqR2_5  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, upperStart,upperEnd,OPID);

-- compute R2 for five-region sequence
DROP TABLE DiscontOpNew_5RegSeqR2;	
CREATE TABLE DiscontOpNew_5RegSeqR2 AS 
	SELECT  lowerRange.runid,
		lowerRange.querynum,
		lowerRange.lowerStart,
		lowerRange.lowerEnd,
		intermRange1.intermStart1,
		intermRange1.intermEnd1,
		intermRange2.intermStart2,
		intermRange2.intermEnd2,
		intermRange3.intermStart3,
		intermRange3.intermEnd3,
		lowerRange.upperStart,
		lowerRange.upperEnd,
		lowerRange.opID,
		avg((lowerRange.r2+intermRange1.r2+intermRange2.r2+intermRange3.r2+upperRange.r2)/5) as r2
	FROM DiscontOpNew_5RegSeqR2_1 lowerRange, DiscontOpNew_5RegSeqR2_2 intermRange1, DiscontOpNew_5RegSeqR2_3 intermRange2, 
DiscontOpNew_5RegSeqR2_4 intermRange3, DiscontOpNew_5RegSeqR2_5 upperRange 
	WHERE lowerRange.runid = upperRange.runid 
	and lowerRange.querynum = upperRange.querynum 
	and lowerRange.lowerStart = upperRange.lowerStart 
	and lowerRange.lowerEnd = upperRange.lowerEnd 
	and lowerRange.upperStart = upperRange.upperStart 
	and lowerRange.upperEnd = upperRange.upperEnd 
	and lowerRange.opID = upperRange.opID 
	and intermRange1.runid = upperRange.runid 
	and intermRange1.querynum = upperRange.querynum 
	and intermRange1.lowerStart = upperRange.lowerStart 
	and intermRange1.lowerEnd = upperRange.lowerEnd 
	and intermRange1.upperStart = upperRange.upperStart 
	and intermRange1.upperEnd = upperRange.upperEnd 
	and intermRange1.opID = upperRange.opID 
	and intermRange1.runid = intermRange2.runid 
	and intermRange1.querynum = intermRange2.querynum 
	and intermRange1.lowerStart = intermRange2.lowerStart 
	and intermRange1.lowerEnd = intermRange2.lowerEnd 
	and intermRange1.upperStart = intermRange2.upperStart 
	and intermRange1.upperEnd = intermRange2.upperEnd 
	and intermRange1.opID = intermRange2.opID 
	and intermRange3.runid = intermRange2.runid 
	and intermRange3.querynum = intermRange2.querynum 
	and intermRange3.lowerStart = intermRange2.lowerStart 
	and intermRange3.lowerEnd = intermRange2.lowerEnd 
	and intermRange3.upperStart = intermRange2.upperStart 
	and intermRange3.upperEnd = intermRange2.upperEnd 
	and intermRange3.opID = intermRange2.opID 
	--and lowerRange.runid = 252 and lowerRange.querynum = 6
	--and lowerRange.runid IN (252,256,250,441)
	group by lowerRange.runid, lowerRange.querynum, lowerRange.lowerStart, lowerRange.lowerEnd, intermRange1.intermStart1, intermRange1.intermEnd1, intermRange2.intermStart2, intermRange2.intermEnd2,intermRange3.intermStart3, intermRange3.intermEnd3,lowerRange.upperStart, lowerRange.upperEnd, lowerRange.opID
	order by runid, querynum, lowerStart asc, opID asc;
ALTER TABLE DiscontOpNew_5RegSeqR2 ADD PRIMARY KEY (runid,querynum,lowerStart, lowerEnd, intermStart1, intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, upperStart, upperEnd, OPID);

--- build six-region sequence 
DROP TABLE DiscontOpNew_6RegSeq;
CREATE TABLE DiscontOpNew_6RegSeq AS 
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
	--and t0.runid = 252 and t0.querynum =6
	--and t0.low_card = 670000 and t0.high_card = 1120000
	and t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t2.runid = t3.runid
	and t2.querynum = t3.querynum 
	and t3.runid = t4.runid
	and t3.querynum = t4.querynum 
	and t4.runid = t5.runid
	and t4.querynum = t5.querynum 
	--and t0.runid IN (252,256,250,441) 
	and t0.low_card+40000 <= t1.card and t1.card+40000 <= t2.card 
	and t2.card+40000+10000 <= t3.card and t3.card+40000+10000 <= t4.card 
	and t4.card+40000+10000 <= t5.card and t5.card+40000 <= t0.high_card
	and t0.high_card-t5.card-40000-10000 >= 40000
	order by runid, querynum, lowerStart, lowerEnd; 
ALTER TABLE DiscontOpNew_6RegSeq ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2,intermEnd2,intermStart3,intermEnd3,intermStart4,intermEnd4,upperStart,upperEnd);

--- compute r2 for the leftmost subrange
DROP TABLE DiscontOpNew_6RegSeqR2_1;
CREATE TABLE DiscontOpNew_6RegSeqR2_1 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_6RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441) 
	and t1.lowerStart <= t0.CARD 
	and t1.lowerEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_6RegSeqR2_1  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3,intermStart4, intermEnd4, upperStart,upperEnd,OPID);

--- compute r2 for the intermediate subrange 1
DROP TABLE DiscontOpNew_6RegSeqR2_2;
CREATE TABLE DiscontOpNew_6RegSeqR2_2 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_6RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441) 
	and t1.intermStart1 <= t0.CARD 
	and t1.intermEnd1 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_6RegSeqR2_2  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3,intermStart4, intermEnd4, upperStart,upperEnd,OPID);

--- compute r2 for the intermediate subrange 2
DROP TABLE DiscontOpNew_6RegSeqR2_3;
CREATE TABLE DiscontOpNew_6RegSeqR2_3 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_6RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441) 
	and t1.intermStart2 <= t0.CARD 
	and t1.intermEnd2 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_6RegSeqR2_3  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3,intermStart4, intermEnd4, upperStart,upperEnd,OPID);

--- compute r2 for the intermediate subrange 3
DROP TABLE DiscontOpNew_6RegSeqR2_4;
CREATE TABLE DiscontOpNew_6RegSeqR2_4 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_6RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441) 
	and t1.intermStart3 <= t0.CARD 
	and t1.intermEnd3 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_6RegSeqR2_4  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3,intermStart4, intermEnd4, upperStart,upperEnd,OPID);

--- compute r2 for the intermediate subrange 4
DROP TABLE DiscontOpNew_6RegSeqR2_5;
CREATE TABLE DiscontOpNew_6RegSeqR2_5 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_6RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441) 
	and t1.intermStart4 <= t0.CARD 
	and t1.intermEnd4 >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_6RegSeqR2_5  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3,intermStart4, intermEnd4, upperStart,upperEnd,OPID);

--- compute r2 for the intermediate subrange 5
DROP TABLE DiscontOpNew_6RegSeqR2_6;
CREATE TABLE DiscontOpNew_6RegSeqR2_6 AS 
	select t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.OPID, coalesce(round(REGR_R2(t0.card, t0.estCost),3),0) r2
	from DiscontOpNew_Step0 t0, DiscontOpNew_6RegSeq t1
	where t0.runid = t1.runid 
	and t0.querynum = t1.querynum
	--and t0.runid IN (252,256,250,441) 
	and t1.upperStart <= t0.CARD 
	and t1.upperEnd >= t0.CARD 
	group by t0.runid, t0.querynum, t1.lowerStart, t1.lowerEnd, t1.intermStart1, t1.intermEnd1, t1.intermStart2, t1.intermEnd2, t1.intermStart3, t1.intermEnd3, t1.intermStart4, t1.intermEnd4, t1.upperStart, t1.upperEnd, t0.opID;
ALTER TABLE DiscontOpNew_6RegSeqR2_6  ADD PRIMARY KEY (runid,querynum,lowerStart,lowerEnd,intermStart1,intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3,intermStart4, intermEnd4, upperStart,upperEnd,OPID);

-- compute R2 for six-region sequence
DROP TABLE DiscontOpNew_6RegSeqR2;	
CREATE TABLE DiscontOpNew_6RegSeqR2 AS 
	SELECT  lowerRange.runid,
		lowerRange.querynum,
		lowerRange.lowerStart,
		lowerRange.lowerEnd,
		intermRange1.intermStart1,
		intermRange1.intermEnd1,
		intermRange2.intermStart2,
		intermRange2.intermEnd2,
		intermRange3.intermStart3,
		intermRange3.intermEnd3,
		intermRange4.intermStart3,
		intermRange4.intermEnd3,
		lowerRange.upperStart,
		lowerRange.upperEnd,
		lowerRange.opID,
		avg((lowerRange.r2+intermRange1.r2+intermRange2.r2+intermRange3.r2+intermRange4.r2+upperRange.r2)/6) as r2
	FROM DiscontOpNew_6RegSeqR2_1 lowerRange, DiscontOpNew_6RegSeqR2_2 intermRange1, DiscontOpNew_6RegSeqR2_3 intermRange2, 
DiscontOpNew_6RegSeqR2_4 intermRange3, DiscontOpNew_6RegSeqR2_5 intermRange4, DiscontOpNew_6RegSeqR2_6 upperRange 
	WHERE lowerRange.runid = upperRange.runid 
	and lowerRange.querynum = upperRange.querynum 
	and lowerRange.lowerStart = upperRange.lowerStart 
	and lowerRange.lowerEnd = upperRange.lowerEnd 
	and lowerRange.upperStart = upperRange.upperStart 
	and lowerRange.upperEnd = upperRange.upperEnd 
	and lowerRange.opID = upperRange.opID 
	and intermRange1.runid = upperRange.runid 
	and intermRange1.querynum = upperRange.querynum 
	and intermRange1.lowerStart = upperRange.lowerStart 
	and intermRange1.lowerEnd = upperRange.lowerEnd 
	and intermRange1.upperStart = upperRange.upperStart 
	and intermRange1.upperEnd = upperRange.upperEnd 
	and intermRange1.opID = upperRange.opID 
	and intermRange1.runid = intermRange2.runid 
	and intermRange1.querynum = intermRange2.querynum 
	and intermRange1.lowerStart = intermRange2.lowerStart 
	and intermRange1.lowerEnd = intermRange2.lowerEnd 
	and intermRange1.upperStart = intermRange2.upperStart 
	and intermRange1.upperEnd = intermRange2.upperEnd 
	and intermRange1.opID = intermRange2.opID 
	and intermRange3.runid = intermRange2.runid 
	and intermRange3.querynum = intermRange2.querynum 
	and intermRange3.lowerStart = intermRange2.lowerStart 
	and intermRange3.lowerEnd = intermRange2.lowerEnd 
	and intermRange3.upperStart = intermRange2.upperStart 
	and intermRange3.upperEnd = intermRange2.upperEnd 
	and intermRange3.opID = intermRange2.opID 
	and intermRange3.runid = intermRange4.runid 
	and intermRange3.querynum = intermRange4.querynum 
	and intermRange3.lowerStart = intermRange4.lowerStart 
	and intermRange3.lowerEnd = intermRange4.lowerEnd 
	and intermRange3.upperStart = intermRange4.upperStart 
	and intermRange3.upperEnd = intermRange4.upperEnd 
	and intermRange3.opID = intermRange4.opID 
	--and lowerRange.runid = 252 and lowerRange.querynum = 6
	--and lowerRange.runid IN (252,256,250,441) 
	group by lowerRange.runid, lowerRange.querynum, lowerRange.lowerStart, lowerRange.lowerEnd, intermRange1.intermStart1, intermRange1.intermEnd1, intermRange2.intermStart2, intermRange2.intermEnd2,intermRange3.intermStart3, intermRange3.intermEnd3,intermRange4.intermStart4, intermRange4.intermEnd4,lowerRange.upperStart, lowerRange.upperEnd, lowerRange.opID
	order by runid, querynum, lowerStart asc, opID asc;
ALTER TABLE DiscontOpNew_6RegSeqR2 ADD PRIMARY KEY (runid,querynum,lowerStart, lowerEnd, intermStart1, intermEnd1,intermStart2, intermEnd2,intermStart3, intermEnd3, intermStart4, intermEnd4,upperStart, upperEnd, OPID);

-- pick up the minimum r2 for x-region sequence
DROP TABLE DiscontOpNew_ReqSeqMinR2;	
CREATE TABLE DiscontOpNew_ReqSeqMinR2 AS 
	SELECT t1.runid,
	       t1.querynum,
	       t1.low_card, 
	       t1.high_card,
	       t1.opID,
	       min(t1.r2) as min_r2
	FROM	DiscontOpNew_1RegSeqR2 t1, 
		DiscontOpNew_2RegSeqR2 t2,
		DiscontOpNew_3RegSeqR2 t3,
		DiscontOpNew_4RegSeqR2 t4,
		DiscontOpNew_5RegSeqR2 t5,
		DiscontOpNew_6RegSeqR2 t6
	WHERE t1.runid = t2.runid 
	and t1.querynum = t2.querynum 
	and t1.low_card = t2.lowStart
	and t1.high_card = t2.upperEnd
	and t1.opID = t2.opID 
	and t1.runid = t3.runid 
	and t1.querynum = t3.querynum 
	and t1.low_card = t3.lowStart
	and t1.high_card = t3.upperEnd 
	and t1.opId = t3.opID
	and t1.runid = t4.runid 
	and t1.querynum = t4.querynum 
	and t1.low_card = t4.lowStart
	and t1.high_card = t4.upperEnd 
	and t1.opId = t4.opID
	and t1.runid = t5.runid 
	and t1.querynum = t5.querynum 
	and t1.low_card = t5.lowStart
	and t1.high_card = t5.upperEnd 
	and t1.opId = t5.opID
	and t1.runid = t6.runid 
	and t1.querynum = t6.querynum 
	and t1.low_card = t6.lowStart
	and t1.high_card = t6.upperEnd 
	and t1.opId = t6.opID
	group by t1.runid, t1.querynum, t1.low_card, t1.high_card, t1.opId
	order by runid, querynum asc, low_card asc, opId asc;
ALTER TABLE DiscontOpNew_RegSeqR2 ADD PRIMARY KEY (runid,querynum,low_card,high_card,opID);
