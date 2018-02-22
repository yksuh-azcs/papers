### MATC1000
numSamples <- 40
x = read.csv(file="MATC1000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matc1000_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATC1000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATC2000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matc2000_dist.eps")
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
ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATC2000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATC4000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matc4000_dist.eps")
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
ymax <- ceiling(ymax/100)*100
ymax <- 8
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATC4000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="MATC8000.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("matc8000_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on MATC8000 with 40 samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()
