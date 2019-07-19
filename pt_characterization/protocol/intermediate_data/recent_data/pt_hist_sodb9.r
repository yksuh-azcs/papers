### INC72,160,192,224
numSamples <- 1000 
start <- 72
end <- 224
fileName <- paste("inc",start,"-",end,"_hist_bin_count.txt",sep="")
fraction <- 0
count <- -1
for (task_len in c(72,160,192,224)){
	count <- count+1
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	INC_label <- paste(task_len,".",fraction,sep="")
	histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	print(dataFileName)
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS()
	postscript(histFileName)
	binsize=2
	if(task_len == 72){
		binsize=1
	}else{
		binsize=2
	}
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
	if(task_len == 72){
		ymax = 200
	}else if(task_len == 160){
		ymax = 250
	}else if(task_len == 192){
		ymax = 250
	}else if(task_len == 224){
		ymax = 250
	}
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
	if(task_len == 72){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}


###### INC128-4096
numSamples <- 300 
start <- 128
end <- 4096
fileName <- paste("inc",start,"-",end,"_hist_bin_count.txt",sep="")
fraction <- 0
count <- -1
for (task_len in c(128,256,512,1024,2048,4096)){
	count <- count+1
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	INC_label <- paste(task_len,".",fraction,sep="")
	histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	print(dataFileName)
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS()
	postscript(histFileName)
	binsize=2
	if(task_len == 128){
		binsize=2
	}else if(task_len == 256){
		binsize=2
	}else if(task_len == 512){
		binsize=5
	}else if(task_len == 1024){
		binsize=5
	}else if(task_len == 2048){
		binsize=5
	}else if(task_len == 4096){
		binsize=5
	}
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
	if(task_len == 128){
		ymax = 80
	}else if(task_len == 256){
		ymax = 80
	}else if(task_len == 512){
		ymax = 150
	}else if(task_len == 1024){
		ymax = 100
	}else if(task_len == 2048){
		ymax = 60
	}else if(task_len == 4096){
		ymax = 50
	}
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
	if(task_len == 128){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}


###### INC48-120
numSamples <- 1000
fileName <- paste("inc48-120_hist_bin_count.txt",sep="")
fraction <- 0
count <- -1
for (task_len in c(48,88,96,104,112,120)){
	count <- count+1
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
	if(task_len == 48){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}
