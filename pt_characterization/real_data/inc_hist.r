### INC8.8
numSamples <- 300
x = read.csv(file="INC8.8.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("inc8.8_dist.eps")
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
ymax <- 100
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on INC8.8 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC13.0
numSamples <- 300
x = read.csv(file="INC13.0.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("inc13.0_dist.eps")
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
ymax <- 150
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on INC13.0 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC17.2
numSamples <- 300
x = read.csv(file="INC17.2.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("inc17.2_dist.eps")
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
ymax <- 60
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on INC17.2 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC25.8
numSamples <- 300
x = read.csv(file="INC25.8.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("inc25.8_dist.eps")
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
ymax <- 80
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on INC25.8 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC35.0
numSamples <- 300
x = read.csv(file="INC35.0.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("inc35.0_dist.eps")
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
ymax <- 80
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on INC35.0 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### INC51.5
numSamples <- 300
x = read.csv(file="INC51.5.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("inc51.5_dist.eps")
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
ymax <- 120
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on INC51.5 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()
