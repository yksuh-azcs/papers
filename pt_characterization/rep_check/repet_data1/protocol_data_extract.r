#total <- merge(h$breaks,h$counts,by=c("BIN","BIN Frequency"))
#total <- rbind(h$breaks, h$counts) 
#test <- matrix(192,1,length(h$breaks))
test <- matrix(192,length(h$breaks),1)
#test <- data.frame(test)
#test <- c(192,1:length(h$breaks)) 
#test <- 192
total <- paste(test,sep = "\t",h$breaks,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

test <- matrix(224,length(h$breaks),1)
total <- paste(test,sep = "\t",h$breaks,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

test <- matrix(256,length(h$breaks),1)
total <- paste(test,sep = "\t",h$breaks,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

test <- matrix(512,length(h$breaks),1)
total <- paste(test,sep = "\t",h$breaks,h$counts)
write.table(total, file="data.txt", quote=F, row.names=F)

