### SORT144
numSamples <- 300
x = read.csv(file="SORT144.0.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort144_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT144 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### new SORT177
numSamples <- 300
x = read.csv(file="SORT177.0.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort177_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT177 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### SORT200
numSamples <- 300
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
ymax <- 100
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT200 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### SORT244
numSamples <- 300
x = read.csv(file="SORT244.0.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort244_dist.eps")
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
ymax <- 50
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT244 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### SORT288
numSamples <- 300
x = read.csv(file="SORT288.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort288_dist.eps")
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
ymax <- 50
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT288 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

### SORT344
numSamples <- 300
x = read.csv(file="SORT344.0.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("sort344_dist.eps")
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
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='PT frequency on SORT344 (sample size: 300)', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
#axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()
