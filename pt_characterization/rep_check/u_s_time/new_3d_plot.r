#### An R script for 3D plot
numSamples <- 1000
### 1 sec
x1 = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
binsize=1
xmin <-min(x1$PRTIME)
xmax <-max(x1$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1 = hist(x1$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1_pt <- (h1$mids-min(h1$mids))
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
#x2_pt <- (h2$mids-2000)/2
x2_pt <- (h2$mids-min(h2$mids))
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
x4_pt <- (h4$mids-min(h4$mids))
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
x8_pt <- (h8$mids-min(h8$mids))
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
x16_pt <- (h16$mids-min(h16$mids))
y16_raw_pt <- 16
y16_pt <- 4
z16_pt <- h16$counts/numSamples
z16_raw_pt <- h16$counts
inc16 <- rep(16,length(h16$mids))
ss_inc16 <- rep(numSamples,length(h16$mids)) 
### 32 sec
binsize=1
x32 = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
xmin <-min(x32$PRTIME)
xmax <-max(x32$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h32 = hist(x32$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x32_pt <- (h32$mids-min(h32$mids))
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
x64_pt <- (h64$mids-min(h64$mids))
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
x128_pt <- (h128$mids-min(h128$mids))
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
x256_pt <- (h256$mids-min(h256$mids))
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
x512_pt <- (h512$mids-min(h512$mids))
y512_raw_pt <- 512
y512_pt <- 9
z512_pt <- h512$counts/numSamples
z512_raw_pt <- h512$counts
inc512 <- rep(512,length(h512$mids))
ss_inc512 <- rep(numSamples,length(h512$mids)) 
### 1024 sec
binsize=5
numSamples = 300
x1024 = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x1024 <- subset(x1024, x1024$ITERNUM <= numSamples)
x1024 <- subset(x1024, x1024$ITERNUM != 17 & x1024$ITERNUM != 101 & x1024$ITERNUM != 184 & x1024$ITERNUM != 268)
xmin <-min(x1024$PRTIME)
xmax <-max(x1024$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1024 = hist(x1024$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1024_pt <- (h1024$mids-min(h1024$mids))
y1024_raw_pt <- 1024
y1024_pt <- 10
z1024_pt <- h1024$counts/numSamples
z1024_raw_pt <- h1024$counts
inc1024 <- rep(1024,length(h1024$mids))
ss_inc1024 <- rep(numSamples,length(h1024$mids)) 
### 2048 sec
binsize=5
x2048 = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x2048  <- subset(x2048, x2048$ITERNUM != 166)
xmin <-min(x2048$PRTIME)
xmax <-max(x2048$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2048 = hist(x2048$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2048_pt <- (h2048$mids-min(h2048$mids))
y2048_raw_pt <- 2048
y2048_pt <- 11
z2048_pt <- h2048$counts/numSamples
z2048_raw_pt <- h2048$counts
inc2048 <- rep(2048,length(h2048$mids))
ss_inc2048 <- rep(numSamples,length(h2048$mids)) 
### 4096 sec
numSamples <- 300
x4096 = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x4096 <- subset(x4096, x4096$ITERNUM <= numSamples)
binsize=5
x4096 <- subset(x4096, x4096$ITERNUM != 11 & x4096$ITERNUM != 32 & x4096$ITERNUM != 53 & x4096$ITERNUM != 74 & x4096$ITERNUM != 95 & x4096$ITERNUM != 116 & x4096$ITERNUM != 137 & x4096$ITERNUM != 158 & x4096$ITERNUM != 179 & x4096$ITERNUM != 200 & x4096$ITERNUM != 221 & x4096$ITERNUM != 242 & x4096$ITERNUM != 264)
xmin <-min(x4096$PRTIME)
xmax <-max(x4096$PRTIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4096 = hist(x4096$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4096_pt <- (h4096$mids-min(h4096$mids))
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
xmin <-min(x8192$PRTIME)
xmin <- xmin-2
xmax <-max(x8192$PRTIME)
xmax <- xmax+1
nbins <- ceiling((xmax-xmin) / binsize)
h8192 = hist(x8192$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x8192_pt <- (h8192$mids-min(h8192$mids))
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
binsize=10
xmin <-min(x16384$PRTIME)
xmin <- xmin-7
xmax <-max(x16384$PRTIME)
xmax <- xmax+5
nbins <- ceiling((xmax-xmin) / binsize)
h16384 = hist(x16384$PRTIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x16384_pt <- (h16384$mids-min(h16384$mids))
y16384_raw_pt <- 16384
y16384_pt <- 14
z16384_pt <- h16384$counts/numSamples
z16384_raw_pt <- h16384$counts
inc16384 <- rep(16384,length(h16384$mids))
ss_inc16384 <- rep(numSamples,length(h16384$mids)) 
######## start 3x3x3 ####
nx <- c(x1_pt,x2_pt,x4_pt)
ny <- c(y1_pt,y2_pt,y4_pt)
nz <- c(z1_pt,z2_pt,z4_pt)
mz=matrix(nz, nrow=length(nx),ncol=length(ny), byrow=F)
## 1 sec
mz[(length(x1_pt)+1):(length(nx)),1] <- 0
## 2 sec
mz[1:length(x1_pt),2] <- 0
mz[(length(x1_pt)+length(x2_pt)+1):(length(nx)),2] <- 0
## 4 sec
mz[1:(length(x1_pt)+length(x2_pt)),3] <- 0
library(plotly)
p <- plot_ly(z=mz, type="surface") %>%
layout(p,
    title = "3D histograms",
    scene = list(
      xaxis = list(title = "Log(TL)"),
      yaxis = list(title = "Norm. PT"),
      zaxis = list(title = "RF")
    ))
#help(signup, package = 'plotly')
Sys.setenv("plotly_username"="yksuh")
Sys.setenv("plotly_api_key"="4jaag7lYwdndqs5J5CLK")
api_create(p, filename = "3dplot")
dev.off()

######## now let's generate 3D-plot ####
nx <- c(x1_pt,x2_pt,x4_pt,x8_pt,x16_pt,x32_pt,x64_pt,x128_pt,x256_pt,x512_pt,x1024_pt,x2048_pt,x4096_pt,x8192_pt,x16384_pt)
ny <- c(y1_pt,y2_pt,y4_pt,y8_pt,y16_pt,y32_pt,y64_pt,y128_pt,y256_pt,y512_pt,y1024_pt,y2048_pt,y4096_pt,y8192_pt,y16384_pt)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt,z16_pt,z32_pt,z64_pt,z128_pt,z256_pt,z512_pt,z1024_pt,z2048_pt,z4096_pt,z8192_pt,z16384_pt)
nz <- c(z1_pt,z2_pt,z4_pt,z8_pt,z16_pt,z32_pt,z64_pt,z128_pt,z256_pt,z512_pt,z1024_pt,z2048_pt,z4096_pt,z8192_pt,z16384_pt)/max(nz)
##### Render 3D plot ###
## row-wise
mz=matrix(nz, nrow=length(nx),ncol=length(ny), byrow=F)
## 1 sec
mz[(length(x1_pt)+1):(length(nx)),1] <- 0
## 2 sec
mz[1:length(x1_pt),2] <- 0
mz[(length(x1_pt)+length(x2_pt)+1):(length(nx)),2] <- 0
## 4 sec
mz[1:(length(x1_pt)+length(x2_pt)),3] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+1):(length(nx)),3] <- 0
## 8 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)),4] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+1):(length(nx)),4] <- 0
## 16 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)),5] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+1):(length(nx)),5] <- 0
## 32 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)),6] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+1):(length(nx)),6] <- 0
## 64 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)),7] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+1):(length(nx)),7] <- 0
## 128 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)),8] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+1):(length(nx)),8] <- 0
## 256 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)),9] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+1):(length(nx)),9] <- 0
## 512 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)),10] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+1):(length(nx)),10] <- 0
## 1024 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)),11] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+1):(length(nx)),11] <- 0
## 2048 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)),12] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+1):(length(nx)),12] <- 0
## 4096 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)),13] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)),13] <- 0
## 8192 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)),14] <- 0
mz[(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)+length(x8192_pt)),14] <- 0
## 16384 sec
mz[1:(length(x1_pt)+length(x2_pt)+length(x4_pt)+length(x8_pt)+length(x16_pt)+length(x32_pt)+length(x64_pt)+length(x128_pt)+length(x256_pt)+length(x512_pt)+length(x1024_pt)+length(x2048_pt)+length(x4096_pt)+length(x8192_pt)),15] <- 0
library(plotly)
p <- plot_ly(z=mz, type="surface") %>%
layout(p,
    title = "3D histograms",
    scene = list(
      xaxis = list(title = "Log(TL)"),
      yaxis = list(title = "Norm. PT"),
      zaxis = list(title = "RF")
    ))
#help(signup, package = 'plotly')
Sys.setenv("plotly_username"="yksuh")
Sys.setenv("plotly_api_key"="4jaag7lYwdndqs5J5CLK")
api_create(p, filename = "3dplot")
dev.off()
