#! /bin/bash
### Submit this Script with: sbatch sbatch_ism.sh ###
 
# Parameters for slurm (don't remove the # in front of #SBATCH!)
#  Use partition debug:
#SBATCH --partition=long
#  Use one node:
#SBATCH --nodes=1
#  Request 4 cores (hard constraint):
#SBATCH -c 32
#  Request 50GB of memory (hard constraint):
#SBATCH --mem=50GB
#  Request one hour maximal execution time (hard constraint):
#SBATCH --time=7-00:00:00
#SBATCH --job-name=JASPARall


# Initialize the module system:sbat  
source /etc/profile.d/modules.sh
mkdir -p /fast/users/$USER/scratch/tmp
export TMPDIR=/fast/users/$USER/scratch/tmp



#HASMC
echo startInst
cat ./pipelineCommands/pipeline_jointPost_HASMC_vs_HASMC_chol_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_HASMC_vs_HASMC_chol_JASPAR+CNN.sh


#RAW IL1b
echo startInst
cat ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_IL1b_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_IL1b_JASPAR+CNN.sh


#RAW TGFB
echo startInst
cat ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_TGFB_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_TGFB_JASPAR+CNN.sh

#3T3 TGFB
echo startInst
cat ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_undiffTGFbeta_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_undiffTGFbeta_JASPAR+CNN.sh

#3T3 diff
echo startInst
cat ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_diff_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_diff_JASPAR+CNN.sh

#Telo IL1b6h
echo startInst
cat ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_6h_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_6h_JASPAR+CNN.sh

#Telo IL1b24h
echo startInst
cat ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_24h_JASPAR+CNN.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_24h_JASPAR+CNN.sh

echo finished
