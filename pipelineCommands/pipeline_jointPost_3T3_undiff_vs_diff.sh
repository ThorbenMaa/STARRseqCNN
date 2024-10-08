#!/bin/bash

#cd /data/gpfs-1/work/groups/ag_kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/

# train CNN
#mamba activate CNN_TM

#sbatch_Train_CNN_setUpSpec_TM.sh




# model interpretation
#sbatch sbatch_ism_spec.sh

#mamba activate modisco_lite_v3

#sbatch_tfmodisco_v2.sh

#mamba activae CNN_TM


# set Wildcards
variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_diff_jointPos"
setUpOne="ccell_3T3_undiff_CTRL"
setUpTwo="cell_3T3_diff_CTRL"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/3T3_diff_CTRL-vs-3T3_undiff_CTRL.csv"


# set meme path
export PATH=$HOME/meme/bin:$HOME/meme/libexec/meme-5.5.4:$PATH

mkdir ./results/${setUpComp}_${motifSource}
#: '
# extract all motifs
python ./allMotifsWithSignificantEffects/trimMotifs.py \
--outputPWM ./results/${setUpComp}_${motifSource}/${setUpComp}_PWMs.txt \
--reportFile modisco_results_v2hypothetical_contribution_scores_mean_ccell_3T3_undiff_CTRL.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_cell_3T3_diff_CTRL.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_cell_3T3_undiff_TGFB.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_HASMC_Chol.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_HASMC_untreatedPilot.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_HepG2_untreatedPilot.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_RAW_CTRL.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_RAW_IL1B.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_RAW_TGFB.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_TeloHAEC_CTRL.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_TeloHAEC_IL1b_24h.npz.h5 \
--reportFile modisco_DeepSTARR_reduced_new_DNA_counts_earlyStop.kerashypothetical_contribution_scores_mean_TeloHAEC_IL1b_6h.npz.h5



# remove similar motifs using tomtom
python ./allMotifsWithSignificantEffects/removeSimilarMotifs.py \
--PWM_file ./results/${setUpComp}_${motifSource}/${setUpComp}_PWMs.txt \
--outputPWM ./results/${setUpComp}_${motifSource}/condensed_${setUpComp}_PWMs.txt \
--tomtomSig 0.05

# run fimo (all motifs, all seqs)
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/FIMO.sh \
./results/${setUpComp}_${motifSource}/condensed_${setUpComp}_PWMs.txt \
all_seqs.fa \

# copy fimo output to results
mkdir ./results/${setUpComp}_${motifSource}/fimo_all_seqs
cp fimo_out/fimo.tsv ./results/${setUpComp}_${motifSource}/fimo_all_seqs/

# check whether CNN motifs lead to significantly higher exp. activity, write sig motifs to new file, check for JASPAR matches, plot
python ./allMotifsWithSignificantEffects/plot_experimental_activities_perSetUp_comp.py \
--output ./results/${setUpComp}_${motifSource}/${setUpComp} \
--outputPWMs ./results/${setUpComp}_${motifSource}/${setUpComp}_sigPWMs.txt \
--setUps ${setUpOne} \
--setUps ${setUpTwo} \
--PWMfile ./results/${setUpComp}_${motifSource}/condensed_${setUpComp}_PWMs.txt \
--tomtomSig 0.05 \
--number-motifs_to_plot 1 \
--fimoQual 1 \
--fimoFile ./results/${setUpComp}_${motifSource}/fimo_all_seqs/fimo.tsv




# check varaint effects
python VariantEffects/extractVariantEffectsFromMatchFile.py \
--output ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp} \
--p_value 0.01 \
--matchFile ${alecFile} \
--p_val_source jointPost \
--rerun_indel_exculsion False

#HARD CODED!

# run fimo sh (significant motifs, variants seqs)
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/FIMO.sh \
./results/${setUpComp}_${motifSource}/${setUpComp}_sigPWMs.txt \
./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_seqs.fa


# copy fimo output to results
mkdir ./results/${setUpComp}_${motifSource}/fimo_variant_seqs
cp fimo_out/fimo.tsv ./results/${setUpComp}_${motifSource}/fimo_variant_seqs/

# gives Number of variants that can be explained by overlapping with a motif (not same as of number of motifs that align with a variant!!!! This would be the output of plot_alignment... script).


#'
# check whether variants align with motifs
python VariantEffects/check_variant_within_motif.py \
--variantsFile ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}.csv \
--output ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_withMotifs \
--q_thres 1 \
--p_thres 0.0001 \
--fimoFile ./results/${setUpComp}_${motifSource}/fimo_variant_seqs/fimo.tsv \
--p_val_source jointPost


# plot variant motif alignments 
python VariantEffects/plot_alignment_withPWM.py \
--aligMotifFile ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_withMotifs.csv \
--PWMsFile ./results/${setUpComp}_${motifSource}/${setUpComp}_sigPWMs.txt \
--output ./results/${setUpComp}_${motifSource}/plot_${variants}_${setUpComp} \
--chunk_size 50



# calculate fraction of explainable effects per p-value thres
python VariantEffects/extractVariantEffectsFromMatchFile.py \
--output ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres \
--p_value 1 \
--matchFile ${alecFile} \
--p_val_source jointPost \
--rerun_indel_exculsion False

# run fimo sh (significant motifs, variants seqs)
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/FIMO.sh \
./results/${setUpComp}_${motifSource}/${setUpComp}_sigPWMs.txt \
./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_seqs.fa

# copy fimo output to results
mkdir ./results/${setUpComp}_${motifSource}/fimo_variant_seqs_no_p_value_thres
cp fimo_out/fimo.tsv ./results/${setUpComp}_${motifSource}/fimo_variant_seqs_no_p_value_thres/

python VariantEffects/check_variant_within_motif.py \
--variantsFile ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--output ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs \
--q_thres 1 \
--p_thres 0.0001 \
--fimoFile ./results/${setUpComp}_${motifSource}/fimo_variant_seqs_no_p_value_thres/fimo.tsv \
--p_val_source jointPost


python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue


python VariantEffects/plot_p_value_vs_explainable_haplo_effect_bins.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--bin_size 100 \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue







#tbd: plotting script