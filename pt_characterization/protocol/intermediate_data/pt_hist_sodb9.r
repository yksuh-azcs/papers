###### INC118-123
numSamples <- 1000
task_len <- 118
fileName <- paste("inc",task_len,"-",task_len+2,"_hist_bin_count.txt",sep="") 
fraction <- 0 
count <- -1
for (task_len in c(118,119,120,121,122,123)){
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
	if(task_len == 118){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}




###### INC60~INC61
numSamples <- 1000
task_len <- 60
fileName <- paste("inc",task_len,"-",task_len+1,"_hist_bin_count.txt",sep="") 
for (fraction in c(0,125,25,375,5,625,75,875)){
	INC_label <- paste(task_len,".",fraction,sep="")
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	if(fraction == 25 || fraction == 75){
		adj_fraction <- fraction*10
		histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
	}else if (fraction == 5){
		adj_fraction <- fraction*100
		histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
	}else{
		histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
	}
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
	ymax <- 600 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",INC_label,sep=""), 
	sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='PT (ms)', ylab=expression('Frequency'))
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}



###### INC8192
numSamples <- 300
task_len <- 8192
fileName <- paste("inc",task_len,"_hist_bin_count.txt",sep="") 
fraction <- 0 
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
INC_label <- paste(task_len,".",fraction,sep="")
histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
print(dataFileName)
x = read.csv(file=dataFileName,head=TRUE,sep="\t") 
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
postscript(histFileName)
binsize=5
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
if(task_len == 8192){
	write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
}else{
	write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
}


