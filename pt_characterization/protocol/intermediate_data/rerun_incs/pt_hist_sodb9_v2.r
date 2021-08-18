###### INC1-64
fileName <- paste("inc72-224_hist_bin_count.txt",sep="") 
fraction <- 0 
for (task_len in c(72,160,192,224)){
	numSamples <- 1000
	if(task_len == 

	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	INC_label <- paste(task_len,".",fraction,sep="")
	histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	print(dataFileName)
	x = read.csv(file=dataFileName,head=TRUE,sep="\t") 
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	postscript(histFileName)
	binsize=1
	x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
	x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
	#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
	xmin <-min(x$PRTIME)
	xmin
	xmax <-max(x$PRTIME)
	xmax
	nbins <- ceiling((xmax-xmin) / binsize)
	h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F) 
	ymax <- max(h$counts)
	ymax <- ceiling(ymax/100)*100 
	#ymax <- 600 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",INC_label,sep=""), 
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
