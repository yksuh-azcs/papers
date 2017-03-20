x = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("1_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), ylim=c(min(x$METIME), max(x$METIME)), pch=1, main='', xlab='Iterations', ylab='ET (msec)')
dev.off()

x = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("2_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), ylim=c(min(x$METIME), max(x$METIME)), pch=1, main='', xlab='Iterations', ylab='ET (msec)')
dev.off()

x = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("4_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), ylim=c(min(x$METIME), max(x$METIME)), pch=1, main='', xlab='Iterations', ylab='ET (msec)')
dev.off()

x = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("8_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), ylim=c(min(x$METIME), max(x$METIME)), pch=1, main='', xlab='Iterations', ylab='ET (msec)')
dev.off()

x = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("16_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), ylim=c(16400,17400), pch=1, main='', xlab='Iterations', ylab='ET (msec)')
dev.off()

x = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
setEPS()
postscript("32_sec_et_all.eps")
plot(x$METIME, xlim=c(0,1000), ylim=c(33000, 34000), pch=1, main='', xlab='Iterations', ylab='ET (msec)')
dev.off()

