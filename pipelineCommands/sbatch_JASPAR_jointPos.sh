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
mkdir -p /data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/
export TMPDIR=/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/
export TMP=/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/
export TEMP=/data/cephfs-2/unmirrored/groups/kircher/Kaikkonen_2023/filesFromMinnaKaikkonen/github_repo/STARseqCNN/tempo_files/

#TeloHAEC 24h ohne JASPAR (remove later)
#echo startInst
#cat ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_24h.sh
#echo run skripts
#bash ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_24h.sh

#3t3 diff vs undiff ohne JASPAR mit MPRAlm (remove later; becuase of weird enrichement plot )
#echo startInst
#cat ./pipelineCommands/pipeline_MPRAlm_3T3_undiff_vs_TGFB.sh
#echo run skripts
#bash ./pipelineCommands/pipeline_MPRAlm_3T3_undiff_vs_TGFB.sh

#HASMC ohne JASPAR mit MPRAlm (remove later; becuase of weird enrichement plot )
#echo startInst
#cat ./pipelineCommands/pipeline_MPRAlm_HASMC_vs_HASMC_chol.sh
#echo run skripts
#bash ./pipelineCommands/pipeline_MPRAlm_HASMC_vs_HASMC_chol.sh

#HASMC
echo startInst
cat ./pipelineCommands/pipeline_jointPost_HASMC_vs_HASMC_chol_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_HASMC_vs_HASMC_chol_JASPAR.sh


#RAW IL1b
echo startInst
cat ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_IL1b_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_IL1b_JASPAR.sh


#RAW TGFB
echo startInst
cat ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_TGFB_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_RAW_CTRL_vs_TGFB_JASPAR.sh

#3T3 TGFB
echo startInst
cat ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_undiffTGFbeta_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_undiffTGFbeta_JASPAR.sh

#3T3 diff
echo startInst
cat ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_diff_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_3T3_undiff_vs_diff_JASPAR.sh

#Telo IL1b6h
echo startInst
cat ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_6h_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_6h_JASPAR.sh

#Telo IL1b24h
echo startInst
cat ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_24h_JASPAR.sh
echo run skripts
bash ./pipelineCommands/pipeline_jointPost_TeloHAEC_CTRL_vs_IL1b_24h_JASPAR.sh

echo finished
