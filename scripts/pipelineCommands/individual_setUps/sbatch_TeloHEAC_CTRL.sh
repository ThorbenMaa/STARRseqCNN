#! /bin/bash
### Submit this Script with: sbatch sbatch_ism.sh ###
 
# Parameters for slurm (don't remove the # in front of #SBATCH!)
#  Use partition debug:
#SBATCH --partition=medium
#  Use one node:
#SBATCH --nodes=1
#  Request 4 cores (hard constraint):
#SBATCH -c 4
#  Request 50GB of memory (hard constraint):
#SBATCH --mem=50GB
#  Request one hour maximal execution time (hard constraint):
#SBATCH --time=0-24:00:00
#SBATCH --job-name=Telo


# Initialize the module system:sbat  
source /etc/profile.d/modules.sh
mkdir -p /fast/users/$USER/scratch/tmp
export TMPDIR=/fast/users/$USER/scratch/tmp

echo startInst
# mamba activate CNN_TM
cat pipelineCommands/individual_setUps/multitaskCNN_TeloHEAC_CTRL.sh

echo start running scripts
bash pipelineCommands/individual_setUps/multitaskCNN_TeloHEAC_CTRL.sh

echo finished
