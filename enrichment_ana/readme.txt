
## file origins
.fa file from Nick from Minna project

see below for further descriptions


motifs from cnn (unfiltered but reduced redundancy, identical for different comparisons, even though file name suggests otherwise, sorry) or from JASPAR

## commands
mamba activate exp_activity_analysis

### CNN motifs

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


## further descriptions
Hi Thorben,

I've attached the following fasta files:

concordanceGroups5_12_up.fa 
This is oligos significant and up regulated in 5-12 samples

concordanceGroups5_12_down.fa
This is oligos significant and down regulated in 5-12 samples

concordanceGroups1.fa is for oligos only significant in a single sample. This has mixed directionality so let me know if that's suitable. 

We can also try with smaller groupings (7-12 samples) but that would reduce the number of oligos in half. Currently there's around 650 oligos per direction. 

Thanks,
Nick 


On Friday, September 6th, 2024 at 11:27, Thorben Maass <tho.maass@uni-luebeck.de> wrote:

Hi Minna, Hi Nick,
definitely an interesting analysis! Itís correct that my analysis focuses on the treatments, but the CNN motifs originate from the individual experiments, so it would still make sense to employ them. If one had a .fa file with sequences of the concordant oligos and a .fa file with all the others, one could check whether a particular motif is enriched in one or the other. I could provide the CNN motif PWMs in meme format and one could directly use FIMO (JASPAR motifs would also be an option of course). This would be quite straightforward, and I guess I could still run it once I have the .fa files. If somebody from your lab could produce a nice figure from the output table, we would have it. Happy to discuss this further!

The .fa file would look like the example one I attached to the mail. An example for the resulting fimo file is attached as well.
 
The result would be two fimo files for each set of sequences (concordant and non-concordant) and one could analyze them for percentual enrichment in one or the other. 
 
If you think this is feasible, just send me the corresponding .fa files and youíll get back the corresponding fimo.tsv files within a day or two.
 
 
One more question/comment to the figure you attached (which I like a lot!):
It could be good to see the actual numbers of concordant cases for each barplot and maybe a test (maybe Kruskal-Wallis) on whether or not the differences are significant. I could imagine that the rather low PhastCons for 10-12 are probably just a result of the quite low total numbers for these cases, would you (Nick and Minna) agree with that? One could do pairwise testing of the respectively adjacent barplots (e.g., 9 vs. 10, 10 vs. 11, maybe also 6 vs 7)? Itís a bit strange to me that there seems to be a peak from 7-9 and no continuously increasing ìcurveî. Just a suggestion of course, the analysis looks nice and I agree that the general observation definitely makes sense! 

Looking forward to discussing this further!
Thorben
 
From: Minna Kaikkonen-M‰‰tt‰ <minna.kaikkonen@uef.fi> 
Sent: Thursday, September 5, 2024 2:46 PM
To: Thorben Maass <tho.maass@uni-luebeck.de>
Cc: Nicholas Downes <ndownes@proton.me>
Subject: RE: STARR-Seq project update meeting
 
Thanks Thorben,
 
I will go through this and get back to you soon! One think that came to my mind when discussing with Nick was that can we independently look which motifs are enriched in the concordant oligos. So those SNPs that are regulated similarly (or not) across cell types. The picture below shows that those shared by 7-9 are more conserved across species but also perhaps they have shared motifs. So are we able to look at that data from your outputs or this gets too complicated? Also, perhaps not possible if your analysis was solely based on the treatment, right? Just thought to drop the question, sorry if it was not so clearly articulated ??
 
 
BR,
 
Minna
