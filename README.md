# Parent of Origin with Haplotype Phasing 
This is the R pipeline I developed for the Oksenberg Lab to detect parent-of-origin effects in multiple sclerosis using haplotype phasing. This pipeline prepares PLINK files (.bed, .bim, and .fam files) for the many different analyses that can be conducted with parent-of-origin software PREMIM and EMIM, as well as haplotype phasing software SHAPEIT.  

Note: Abstract and complete documentation coming soon. In the meantime, here is the order in which these scripts should be run.

1) for affected_child...

affected_child_rfileMin.r

affected_child_premim_emim.sh

affected_child_master_script.r


2) for unaffected_child...

unaffected_child_rfileMin.r

unaffected_child_edit_affect.r

unaffected_child_premim_emim.sh

unaffected_child_master_script.r


3) BEFORE YOU PROCEED! ...

run swap_parents_post.r

4) for affected_parent_run...

affected_parent_run_rfileMin.r

affected_parent_run_edit_fam.r

affected_parent_premim_emim.sh

affected_parent_master_script.r


4) for unaffected_parent_run...

unaffected_parent_run_rfileMin.r

unaffected_parent_run_edit_fam.r

unaffected_parent_run_edit_affect.r

affected_parent_premim_emim.sh

affected_parent_master_script.r

