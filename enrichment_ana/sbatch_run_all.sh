#!/bin/bash
### Submit this Script with: sbatch sbatch_ism.sh ###
 
# Parameters for slurm (don't remove the # in front of #SBATCH!)
#  Use partition debug:
#SBATCH --partition=medium
#  Use one node:
#SBATCH --nodes=1
#  Request 4 cores (hard constraint):
#SBATCH -c 16
#  Request 50GB of memory (hard constraint):
#SBATCH --mem=50GB
#  Request one hour maximal execution time (hard constraint):
#SBATCH --time=0-48:00:00
#SBATCH --job-name=enrichment


# Initialize the module system:sbat  
source /etc/profile.d/modules.sh
mkdir -p /data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/
export TMPDIR=/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/
export TMP=/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/
export TEMP=/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/


# run all as described in readme.txt

echo CNN motifs...

motif_file="motifs/condensed_FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_6h_jointPos_PWMs.txt"
fasta_file="fasta_files_from_nick/concordanceGroups1.fa"
outfile="results/CNN_concordanceGroups1"

fimo \
--verbosity 1 \
--oc ${outfile} \
${motif_file} \
${fasta_file}


motif_file="motifs/condensed_FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_6h_jointPos_PWMs.txt"
fasta_file="fasta_files_from_nick/concordanceGroups5_12_up.fa"
outfile="results/CNN_concordanceGroups5_12_up"

fimo \
--verbosity 1 \
--oc ${outfile} \
${motif_file} \
${fasta_file}


motif_file="motifs/condensed_FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_6h_jointPos_PWMs.txt"
fasta_file="fasta_files_from_nick/concordanceGroups5_12_down.fa"
outfile="results/CNN_concordanceGroups5_12_down"

fimo \
--verbosity 1 \
--oc ${outfile} \
${motif_file} \
${fasta_file}

### JASPAR motifs
echo JASPAR motifs...
motif_file="motifs/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme_nice.txt"
fasta_file="fasta_files_from_nick/concordanceGroups1.fa"
outfile="results/JASPAR_concordanceGroups1"

fimo \
--verbosity 1 \
--oc ${outfile} \
${motif_file} \
${fasta_file}


motif_file="motifs/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme_nice.txt"
fasta_file="fasta_files_from_nick/concordanceGroups5_12_up.fa"
outfile="results/JASPAR_concordanceGroups5_12_up"

fimo \
--verbosity 1 \
--oc ${outfile} \
${motif_file} \
${fasta_file}


motif_file="motifs/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme_nice.txt"
fasta_file="fasta_files_from_nick/concordanceGroups5_12_down.fa"
outfile="results/JASPAR_concordanceGroups5_12_down"

fimo \
--verbosity 1 \
--oc ${outfile} \
${motif_file} \
${fasta_file}
