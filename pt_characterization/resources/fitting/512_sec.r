x = read.csv(file="result_summary/512_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("result_summary/512_sec_ect_all.eps")
plot(x$METIME, xlim=c(0,300), pch=19, main='ECT on 512-second task', xlab='# of executions', ylab='ECT (ms)')
dev.off()
setEPS()
hist.data = hist(x$METIME, breaks = 100, plot=F)
postscript("result_summary/512_sec_ect_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, xaxt='n', yaxt='n', type='h', lwd=5, lend=2, main='ECT frequency on 512-second task', xlab='ECT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
xaxtl <- seq(0,ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300,by=100)
axis(side=2, at=axt, labels=axt)
dev.off()
setEPS()
postscript("result_summary/512_sec_pt_all.eps")
plot(x$PRTIME, xlim=c(0,300), pch=19, main='PT on 512-second task', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x$PRTIME, breaks = 100, plot=F)
postscript("result_summary/512_sec_pt_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, xaxt='n', type='h', lwd=5, lend=2, main='PT frequency on 512-second task', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,300, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

