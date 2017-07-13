#### An R script for 3D plot
require(rgl)
library(plot3D)
numSamples <- 1000
### 1 sec
x1 = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
binsize=1
xmin <-min(x1$PRTIME)
xmax <-max(x1$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1 = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1_pt <- (h1$mids-1000)/1
y1_raw_pt <- 1
y1_pt <- 0
z1_pt <- h1$counts/numSamples
z1_raw_pt <- h1$counts
inc1 <- rep(1,length(h1$mids))
ss_inc1 <- rep(numSamples,length(h1$mids)) 
### 2 sec
x2 = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x2 <- subset(x2, x2$ITERNUM <= numSamples)
xmin <-min(x2$PRTIME)
xmax <-max(x2$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2 = hist(x2$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2_pt <- (h2$mids-2000)/2
y2_raw_pt <- 2
y2_pt <- 1
z2_pt <- h2$counts/numSamples
z2_raw_pt <- h2$counts
inc2 <- rep(2,length(h2$mids))
ss_inc2 <- rep(numSamples,length(h2$mids)) 
### 4 sec
x4 = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x4 <- subset(x4, x4$ITERNUM <= numSamples)
xmin <-min(x4$PRTIME)
xmax <-max(x4$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4 = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4_pt <- (h4$mids-4000)/4
y4_raw_pt <- 4
y4_pt <- 2
z4_pt <- h4$counts/numSamples
z4_raw_pt <- h4$counts
inc4 <- rep(4,length(h4$mids))
ss_inc4 <- rep(numSamples,length(h4$mids)) 
### 8 sec
x8 = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x8 <- subset(x8, x8$ITERNUM <= numSamples)
x8 <- subset(x8, x8$ITERNUM != 27)
xmin <-min(x8$PRTIME)
xmax <-max(x8$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h8 = hist(x8$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x8_pt <- (h8$mids-8000)/8
y8_raw_pt <- 8
y8_pt <- 3
z8_pt <- h8$counts/numSamples
z8_raw_pt <- h8$counts
inc8 <- rep(8,length(h8$mids))
ss_inc8 <- rep(numSamples,length(h8$mids)) 
### 16 sec
x16 = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x16 <- subset(x16, x16$ITERNUM <= numSamples)
xmin <-min(x16$PRTIME)
xmax <-max(x16$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h16 = hist(x16$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x16_pt <- (h16$mids-16000)/16
y16_raw_pt <- 16
y16_pt <- 4
z16_pt <- h16$counts/numSamples
z16_raw_pt <- h16$counts
inc16 <- rep(16,length(h16$mids))
ss_inc16 <- rep(numSamples,length(h16$mids)) 
### 32 sec
x32 = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x32 <- subset(x32, x32$ITERNUM <= numSamples)
x32 <- subset(x32, x32$ITERNUM != 433)
xmin <-min(x32$PRTIME)
xmax <-max(x32$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h32 = hist(x32$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x32_pt <- (h32$mids-32000)/32
y32_raw_pt <- 32
y32_pt <- 5
z32_pt <- h32$counts/numSamples
z32_raw_pt <- h32$counts
inc32 <- rep(32,length(h32$mids))
ss_inc32 <- rep(numSamples,length(h32$mids)) 
### 64 sec
x64 = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x64 <- subset(x64, x64$ITERNUM <= numSamples)
xmin <-min(x64$PRTIME)
xmax <-max(x64$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h64 = hist(x64$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x64_pt <- (h64$mids-64000)/64
y64_raw_pt <- 64
y64_pt <- 6
z64_pt <- h64$counts/numSamples
z64_raw_pt <- h64$counts
inc64 <- rep(64,length(h64$mids))
ss_inc64 <- rep(numSamples,length(h64$mids)) 
#### INC128 --- INC2048
numSamples <- 300
### 128 sec
x128 = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x128 <- subset(x128, x128$ITERNUM <= numSamples)
x128 <- subset(x128, x128$ITERNUM != 26)
xmin <-min(x128$PRTIME)
xmax <-max(x128$PRTIME)
binsize=2
nbins <- ceiling((xmax-xmin) / binsize)
h128 = hist(x128$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x128_pt <- (h128$mids-128000)/128
y128_raw_pt <- 128
y128_pt <- 7
z128_pt <- h128$counts/numSamples
z128_raw_pt <- h128$counts
inc128 <- rep(128,length(h128$mids))
ss_inc128 <- rep(numSamples,length(h128$mids)) 
### 256 sec
x256 = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x256 <- subset(x256, x256$ITERNUM <= numSamples)
x256 <- subset(x256, x256$ITERNUM != 199)
xmin <-min(x256$PRTIME)
xmax <-max(x256$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h256 = hist(x256$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x256_pt <- (h256$mids-256000)/256
y256_raw_pt <- 256
y256_pt <- 8
z256_pt <- h256$counts/numSamples
z256_raw_pt <- h256$counts
inc256 <- rep(256,length(h256$mids))
ss_inc256 <- rep(numSamples,length(h256$mids)) 
### 512 sec
x512 = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x512 <- subset(x512, x512$ITERNUM <= numSamples)
x512 <- subset(x512, x512$ITERNUM != 114 & x512$ITERNUM != 186 & x512$ITERNUM != 285)
xmin <-min(x512$PRTIME)
xmax <-max(x512$PRTIME)
binsize=5
nbins <- ceiling((xmax-xmin) / binsize)
h512 = hist(x512$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x512_pt <- (h512$mids-512000)/512
y512_raw_pt <- 512
y512_pt <- 9
z512_pt <- h512$counts/numSamples
z512_raw_pt <- h512$counts
inc512 <- rep(512,length(h512$mids))
ss_inc512 <- rep(numSamples,length(h512$mids)) 
### 1024 sec
x1024 = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x1024 <- subset(x1024, x1024$ITERNUM <= numSamples)
x1024 <- subset(x1024, x1024$ITERNUM != 17 & x1024$ITERNUM != 101 & x1024$ITERNUM != 184 & x1024$ITERNUM != 268)
xmin <-min(x1024$PRTIME)
xmax <-max(x1024$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1024 = hist(x1024$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1024_pt <- (h1024$mids-1024000)/1024
y1024_raw_pt <- 1024
y1024_pt <- 10
z1024_pt <- h1024$counts/numSamples
z1024_raw_pt <- h1024$counts
inc1024 <- rep(1024,length(h1024$mids))
ss_inc1024 <- rep(numSamples,length(h1024$mids)) 
### 2048 sec
x2048 = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x2048 <- subset(x2048, x2048$ITERNUM <= numSamples)
xmin <-min(x2048$PRTIME)
xmax <-max(x2048$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2048 = hist(x2048$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2048_pt <- (h2048$mids-2048000)/2048
y2048_raw_pt <- 2048
y2048_pt <- 11
z2048_pt <- h2048$counts/numSamples
z2048_raw_pt <- h2048$counts
inc2048 <- rep(2048,length(h2048$mids))
ss_inc2048 <- rep(numSamples,length(h2048$mids)) 
### 4096 sec
x4096 = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x4096 <- subset(x4096, x4096$ITERNUM <= numSamples)
x4096 <- subset(x4096, x4096$ITERNUM != 5 & x4096$ITERNUM != 26 & x4096$ITERNUM != 47 & x4096$ITERNUM != 68 & x4096$ITERNUM != 89 & x4096$ITERNUM != 110 & x4096$ITERNUM != 131 & x4096$ITERNUM != 152 & x4096$ITERNUM != 173 & x4096$ITERNUM != 195 & x4096$ITERNUM != 215 & x4096$ITERNUM != 236 & x4096$ITERNUM != 258 & x4096$ITERNUM != 278 & x4096$ITERNUM != 299) 
xmin <-min(x4096$PRTIME)
xmax <-max(x4096$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4096 = hist(x4096$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4096_pt <- (h4096$mids-4096000)/4096
y4096_raw_pt <- 4096
y4096_pt <- 12
z4096_pt <- h4096$counts/numSamples
z4096_raw_pt <- h4096$counts
inc4096 <- rep(4096,length(h4096$mids))
ss_inc4096 <- rep(numSamples,length(h4096$mids)) 
### 8192 sec
numSamples <- 260
x8192 = read.csv(file="8192_sec.dat",head=TRUE,sep="\t")
x8192 <- subset(x8192, x8192$ITERNUM <= numSamples)
#x8192_up = mean(x8192$PRTIME) + 2*sd(x8192$PRTIME)
#x8192_dn = mean(x8192$PRTIME) - 2*sd(x8192$PRTIME)
#x8192 = subset(x8192, x8192$PRTIME >= x8192_dn & x8192$PRTIME <= x8192_up)
xmin <-min(x8192$PRTIME)
xmax <-max(x8192$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h8192 = hist(x8192$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x8192_pt <- (h8192$mids-8192000)/8192
y8192_raw_pt <- 8192
y8192_pt <- 13
z8192_pt <- h8192$counts/numSamples
z8192_raw_pt <- h8192$counts
inc8192 <- rep(8192,length(h8192$mids))
ss_inc8192 <- rep(numSamples,length(h8192$mids)) 
### 16384 sec
numSamples <- 130
x16384 = read.csv(file="16384_sec.dat",head=TRUE,sep="\t")
x16384 <- subset(x16384, x16384$ITERNUM <= numSamples)
x16384_up = mean(x16384$PRTIME) + 2*sd(x16384$PRTIME)
x16384_dn = mean(x16384$PRTIME) - 2*sd(x16384$PRTIME)
#x16384 = subset(x16384, x16384$PRTIME >= x16384_dn & x16384$PRTIME <= x16384_up)
xmin <-min(x16384$PRTIME)
xmax <-max(x16384$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h16384 = hist(x16384$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x16384_pt <- (h16384$mids-16384000)/16384
y16384_raw_pt <- 16384
y16384_pt <- 14
z16384_pt <- h16384$counts/numSamples
z16384_raw_pt <- h16384$counts
inc16384 <- rep(16384,length(h16384$mids))
ss_inc16384 <- rep(numSamples,length(h16384$mids)) 
######## now let's generate 3D-plot ####
ny <- c(x1_pt,x2_pt,x4_pt,x8_pt,x16_pt,x32_pt,x64_pt,x128_pt,x256_pt,x512_pt,x1024_pt,x2048_pt,x4096_pt,x8192_pt,x16384_pt)
nx <- c(y1_pt,y2_pt,y4_pt,y8_pt,y16_pt,y32_pt,y64_pt,y128_pt,y256_pt,y512_pt,y1024_pt,y2048_pt,y4096_pt,y8192_pt,y16384_pt)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt,z16_pt,z32_pt,z64_pt,z128_pt,z256_pt,z512_pt,z1024_pt,z2048_pt,z4096_pt,z8192_pt,z16384_pt)
#### RAW DATA
ny_raw <- c(h1$mids,h2$mids,h4$mids,h8$mids,h16$mids,h32$mids,h64$mids,h128$mids,h256$mids,h512$mids,h1024$mids,h2048$mids,h4096$mids,h8192$mids,h16384$mids)
nx_raw <- c(y1_raw_pt,y2_raw_pt,y4_raw_pt,y8_raw_pt,y16_raw_pt,y32_raw_pt,y64_raw_pt,y128_raw_pt,y256_raw_pt,y512_raw_pt,y1024_raw_pt,y2048_raw_pt,y4096_raw_pt,y8192_raw_pt,y16384_raw_pt)
nz_raw <- c(z1_raw_pt,z2_raw_pt,z4_raw_pt,z8_raw_pt,z16_raw_pt,z32_raw_pt,z64_raw_pt,z128_raw_pt,z256_raw_pt,z512_raw_pt,z1024_raw_pt,z2048_raw_pt,z4096_raw_pt,z8192_raw_pt,z16384_raw_pt)
all_inc <- c(inc1,inc2,inc4,inc8,inc16,inc32,inc64,inc128,inc256,inc512,inc1024,inc2048,inc4096,inc8192,inc16384)
all_ss <- c(ss_inc1,ss_inc2,ss_inc4,ss_inc8,ss_inc16,ss_inc32,ss_inc64,ss_inc128,ss_inc256,ss_inc512,ss_inc1024,ss_inc2048,ss_inc4096,ss_inc8192,ss_inc16384)
#### FOR OUTPUT
#new_y <- cbind(ny_raw,ny)
#colnames(new_y) <- c("RAW_BIN","NORMALIZED")
#new_x <- cbind(nx_raw,nx)
#colnames(new_x) <- c("RAW_INC","LOG")
#new_z <- cbind(ny_raw,nz_raw,nz)
#colnames(new_z) <- c("RAW_BIN","RAW_FREQ","REL_FREQ")
#all_data <- cbind(all_inc,all_ss,ny_raw,nz_raw,ny,nz)
#colnames(all_data) <- c("TASK_LEN (in s)","SAMPLE_SIZE","RAW_BIN (in ms)","RAW_FREQ","NOR_PT","REL_FREQ")
#write.table(all_data, "/Users/yksuh/GitHub/papers/pt_characterization/rep_check/u_s_time/all_freq_data.txt", sep="\t",row.names = F)
##### Render 3D plot ###
## row-wise
mz=matrix(nz, nrow=length(nx),ncol=length(ny), byrow=F)
## 1 sec
mz[1, (length(x1_pt)+1):(length(nx))] <- 0
## 2 sec
mz[2,1:length(x1_pt)] <- 0
mz[2, (length(x1_pt)+length(x2_pt)+1):(length(nx))] <- 0
## 4 sec
mz[3, 1:(length(x1_pt)+length(x2_pt))] <- 0
mz[3, (length(x1_pt)+length(x2_pt)+length(x4_pt)+1):(length(nx))] <- 0
## 8 sec
mz[4, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt))] <- 0
mz[4, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+1):(length(nx))] <- 0
## 16 sec
mz[5, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt))] <- 0
mz[5, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+1):(length(nx))] <- 0
## 32 sec
mz[6, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt))] <- 0
mz[6, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+1):(length(nx))] <- 0
## 64 sec
mz[7, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt))] <- 0
mz[7, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+1):(length(nx))] <- 0
## 128 sec
mz[8, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt))] <- 0
mz[8, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+1):(length(nx))] <- 0
## 256 sec
mz[9, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt))] <- 0
mz[9, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+1):(length(nx))] <- 0
## 512 sec
mz[10, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt))] <- 0
mz[10, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+1):(length(nx))] <- 0
## 1024 sec
mz[11, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt))] <- 0
mz[11, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+1):(length(nx))] <- 0
## 2048 sec
mz[12, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt))] <- 0
mz[12, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+1):(length(nx))] <- 0
## 4096 sec
mz[13, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt))] <- 0
mz[13, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt))] <- 0
## 8192 sec
mz[14, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt))] <- 0
mz[14, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)+length(x8192_pt))] <- 0
## 16384 sec
mz[15, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)+length(x8192_pt))] <- 0
postscript("3d_plot.eps")
hist3D(nx,ny,mz,colkey = F, theta=35,phi=20,zlim=c(0,0.8), xlab="Task Length in Log Scale (sec)",ylab="Normalized INC PT",zlab="Relative Frequency", border = "black", axes=TRUE,label=TRUE,space=0.5,ticktype="detailed",nticks=15,shade=0.5) 
dev.off()









































