numSamples <- 300
x = read.csv(file="per_iter_detailed.dat",head=TRUE,sep="\t")
corr(x$U_TIME, x$S_TIME)

### sodb9
numSamples <- 300
x = read.csv(file="per_iter_detailed.dat",head=TRUE,sep="\t")
x <- subset(x, x$ITERNUM <= numSamples)
min_stime <- min(x$S_TIME)
min_stime <- floor(min_stime/10)*10
max_stime <- max(x$S_TIME)
max_stime <- ceiling(max_stime/10)*10
min_mnflt <- min(x$ALL_MIN_FLT)
min_mnflt <- floor(min_mnflt/1000)*1000
min_mnflt <-0
max_mnflt <- max(x$ALL_MIN_FLT)
max_mnflt <- ceiling(max_mnflt/1000)*1000
setEPS()
postscript("corr_mnf_s_time.eps")
plot(x$S_TIME, x$ALL_MIN_FLT,xlim=c(min_stime,max_stime), 
ylim=c(min_mnflt,max_mnflt),
pch=1, main='', xlab='System time (ms)', ylab='All daemon minor faults')
dev.off()

min_utime <- min(x$U_TIME)
min_utime <- floor(min_utime/10)*10
max_utime <- max(x$U_TIME)
max_utime <- ceiling(max_utime/10)*10
min_mnflt <- min(x$ALL_MIN_FLT)
min_mnflt <- floor(min_mnflt/1000)*1000
min_mnflt <-0
max_mnflt <- max(x$ALL_MIN_FLT)
max_mnflt <- ceiling(max_mnflt/1000)*1000
setEPS()
postscript("corr_mnf_u_time.eps")
plot(x$U_TIME, x$ALL_MIN_FLT,xlim=c(min_utime,max_utime), 
ylim=c(min_mnflt,max_mnflt),
pch=1, main='', xlab='User time (ms)', ylab='All daemon minor faults')
dev.off()

min_utime <- min(x$U_TIME)
min_utime <- floor(min_utime/10)*10
max_utime <- max(x$U_TIME)
max_utime <- ceiling(max_utime/10)*10
min_astime <- min(x$ALL_S_TIME)
min_astime <- floor(min_astime/10)*10
max_astime <- max(x$ALL_S_TIME)
max_astime <- ceiling(max_astime/10)*10
setEPS()
postscript("corr_u_as_time.eps")
plot(x$U_TIME, x$ALL_S_TIME,xlim=c(min_utime,max_utime), 
ylim=c(min_astime,max_astime),
pch=1, main='', xlab='User time (ms)', ylab='All daemon system time (ms)')
dev.off()

min_stime <- min(x$S_TIME)
min_stime <- floor(min_stime/10)*10
max_stime <- max(x$S_TIME)
max_stime <- ceiling(max_stime/10)*10
min_astime <- min(x$ALL_S_TIME)
min_astime <- floor(min_astime/10)*10
max_astime <- max(x$ALL_S_TIME)
max_astime <- ceiling(max_astime/10)*10
setEPS()
postscript("corr_s_as_time.eps")
plot(x$S_TIME, x$ALL_S_TIME,xlim=c(min_stime,max_stime), 
ylim=c(min_astime,max_astime),
pch=1, main='', xlab='System time (ms)', ylab='All daemon system time (ms)')
dev.off()

min_stime <- min(x$S_TIME)
min_stime <- floor(min_stime/10)*10
max_stime <- max(x$S_TIME)
max_stime <- ceiling(max_stime/10)*10
min_rchar <- min(x$ALL_READ_CHAR)
min_rchar <- floor(min_rchar/1000000)*1000000
max_rchar <- max(x$ALL_READ_CHAR)
max_rchar <- ceiling(max_rchar/1000000)*1000000
setEPS()
postscript("corr_s_rchar.eps")
plot(x$S_TIME, x$ALL_READ_CHAR,xlim=c(min_stime,max_stime), 
ylim=c(min_rchar,max_rchar),
pch=1, main='', xlab='System time (ms)', ylab='All daemon read chars')
dev.off()

min_stime <- min(x$S_TIME)
min_stime <- floor(min_stime/10)*10
max_stime <- max(x$S_TIME)
max_stime <- ceiling(max_stime/10)*10
min_rsysc <- min(x$ALL_READ_SYSCALLS)
min_rsysc <- floor(min_rchar/1000)*1000
max_rsysc <- max(x$ALL_READ_SYSCALLS)
max_rsysc <- 1500
setEPS()
postscript("corr_s_rsysc.eps")
plot(x$S_TIME, x$ALL_READ_SYSCALLS,xlim=c(min_stime,max_stime), 
ylim=c(min_rsysc,max_rsysc),
pch=1, main='', xlab='System time (ms)', ylab='All daemon read syscalls')
dev.off()

min_stime <- min(x$S_TIME)
min_stime <- floor(min_stime/10)*10
max_stime <- max(x$S_TIME)
max_stime <- ceiling(max_stime/10)*10
min_wbytes <- min(x$ALL_WRITE_BYTES)
min_wbytes <- floor(min_wbytes/100000)*100000
max_wbytes <- max(x$ALL_WRITE_BYTES)
max_wbytes <- ceiling(max_wbytes/100000)*100000
setEPS()
postscript("corr_s_wbytes.eps")
plot(x$S_TIME, x$ALL_WRITE_BYTES,xlim=c(min_stime,max_stime), 
ylim=c(min_wbytes,max_wbytes),
pch=1, main='', xlab='System time (ms)', ylab='All daemon write bytes')
dev.off()


min_stime <- min(x$S_TIME)
min_stime <- floor(min_stime/10)*10
max_stime <- max(x$S_TIME)
max_stime <- ceiling(max_stime/10)*10
min_wchar <- min(x$ALL_WRITE_CHAR)
min_wchar <- floor(min_wchar/10000)*10000
max_wchar <- max(x$ALL_WRITE_CHAR)
max_wchar <- ceiling(max_wchar/10000)*10000
setEPS()
postscript("corr_s_wchar.eps")
plot(x$S_TIME, x$ALL_WRITE_CHAR,xlim=c(min_stime,max_stime), 
ylim=c(min_wchar,max_wchar),
pch=1, main='', xlab='System time (ms)', ylab='All daemon write char')
dev.off()
