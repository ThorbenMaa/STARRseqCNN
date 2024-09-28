# prepare seqs
python ./ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/sanityCheck_extract_Sequences.py --seqFile starrseq-all-final-toorder_oligocomposition.csv --output all_seqs.fa

# prepare motif PWM
python ./ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/sanityCheck_extract_motifPWM.py --motif MA1130.1_FOSL::JUN --motif  --output test.txt

# run fimo
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/FIMO.sh test.txt all_seqs.fa

# plot
python ./ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/plot_experimental_activities.py --setUps TeloHAEC_CTRL --setUps TeloHAEC_IL1b_6h


#run entire pipeline using
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/plt_pipeline_on_all_TeloHEAC_CTRL_vs_6hIL1b.sh
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/plt_pipeline_on_all_HepG2_vs_TeloHEAC_CTRL.sh
