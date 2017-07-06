### sodb9
#install.packages("devtools")
#library(devtools)
#install.packages("rgl")
#library(rgl)
require(rgl)
#install.packages("misc3d")
#install.packages("plot3D", repos="http://R-Forge.R-project.org")
require(plot3D)
library(plot3D)
numSamples <- 1000
### 1 sec
x1 = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
binsize=1
xmin <-min(x1$PRTIME)
xmax <-max(x1$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1 = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
#x1_pt <- (h1$mids-1000)
x1_pt <- ((h1$mids-min(h1$mids))/(max(h1$mids)-min(h1$mids)))
y1_pt <- 1
z1_pt <- h1$density
### 2 sec
x2 = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x2 <- subset(x2, x2$ITERNUM <= numSamples)
xmin <-min(x2$PRTIME)
xmax <-max(x2$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2 = hist(x2$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
#z2 <- h2$mids
#z2[z2!=0] <- 2
#x2_pt <- (h2$mids-2000)
#x2_pt <- (h2$mids-min(h2$mids))
x2_pt <- ((h2$mids-min(h2$mids))/(max(h2$mids)-min(h2$mids)))
y2_pt <- 2
z2_pt <- h2$density
### 4 sec
x4 = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x4 <- subset(x4, x4$ITERNUM <= numSamples)
xmin <-min(x4$PRTIME)
xmax <-max(x4$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4 = hist(x4$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
#x4_pt <- (h4$mids-4000)
#x4_pt <- (h4$mids-min(h4$mids))
x4_pt <- ((h4$mids-min(h4$mids))/(max(h4$mids)-min(h4$mids)))
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
#x8_pt <- (h8$mids-8000)
#x8_pt <- (h8$mids-min(h8$mids))
x8_pt <- ((h8$mids-min(h8$mids))/(max(h8$mids)-min(h8$mids)))
y8_pt <- 8
z8_pt <- h8$density
### 16 sec
x16 = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x16 <- subset(x16, x16$ITERNUM <= numSamples)
xmin <-min(x16$PRTIME)
xmax <-max(x16$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h16 = hist(x16$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
#x16_pt <- (h16$mids-16000)
#x16_pt <- (h16$mids-min(h16$mids))
x16_pt <- ((h16$mids-min(h16$mids))/(max(h16$mids)-min(h16$mids)))
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
#x32_pt <- (h32$mids-32000)
#x32_pt <- (h32$mids-min(h32$mids))
x32_pt <- ((h32$mids-min(h32$mids))/(max(h32$mids)-min(h32$mids)))
y32_pt <- 32
z32_pt <- h32$density
### 64 sec
x64 = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x64 <- subset(x64, x64$ITERNUM <= numSamples)
xmin <-min(x64$PRTIME)
xmax <-max(x64$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h64 = hist(x64$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
#x64_pt <- (h64$mids-64000)
#x64_pt <- (h64$mids-min(h64$mids))
x64_pt <- ((h64$mids-min(h64$mids))/(max(h64$mids)-min(h64$mids)))
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
#x128_pt <- (h128$mids-128000)
#x128_pt <- (h128$mids-min(h128$mids))
x128_pt <- ((h128$mids-min(h128$mids))/(max(h128$mids)-min(h128$mids)))
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
#x256_pt <- (h256$mids-256000)
#x256_pt <- (h256$mids-min(h256$mids))
x256_pt <- ((h256$mids-min(h256$mids))/(max(h256$mids)-min(h256$mids)))
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
#x512_pt <- (h512$mids-512000)
#x512_pt <- (h512$mids-min(h512$mids))
x512_pt <- ((h512$mids-min(h512$mids))/(max(h512$mids)-min(h512$mids)))
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
#x1024_pt <- (h1024$mids-1024000)
#x1024_pt <- (h1024$mids-min(h1024$mids))
x1024_pt <- ((h1024$mids-min(h1024$mids))/(max(h1024$mids)-min(h1024$mids)))
y1024_pt <- 1024
z1024_pt <- h1024$density
### 2048 sec
x2048 = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x2048 <- subset(x2048, x2048$ITERNUM <= numSamples)
xmin <-min(x2048$PRTIME)
xmax <-max(x2048$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2048 = hist(x2048$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
#x2048_pt <- (h2048$mids-2048000)
#x2048_pt <- (h2048$mids-min(h2048$mids))
x2048_pt <- ((h2048$mids-min(h2048$mids))/(max(h2048$mids)-min(h2048$mids)))
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
#x4096_pt <- (h4096$mids-4096000)
#x4096_pt <- (h4096$mids-min(h4096$mids))
x4096_pt <- ((h4096$mids-min(h4096$mids))/(max(h4096$mids)-min(h4096$mids)))
y4096_pt <- 4096
z4096_pt <- h4096$density

######## now let's generate 3D-plot ####
nx <- c(x1_pt,x2_pt,x4_pt,x8_pt,x16_pt,x32_pt,x64_pt,x128_pt,x256_pt,x512_pt,x1024_pt,x2048_pt,x4096_pt)
#ny <- c(y1_pt,y2_pt,y4_pt,y8_pt,y16_pt,y32_pt,y64_pt,y128_pt,y256_pt,y512_pt,y1024_pt,y2048_pt,y4096_pt)
ny <- c(0,1,2,3,4,5,6,7,8,9,10,11,12)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt,z16_pt,z32_pt,z64_pt,z128_pt,z256_pt,z512_pt,z1024_pt,z2048_pt,z4096_pt)

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
hist3D(nx,ny,mz,log='xy',zlim=c(0,1), xlab="Normalized INC Time Difference",ylab="Task Length in log scale",zlab="Relative Frequency",
bty = "g",  border = "black",axes=TRUE,label=TRUE, ticktype="detailed", nticks=10,space=0.1) 
#axis(side=1,at=x,labels=seq(min(x),max(x),1))
dev.off()


