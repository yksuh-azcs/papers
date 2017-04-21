### sodb9
numSamples <- 10000
x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_et_hist_v5.eps")
binsize=1
x <- subset(x, x$ITERNUM != 9394)
#x_up = mean(x$METIME) + 2*sd(x$METIME)
#x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 4000
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC8 with 10K samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

numSamples <- 10000
x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_et_hist_v5.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 9394)
#x_up = mean(x$METIME) + 2*sd(x$METIME)
#x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 2500
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC16 with 10K samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 9394)
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 4000
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC8 with 10K samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_pt_hist_v5.eps")
binsize=1
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 4000
plot(h, xaxt='n', freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC16 with 10K samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()
