import click
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

@click.command()
@click.option(
    "--sig_files",
    "sig_files",
    required=True,
    multiple=True,
    type=str,
    help="e.g. motif_specificity_stats.tsv",
)
@click.option(
    "--comparison",
    "comparison",
    required=True,
    multiple=True,
    type=str,
    help="comparison of motif sig file",
)
@click.option(
    "--p_val_thres",
    "p_val_thres",
    required=True,
    multiple=False,
    default=0.01,
    help="exclude non sig motifs",
)

def cli(sig_files, comparison, p_val_thres):
    # merge sig files into one df
    df_all_sig_file = pd.read_csv(sig_files[0], sep="\t")#, index_col=True)
    df_all_sig_file.drop(['p-val control', 'p-val treatment', 'n(have motif)', 'n(has not motif)', 'Unnamed: 0'], axis=1, inplace=True)
    df_all_sig_file = df_all_sig_file[df_all_sig_file["p-val difference"] <= p_val_thres]
    df_all_sig_file.rename({'p-val difference': 'p-val difference_' + str(0)}, axis=1, inplace=True)
    print (df_all_sig_file)
    for i in range (1, len(sig_files), 1):
        tmp_sig_file = pd.read_csv(sig_files[i], sep="\t")#, index_col=True)
        tmp_sig_file.drop(['p-val control', 'p-val treatment', 'n(have motif)', 'n(has not motif)', 'Unnamed: 0'], axis=1, inplace=True)
        tmp_sig_file = tmp_sig_file[tmp_sig_file["p-val difference"] <= p_val_thres]
        tmp_sig_file.rename({'p-val difference': 'p-val difference_' + str(i)}, axis=1, inplace=True)
        df_all_sig_file = pd.merge(df_all_sig_file, tmp_sig_file, on="MOTIF ID", how="outer")
    
    # test
    
    print(df_all_sig_file)
    df_all_sig_file_IDs = pd.DataFrame()
    df_all_sig_file_IDs["MOTIF ID"] = df_all_sig_file["MOTIF ID"]
    df_all_sig_file.drop(["MOTIF ID"], axis=1, inplace=True)
    print(df_all_sig_file)

    plt.figure(figsize=(len(sig_files)/4+2, len(df_all_sig_file_IDs["MOTIF ID"])/8+2))
    
    plt.pcolor(np.log10(df_all_sig_file), vmin=-10, vmax=-1)
    plt.yticks(np.arange(0.5, len(df_all_sig_file_IDs["MOTIF ID"]), 1), labels=df_all_sig_file_IDs["MOTIF ID"], fontsize=8)
    plt.xticks(np.arange(0.5, len(df_all_sig_file.columns), 1), labels=comparison, rotation=90)


    # color bar legend
    cb = plt.colorbar(label="log (p-value)")
    cb.ax.tick_params(labelsize=12)
    plt.tight_layout()
    
    plt.savefig("results/heatmap_sig_of_motifs.svg")




if __name__ == "__main__":
    cli()