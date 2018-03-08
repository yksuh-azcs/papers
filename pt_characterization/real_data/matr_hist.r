### MATR1000
numSamples <- 40
x = read.csv(file="MATR250.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr250_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 20
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR250 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR500.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr500_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 35
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR500 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR1024.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr1024_dist2.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 20
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR1024 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR2048.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr2048_dist2.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR2048 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR4096.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr4096_dist2.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 10
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR4096 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR8192.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr8192_dist2.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 10
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR8192 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()


x = read.csv(file="MATR2000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr2000_dist.eps")
binsize=1
x <- subset(x, x$ITERNUM >= 6)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR2000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR4000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr4000_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM >= 6)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 10
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR4000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATR8000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr8000_dist.eps")
binsize=4
#x <- subset(x, x$ITERNUM >= 6)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
#ymax <- ceiling(ymax/100)*100
ymax <- 8
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR8000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

#### intermediates
numSamples <- 40
x = read.csv(file="MATR1440.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr1440_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 20
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR1440 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="MATR2880.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr2880_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR2880 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="MATR5760.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr5760_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR5760 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="MATR11520.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr11520_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR11520 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="MATR23040.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matr23040_dist.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATR23040 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()
