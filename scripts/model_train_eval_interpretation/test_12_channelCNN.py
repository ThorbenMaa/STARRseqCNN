#set seed and load dependencies
seed_value=1234
import os
from xmlrpc.client import boolean
os.environ['PYTHONHASHSEED']=str(seed_value)
os.environ["TF_CPP_MIN_LOG_LEVEL"]="2" #to supress warnings with loading tf
import random
random.seed(seed_value)#to make training reproducable, 1234 is abitrary
import numpy as np
np.random.seed(seed_value)#to make training reproducable, 1234 is abitrary
import matplotlib.pyplot as plt
import pandas as pd
import sys
import tensorflow as tf
from tensorflow import keras
tf.random.set_seed(seed_value)
from scipy import stats
import click

@click.command()
@click.option(
    "--activityFile",
    "activity_file",
    required=True,
    multiple=True,
    type=str,
    default=["2023-01-10_22-29-33 myCounts.minDNAfilt.depthNorm.keepHaps - starr.haplotypes.oligo1.txt", "2023-01-10_22-29-33 myCounts.minDNAfilt.depthNorm.keepHaps - starr.haplotypes.oligo2.txt" ],
    help="e.g. 2023-01-10_22-29-33 myCounts.minDNAfilt.depthNorm.keepHaps - starr.haplotypes.oligo1.txt",
)
@click.option(
    "--seqFile",
    "seq_file",
    required=True,
    multiple=False,
    type=str,
    default="starrseq-all-final-toorder_oligocomposition.csv",
    help="e.g. starrseq-all-final-toorder_oligocomposition.csv",
)
@click.option(
    "--sequence_length",
    "sequence_length",
    required=True,
    multiple=False,
    type=int,
    default=198,
    help="length of input seqs",
)
@click.option(
    "--batch_size",
    "batch_size",
    required=True,
    multiple=False,
    type=int,
    default=128,
    help="batch size",
)
@click.option(
    "--modelName",
    "model_name",
    required=True,
    multiple=False,
    type=str,
    default="TM_s_model",
    help="name uder that the model is stored",
)
@click.option(
    "--holdOutChr",
    "hold_out_chr",
    required=True,
    multiple=False,
    type=str,
    default="chr8",
    help="e.g., chr8 . used as hold out for testing. cross validation is not advisible if you don't know how the seqs were designed",
)
def cli(activity_file, seq_file, sequence_length, batch_size, model_name, hold_out_chr):

    #import labels
    df_list=[]
    for i in range (0, len(activity_file), 1):
        df_list.append(pd.read_csv(activity_file[i], sep="\t", decimal=',', low_memory=False))
    df_IDs_reg_labels = pd.concat(df_list, axis=0)
    df_IDs_reg_labels=df_IDs_reg_labels.drop_duplicates()


    #import sequences
    df_IDs_Sequences=pd.read_csv(seq_file, sep=",",low_memory=False)

    #remove ">" as first character from ID column
    df_IDs_Sequences["name"]=df_IDs_Sequences["name"].str[1:]

    #convert seqs to list and transform to one hot ecnoceded seqs; add to imported sequences data frame; drop sequences with wrong sequence length
    sequence_list=df_IDs_Sequences['enhancer'].to_list()
    sequences_tok=[]

    for i in range (0, len(sequence_list), 1): 
        if  len(sequence_list[i])==sequence_length:
            sequences_tok.append(one_hot_encode(sequence_list[i]))
        else:
            sequences_tok.append(np.nan)

    #add one-hot-encoded to data frame
    df_IDs_Sequences['Seq one hot encoded'] = sequences_tok

    #drop duplicates
    df_IDs_Sequences=df_IDs_Sequences.dropna()

    #merge data frames on name/oligo columns
    df_IDs_Sequences=df_IDs_Sequences.rename(columns={'name': 'ID'})
    df_IDs_reg_labels=df_IDs_reg_labels.rename(columns={'Oligo': 'ID'})
    df_IDs_seqs_reg_labels=pd.merge(df_IDs_Sequences, df_IDs_reg_labels, on=["ID"])

    #average data over replica to generate labels, systematic +1 to be able to log transform, normalize by dividing by mean_input2022Dec

    #input for normalization (old)
    #df_IDs_seqs_reg_labels['mean_input2022Dec'] = df_IDs_seqs_reg_labels.loc[:, ["input2022Dec_50ng_rep1_2022_12_14", "input2022Dec_50ng_rep2_2022_12_14", "input2022Dec_50ng_rep3_2022_12_14", "input2022Dec_50ng_rep4_2022_12_14"]].mean(axis=1) + 1

    #input for normalization (new 08/19/2024)
    df_IDs_seqs_reg_labels['mean_input2022Dec'] = df_IDs_seqs_reg_labels.loc[:, ["Input_50C_10ng", "Input_50C_20ng", "Input_50C_50ng"]].mean(axis=1) + 1
    
    #3T3
    df_IDs_seqs_reg_labels['mean_cell_3T3_diff_CTRL'] = df_IDs_seqs_reg_labels.loc[:, ["cell_3T3_diff_CTRL_rep1_2022_12_14", "cell_3T3_diff_CTRL_rep2_2022_12_14", "cell_3T3_diff_CTRL_rep3_2022_12_14", "cell_3T3_diff_CTRL_rep4_2022_12_14"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_ccell_3T3_undiff_CTRL'] = df_IDs_seqs_reg_labels.loc[:, ["cell_3T3_undiff_CTRL_rep1_2022_12_14", "cell_3T3_undiff_CTRL_rep2_2022_12_14", "cell_3T3_undiff_CTRL_rep3_2022_12_14", "cell_3T3_undiff_CTRL_rep4_2022_12_14"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_cell_3T3_undiff_TGFB'] = df_IDs_seqs_reg_labels.loc[:, ["cell_3T3_undiff_TGFB_rep1_2022_12_14", "cell_3T3_undiff_TGFB_rep2_2022_12_14", "cell_3T3_undiff_TGFB_rep3_2022_12_14", "cell_3T3_undiff_TGFB_rep4_2022_12_14"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    #RAW
    df_IDs_seqs_reg_labels['mean_RAW_CTRL'] = df_IDs_seqs_reg_labels.loc[:, ["RAW_CTRL_rep1_2022_12_14", "RAW_CTRL_rep2_2022_12_14", "RAW_CTRL_rep3_2022_12_14", "RAW_CTRL_rep4_2022_12_14"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_RAW_IL1B'] = df_IDs_seqs_reg_labels.loc[:, ["RAW_IL1B_rep1_2022_12_14", "RAW_IL1B_rep2_2022_12_14", "RAW_IL1B_rep3_2022_12_14", "RAW_IL1B_rep4_2022_12_14"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_RAW_TGFB'] = df_IDs_seqs_reg_labels.loc[:, ["RAW_TGFB_rep1_2022_12_14", "RAW_TGFB_rep2_2022_12_14", "RAW_TGFB_rep3_2022_12_14", "RAW_TGFB_rep4_2022_12_14"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    #TeloHAEC
    df_IDs_seqs_reg_labels['mean_TeloHAEC_CTRL'] = df_IDs_seqs_reg_labels.loc[:, ["TeloHAEC_CTRL_rep1", "TeloHAEC_CTRL_rep2", "TeloHAEC_CTRL_rep3"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_TeloHAEC_IL1b_24h'] = df_IDs_seqs_reg_labels.loc[:, ["TeloHAEC_IL1b_24h_rep1", "TeloHAEC_IL1b_24h_rep2", "TeloHAEC_IL1b_24h_rep3"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_TeloHAEC_IL1b_6h'] = df_IDs_seqs_reg_labels.loc[:, ["TeloHAEC_IL1b_6h_rep1", "TeloHAEC_IL1b_6h_rep2", "TeloHAEC_IL1b_6h_rep3"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    #HASMC
    df_IDs_seqs_reg_labels['mean_HASMC_untreatedPilot'] = df_IDs_seqs_reg_labels.loc[:, ["HASMC_untreatedPilot_rep1", "HASMC_untreatedPilot_rep2", "HASMC_untreatedPilot_rep3"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    df_IDs_seqs_reg_labels['mean_HASMC_Chol'] = df_IDs_seqs_reg_labels.loc[:, ["HASMC_Chol_rep1", "HASMC_Chol_rep2", "HASMC_Chol_rep3"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']
    #HepG2
    df_IDs_seqs_reg_labels['mean_HepG2_untreatedPilot'] = df_IDs_seqs_reg_labels.loc[:, ["HepG2_untreatedPilot_rep1", "HepG2_untreatedPilot_rep2", "HepG2_untreatedPilot_rep3"]].mean(axis=1) + 1 / df_IDs_seqs_reg_labels['mean_input2022Dec']



    #split data to train and test data
    df_IDs_seqs_reg_labels_test=df_IDs_seqs_reg_labels.loc[(df_IDs_seqs_reg_labels['ID'].str.contains(str(hold_out_chr)))==True]

 

    #labels test data
    input_label_test=tf.convert_to_tensor([df_IDs_seqs_reg_labels_test["mean_cell_3T3_diff_CTRL"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_ccell_3T3_undiff_CTRL"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_cell_3T3_undiff_TGFB"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_RAW_CTRL"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_RAW_IL1B"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_RAW_TGFB"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_TeloHAEC_CTRL"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_TeloHAEC_IL1b_24h"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_TeloHAEC_IL1b_6h"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_HASMC_untreatedPilot"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_HASMC_Chol"].to_list(),
                                        df_IDs_seqs_reg_labels_test["mean_HepG2_untreatedPilot"].to_list()                                    
    ])

    #log transform and transpose
    input_label_test=tf.math.log(tf.transpose(input_label_test))
    #sequences test data
    input_seq_test=tf.cast(tf.convert_to_tensor(df_IDs_seqs_reg_labels_test["Seq one hot encoded"].to_list()), tf.int8)


    model=keras.models.load_model(str(model_name))

    # loaded model on test data
    model.evaluate(input_seq_test, input_label_test, batch_size=batch_size, verbose=2)

    #calculate predicted labels
    predictions=model.predict(input_seq_test, batch_size=batch_size, verbose=2)

    #correlations of predicted and experimental labels for different cell types
    print(stats.pearsonr(predictions[:,0], input_label_test[:,0]))
    print(stats.pearsonr(predictions[:,1], input_label_test[:,1]))
    print(stats.pearsonr(predictions[:,2], input_label_test[:,2]))
    print(stats.pearsonr(predictions[:,3], input_label_test[:,3]))
    print(stats.pearsonr(predictions[:,4], input_label_test[:,4]))
    print(stats.pearsonr(predictions[:,5], input_label_test[:,5]))
    print(stats.pearsonr(predictions[:,6], input_label_test[:,6]))
    print(stats.pearsonr(predictions[:,7], input_label_test[:,7]))
    print(stats.pearsonr(predictions[:,8], input_label_test[:,8]))
    print(stats.pearsonr(predictions[:,9], input_label_test[:,9]))
    print(stats.pearsonr(predictions[:,10], input_label_test[:,10]))
    print(stats.pearsonr(predictions[:,11], input_label_test[:,11]))

    #scatterplots of predicted and experimental labels for different cell types
    print("save plots as svg")
    plt.scatter(predictions[:,0], input_label_test[:,0], s=1)
    plt.title('mean_cell_3T3_diff_CTRL'+str(stats.pearsonr(predictions[:,0], input_label_test[:,0])))
    plt.savefig(str(model_name)+"_mean_cell_3T3_diff_CTRL.svg")
    plt.close()
    plt.scatter(predictions[:,1], input_label_test[:,1], s=1)
    plt.title('mean_ccell_3T3_undiff_CTRL'+str(stats.pearsonr(predictions[:,0], input_label_test[:,1])))
    plt.savefig(str(model_name)+"_mean_ccell_3T3_undiff_CTRL.svg")
    plt.close()
    plt.scatter(predictions[:,2], input_label_test[:,2], s=1)
    plt.title('mean_cell_3T3_undiff_TGFB'+str(stats.pearsonr(predictions[:,0], input_label_test[:,2])))
    plt.savefig(str(model_name)+"_mean_cell_3T3_undiff_TGFB.svg")
    plt.close()
    plt.scatter(predictions[:,3], input_label_test[:,3], s=1)
    plt.title('mean_RAW_CTRL'+str(stats.pearsonr(predictions[:,0], input_label_test[:,3])))
    plt.savefig(str(model_name)+"_mean_RAW_CTRL.svg")
    plt.close()
    plt.scatter(predictions[:,4], input_label_test[:,4], s=1)
    plt.title('mean_RAW_IL1B'+str(stats.pearsonr(predictions[:,0], input_label_test[:,4])))
    plt.savefig(str(model_name)+"_mean_RAW_IL1B.svg")
    plt.close()
    plt.scatter(predictions[:,5], input_label_test[:,5], s=1)
    plt.title('mean_cell_3T3_diff_CTRL'+str(stats.pearsonr(predictions[:,0], input_label_test[:,5])))
    plt.savefig(str(model_name)+"_mean_RAW_TGFB.svg")
    plt.close()
    plt.scatter(predictions[:,6], input_label_test[:,6], s=1)
    plt.title('mean_TeloHAEC_CTRL'+str(stats.pearsonr(predictions[:,0], input_label_test[:,6])))
    plt.savefig(str(model_name)+"_mean_TeloHAEC_CTRL.svg")
    plt.close()
    plt.scatter(predictions[:,7], input_label_test[:,7], s=1)
    plt.title('mean_TeloHAEC_IL1b_24h'+str(stats.pearsonr(predictions[:,0], input_label_test[:,7])))
    plt.savefig(str(model_name)+"_mean_TeloHAEC_IL1b_24h.svg")
    plt.close()
    plt.scatter(predictions[:,8], input_label_test[:,8], s=1)
    plt.title('mean_TeloHAEC_IL1b_6h'+str(stats.pearsonr(predictions[:,0], input_label_test[:,8])))
    plt.savefig(str(model_name)+"_mean_TeloHAEC_IL1b_6h.svg")
    plt.close()
    plt.scatter(predictions[:,9], input_label_test[:,9], s=1)
    plt.title('mean_HASMC_untreatedPilot'+str(stats.pearsonr(predictions[:,0], input_label_test[:,9])))
    plt.savefig(str(model_name)+"_mean_HASMC_untreatedPilot.svg")
    plt.close()
    plt.scatter(predictions[:,10], input_label_test[:,10], s=1)
    plt.title('mean_HASMC_Chol'+str(stats.pearsonr(predictions[:,0], input_label_test[:,10])))
    plt.savefig(str(model_name)+"_mean_HASMC_Chol.svg")
    plt.close()
    plt.scatter(predictions[:,11], input_label_test[:,11], s=1)
    plt.title('mean_HepG2_untreatedPilot'+str(stats.pearsonr(predictions[:,0], input_label_test[:,11])))
    plt.savefig(str(model_name)+"_mean_HepG2_untreatedPilot.svg")
    plt.close()

def one_hot_encode(seq): #taken from https://stackoverflow.com/questions/34263772/how-to-generate-one-hot-encoding-for-dna-sequences?rq=3
    mapping = dict(zip("ACGT", range(4)))    
    seq2 = [mapping[i] for i in seq]
    return np.eye(4)[seq2]

def complementary(strand): #adapted from https://codereview.stackexchange.com/questions/193766/generating-complementary-dna-sequence
    complementary_strand = ''
    for dna in strand:
        if dna == 'A':
            complementary_strand += 'T'
        elif dna == 'T':
            complementary_strand += 'A'
        elif dna == 'G':
            complementary_strand += 'C'
        elif dna == 'C':
            complementary_strand += 'G'
    return complementary_strand


            
if __name__ == "__main__":
    cli()