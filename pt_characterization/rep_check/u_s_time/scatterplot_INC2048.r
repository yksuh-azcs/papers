numSamples <- 300
x = read.csv(file="INC2048_per_iter_detailed.dat",head=TRUE,sep="\t")
corr(x$U_TIME, x$S_TIME)

numSamples <- 300
x = read.csv(file="per_iter_detailed.dat",head=TRUE,sep="\t")
min(x$S_TIME)
corr(x$U_TIME, x$S_TIME)
