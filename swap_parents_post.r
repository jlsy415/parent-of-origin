#in order to switch the analysis from gender analysis to affectation status analysis, the mother and father listings of the proband must also be swapped.
#this script should be executed before any of the scripts in either runs involving changing parental status of parents
dir <- ""

for ( i in 1:22) {
	dir[i] <- paste(c("chr", i), collapse="")
}

dirr <- c("affected_parent_run", "unaffected_parent_run")

for (index in dir){
	for (indexx in dirr) {
		dir_one <- paste(c("~/Desktop/post_final_run/", indexx, "/", index, "_im"), collapse="")
		dir_two <- paste(c("~/Desktop/post_final_run/", indexx, "/", index, "_ip"), collapse="")
		if (indexx == "affected_parent_run") {
			dir_three <- paste(c("Quartets_trio_1affected4_", index, ".fam"), collapse="")
		} else {
			dir_three <- paste(c("Quartets_trio_1unaffected4_", index, ".fam"), collapse="")
		}
		fam <- read.table(paste(c(dir_one, "/", dir_three), collapse=""), quote="\"", comment.char="", stringsAsFactors=FALSE)

	#not all pedigrees require that the parents be swapped; only some
	#this identifies children with pedigrees that need swapping, and then swaps the parents
	fam_id <- rep(0, nrow(fam))
	for (i in 1:nrow(fam)) {
		if (is.na(fam[i,3]) == TRUE && fam[i,5] == 1 && fam[i,6] ==2) {
			fam_id[i] <- fam[i,1]
		}
		for (j in 1:nrow(fam)) {
			if (is.na(fam[i,3]) == FALSE && fam[i,1] == fam_id[j]) {
				father <- fam[i,3] 
				mother <- fam[i,4]
				fam[i,3] <- mother
				fam[i,4] <- father
 			}
		}

	}

	#output tables comes here
	setwd(dir_one)
	write.table(fam, file=dir_three, row.names=FALSE, col.names=FALSE, quote=FALSE)
	setwd(dir_two)
	write.table(fam, file=dir_three, row.names=FALSE, col.names=FALSE, quote=FALSE)
	}
}