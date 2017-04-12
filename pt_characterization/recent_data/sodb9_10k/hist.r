### sodb9
numSamples <- 10000

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_et_hist_v5.eps")
binsize=1
x <- subset(x, x$ITERNUM != 27)
#x_up = mean(x$METIME) + 2*sd(x$METIME)
#x_dn = mean(x$METIME) - 2*sd(x$METIME)
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
nbins <- ceiling((max(x$METIME)-min(x$METIME)) / binsize)
h = hist(x$METIME, right=F, breaks=nbins,plot=F)
xmin <-min(x$METIME)
xmax <-max(x$METIME)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 150
plot(h, freq=TRUE,ylim=c(0,ymax), xlim=c(xmin-binsize-5,xmax+binsize+1),col="blue", main='ET frequency on INC8 with 10K samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
setEPS()
postscript("8_sec_pt_hist_v5.eps")
x <- subset(x, x$ITERNUM != 27)
#x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
#x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
h = hist(x$PRTIME, right=F,breaks=max(x$PRTIME)-min(x$PRTIME)+1,plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
#ymax <- 100
binsize=1
plot(h, ylim=c(0,ymax), axes = TRUE,freq=TRUE,xlim=c(min(x$PRTIME)-4,max(x$PRTIME)+4),col="green", main='PT frequency on INC8 with 10K samples', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
dev.off()
