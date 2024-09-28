#!/bin/bash





python allMotifsWithSignificantEffects/plot_heatmap_sig_motifs.py \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_6h_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_6h_jointPosmotif_specificity_stats.tsv" \
--comparison "TeloHAEC vs. TeloHAEC IL1b (6h)" \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_24h_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_diffTeloHEAC_CTRL_vs_24h_jointPosmotif_specificity_stats.tsv" \
--comparison "TeloHAEC vs. TeloHAEC IL1b (24h)" \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_RAW_CTRL_vs_RAW_IL1B_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_RAW_CTRL_vs_RAW_IL1B_jointPosmotif_specificity_stats.tsv" \
--comparison "RAW vs. RAW + IL1b" \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_RAW_CTRL_vs_RAW_TGFB_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_RAW_CTRL_vs_RAW_TGFB_jointPosmotif_specificity_stats.tsv" \
--comparison "RAW vs. RAW + TGFb" \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_TGFB_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_TGFB_jointPosmotif_specificity_stats.tsv" \
--comparison "3T3 undiff vs. 3T3 undiff + TGFb" \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_diff_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_diff3T3_undiff_vs_diff_jointPosmotif_specificity_stats.tsv" \
--comparison "3T3 undiff vs. 3T3 diff" \
--sig_files "/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/results/FIMO_p_val_larger_new_DNA_counts_noInDels_HASMC_vs_HASMC_chol_jointPos_multitaskCNN_v2/FIMO_p_val_larger_new_DNA_counts_noInDels_HASMC_vs_HASMC_chol_jointPosmotif_specificity_stats.tsv" \
--comparison "HASMC vs. HASMC + chol" \
--p_val_thres 0.01







echo fertig