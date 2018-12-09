### sodb9


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

### INC10
numSamples <- 1000
x = read.csv(file="INC10_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("10_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC10', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC11
numSamples <- 1000
x = read.csv(file="INC11_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("11_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC11', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC13
numSamples <- 1000
x = read.csv(file="INC13_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("13_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC13', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC14
numSamples <- 1000
x = read.csv(file="14_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("14_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(floor(h$mids),h$counts)
write.table(y, file = "84_summary.txt", sep = " ")
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC14', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC15
numSamples <- 1000
x = read.csv(file="INC15_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("15_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC15', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

#######################################################################################################
###INC17
numSamples <- 1000 
INC_Num <- 17
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

###INC18
INC_Num <- 18
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

###INC19
INC_Num <- 19
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

###INC20
INC_Num <- 20
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 21
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 22
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 23
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

###INC24
INC_Num <- 24
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

###INC74
INC_Num <- 74
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 76
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 78
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 82
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 84
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

INC_Num <- 86
filename <- paste(INC_Num, "_sec.dat", sep="")
x = read.csv(file=filename,head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(INC_Num,floor(h$mids),h$counts)
write.table(y, file = "summary.txt", append = TRUE, col.names = FALSE, quote = FALSE, row.names = FALSE, sep = "\t")

#######################################################################################################
###INC1
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()


x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist.eps")
binsize=1
x <- subset(x, x$ITERNUM != 948)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 578)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

###INC84
numSamples <- 1000
x = read.csv(file="84_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("84_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(floor(h$mids),h$counts)
write.table(y, file = "84_summary.txt", sep = " ")
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC84', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

###INC92
numSamples <- 1000
x = read.csv(file="92_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("92_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(floor(h$mids),h$counts)
write.table(y, file = "92_summary.txt", sep = " ")
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC92', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

###INC100
numSamples <- 1000
x = read.csv(file="100_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("100_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(floor(h$mids),h$counts)
write.table(y, file = "100_summary.txt", sep = " ")
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC100', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

###INC108
numSamples <- 1000
x = read.csv(file="108_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME);
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME);
#x <- subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up);
setEPS()
postscript("108_sec_pt_hist.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
nrow(x)
h
y <- cbind(floor(h$mids),h$counts)
write.table(y, file = "108_summary.txt", sep = " ")
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC108', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_pt_hist.eps")
binsize=2
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
#x <- subset(x, x$ITERNUM != 281 & x$ITERNUM != 949)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("256_sec_pt_hist.eps")
binsize=2
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 81)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="256_sec2.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("256_sec_pt_hist2.eps")
binsize=2
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 75 & x$ITERNUM != 409 & x$ITERNUM != 750)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 200
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("512_sec_pt_hist.eps")
binsize=5
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
#x <- subset(x, x$ITERNUM != 58 & x$ITERNUM != 226)
x <- subset(x, x$ITERNUM != 58 & x$ITERNUM != 186 & x$ITERNUM != 226)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-120
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1024_sec_pt_hist.eps")
binsize=5
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 46 & x$ITERNUM != 130 & x$ITERNUM != 214 & x$ITERNUM != 299)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2048_sec_pt_hist.eps")
binsize=5
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 166)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4096_sec_pt_hist.eps")
binsize=5
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 11 & x$ITERNUM != 32 & x$ITERNUM != 53 & x$ITERNUM != 74 & x$ITERNUM != 95 & x$ITERNUM != 116 & x$ITERNUM != 137 & x$ITERNUM != 158 & x$ITERNUM != 179 & x$ITERNUM != 200 & x$ITERNUM != 221 & x$ITERNUM != 242 & x$ITERNUM != 264) 
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 60
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

#################
numSamples <- 1000
x = read.csv(file="3_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("3_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
sd(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC3', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

numSamples <- 1000
x = read.csv(file="6_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("6_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
sd(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC6', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="12_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("12_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
sd(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC12', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="24_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("24_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM !=951)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
sd(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC24', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="48_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("48_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
sd(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- 150
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC48', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="72_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("72_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM !=523)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
sd(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC72', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="80_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("80_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM !=625)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC80', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="88_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("88_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 639)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- 200
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC88', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="96_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("96_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 474)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC96', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="104_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("104_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 639)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- 150
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC104', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="112_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("112_sec_pt_hist.eps")
binsize=1
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 327)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC112', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="120_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("120_sec_pt_hist.eps")
#binsize=1
binsize=2
x <- subset(x, x$ITERNUM != 80 & x$ITERNUM != 797)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 300
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC120', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="160_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("160_sec_pt_hist.eps")
binsize=2
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 503)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC160', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="192_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("192_sec_pt_hist.eps")
binsize=2
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 26 & x$ITERNUM != 472 & x$ITERNUM != 922)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC192', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="224_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("224_sec_pt_hist.eps")
binsize=2
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
x <- subset(x, x$ITERNUM != 321 & x$ITERNUM !=704)
sd(x$PRTIME)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 200
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green",  main='PT frequency on INC224', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

