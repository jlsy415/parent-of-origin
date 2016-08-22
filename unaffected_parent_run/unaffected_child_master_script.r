#note: this is exactly the same as the master script in affected_child
#please check affected_child_master_script.r for more detailed comments

library(ggplot2)
library(scales)

dirr <- ""
for (i in 1:22) {
	dirr[i] <- paste(c("chr", i), collapse="")
}

#processing
for (index in dirr) {
	dir_one <- paste(c("~/Desktop/post_final_run/unaffected_child/", index, "_im"), collapse="")
	dir_two <- paste(c("~/Desktop/post_final_run/unaffected_child/", index, "_im/Quartets_trio_1unaffected4_", index, ".bim"), collapse="")
	dir_three <- paste(c("../", index, "_ip"), collapse="")
	dir_four <- paste(c(index, "_master.txt"), collapse="")
	dir_five <- paste(c("P Values for Maternal and Paternal Imprinting for ", index), collapse="")
	dir_six <- paste(c("p-value_mirror_graph_", index, ".pdf"), collapse="")

	#import datasets
	setwd(dir_one)
	marker <- read.table("emimmarkers.dat")
	rout_im <- read.table("rout_file")
	sum_im <- read.table("emimsummary.out", header=TRUE)
	bim <- read.delim(dir_two, header=FALSE, stringsAsFactors=FALSE)
	setwd(dir_three)
	rout_ip <- read.table("rout_file")
	sum_ip <- read.table("emimsummary.out", header=TRUE)

	#make sure twicediff are numeric and convert to p values
	sum_im$twicediff <- as.numeric(sum_im$twicediff)
	sum_ip$twicediff <- as.numeric(sum_ip$twicediff)
	sum_im$p_im <- pchisq(sum_im$twicediff, 1, lower.tail=FALSE)
	sum_ip$p_ip <- pchisq(sum_ip$twicediff, 1, lower.tail=FALSE)
	sum_im <- sum_im[-log10(sum_im$p_im) > -20,]
	sum_ip <- sum_ip[-log10(sum_ip$p_ip) > -20,]

	#make table
	master <- cbind(bim$V1, marker$V1, bim$V2, bim$V4, bim$V5, bim$V6, marker$V2, sum_im[,20:23], sum_im$twicediff, sum_im$p_im, sum_ip[,24:27], sum_ip$twicediff, sum_ip$p_ip)
	names(master) <- c("chr", "snp_number", "snpID", "snp_position", "minor_allele", "major_allele", "minor_allele_freq", "lnIm", "sd_lnIm", "cl_lnIm", "cu_lnIm", "twicediff_im", "p_im", "lnIp", "sd_lnIp", "cl_lnIp", "cu_lnIp", "twicediff_ip", "p_ip")
	setwd("../output_files")
	write.table(master, file=dir_four, row.names=FALSE)

	#create tidy data
	tidy_im <- cbind(bim$V4, sum_im[,c(2,48)])
	tidy_ip <- cbind(bim$V4, sum_ip[,c(2,48)])
	tidy_im$type <- "maternal imprinting"
	tidy_ip$type <- "paternal imprinting"
	names(tidy_im) <- c("pos", "id","p_value", "type")
	names(tidy_ip) <- c("pos", "id","p_value", "type")
	tidy <- rbind(tidy_im, tidy_ip)
	tidy <- tidy[,-2]
	names(tidy) <- c("pos", "log_p_values", "type")
	tidy$log_p_values <- -log10(tidy$log_p_values)
	tidy$type <- as.factor(tidy$type)

	#process tidy p_values to negative
	for (i in 1:nrow(tidy)) {
		if (tidy$type[i] == "paternal imprinting") {
			tidy$log_p_values[i] <- -tidy$log_p_values[i]
		}
	}

	#formatter
	mirplot_formatter <- function(x) {
		ab <- abs(x)
	}

	#plot
	ggplot(tidy, aes(x=pos,y=log_p_values, col=type)) + geom_point() + 
		geom_hline(yintercept = -log10(0.05/nrow(bim))) +
		geom_hline(yintercept = log10(0.05/nrow(bim)))  +
		labs(title = dir_five, x="SNP position on chromosome", y="-log10(P Values)") + 
		theme_light() + scale_y_continuous(label=mirplot_formatter) + scale_x_continuous(label=comma) 
	ggsave(file=dir_six, width=11, height=8.5)
	#change to megabases


	#check function
	if (sum(rout_im$V2 == rout_ip$V2) == length(rout_im$V2)) {
		print("SNPs line up")
	} else {
		print("ERROR")
	}
}



