#initializes string vector c("chr1", "chr2", ..., "chr22")
#note: PREMIM and EMIM does not extend to sex chromosomes
dirr <- ""
for (i in 1:22) {
	dirr[i] <- paste(c("chr", i), collapse="")
}

#this changes the affectation statuses of the parents to match their gender
#thus, parental imprinting becomes a test for unaffected parent imprinting; maternal, for affected parent.
for (index in dirr) {
	#specifies directories to use, these paths will have to be edited for different computers
	dir_one <- paste(c("~/Desktop/post_final_run/affected_parent_run/", index, "_im"), collapse="")
	dir_two <- paste(c("../", index, "_ip"), collapse="")
	dir_three <- paste(  c("Quartets_trio_1affected4_", index, ".fam"), collapse="")

	#import datasets
	setwd(dir_one)
	fam_one <- read.table( paste(  c("Quartets_trio_1affected4_", index, ".fam"), collapse="") )
	fam_one$V5[is.na(fam_one$V3)] <- fam_one$V6[is.na(fam_one$V3)]
	write.table(fam_one, file=dir_three, row.names=FALSE, col.names=FALSE)

	setwd(dir_two)
	fam_two <- read.table( paste(  c("Quartets_trio_1affected4_", index, ".fam"), collapse="") )
	fam_two$V5[is.na(fam_two$V3)] <- fam_two$V6[is.na(fam_two$V3)]
	write.table(fam_two, file=dir_three, row.names=FALSE, col.names=FALSE)
}