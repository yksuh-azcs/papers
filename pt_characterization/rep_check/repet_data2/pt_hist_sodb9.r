### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_pt_hist_v5.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
nbins <- ceiling((max(x$PRTIME)-min(x$PRTIME)) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, axes = TRUE,freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-1,xmax+1),col="green", main='PT frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
xaxtl <- seq(xmin-1,xmax+1,by=1)
axis(side=1, at=xaxtl, labels=xaxtl)
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_pt_hist_v5.eps")
binsize=1
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
nbins <- ceiling((max(x$PRTIME)-min(x$PRTIME)) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 250
xmin <-min(x$PRTIME)
xmax <-max(x$PRTIME)
plot(h, axes = TRUE,freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-1,xmax+1),col="green", main='PT frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
xaxtl <- seq(xmin-1,xmax+1,by=1)
axis(side=1, at=xaxtl, labels=xaxtl)
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_pt_hist_v5.eps")
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 200
binsize=1
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-2,max(x$PRTIME)+4),col="green", main='PT frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 948)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
binsize=1
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+4),col="green", main='PT frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_pt_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 686 & x$ITERNUM != 700)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-8,max(x$PRTIME)+8),col="green", main='PT frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_pt_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 433)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-5,max(x$PRTIME)+9),col="green", main='PT frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 578)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-5,max(x$PRTIME)+7),col="green", main='PT frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_pt_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 26)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 50
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+5),col="green", main='PT frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 81)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
binsize=1
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 40
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+5),col="green", main='PT frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 58 & x$ITERNUM != 226)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=2
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 50
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+5),col="green", main='PT frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 46 & x$ITERNUM != 130 & x$ITERNUM != 214 & x$ITERNUM != 299)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 30
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+5),col="green", main='PT frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

### run on sodb10
x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 166)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 20
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-9,max(x$PRTIME)+10),col="green", main='PT frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()

### run on sodb12
x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("4096_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 11 & x$ITERNUM != 32 & x$ITERNUM != 53 & x$ITERNUM != 74 & x$ITERNUM != 95 & x$ITERNUM != 116 & x$ITERNUM != 137 & x$ITERNUM != 158 & x$ITERNUM != 179 & x$ITERNUM != 200 & x$ITERNUM != 221 & x$ITERNUM != 242 & x$ITERNUM != 264) 
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
xmax <- max(x$PRTIME)
xmin <- min(x$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=nbins,plot=F)
binsize=1
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 15
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+10),col="green", main='PT frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()
