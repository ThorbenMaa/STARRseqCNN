# STARRseqCNN (README needs update!!)

This repository contains and describes code used to train, evaluate, and interprete multi task STARRseq CNNs based on STARRseq data from multiple experimental set-ups provided by the [Kaikkonen Lab](https://uefconnect.uef.fi/en/group/cardiovascular-genomics-kaikkonen-lab/). The folder `models` contains the trained model used for further analysis described in the manuscript. 

### Clone this repository
Use `git clone https://github.com/ThorbenMaa/STARRseqCNN.git`. Operate from inside the directory.

### Install dependencies
I recommend to use [mamba](https://mamba.readthedocs.io/en/latest/installation.html) to create environments and install dependencies:

```
mamba env create --name CNN_TM --file=./envs/CNN_TM.yml
mamba env create --name modisco_lite --file=./envs/modisco_lite.yml
```


## Required files
Here is a list of required files that you need to place in this folder. Please start all scripts from this folder.
The STARRseq activity files:
 -2023-01-10_22-29-33\ myCounts.minDNAfilt.depthNorm.keepHaps\ -\ starr.haplotypes.oligo1.txt
 -2023-01-10_22-29-33\ myCounts.minDNAfilt.depthNorm.keepHaps\ -\ starr.haplotypes.oligo2.txt

A file with all oligos:
 -starrseq-all-final-toorder_oligocomposition.csv

Files with p-values.



## Worklflow multitask CNN training, evaluation, and interpretation

Run
```

# model training
mamba activate CNN_TM
bash model_train_eavl_interpretation/sbatch_Train_CNN_TM.sh

# test CNN
bash model_train_eavl_interpretation/sbatch_test_CNN.sh

# ism
bash model_train_eavl_interpretation/sbatch_ism_non_overfitted_multitask.sh


# tfmodisco-lite
## activate env
mamba activate modisco_lite

## download JASPAR and make it nice (without making it nice only the motif names but not the IDs will be displayed in the tfmodisco reports)
wget https://jaspar.genereg.net/download/data/2022/CORE/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt
cat JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt | awk '{{if ($1=="MOTIF") {{print $1,$2"_"$3,$3}} else {{print $0}}}}' > JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme_nice.txt


bash model_train_eavl_interpretation/sbatch_tfmodisco_v2_nonOverfitted.sh
```

## Workflow for analysis
All analysis pipelines can be found in the `PipelineCommands` folder. The ones named `pipeline_jointPost_*.sh` without `JASPAR` (i.e. with CNN motifs as motif source) were used for the manuscript.

Motif enrichment can be tested with the script `sbatch_run_all.sh` in the `enrichment_ana` folder. The script needs to be run from inside this folder.





