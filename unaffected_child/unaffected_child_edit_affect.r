#initializes string vector c("chr1", "chr2", ..., "chr22")
#note: PREMIM and EMIM does not extend to sex chromosomes
dirr <- ""
for (i in 1:22) {
	dirr[i] <- paste(c("chr", i), collapse="")
}

#this edits the fam file to make the unaffected child the proband instead of the affected child
for (index in dirr) {
	#again, these directories must be customized to one's own paths
	dir_one <- paste(c("~/Desktop/post_final_run/unaffected_child/", index, "_im"), collapse="")
	dir_two <- paste(c("../", index, "_ip"), collapse="")
	dir_three <- paste(  c("Quartets_trio_1unaffected4_", index, ".fam"), collapse="")

	#import datasets
	setwd(dir_one)
	fam_one <- read.table( paste(  c("Quartets_trio_1unaffected4_", index, ".fam"), collapse="") )
	fam_one$V6[!is.na(fam_one$V3)] <- 2
	write.table(fam_one, file=dir_three, row.names=FALSE, col.names=FALSE, quote=FALSE)
	setwd(dir_two)
	write.table(fam_one, file=dir_three, row.names=FALSE, col.names=FALSE, quote=FALSE)
}