### sodb9
#install.packages("devtools")
#library(devtools)
#install.packages("rgl")
#library(rgl)
require(rgl)
#install.packages("misc3d")
#install.packages("plot3D", repos="http://R-Forge.R-project.org")
require(plot3D)
require(axis3D)
library(plot3D)
numSamples <- 1000
### 1 sec
x1 = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
binsize=1
xmin <-min(x1$PRTIME)
xmax <-max(x1$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1 = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1_pt <- (h1$mids-1000)
#x1_pt <- h1$mids-min(h1$mids)
#x1_pt <- ((h1$mids-min(h1$mids))/(max(h1$mids)-min(h1$mids)))
y1_pt <- 1
z1_pt <- h1$density
### 2 sec
x2 = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x2 <- subset(x2, x2$ITERNUM <= numSamples)
xmin <-min(x2$PRTIME)
xmax <-max(x2$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2 = hist(x2$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2_pt <- (h2$mids-2000)
#x2_pt <- (h2$mids-min(h2$mids))
#x2_pt <- ((h2$mids-min(h2$mids))/(max(h2$mids)-min(h2$mids)))
y2_pt <- 2
z2_pt <- h2$density
### 4 sec
x4 = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x4 <- subset(x4, x4$ITERNUM <= numSamples)
xmin <-min(x4$PRTIME)
xmax <-max(x4$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4 = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4_pt <- (h4$mids-4000)
#x4_pt <- (h4$mids-min(h4$mids))
#x4_pt <- ((h4$mids-min(h4$mids))/(max(h4$mids)-min(h4$mids)))
y4_pt <- 4
z4_pt <- h4$density
### 8 sec
x8 = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x8 <- subset(x8, x8$ITERNUM <= numSamples)
x8 <- subset(x8, x8$ITERNUM != 27)
xmin <-min(x8$PRTIME)
xmax <-max(x8$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h8 = hist(x8$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x8_pt <- (h8$mids-8000)
#x8_pt <- (h8$mids-min(h8$mids))
#x8_pt <- ((h8$mids-min(h8$mids))/(max(h8$mids)-min(h8$mids)))
y8_pt <- 8
z8_pt <- h8$density
### 16 sec
x16 = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x16 <- subset(x16, x16$ITERNUM <= numSamples)
xmin <-min(x16$PRTIME)
xmax <-max(x16$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h16 = hist(x16$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x16_pt <- (h16$mids-16000)
#x16_pt <- (h16$mids-min(h16$mids))
#x16_pt <- ((h16$mids-min(h16$mids))/(max(h16$mids)-min(h16$mids)))
y16_pt <- 16
z16_pt <- h16$density
### 32 sec
x32 = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
x32 <- subset(x32, x32$ITERNUM <= numSamples)
x32 <- subset(x32, x32$ITERNUM != 433)
xmin <-min(x32$PRTIME)
xmax <-max(x32$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h32 = hist(x32$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x32_pt <- (h32$mids-32000)
#x32_pt <- (h32$mids-min(h32$mids))
#x32_pt <- ((h32$mids-min(h32$mids))/(max(h32$mids)-min(h32$mids)))
y32_pt <- 32
z32_pt <- h32$density
### 64 sec
x64 = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x64 <- subset(x64, x64$ITERNUM <= numSamples)
xmin <-min(x64$PRTIME)
xmax <-max(x64$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h64 = hist(x64$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x64_pt <- (h64$mids-64000)
#x64_pt <- (h64$mids-min(h64$mids))
#x64_pt <- ((h64$mids-min(h64$mids))/(max(h64$mids)-min(h64$mids)))
y64_pt <- 64
z64_pt <- h64$density
### 128 sec
x128 = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x128 <- subset(x128, x128$ITERNUM <= numSamples)
x128 <- subset(x128, x128$ITERNUM != 26)
xmin <-min(x128$PRTIME)
xmax <-max(x128$PRTIME)
binsize=2
nbins <- ceiling((xmax-xmin) / binsize)
h128 = hist(x128$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x128_pt <- (h128$mids-128000)
#x128_pt <- (h128$mids-min(h128$mids))
#x128_pt <- ((h128$mids-min(h128$mids))/(max(h128$mids)-min(h128$mids)))
y128_pt <- 128
z128_pt <- h128$density
### 256 sec
x256 = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x256 <- subset(x256, x256$ITERNUM <= numSamples)
x256 <- subset(x256, x256$ITERNUM != 199)
xmin <-min(x256$PRTIME)
xmax <-max(x256$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h256 = hist(x256$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x256_pt <- (h256$mids-256000)
#x256_pt <- (h256$mids-min(h256$mids))
#x256_pt <- ((h256$mids-min(h256$mids))/(max(h256$mids)-min(h256$mids)))
y256_pt <- 256
z256_pt <- h256$density
### 512 sec
x512 = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x512 <- subset(x512, x512$ITERNUM <= numSamples)
x512 <- subset(x512, x512$ITERNUM != 114 & x512$ITERNUM != 186 & x512$ITERNUM != 285)
xmin <-min(x512$PRTIME)
xmax <-max(x512$PRTIME)
binsize=5
nbins <- ceiling((xmax-xmin) / binsize)
h512 = hist(x512$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x512_pt <- (h512$mids-512000)
#x512_pt <- (h512$mids-min(h512$mids))
#x512_pt <- ((h512$mids-min(h512$mids))/(max(h512$mids)-min(h512$mids)))
y512_pt <- 512
z512_pt <- h512$density
### 1024 sec
x1024 = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x1024 <- subset(x1024, x1024$ITERNUM <= numSamples)
x1024 <- subset(x1024, x1024$ITERNUM != 17 & x1024$ITERNUM != 101 & x1024$ITERNUM != 184 & x1024$ITERNUM != 268)
xmin <-min(x1024$PRTIME)
xmax <-max(x1024$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1024 = hist(x1024$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1024_pt <- (h1024$mids-1024000)
#x1024_pt <- (h1024$mids-min(h1024$mids))
#x1024_pt <- ((h1024$mids-min(h1024$mids))/(max(h1024$mids)-min(h1024$mids)))
y1024_pt <- 1024
z1024_pt <- h1024$density
### 2048 sec
x2048 = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x2048 <- subset(x2048, x2048$ITERNUM <= numSamples)
xmin <-min(x2048$PRTIME)
xmax <-max(x2048$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2048 = hist(x2048$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2048_pt <- (h2048$mids-2048000)
#x2048_pt <- (h2048$mids-min(h2048$mids))
#x2048_pt <- ((h2048$mids-min(h2048$mids))/(max(h2048$mids)-min(h2048$mids)))
y2048_pt <- 2048
z2048_pt <- h2048$density
### 4096 sec
x4096 = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x4096 <- subset(x4096, x4096$ITERNUM <= numSamples)
x4096 <- subset(x4096, x4096$ITERNUM != 5 & x4096$ITERNUM != 26 & x4096$ITERNUM != 47 & x4096$ITERNUM != 68 & x4096$ITERNUM != 89 & x4096$ITERNUM != 110 & x4096$ITERNUM != 131 & x4096$ITERNUM != 152 & x4096$ITERNUM != 173 & x4096$ITERNUM != 195 & x4096$ITERNUM != 215 & x4096$ITERNUM != 236 & x4096$ITERNUM != 258 & x4096$ITERNUM != 278 & x4096$ITERNUM != 299) 
xmin <-min(x4096$PRTIME)
xmax <-max(x4096$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4096 = hist(x4096$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4096_pt <- (h4096$mids-4096000)
#x4096_pt <- (h4096$mids-min(h4096$mids))
#x4096_pt <- ((h4096$mids-min(h4096$mids))/(max(h4096$mids)-min(h4096$mids)))
y4096_pt <- 4096
z4096_pt <- h4096$density

######## now let's generate 3D-plot ####
nx <- c(x1_pt,x2_pt,x4_pt,x8_pt,x16_pt,x32_pt,x64_pt,x128_pt,x256_pt,x512_pt,x1024_pt,x2048_pt,x4096_pt)
ny <- c(y1_pt,y2_pt,y4_pt,y8_pt,y16_pt,y32_pt,y64_pt,y128_pt,y256_pt,y512_pt,y1024_pt,y2048_pt,y4096_pt)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt,z16_pt,z32_pt,z64_pt,z128_pt,z256_pt,z512_pt,z1024_pt,z2048_pt,z4096_pt)
## row-wise
mz=matrix(nz, nrow=length(ny),ncol=length(nx), byrow=T)
## 1 sec
mz[1, (length(x1_pt)+1):(length(nx))] <- NA
## 2 sec
mz[2,1:length(x1_pt)] <- NA
mz[2, (length(x1_pt)+length(x2_pt)+1):(length(nx))] <- NA
## 4 sec
mz[3, 1:(length(x1_pt)+length(x2_pt))] <- NA
mz[3, (length(x1_pt)+length(x2_pt)+length(x4_pt)+1):(length(nx))] <- NA
## 8 sec
mz[4, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt))] <- NA
mz[4, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+1):(length(nx))] <- NA
## 16 sec
mz[5, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt))] <- NA
mz[5, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+1):(length(nx))] <- NA
## 32 sec
mz[6, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt))] <- NA
mz[6, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+1):(length(nx))] <- NA
## 64 sec
mz[7, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt))] <- NA
mz[7, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+1):(length(nx))] <- NA
## 128 sec
mz[8, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt))] <- NA
mz[8, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+1):(length(nx))] <- NA
## 256 sec
mz[9, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt))] <- NA
mz[9, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+1):(length(nx))] <- NA
## 512 sec
mz[10, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt))] <- NA
mz[10, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+1):(length(nx))] <- NA
## 1024 sec
mz[11, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt))] <- NA
mz[11, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+1):(length(nx))] <- NA
## 2048 sec
mz[12, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt))] <- NA
mz[12, (length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+1):(length(nx))] <- NA
## 4096 sec
mz[13, 1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt))] <- NA
#library(rgl)
postscript("3d_plot.eps")
#open3d()
#hist3D(ny,nx,mz,log='xy', colkey = F, zlim=c(0,0.8), xlab="Task Length (sec) (in log scale)",ylab="INC Time Difference",zlab="Relative Frequency", border = "black",theta=225, phi=140, axes=TRUE,label=FALSE,space=0.5,ticktype="detailed",shade=0.5) 
hist3D(ny,nx,mz,theta=30,phi=10,colkey = F, zlim=c(0,0.8), bty = "g",  xlab="Task Length (sec)",ylab="INC Time Difference",zlab="Relative Frequency", border = "black", axes=TRUE,label=TRUE,space=0.5,ticktype="detailed",nticks=8,shade=0.5) 
#axis(side=1,at=ny,labels=c('1','2','4','8','16')) ,ticktype="detailed", lighting=TRUE, light="diffuse", 
#axes3d('x',nticks=length(ny), pos=c(1,2,4,8,16), labels=ny)
#axes3d("y",nticks=10, at=c(min(nx),max(nx),1), labels=nx)
#axes3d("z",nticks=10, at=c(0,1,0.2), labels=c(0,1,0.2))
#axis3d("y", at=seq(0,1, length = length(ylabels)), labels=ylabels, nticks=4)
#axes3d(c('x','y','z'))
#title3d('','','xlab','ylab','zlab')xlabels=c('1','2','4','8','16')),
#text3D(x=ny, y=seq(10,50,10),z=seq(0.2,1,0.2),labels=ny)
#text3D(x=c(1,2,4,8,16,32,64), y=rep(3,length(ny)), z=rep(3,length(ny)),
#       labels=paste("",c(1,2,4,8,16,32,64), sep=""), add=TRUE, cex=0.8, srt=35)
dev.off()



