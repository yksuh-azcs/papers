x = read.csv(file="result_summary/4_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("result_summary/4_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), pch=19, main='', xlab='# of executions', ylab='ET (ms)')
dev.off()
setEPS()
hist.data = hist(x$METIME, breaks = 100, plot=F)
postscript("result_summary/4_sec_et_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, xaxt='n', yaxt='n', log='y', type='h', lwd=5, lend=2, main='', xlab='ET (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
xaxtl <- seq(0,ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,1000,by=100)
axis(side=2, at=axt, labels=axt)
dev.off()
setEPS()
postscript("result_summary/4_sec_pt_all.eps")
plot(x$PRTIME, xlim=c(0,1000), pch=19, main='', xlab='# of executions', ylab='PT (ms)')
dev.off()
setEPS()
hist.data = hist(x$PRTIME, breaks = 100, plot=F)
postscript("result_summary/4_sec_pt_hist.eps")
counts = hist.data$counts
breaks = hist.data$breaks[0:(length(hist.data$breaks)-1)]
plot(breaks, counts, xaxt='n', log='y', type='h', lwd=5, lend=2, main='', xlab='PT (ms)', ylab=expression('Frequency'))
delta=max(breaks)-min(breaks)
xaxtl <- seq(floor(min(breaks)-delta/2),ceiling(max(breaks)+delta/2),by=(ceiling((delta/2)/100)*5))
axis(side=1, at=xaxtl, labels=xaxtl)
axt <- seq(0,1000, by=50)
axis(side=2, at=axt, labels=axt)
dev.off()

