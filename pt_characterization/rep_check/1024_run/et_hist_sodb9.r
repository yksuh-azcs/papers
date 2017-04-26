### sodb9 
### 1st run
### INC1024 with 300 samples: taking 3.5 days.
x = read.csv(file="1024_sec1.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_et_hist1.eps")
x <- subset(x, x$ITERNUM != 40 & x$ITERNUM != 124 & x$ITERNUM != 207 & x$ITERNUM != 292)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="1024_sec2.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_et_hist2.eps")
x <- subset(x, x$ITERNUM != 75 & x$ITERNUM != 159 & x$ITERNUM != 243)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()

x = read.csv(file="1024_sec3.dat",head=TRUE,sep="\t")
setEPS()
postscript("1024_sec_et_hist3.eps")
x <- subset(x, x$ITERNUM != 27 & x$ITERNUM != 111 & x$ITERNUM != 195 & x$ITERNUM != 280)
x_up = mean(x$METIME) + 2*sd(x$METIME)
x_dn = mean(x$METIME) - 2*sd(x$METIME)
binsize=2
#x = subset(x, x$METIME >= x_dn & x$METIME <= x_up)
xmin <-min(x$METIME)
xmin
xmax <-max(x$METIME)
xmax
nbins <- ceiling((xmax-xmin) / binsize)
h = hist(x$METIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
ymax <- max(h$counts)
ymax <- ceiling(ymax/100)*100
ymax <- max(h$counts)
ymax <- 50
plot(h, xaxt="n",freq=TRUE,ylim=c(0,ymax), col="blue", main='', 
sub=paste("(n=",nrow(x),", bin_size=",binsize,"ms)",sep=""), 
xlab='ET (ms)', ylab=expression('Frequency'))
axis(side=1,at=seq(min(h$mids),max(h$mids)+binsize,binsize),labels=seq(ceiling(min(h$mids)),ceiling(max(h$mids))+binsize,binsize))
dev.off()
