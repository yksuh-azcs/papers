### SORT10
numSamples <- 40
x = read.csv(file="SORT100.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort100_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT100 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="SORT200.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort200_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT200 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="SORT400.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort400_dist.eps")
binsize=2
#x <- subset(x, x$ITERNUM != 9394)
x_up = mean(x$PRTIME) + 1*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 1*sd(x$PRTIME)
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
ymax
#ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT400 with 40 samples (one st. dev. used)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="SORT800.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort800_dist.eps")
binsize=2
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
ymax
#ymax <- ceiling(ymax/100)*100
ymax <- 8
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT800 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="SORT1600.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort1600_dist.eps")
binsize=2
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
ymax
#ymax <- ceiling(ymax/100)*100
ymax <- 4
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT1600 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="SORT3200.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort3200_dist.eps")
binsize=2
x <- subset(x, x$ITERNUM != 3 | x$ITERNUM != 6 | x$ITERNUM != 10)
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
ymax
#ymax <- ceiling(ymax/100)*100
ymax <- 4
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT3200 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()