###### INC80
numSamples <- 1000
task_len <- 80
fileName <- paste("inc",task_len,"_hist_bin_count.txt",sep="") 
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
if(task_len == 80){
	write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
}else{
	write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
}
###### INC93-103
numSamples <- 1000
task_len <- 93
fileName <- paste("inc",task_len,"-",task_len+10,"_hist_bin_count.txt",sep="") 
fraction <- 0 
count <- -1
for (task_len in c(93,94,95,96,97,98,99,100,101,102,103)){
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
	if(task_len == 93){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC78-80
numSamples <- 1000
task_len <- 78
fileName <- paste("inc",task_len,"-",task_len+2,"_hist_bin_count.txt",sep="") 
fraction <- 0 
count <- -1
for (task_len in c(78,78.25,78.5,78.75,79,79.25,79.5,79.75,80)){
	count <- count+1
	if(count %% 4 == 0){
		fraction <- 0
		dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
		INC_label <- paste(task_len,".",fraction,sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}else{
		fraction <- fraction+0.25
		if(fraction == 1){
			fraction <- 0
		}
		dataFileName <- paste("INC",task_len,".dat",sep="")
		INC_label <- paste(task_len,sep="")
		histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
	}
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
	if(task_len == 78){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC60-64
numSamples <- 1000
task_len <- 60
fileName <- paste("inc",task_len,"-",task_len+4,"_hist_bin_count.txt",sep="") 
fraction <- 0 
count <- -1
for (task_len in c(60,60.5,61,61.5,62,62.5,63,63.5,64)){
	count <- count+1
	if(count %% 2 == 0){
		fraction <- 0
		dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
		INC_label <- paste(task_len,".",fraction,sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}else{
		fraction <- 0.5
		dataFileName <- paste("INC",task_len,".dat",sep="")
		INC_label <- paste(task_len,sep="")
		histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
	}
	#print(dataFileName)
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
	if(task_len == 60){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}


###### INC224
numSamples <- 1000
task_len <- 224
fileName <- paste("inc",task_len,"_hist_bin_count.txt",sep="") 
for (task_len in c(224)){
	fraction <- 0
	INC_label <- paste(task_len,sep="")
	dataFileName <- paste(task_len,"_sec.dat",sep="")
	histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
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
	ymax <- 150 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",INC_label,sep=""), 
	sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='PT (ms)', ylab=expression('Frequency'))
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC60,62
numSamples <- 1000
task_len <- 60
fileName <- paste("inc",task_len,"-",task_len+2,"_hist_bin_count.txt",sep="") 
for (task_len in c(60,62)){
	fraction <- 0
	INC_label <- paste(task_len,sep="")
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC21~22
numSamples <- 1000
task_len <- 21
fileName <- paste("inc",task_len,"-",task_len+1,"_hist_bin_count.txt",sep="") 
for (fraction in c(0,125,25,375,5,625,75,875,1000)){
	if(fraction == 0){
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else if(fraction == 1000){
		task_len <- task_len+1
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else{
		INC_label <- paste(task_len,".",fraction,sep="")
		dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
		if(fraction == 25 || fraction == 75){
			adj_fraction <- fraction*10
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else if (fraction == 5){
			adj_fraction <- fraction*100
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else{
			histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
		}
	}
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
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC20~21
numSamples <- 1000
task_len <- 20
fileName <- paste("inc",task_len,"-",task_len+1,"_hist_bin_count.txt",sep="") 
for (fraction in c(0,125,25,375,5,625,75,875,1000)){
	if(fraction == 0){
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else if(fraction == 1000){
		task_len <- task_len+1
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else{
		INC_label <- paste(task_len,".",fraction,sep="")
		dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
		if(fraction == 25 || fraction == 75){
			adj_fraction <- fraction*10
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else if (fraction == 5){
			adj_fraction <- fraction*100
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else{
			histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
		}
	}
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
	#ymax <- ceiling(ymax/100)*100 
	ymax <- 600 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",INC_label,sep=""), 
	sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='PT (ms)', ylab=expression('Frequency'))
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC19~20
numSamples <- 1000
task_len <- 19
fileName <- paste("inc",task_len,"-",task_len+1,"_hist_bin_count.txt",sep="") 
for (fraction in c(0,125,25,375,5,625,75,875,1000)){
	if(fraction == 0){
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else if(fraction == 1000){
		task_len <- task_len+1
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else{
		INC_label <- paste(task_len,".",fraction,sep="")
		dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
		if(fraction == 25 || fraction == 75){
			adj_fraction <- fraction*10
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else if (fraction == 5){
			adj_fraction <- fraction*100
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else{
			histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
		}
	}
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
	ymax <- 600 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",INC_label,sep=""), 
	sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='PT (ms)', ylab=expression('Frequency'))
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

numSamples <- 1000
task_len <- 19
fileName <- paste("inc",task_len,"-",task_len+1,"_hist_bin_count.txt",sep="") 
for (fraction in c(0,125,25,375,5,625,75,875,1000)){
	if(fraction == 0){
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else if(fraction == 1000){
		task_len <- task_len+1
		INC_label <- paste(task_len,sep="")
		dataFileName <- paste(task_len,"_sec.dat",sep="")
		histFileName <- paste(task_len,"_sec_pt_hist.eps",sep="")
	}
	else{
		INC_label <- paste(task_len,".",fraction,sep="")
		dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
		if(fraction == 25 || fraction == 75){
			adj_fraction <- fraction*10
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else if (fraction == 5){
			adj_fraction <- fraction*100
			histFileName <- paste(task_len,"_",adj_fraction,"_sec_pt_hist.eps",sep="")
		}else{
			histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
		}
	}
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
	ymax <- 600 
	plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", 
	main=paste("PT frequency on INC",INC_label,sep=""), 
	sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='PT (ms)', ylab=expression('Frequency'))
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }else if (fraction == 0 || fraction == 1000){
		tl[c:1] <- task_len
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(fraction == 0){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

###### INC48,64 --- run1
numSamples <- 1000
task_len <- 19
fileName <- paste("INC48_64_hist1.txt",sep="") 
for (task_len in c(48,64)){
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist1.eps",sep="")
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
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1
	    tl[c:1] <- task_len
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	#if(task_len == 48){
	#write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	#}else{
	#	write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	#}
	xmin
	xmax <-max(x$PRTIME)
	xmax
	nbins <- ceiling((xmax-xmin) / binsize)
	h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
	ymax <- max(h$counts)
	ymax <- ceiling(ymax/100)*100 
	if(task_len == 48){
		plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main=paste("2017-06-08: PT frequency on INC",task_len,sep=""), sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 	xlab='PT (ms)', ylab=expression('Frequency'))
	}else{
		ymax <-250
		plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main=paste("2017-03-09: PT frequency on INC",task_len,sep=""), sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 	xlab='PT (ms)', ylab=expression('Frequency'))
	}
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
}



###INC25
task_len <- 25 
fraction <- 0
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

task_len <- task_len+1
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

task_len <- task_len+1
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

task_len <- task_len+1
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

task_len <- task_len+1
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

task_len <- task_len+1
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

task_len <- task_len+1
dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
x = read.csv(file=dataFileName,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS() 
histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
tl <- h$counts  
c <- 0
for (v in tl) {
    c <- c+1
    tl[c:1] <- task_len
}
y <- cbind(tl,floor(h$mids),h$counts) 
y
write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")

###### INC48,64 --- run1
numSamples <- 1000
fileName <- paste("INC48_64_hist1.txt",sep="") 
for (task_len in c(48,64)){
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist1.eps",sep="")
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
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1
	    tl[c:1] <- task_len
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	#if(task_len == 48){
	#write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	#}else{
	#	write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	#}
	xmin
	xmax <-max(x$PRTIME)
	xmax
	nbins <- ceiling((xmax-xmin) / binsize)
	h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
	ymax <- max(h$counts)
	ymax <- ceiling(ymax/100)*100 
	if(task_len == 48){
		plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main=paste("2017-06-08: PT frequency on INC",task_len,sep=""), sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 	xlab='PT (ms)', ylab=expression('Frequency'))
	}else{
		ymax <-250
		plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main=paste("2017-03-09: PT frequency on INC",task_len,sep=""), sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 	xlab='PT (ms)', ylab=expression('Frequency'))
	}
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
}


###### INC48,60 --- run2
numSamples <- 1000
fileName <- paste("INC48_64_hist2.txt",sep="") 
for (task_len in c(48,64)){
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat2",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist2.eps",sep="")
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
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1
	    tl[c:1] <- task_len
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	#if(task_len == 48){
	#	write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	#}else{
	#	write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	#}
	xmin
	xmax <-max(x$PRTIME)
	xmax
	nbins <- ceiling((xmax-xmin) / binsize)
	h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
	ymax <- max(h$counts)
	ymax <- ceiling(ymax/100)*100 
	if(task_len == 48){
		plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main=paste("2019-03-29: PT frequency on INC",task_len,sep=""), sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 	xlab='PT (ms)', ylab=expression('Frequency'))
	}else{
		ymax <-250
		plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main=paste("2019-03-30: PT frequency on INC",task_len,sep=""), sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 	xlab='PT (ms)', ylab=expression('Frequency'))
	}
	axis(side=1,at=h$mids,labels=seq(min(h$breaks),max(h$breaks)-1,binsize))
	dev.off()
}

###INC50 
numSamples <- 1000
fileName <- paste("interm_inc_hist_bin_count2.txt",sep="") 
for (task_len in c(50,52,54,56,58,60,62)){
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1
	    tl[c:1] <- task_len
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	if(task_len == 50){
	write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}
###INC65-71 
for (task_len in c(65,66,67,68,69,70,71)){
	fraction <- 0
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1
	    tl[c:1] <- task_len
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	#if(task_len == 50){
	#write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	#}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	#}
}

numSamples <- 1000
task_len <- 21
for (fraction in c(125,25,375,5,625,75,875)){
	dataFileName <- paste("INC",task_len,".",fraction,".dat",sep="")
	x = read.csv(file=dataFileName,head=TRUE,sep="\t")
	x <- subset(x, x$ITERNUM <= numSamples)
	setEPS() 
	histFileName <- paste(task_len,"_",fraction,"_sec_pt_hist.eps",sep="")
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
	tl <- h$counts  
	c <- 0
	for (v in tl) {
	    c <- c+1 
	    if(fraction == 25 || fraction == 75){
	   	tl[c:1] <- task_len+fraction/100
	    }else if (fraction == 5){
		tl[c:1] <- task_len+fraction/10
	    }
	    else{
		tl[c:1] <- task_len+fraction/1000
	    }
	}
	y <- cbind(tl,floor(h$mids),h$counts) 
	y
	fileName <- paste("interm_inc_hist_bin_count3.txt",sep="") 
	if(fraction == 125){
		write.table(y, file=fileName, row.names = FALSE, col.names = c('INC Number', 'Bin Number', 'Counts'), sep = "\t")
	}else{
		write.table(y, file=fileName, append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
	}
}

######
numSamples <- 30
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_pt_hist.eps")
binsize=2
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
ymax <- 20
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_pt_hist.eps")
binsize=2
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
ymax <-25
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_pt_hist.eps")
binsize=2
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
ymax <-25
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist.eps")
binsize=2
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
ymax <-15
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_pt_hist.eps")
binsize=2
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
ymax <-20
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_pt_hist.eps")
binsize=2
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
ymax <-10
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_pt_hist.eps")
binsize=2
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
ymax <-10
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_pt_hist.eps")
binsize=4
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
ymax <-15
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("256_sec_pt_hist.eps")
binsize=4
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
ymax <- 15
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("512_sec_pt_hist.eps")
binsize=10
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
ymax <- 20
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1024_sec_pt_hist.eps")
binsize=10
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
ymax <- 20
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2048_sec_pt_hist.eps")
binsize=10
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
ymax <- 15
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4096_sec_pt_hist.eps")
binsize=10
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
ymax <- 10
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="8192_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples) 
x$PRTIME <- round(x$PRTIME,1)
setEPS()
postscript("8192_sec_pt_hist.eps")
binsize=10
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
ymax <- 8
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC8192', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(min(h$mids),max(h$mids),binsize))
dev.off()

numSamples <- 30
x = read.csv(file="16384_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16384_sec_pt_hist.eps")
binsize=20
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
ymax <- 10
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC16384', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids)),binsize))
dev.off()
###############################################################################################

numSamples <- 1000
x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x1 <- subset(x, x$ITERNUM <= 200)
x2 <- subset(x, x$ITERNUM > 200 & x$ITERNUM <= 400)
x3 <- subset(x, x$ITERNUM > 400 & x$ITERNUM <= 600)
x4 <- subset(x, x$ITERNUM > 600 & x$ITERNUM <= 800)
x5 <- subset(x, x$ITERNUM > 800 & x$ITERNUM <= 1000)

### 16-1
setEPS()
postscript("16_sec_pt_hist0_1.eps")
x1_up = mean(x1$PRTIME) + 2*sd(x1$PRTIME)
x1_dn = mean(x1$PRTIME) - 2*sd(x1$PRTIME)
#x1 = subset(x1, x1$PRTIME >= x1_dn & x1$PRTIME <= x1_up)
binsize=1
xmin <-min(x1$PRTIME)
xmin
xmax <-max(x1$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x1)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-1', 
sub=paste("(n=",nrow(x1),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-2
setEPS()
postscript("16_sec_pt_hist0_2.eps")
x2_up = mean(x2$PRTIME) + 2*sd(x2$PRTIME)
x2_dn = mean(x2$PRTIME) - 2*sd(x2$PRTIME)
#x2 = subset(x2, x2$PRTIME >= x2_dn & x2$PRTIME <= x2_up)
binsize=1
xmin <-min(x2$PRTIME)
xmin
xmax <-max(x2$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x2$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x2)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-2', 
sub=paste("(n=",nrow(x2),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-3
setEPS()
postscript("16_sec_pt_hist0_3.eps")
x3_up = mean(x3$PRTIME) + 2*sd(x3$PRTIME)
x3_dn = mean(x3$PRTIME) - 2*sd(x3$PRTIME)
#x3 = subset(x3, x3$PRTIME >= x3_dn & x3$PRTIME <= x3_up)
binsize=1
xmin <-min(x3$PRTIME)
xmin
xmax <-max(x3$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x3$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x3)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-3', 
sub=paste("(n=",nrow(x3),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-4
setEPS()
postscript("16_sec_pt_hist0_4.eps")
x4_up = mean(x4$PRTIME) + 2*sd(x4$PRTIME)
x4_dn = mean(x4$PRTIME) - 2*sd(x4$PRTIME)
#x4 = subset(x4, x4$PRTIME >= x4_dn & x4$PRTIME <= x4_up)
binsize=1
xmin <-min(x4$PRTIME)
xmin
xmax <-max(x4$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x4)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-4', 
sub=paste("(n=",nrow(x4),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-5
setEPS()
postscript("16_sec_pt_hist0_5.eps")
x5_up = mean(x5$PRTIME) + 2*sd(x5$PRTIME)
x5_dn = mean(x5$PRTIME) - 2*sd(x5$PRTIME)
#x5 = subset(x5, x5$PRTIME >= x5_dn & x5$PRTIME <= x5_up)
binsize=1
xmin <-min(x5$PRTIME)
xmin
xmax <-max(x5$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x5$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x5)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-5', 
sub=paste("(n=",nrow(x5),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

###########
### 16-1
setEPS()
postscript("16_sec_pt_hist1.eps")
x1_up = mean(x1$PRTIME) + 2*sd(x1$PRTIME)
x1_dn = mean(x1$PRTIME) - 2*sd(x1$PRTIME)
x1 = subset(x1, x1$PRTIME >= x1_dn & x1$PRTIME <= x1_up)
binsize=1
xmin <-min(x1$PRTIME)
xmin
xmax <-max(x1$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x1)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-1', 
sub=paste("(n=",nrow(x1),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-2
setEPS()
postscript("16_sec_pt_hist2.eps")
x2_up = mean(x2$PRTIME) + 2*sd(x2$PRTIME)
x2_dn = mean(x2$PRTIME) - 2*sd(x2$PRTIME)
x2 = subset(x2, x2$PRTIME >= x2_dn & x2$PRTIME <= x2_up)
binsize=1
xmin <-min(x2$PRTIME)
xmin
xmax <-max(x2$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x2$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x2)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-2', 
sub=paste("(n=",nrow(x2),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-3
setEPS()
postscript("16_sec_pt_hist3.eps")
x3_up = mean(x3$PRTIME) + 2*sd(x3$PRTIME)
x3_dn = mean(x3$PRTIME) - 2*sd(x3$PRTIME)
x3 = subset(x3, x3$PRTIME >= x3_dn & x3$PRTIME <= x3_up)
binsize=1
xmin <-min(x3$PRTIME)
xmin
xmax <-max(x3$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x3$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x3)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-3', 
sub=paste("(n=",nrow(x3),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-4
setEPS()
postscript("16_sec_pt_hist4.eps")
x4_up = mean(x4$PRTIME) + 2*sd(x4$PRTIME)
x4_dn = mean(x4$PRTIME) - 2*sd(x4$PRTIME)
x4 = subset(x4, x4$PRTIME >= x4_dn & x4$PRTIME <= x4_up)
binsize=1
xmin <-min(x4$PRTIME)
xmin
xmax <-max(x4$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x4)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-4', 
sub=paste("(n=",nrow(x4),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### 16-5
setEPS()
postscript("16_sec_pt_hist5.eps")
x5_up = mean(x5$PRTIME) + 2*sd(x5$PRTIME)
x5_dn = mean(x5$PRTIME) - 2*sd(x5$PRTIME)
x5 = subset(x5, x5$PRTIME >= x5_dn & x5$PRTIME <= x5_up)
binsize=1
xmin <-min(x5$PRTIME)
xmin
xmax <-max(x5$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x5$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x5)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16-5', 
sub=paste("(n=",nrow(x5),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC1
numSamples <- 30
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("1_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()


#########################################
### INC9
numSamples <- 1000
x = read.csv(file="INC9_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("9_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC9', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()



### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_pt_hist.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 1000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()





setEPS()
postscript("16_sec_pt_hist.eps")
#x <- subset(x, x$ITERNUM != 686 & x$ITERNUM != 700)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=1
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 16000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()





### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_pt_hist.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 1000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_pt_hist.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 2000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 400
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_pt_hist.eps")
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
#ymax <- 200
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
task_len <- 4000
sd(x$PRTIME)/task_len
binsize=1
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 27)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=1
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 8000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()


x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_pt_hist.eps")
#x <- subset(x, x$ITERNUM != 686 & x$ITERNUM != 700)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=1
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 16000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 433)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=1
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 32000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_pt_hist.eps")
#x <- subset(x, x$ITERNUM != 85 & x$ITERNUM != 89 & x$ITERNUM != 308 & x$ITERNUM != 312 & x$ITERNUM != 437 & x$ITERNUM != 437 & x$ITERNUM != 531 & x$ITERNUM != 535 & x$ITERNUM != 754 & x$ITERNUM != 758 & x$ITERNUM != 977 & x$ITERNUM != 981)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=1
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 64000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 250
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 26)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
binsize=2
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 128000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 199)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=2
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 256000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 114 & x$ITERNUM != 186 & x$ITERNUM != 285)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 512000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-120
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 17 & x$ITERNUM != 101 & x$ITERNUM != 184 & x$ITERNUM != 268)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 1024000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

### run on sodb10
x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_pt_hist.eps")
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 2048000
sd(x$PRTIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

### run on sodb12
x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("4096_sec_pt_hist.eps")
x <- subset(x, x$ITERNUM != 5 & x$ITERNUM != 26 & x$ITERNUM != 47 & x$ITERNUM != 68 & x$ITERNUM != 89 & x$ITERNUM != 110 & x$ITERNUM != 131 & x$ITERNUM != 152 & x$ITERNUM != 173 & x$ITERNUM != 195 & x$ITERNUM != 215 & x$ITERNUM != 236 & x$ITERNUM != 258 & x$ITERNUM != 278 & x$ITERNUM != 299) 
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
task_len <- 4096000
sd(x$PRTIME)/task_len
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-50
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="8192_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("8192_sec_pt_hist.eps")
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin <- xmin-2
xmax <-max(x$PRTIME)
xmax <- xmax+1
task_len <-8192
sd(x$PRTIME)/task_len 
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 40
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="16384_sec.dat",head=TRUE,sep="\t")
setEPS()
task_len <-16384
postscript("16384_sec_pt_hist.eps")
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
task_len <-16384
sd(x$PRTIME)/task_len 
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=10
xmin <-min(x$PRTIME)
xmin <- xmin-7
xmax <-max(x$PRTIME)
xmax <- xmax+5
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 20
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()
