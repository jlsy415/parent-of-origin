
#same procedure of rfileMin creation in affected_child, please check affected_child_rfileMin.r for detailed comments
dirr <- ""
for (i in 1:22) {
	dirr[i] <- paste(c("chr", i), collapse="")
}

for (index in dirr) {
	dir_one <- paste(c("~/Desktop/post_final_run/unaffected_child/", index, "_im"), collapse="")
	dir_two <- paste(c("../", index, "_ip"), collapse="")

	#import datasets
	setwd(dir_one)
	bim <- read.table( paste(  c("Quartets_trio_1unaffected4_", index, ".bim"), collapse="") )
	bim <- bim[,c(1,2,5)]
	bim[,1] <- rownames(bim)
	write.table(bim, file="rfileMin.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
	setwd(dir_two)
	write.table(bim, file="rfileMin.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
}