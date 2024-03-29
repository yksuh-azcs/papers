### sodb9
numSamples <- 1000
x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("1_sec_et_hist_v5.eps")
binsize=1
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 1000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC1', sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("2_sec_et_hist_v5.eps")
binsize=1
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
xmin <-min(x$METIME)
xmax <-max(x$METIME)
task_len <- 2000
sd(x$METIME)/task_len
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-1,xmax+1),col="blue", main='ET frequency on INC2', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("4_sec_et_hist_v5.eps")
binsize=1
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 4000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 80
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC4', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_et_hist_v5.eps")
binsize=1
x <- subset(x, x$ITERNUM != 27)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 8000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 150
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC8', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("16_sec_et_hist_v5.eps")
binsize=1
#x <- subset(x, x$ITERNUM != 686 & x$ITERNUM != 700)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 16000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC16', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("32_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 433)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=1
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 32000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 120
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC32', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("64_sec_et_hist_v5.eps")
#x <- subset(x, x$ITERNUM != 85 & x$ITERNUM != 89 & x$ITERNUM != 308 & x$ITERNUM != 312 & x$ITERNUM != 437 & x$ITERNUM != 437 & x$ITERNUM != 531 & x$ITERNUM != 535 & x$ITERNUM != 754 & x$ITERNUM != 758 & x$ITERNUM != 977 & x$ITERNUM != 981)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=1
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 64000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 60
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC64', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,1))
dev.off()

x = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("128_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 26)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 128000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 80
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax),col="blue", main='ET frequency on INC128', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=h$mids,labels=seq(xmin,xmax,binsize))
dev.off()

x = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("256_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 199)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 256000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 80
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC256', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("512_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 114 & x$ITERNUM != 186 & x$ITERNUM != 285)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 512000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 60
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC512', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 17 & x$ITERNUM != 101 & x$ITERNUM != 184 & x$ITERNUM != 268)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 1024000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC1024', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("2048_sec_et_hist_v5.eps")
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=5
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 2048000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 80
plot(h,  xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC2048', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

### run on sodb12
x = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("4096_sec_et_hist_v5.eps")
x <- subset(x, x$ITERNUM != 5 & x$ITERNUM != 26 & x$ITERNUM != 47 & x$ITERNUM != 68 & x$ITERNUM != 89 & x$ITERNUM != 110 & x$ITERNUM != 131 & x$ITERNUM != 152 & x$ITERNUM != 173 & x$ITERNUM != 195 & x$ITERNUM != 215 & x$ITERNUM != 236 & x$ITERNUM != 258 & x$ITERNUM != 278 & x$ITERNUM != 299) 
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=5
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
task_len <- 4096000
sd(x$METIME)/task_len
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='ET frequency on INC4096', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()
