h$mids <- ceiling(h$mids)
test <- matrix(120,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(128,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(160,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

#total <- merge(h$breaks,h$counts,by=c("BIN","BIN Frequency"))
#total <- rbind(h$breaks, h$counts) 
#test <- matrix(192,1,length(h$breaks))
test <- matrix(192,length(h$breaks),1)
#test <- data.frame(test)
#test <- c(192,1:length(h$breaks)) 
#test <- 192
total <- paste(test,sep = "\t",h$breaks,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(192,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(224,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

test <- matrix(256,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(512,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(1024,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(2048,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(4096,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(8192,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

h$mids <- ceiling(h$mids)
test <- matrix(16384,length(h$mids),1)
total <- paste(test,sep = "\t",h$mids,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)
