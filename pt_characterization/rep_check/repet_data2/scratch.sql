


DROP TABLE INC8192_r2_INFO CASCADE CONSTRAINTS;
CREATE TABLE INC8192_r2_INFO AS
	SELECT ar.exp_run_time as task_len,
	    arr.iternum,
	    proc.processname as procname,
	    arr.RUNTIME as et,
	    proc.utime+proc.stime as pt 
	FROM AZDBLab_NewAlgRun2 ar, 
	     AZDBLab_NewAlgRunResult2 arr, 
	     AZDBLab_ProcInfo2 proc
	WHERE 
	ar.algrunid = arr.algrunid
	and arr.algrunid = proc.algrunid
	and arr.datanum = proc.DATANUM
	and arr.iternum = proc.iternum
	and (proc.utime+proc.stime) > 0
	and proc.processname = 'incr_work'
	and arr.algrunid IN (18840);
ALTER TABLE INC8192_r2_INFO ADD PRIMARY KEY (task_len, iternum);

select sum(freq) 
from (select pt, count(*) as freq 
	from INC8192_r2_INFO  
	group by pt 
	order by pt asc) t0


	PT	 FREQ
---------- ----------
8209062999	    2
8209063999	    1
8209067999	    3
8209070999	    2
8209075999	    2
8209077999	    1
8209078999	    2
8209079999	    1
8209080999	    1
8209081999	    2
8209083999	    1
8209085999	    1
8209086999	    2
8209087999	    2
8209088999	    2
8209089999	    3
8209090999	    6
8209091999	    1
8209092999	    7
8209093999	    1
8209094999	    2
8209095999	    3
8209096999	    5
8209097999	    4
8209098999	    1
8209099999	    5
8209100999	    7
8209101999	    7
8209102999	    5
8209103999	    9
8209104999	    4
8209105999	    5
8209106999	    2
8209107999	   10
8209108999	    7
8209109999	    3
8209110999	    8
8209111999	    3
8209112999	    8
8209113999	    4
8209114999	    4
8209115999	    2
8209116999	    7
8209117999	   11
8209118999	    6
8209119999	    4
8209120999	    4
8209121999	    5
8209122999	    8
8209123999	    2
8209124999	    3
8209125999	    1
8209126999	    2
8209127999	    5
8209128999	    4
8209129999	    5
8209130999	    5
8209131999	    4
8209132999	    2
8209133999	    1
8209134999	    3
8209135999	    4
8209136999	    1
8209138999	    2
8209139999	    4
8209140999	    4
8209141999	    1
8209143999	    3
8209144999	    1
8209145999	    1
8209147999	    1
8209149999	    1
8209150999	    1
8209153999	    2
8209156999	    1
8209159999	    1
