# Promoter prediction

Promoter prediction is an important task in genome annotation projects, and during the past years many new promoter prediction programs (PPPs) have been emerged. PPPs aim to identify promoter regions in a genome using computational methods. Promoter prediction is a supervised learning problem which contains three main steps to extract features:

1. CpG islands
2. Structural features
3. Content features

Here we are going to extract suitable features in order to train a discriminative model on dataset to classify promoter and non-promoter sequences.

In the implementations, we should notice:
- We can use the conversion table to calculate structural features.
- We can use any feature selection method to reduce dimensionality.
- Running time is important so, we should choose suitable classifier.
- We implement K-fold CV and calculate precision, recall and Fscore to evaluate your method.
- We choose proper K according to the dataset.

Dataset:
The dataset has 40000 samples which contain promoter, exon, utr3 and intron as a samples. Promoter samples are labeled as class one and others class zero.
