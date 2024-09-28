python ./allMotifsWithSignificantEffects/trimMotifs.py --output trimmed_PWMs.txt

python ./ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/sanityCheck_extract_Sequences.py --seqFile starrseq-all-final-toorder_oligocomposition.csv --output all_seqs.fa

bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/FIMO.sh trimmed_PWMs.txt all_seqs.fa

python ./allMotifsWithSignificantEffects/plot_experimental_activities_perSetUp.py 


#neu
export PATH=$HOME/meme/bin:$HOME/meme/libexec/meme-5.5.4:$PATH

python ./allMotifsWithSignificantEffects/trimMotifs.py --outputPWM test.txt

python ./allMotifsWithSignificantEffects/removeSimilarMotifs.py --outputPWM condensed_test.txt
 
bash ExpSetUpSpecificCNN/sanityCheck_expMotifAcitvity/FIMO.sh condensed_test.txt all_seqs.fa

python ./allMotifsWithSignificantEffects/plot_experimental_activities_perSetUp.py 
or
python ./allMotifsWithSignificantEffects/plot_experimental_activities_perSetUp_comp.py 
 
 

