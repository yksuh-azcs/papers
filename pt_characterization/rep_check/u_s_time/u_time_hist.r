### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_ut_hist.eps")
binsize=1
x <- subset(x, x$ITERNUM != 948)
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 578)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="96_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("96_sec_ut_hist.eps")
binsize=1
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 474)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+1,1),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC96', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_ut_hist.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
#x <- subset(x, x$ITERNUM != 578)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="128_sec2.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_ut_hist2.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 281 & x$ITERNUM != 949)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 300
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="160_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("160_sec_ut_hist.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 503)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC160', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="192_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("192_sec_ut_hist.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 26 & x$ITERNUM != 472 & x$ITERNUM != 922)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 250
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC192', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="224_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("224_sec_ut_hist.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 321 & x$ITERNUM !=704)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 200
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC224', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("256_sec_ut_hist.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 81)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 60
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="256_sec2.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("256_sec_ut_hist2.eps")
binsize=2
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 75 & x$ITERNUM != 409 & x$ITERNUM != 750)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 200
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("512_sec_ut_hist.eps")
binsize=5
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
#x <- subset(x, x$ITERNUM != 58 & x$ITERNUM != 226)
x <- subset(x, x$ITERNUM != 58 & x$ITERNUM != 186 & x$ITERNUM != 226)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-140
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1024_sec_ut_hist.eps")
binsize=5
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 46 & x$ITERNUM != 130 & x$ITERNUM != 214 & x$ITERNUM != 299)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-100
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2048_sec_ut_hist.eps")
binsize=5
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 166)
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
#axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4096_sec_ut_hist.eps")
binsize=5
#x = subset(x, x$U_TIME >= x_dn & x$U_TIME <= x_up)
x <- subset(x, x$ITERNUM != 11 & x$ITERNUM != 32 & x$ITERNUM != 53 & x$ITERNUM != 74 & x$ITERNUM != 95 & x$ITERNUM != 116 & x$ITERNUM != 137 & x$ITERNUM != 158 & x$ITERNUM != 179 & x$ITERNUM != 200 & x$ITERNUM != 221 & x$ITERNUM != 242 & x$ITERNUM != 264) 
xmin <-min(x$U_TIME)
xmax <-max(x$U_TIME)
xmin
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 50
plot(h, xaxt='n', axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="orange",  main='User time frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='User time (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()
