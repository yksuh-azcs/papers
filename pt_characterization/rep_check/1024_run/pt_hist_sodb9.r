### sodb9
### 1st run
### INC1024 with 300 samples: taking 3.5 days.
numSamples <- 300
x = read.csv(file="1024_sec1.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_pt_hist1.eps")
x <- subset(x, x$ITERNUM != 40 & x$ITERNUM != 124 & x$ITERNUM != 207 & x$ITERNUM != 292)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

numSamples <- 300
x = read.csv(file="1024_sec2.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_pt_hist2.eps")
x <- subset(x, x$ITERNUM != 75 & x$ITERNUM != 159 & x$ITERNUM != 243)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

numSamples <- 300
x = read.csv(file="1024_sec3.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_pt_hist3.eps")
x <- subset(x, x$ITERNUM != 27 & x$ITERNUM != 111 & x$ITERNUM != 195 & x$ITERNUM != 280)
x_up = mean(x$PRTIME) + 2*sd(x$PRTIME)
x_dn = mean(x$PRTIME) - 2*sd(x$PRTIME)
#x = subset(x, x$PRTIME >= x_dn & x$PRTIME <= x_up)
binsize=5
xmin <-min(x$PRTIME)
xmin
xmax <-max(x$PRTIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- 100
plot(h, ylim=c(0,ymax), xaxt="n",freq=TRUE,col="green", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='PT (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()
