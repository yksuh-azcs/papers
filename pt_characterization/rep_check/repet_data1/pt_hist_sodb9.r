### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_pt_hist_v5.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
nbins <- ceiling((max(x$PRTIME)-min(x$PRTIME)) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, xaxt="n",axes = TRUE,freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_pt_hist_v5.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
nbins <- ceiling((max(x$PRTIME)-min(x$PRTIME)) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 400
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="green", main='PT frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_pt_hist_v5.eps")
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 200
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
binsize=1
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 27)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
#ymax <- 100
binsize=1
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_pt_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 686 & x$ITERNUM != 700)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
#ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 433)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
#ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_pt_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 85 & x$ITERNUM != 89 & x$ITERNUM != 308 & x$ITERNUM != 312 & x$ITERNUM != 437 & x$ITERNUM != 437 & x$ITERNUM != 531 & x$ITERNUM != 535 & x$ITERNUM != 754 & x$ITERNUM != 758 & x$ITERNUM != 977 & x$ITERNUM != 981)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
ymax <- 250
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 26)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 60
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax-1))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 199)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
binsize=2
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids)),2))
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 114 & x$ITERNUM != 186 & x$ITERNUM != 285)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=5
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-120
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids)),5))
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 17 & x$ITERNUM != 101 & x$ITERNUM != 184 & x$ITERNUM != 268)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=5
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids)),5))
dev.off()

### run on sodb10
x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_pt_hist_v5.eps")
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
binsize=5
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids)),5))
dev.off()

### run on sodb12
x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("4096_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 5 & x$ITERNUM != 26 & x$ITERNUM != 47 & x$ITERNUM != 68 & x$ITERNUM != 89 & x$ITERNUM != 110 & x$ITERNUM != 131 & x$ITERNUM != 152 & x$ITERNUM != 173 & x$ITERNUM != 195 & x$ITERNUM != 215 & x$ITERNUM != 236 & x$ITERNUM != 258 & x$ITERNUM != 278 & x$ITERNUM != 299) 
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
binsize=5
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <-50
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='PT frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids)),5))
dev.off()
