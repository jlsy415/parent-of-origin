#initializes string vector c("chr1", "chr2", ..., "chr22")
#note: PREMIM and EMIM does not extend to sex chromosomes
dirr <- ""
for (i in 1:22) {
	dirr[i] <- paste(c("chr", i), collapse="")
}


#in this pipeline, minor alleles are treated as risk alleles
#PREMIM and EMIM finds minor alleles from provided sample; to ensure that minor alleles are not mistaken as major alleles, minor alleles are provided
for (index in dirr) {
	#specifies directories to use, these paths will have to be edited for different computers
	dir_one <- paste(c("~/Desktop/post_final_run/affected_child/", index, "_im"), collapse="")
	dir_two <- paste(c("../", index, "_ip"), collapse="")

	#import datasets
	setwd(dir_one)
	bim <- read.table( paste(  c("Quartets_trio_1affected4_", index, ".bim"), collapse="") ) #name of bim file
	bim <- bim[,c(1,2,5)]
	bim[,1] <- rownames(bim)
	write.table(bim, file="rfileMin.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
	setwd(dir_two)
	write.table(bim, file="rfileMin.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
}