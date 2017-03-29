### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_et_hist_v5.eps")
binsize=1
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$METIME)
xmax <-max(x$METIME)
plot(h, axes = TRUE,freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-1,xmax+1),col="blue", main='ET frequency on INC1', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
xaxtl <- seq(xmin-1,xmax+1,by=1)
axis(side=1, at=xaxtl, labels=xaxtl)
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_et_hist_v5.eps")
binsize=1
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$METIME)
xmax <-max(x$METIME)
plot(h, axes = TRUE,freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-1,xmax+1),col="blue", main='ET frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
xaxtl <- seq(xmin-1,xmax+1,by=1)
axis(side=1, at=xaxtl, labels=xaxtl)
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_et_hist_v5.eps")
binsize=1
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 80
xmin <-min(x$METIME)
xmax <-max(x$METIME)
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-2,xmax+2),col="blue", main='ET frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1, at=xaxtl, labels=xaxtl)
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_et_hist_v5.eps")
binsize=1
x <- subset(x, x$ITERNUM != 948)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 150
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-binsize-5,xmax+binsize+1),col="blue", main='ET frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_et_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 686 & x$ITERNUM != 700)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-3,xmax+2),col="blue", main='ET frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_et_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 433)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=1
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 120
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-6,xmax+5),col="blue", main='ET frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
#xaxtl <- seq(xmin-1,xmax+1,by=1)
#axis(side=1, at=xaxtl, labels=xaxtl)
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 578)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=1
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 60
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-4,xmax+4),col="blue", main='ET frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_et_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 26)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=1
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 60
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-4,xmax+4),col="blue", main='ET frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 81)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 80
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-5,xmax+5),col="blue", main='ET frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()


x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 58 & x$ITERNUM != 226)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-4,xmax+4),col="blue", main='ET frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()


x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 46 & x$ITERNUM != 130 & x$ITERNUM != 214 & x$ITERNUM != 299)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 60
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-10,xmax+10),col="blue", main='ET frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

### run on sodb10
x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 166)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=5
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 100
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-50,xmax+50),col="blue", main='ET frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

### run on sodb12
x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("4096_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 11 & x$ITERNUM != 32 & x$ITERNUM != 53 & x$ITERNUM != 74 & x$ITERNUM != 95 & x$ITERNUM != 116 & x$ITERNUM != 137 & x$ITERNUM != 158 & x$ITERNUM != 179 & x$ITERNUM != 200 & x$ITERNUM != 221 & x$ITERNUM != 242 & x$ITERNUM != 264) 
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=5
x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-50,xmax+50),col="blue", main='ET frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

