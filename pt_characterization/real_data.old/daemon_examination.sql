DROP TABLE  INC_BIN_Iters CASCADE CONSTRAINTS;
CREATE TABLE INC_BIN_Iters AS
	select algrunid, 
	       exp_run_time as task_len,
	       pt as bin,
	       iternum
	from DIFF_INC_RUN_PROC_INFO 
	where processname = 'incr_work' 
	and algrunid IN (24021,24121) 
	order by algrunid, exp_run_time, pt;
	--group by algrunid, exp_run_time, pt
ALTER TABLE INC_BIN_Iters ADD PRIMARY KEY (algrunid, task_len, bin, iternum);

DROP TABLE INC_BIN_Proc_Per_Iter CASCADE CONSTRAINTS;
CREATE TABLE INC_BIN_Proc_Per_Iter AS
	SELECT t1.algrunid,
	       t1.task_len,
	       t1.bin, 
	       t1.iternum,
	       t0.procid, 
	       t0.processname,
	       t0.pt 
	FROM DIFF_INC_RUN_PROC_INFO t0, 
	     INC_BIN_Iters t1
	WHERE t1.algrunid = t0.algrunid 
	and t1.task_len = t0.exp_run_time 
	and t1.iternum = t0.iternum 
	and t1.algrunid = t0.algrunid 
	and t0.processname <> 'incr_work' 
	and t0.pt > 0 
	--group by t1.algrunid, t1.bin, t1.iternum, t0.procid, t0.processname 
	order by t1.algrunid, t1.bin, t1.iternum, t0.pt desc, t0.procid; 
ALTER TABLE INC_BIN_Proc_Per_Iter ADD PRIMARY KEY (algrunid, task_len, bin, iternum, procid);

DROP TABLE INC_BIN_Proc_Stat CASCADE CONSTRAINTS;
CREATE TABLE INC_BIN_Proc_Stat AS
	SELECT algrunid, 
		task_len, 
		bin, 
		procid, 
		processname, 
		max(pt) as max_pt,
      		min(pt) as min_pt,
      		round(avg(pt), 2) as avg_pt,
      		round(stddev(pt), 1) as std_pt 
	FROM INC_BIN_Proc_Per_Iter 
	group by algrunid, task_len, bin, procid, processname 
	order by algrunid, task_len, bin, avg_pt desc, processname asc; 
ALTER TABLE INC_BIN_Proc_Stat ADD PRIMARY KEY (algrunid, task_len, bin, procid);

select * from INC_BIN_Proc_Stat;


