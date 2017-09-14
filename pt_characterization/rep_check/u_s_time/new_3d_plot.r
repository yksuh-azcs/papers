#### An R script for 3D plot
numSamples <- 1000
binsize=1
### 1 sec
x1 = read.csv(file="1_sec.dat",head=TRUE,sep="\t")
xmin <-min(x1$U_TIME)
xmax <-max(x1$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1 = hist(x1$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1_pt <- round((h1$breaks-min(h1$breaks))/(max(h1$breaks-min(h1$breaks)))*100,0)
x1_pt
z1_pt <- round(h1$counts/max(h1$counts)*100,0)
z1_pt
### 2 sec
x2 = read.csv(file="2_sec.dat",head=TRUE,sep="\t")
x2 <- subset(x2, x2$ITERNUM <= numSamples)
xmin <-min(x2$U_TIME)
xmax <-max(x2$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2 = hist(x2$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2_pt <- round((h2$breaks-min(h2$breaks))/(max(h2$breaks-min(h2$breaks)))*100,0)
x2_pt
z2_pt <- round(h2$counts/max(h2$counts)*100,0)
z2_pt
### 4 sec
x4 = read.csv(file="4_sec.dat",head=TRUE,sep="\t")
x4 <- subset(x4, x4$ITERNUM <= numSamples)
xmin <-min(x4$U_TIME)
xmax <-max(x4$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4 = hist(x4$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4_pt <- round((h4$breaks-min(h4$breaks))/(max(h4$breaks-min(h4$breaks)))*100,0)
x4_pt
z4_pt <- round(h4$counts/max(h4$counts)*100,0)
z4_pt
### 8 sec
x8 = read.csv(file="8_sec.dat",head=TRUE,sep="\t")
x8 <- subset(x8, x8$ITERNUM <= numSamples)
x8 <- subset(x8, x8$ITERNUM != 27)
xmin <-min(x8$U_TIME)
xmax <-max(x8$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h8 = hist(x8$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x8_pt <- round((h8$breaks-min(h8$breaks))/(max(h8$breaks-min(h8$breaks)))*100,0)
x8_pt
z8_pt <- round(h8$counts/max(h8$counts)*100,0)
z8_pt
### 16 sec
x16 = read.csv(file="16_sec.dat",head=TRUE,sep="\t")
x16 <- subset(x16, x16$ITERNUM <= numSamples)
xmin <-min(x16$U_TIME)
xmax <-max(x16$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h16 = hist(x16$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
h16$breaks-min(h16$breaks)
x16_pt <- round((h16$breaks-min(h16$breaks))/(max(h16$breaks-min(h16$breaks)))*100,0)
x16_pt
z16_pt <- round(h16$counts/max(h16$counts)*100,0)
z16_pt
### 32 sec
binsize=1
x32 = read.csv(file="32_sec.dat",head=TRUE,sep="\t")
xmin <-min(x32$U_TIME)
xmax <-max(x32$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h32 = hist(x32$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
h32$breaks-min(h32$breaks)
x32_pt <- round((h32$breaks-min(h32$breaks))/(max(h32$breaks-min(h32$breaks)))*100,0)
x32_pt
z32_pt <- round(h32$counts/max(h32$counts)*100,0)
z32_pt
### 64 sec
x64 = read.csv(file="64_sec.dat",head=TRUE,sep="\t")
x64 <- subset(x64, x64$ITERNUM <= numSamples)
xmin <-min(x64$U_TIME)
xmax <-max(x64$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h64 = hist(x64$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x64_pt <- round((h64$breaks-min(h64$breaks))/(max(h64$breaks-min(h64$breaks)))*100,0)
x64_pt
z64_pt <- round(h64$counts/max(h64$counts)*100,0)
z64_pt
#### INC128 --- INC2048
numSamples <- 300
### 128 sec
x128 = read.csv(file="128_sec.dat",head=TRUE,sep="\t")
x128 <- subset(x128, x128$ITERNUM <= numSamples)
x128 <- subset(x128, x128$ITERNUM != 26)
xmin <-min(x128$U_TIME)
xmax <-max(x128$U_TIME)
binsize=2
nbins <- ceiling((xmax-xmin) / binsize)
h128 = hist(x128$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x128_pt <- round((h128$breaks-min(h128$breaks))/(max(h128$breaks-min(h128$breaks)))*100,0)
x128_pt
z128_pt <- round(h128$counts/max(h128$counts)*100,0)
z128_pt
### 256 sec
x256 = read.csv(file="256_sec.dat",head=TRUE,sep="\t")
x256 <- subset(x256, x256$ITERNUM <= numSamples)
x256 <- subset(x256, x256$ITERNUM != 199)
xmin <-min(x256$U_TIME)
xmax <-max(x256$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h256 = hist(x256$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
h256$breaks-min(h256$breaks)
x256_pt <- round((h256$breaks-min(h256$breaks))/(max(h256$breaks-min(h256$breaks)))*100,0)
x256_pt
z256_pt <- round(h256$counts/max(h256$counts)*100,0)
z256_pt
### 512 sec
x512 = read.csv(file="512_sec.dat",head=TRUE,sep="\t")
x512 <- subset(x512, x512$ITERNUM <= numSamples)
x512 <- subset(x512, x512$ITERNUM != 114 & x512$ITERNUM != 186 & x512$ITERNUM != 285)
xmin <-min(x512$U_TIME)
xmax <-max(x512$U_TIME)
binsize=5
nbins <- ceiling((xmax-xmin) / binsize)
h512 = hist(x512$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x512_pt <- round((h512$breaks-min(h512$breaks))/(max(h512$breaks-min(h512$breaks)))*100,0)
x512_pt
z512_pt <- round(h512$counts/max(h512$counts)*100,0)
z512_pt
### 1024 sec
binsize=5
numSamples = 300
x1024 = read.csv(file="1024_sec.dat",head=TRUE,sep="\t")
x1024 <- subset(x1024, x1024$ITERNUM <= numSamples)
x1024 <- subset(x1024, x1024$ITERNUM != 17 & x1024$ITERNUM != 101 & x1024$ITERNUM != 184 & x1024$ITERNUM != 268)
xmin <-min(x1024$U_TIME)
xmax <-max(x1024$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h1024 = hist(x1024$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x1024_pt <- round((h1024$breaks-min(h1024$breaks))/(max(h1024$breaks-min(h1024$breaks)))*100,0)
x1024_pt
z1024_pt <- round(h1024$counts/max(h1024$counts)*100,0)
z1024_pt 
### 2048 sec
binsize=5
x2048 = read.csv(file="2048_sec.dat",head=TRUE,sep="\t")
x2048  <- subset(x2048, x2048$ITERNUM != 166)
xmin <-min(x2048$U_TIME)
xmax <-max(x2048$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h2048 = hist(x2048$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x2048_pt <- round((h2048$breaks-min(h2048$breaks))/(max(h2048$breaks-min(h2048$breaks)))*100,0)
x2048_pt
z2048_pt <- round(h2048$counts/max(h2048$counts)*100,0)
z2048_pt
### 4096 sec
numSamples <- 300
x4096 = read.csv(file="4096_sec.dat",head=TRUE,sep="\t")
x4096 <- subset(x4096, x4096$ITERNUM <= numSamples)
binsize=5
x4096 <- subset(x4096, x4096$ITERNUM != 11 & x4096$ITERNUM != 32 & x4096$ITERNUM != 53 & x4096$ITERNUM != 74 & x4096$ITERNUM != 95 & x4096$ITERNUM != 116 & x4096$ITERNUM != 137 & x4096$ITERNUM != 158 & x4096$ITERNUM != 179 & x4096$ITERNUM != 200 & x4096$ITERNUM != 221 & x4096$ITERNUM != 242 & x4096$ITERNUM != 264)
xmin <-min(x4096$U_TIME)
xmax <-max(x4096$U_TIME)
nbins <- ceiling((xmax-xmin) / binsize)
h4096 = hist(x4096$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x4096_pt <- round((h4096$breaks-min(h4096$breaks))/(max(h4096$breaks-min(h4096$breaks)))*100,0)
x4096_pt
z4096_pt <- round(h4096$counts/max(h4096$counts)*100,0)
z4096_pt
### 8192 sec
numSamples <- 260
x8192 = read.csv(file="8192_sec.dat",head=TRUE,sep="\t")
x8192 <- subset(x8192, x8192$ITERNUM <= numSamples)
xmin <-min(x8192$U_TIME)
xmin <- xmin-2
xmax <-max(x8192$U_TIME)
xmax <- xmax+1
nbins <- ceiling((xmax-xmin) / binsize)
h8192 = hist(x8192$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x8192_pt <- round((h8192$breaks-min(h8192$breaks))/(max(h8192$breaks-min(h8192$breaks)))*100,0)
x8192_pt
z8192_pt <- round(h8192$counts/max(h8192$counts)*100,0)
z8192_pt
### 16384 sec
numSamples <- 130
x16384 = read.csv(file="16384_sec.dat",head=TRUE,sep="\t")
x16384 <- subset(x16384, x16384$ITERNUM <= numSamples)
binsize=10
xmin <-min(x16384$U_TIME)
xmin <- xmin-7
xmax <-max(x16384$U_TIME)
xmax <- xmax+5
nbins <- ceiling((xmax-xmin) / binsize)
h16384 = hist(x16384$U_TIME, right=F, breaks=seq(xmin,xmax+binsize,binsize),plot=F)
x16384_pt <- round((h16384$breaks-min(h16384$breaks))/(max(h16384$breaks-min(h16384$breaks)))*100,0)
x16384_pt
z16384_pt <- round(h16384$counts/max(h16384$counts)*100,0)
z16384_pt
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