nrank <- max(test$mon_rank)
nmon <- nrow(y_mat)

text3D(x=rep(nmon+1.75, nrank), y=1:nrank+0.5, z=rep(0.5, nrank), 
       labels=paste("Rank ",1:max(test$mon_rank), sep=""), add=TRUE, cex=0.8, srt=35)

text3D(x=1:nmon, y=rep(nrank+0.75, nmon), z=rep(0, nmon), labels=as.character(y_mat$mon), 
       cex=0.85, add=TRUE)

text3D(x=rep(nmon+0.75, 5), y=rep(0, 5), z=1:5, labels=1:5,
       cex=0.9, add=TRUE)

#hist3D(x = 1:5, z = dt, scale = T, col = jet.col(100, alpha = 0.3), add = F,  colkey = F, ticktype = "detailed")

######## now let's generate 3D-plot ####
nx <- c(x1_pt,x2_pt,x4_pt,x8_pt,x16_pt,x32_pt,x64_pt,x128_pt,x256_pt,x512_pt,x1024_pt,x2048_pt,x4096_pt)
ny <- c(y1_pt,y2_pt,y4_pt,y8_pt,y16_pt,y32_pt,y64_pt,y128_pt,y256_pt,y512_pt,y1024_pt,y2048_pt,y4096_pt)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt,z16_pt,z32_pt,z64_pt,z128_pt,z256_pt,z512_pt,z1024_pt,z2048_pt,z4096_pt)
### column-wise
mz=matrix(nz, nrow=length(nx),ncol=length(ny), byrow=F)
## 1 sec
mz[(length(x1_pt)+1):(length(nx)),1] <- NA
## 2 sec
mz[1:length(x1_pt),2] <- NA
mz[(length(x1_pt)+length(x2_pt)+1):(length(nx)),2] <- NA
## 4 sec
mz[1:(length(x1_pt)+length(x2_pt)),3] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+1):(length(nx)),3] <- NA
## 8 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)),4] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+1):(length(nx)),4] <- NA
## 16 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)),5] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+1):(length(nx)),5] <- NA
## 32 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)),6] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+1):(length(nx)),6] <- NA
## 64 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)),7] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+1):(length(nx)),7] <- NA
## 128 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)),8] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+1):(length(nx)),8] <- NA
## 256 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)),9] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+1):(length(nx)),9] <- NA
## 512 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)),10] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+1):(length(nx)),10] <- NA
## 1024 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)),11] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+1):(length(nx)),11] <- NA
## 2048 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)),12] <- NA
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+1):(length(nx)),12] <- NA
## 4096 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)),13] <- NA
#mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)+1):(length(nx)),12] <- NA

postscript("3d_plot.eps")
#hist3D(x,y,mz,xlim=c(0,17000),zlim=c(0,1000), ylim=c(0,13), xlab="INC Time (msec)",ylab="INC Length (sec)",zlab="Frequency",theta=30, phi=20, border = "black", axes=TRUE,label=TRUE, nticks=10,ticktype="detailed", space=0.2) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
hist3D(ny,nx,mz,log='xy',zlim=c(0,1), xlab="Normalized INC Time Difference",ylab="Task Length in log scale",zlab="Relative Frequency",
bty = "g",  border = "black",axes=TRUE,label=TRUE, ticktype="detailed", nticks=10,space=0.1) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
dev.off()


