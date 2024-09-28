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
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_HASMC_vs_HASMC_chol_jointPos"
setUpOne="HASMC_untreatedPilot"
setUpTwo="HASMC_Chol"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/HASMC_Chol-vs-HASMC_untreatedPilot.csv"



python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1


variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_24h_jointPos"
setUpOne="TeloHAEC_CTRL"
setUpTwo="TeloHAEC_IL1b_24h"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/TeloHAEC_CTRL-vs-TeloHAEC_IL1b_24h.csv"


python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1


variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_RAW_CTRL_vs_RAW_IL1B_jointPos"
setUpOne="RAW_CTRL"
setUpTwo="RAW_IL1B"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/RAW_CTRL-vs-RAW_IL1B.csv"

python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1


variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_TGFB_jointPos"
setUpOne="ccell_3T3_undiff_CTRL"
setUpTwo="cell_3T3_undiff_TGFB"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/3T3_undiff_CTRL-vs-3T3_undiff_TGFB.csv"


python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1

variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_RAW_CTRL_vs_RAW_TGFB_jointPos"
setUpOne="RAW_CTRL"
setUpTwo="RAW_TGFB"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/RAW_CTRL-vs-RAW_TGFB.csv"


python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1


variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_diff_jointPos"
setUpOne="ccell_3T3_undiff_CTRL"
setUpTwo="cell_3T3_diff_CTRL"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/3T3_diff_CTRL-vs-3T3_undiff_CTRL.csv"


python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1


variants="jointPos_Alec"
setUpComp="FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_6h_jointPos"
setUpOne="TeloHAEC_CTRL"
setUpTwo="TeloHAEC_IL1b_6h"
motifSource="multitaskCNN_v2"
alecFile="./alec_p-vals/TeloHAEC_CTRL-vs-TeloHAEC_IL1b_6h.csv"

python VariantEffects/plot_p_value_vs_explainable_haplo_effect.py \
--input_explainable ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres_withMotifs.csv \
--input_all ./results/${setUpComp}_${motifSource}/${variants}_${setUpComp}_no_p_value_thres.csv \
--out_path ./results/${setUpComp}_${motifSource}/ \
--p_val_type pvalue \
--p_val_step 1

#tbd: plotting script