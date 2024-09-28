# extract sequences with 10% highest variant effects
python VariantEffects/extractSeqsWithHighVariantEffect.py --quantile 0.1 --output 10percent_


# how many of the top variants effects in TeloHEAC_IL1b_6h can I explain with them lying in one of the TF motif groups discovered for this cell type and more active due to IL1b?
bash VariantEffects/strongVariantEffects_per_motif_group_per_setUp.sh




#new
python VariantEffects/extractVariantEffectsFromMatchFile.py --output test

run fimo sh

python VariantEffects/check_variant_within_motif.py \

