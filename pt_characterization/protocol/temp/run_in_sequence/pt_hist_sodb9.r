###INC1-16384 
numSamples <- 30 
fileName <- paste("inc1-16K_run_in_seq_hist_bin_count.txt",sep="") 
for (task_len in c(1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384)){
	dataFileName <- paste("INC",task_len,".dat",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	postscript(histFileName)
	if(task_len <= 64){
		binsize=1
	}else if(task_len <= 256){
		binsize=2
	}else if(task_len <= 8192){
		binsize=5
	}else if(task_len == 16384){
		binsize=10
	}
	x_up = mean(x$PT) + 2*sd(x$PT)
	x_dn = mean(x$PT) - 2*sd(x$PT)
	#x = subset(x, x$PT >= x_dn & x$PT <= x_up)
	xmin <-min(x$PT)
	xmin
	xmax <- max(x$PT)
	xmax
	nbins <- ceiling((xmax-xmin) / binsize)
	h = hist(x$PT, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F) 
	ymax <- max(h$counts)
	#ymax <- 600 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",task_len,sep=""), 
	sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='PT (ms)', ylab=expression('Frequency'))
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    tl[c:1] <- task_len
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(task_len == 1){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}
