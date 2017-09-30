x1_1 = read.csv(file="repet_data1/1_sec.dat",head=TRUE,sep="\t")
x1_2 = read.csv(file="repet_data2/1_sec.dat",head=TRUE,sep="\t")
x1_ <- c(x1_1$PRTIME, x1_2$PRTIME)
x1_ <- cbind(x1_)
x1_n <- seq.int(nrow(x1_))
x1_ <- cbind(x1_n,x1_)
colnames(x1_) <- c("NUM", "PRTIME")
write.table(x1_, "final_data/1_sec.dat", sep="\t",row.names = F)
x1_up = mean(x1_[,2]) + 2*sd(x1_[,2])
x1_dn = mean(x1_[,2]) - 2*sd(x1_[,2])
x1_ = subset(x1_, x1_[,2] >= x1_dn & x1_[,2] <= x1_up)
xmax <- max(x1_[,2])
xmin <- min(x1_[,2])
binsize <- 1
nbins <- ceiling((xmax-xmin) / binsize)
h1_ = hist(x1_[,2], right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
h1 = h1_
x1_pt <- round((h1_$breaks-min(h1_$breaks))/(max(h1_$breaks-min(h1_$breaks)))*100,0)
x1_pt
z1_pt <- round(h1_$counts/max(h1_$counts)*100,0)
z1_pt



## 2 sec
x2_1 = read.csv(file="repet_data1/2_sec.dat",head=TRUE,sep="\t")
x2_2 = read.csv(file="repet_data2/2_sec.dat",head=TRUE,sep="\t")
x2 <- c(x2_1$PRTIME, x2_2$PRTIME)
x2 <- cbind(x2)
x2_n <- seq.int(nrow(x2))
x2 <- cbind(x2_n,x2)
colnames(x2) <- c("NUM", "PRTIME")
write.table(x2, "final_data/2_sec.dat", sep="\t",row.names = F)
x2_up = mean(x2[,2]) + 2*sd(mean(x2[,2]))
x2_dn = mean(x2[,2]) + 2*sd(mean(x2[,2]))
xmax <- max(x2[,2])
xmin <- min(x2[,2])
binsize <- 1
nbins <- ceiling((xmax-xmin) / binsize)
h2_ = hist(x2[,2], right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
h2 = h2_
x2_pt <- round((h1$breaks-min(h1$breaks))/(max(h1$breaks-min(h1$breaks)))*100,0)
x2_pt
z2_pt <- round(h1$counts/max(h1$counts)*100,3)
z2_pt



