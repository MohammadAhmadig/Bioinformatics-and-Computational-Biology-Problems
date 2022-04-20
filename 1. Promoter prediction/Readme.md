# Promoter prediction

Promoter predictionis an important task in genome annotation projects, and during the past years many new promoter prediction programs (PPPs) have been emerged. PPPs aim to identify promoter regions in a genome using computational methods. Promoter prediction is a supervised learning problem which contains three main steps to extract features:

1. CpG islands
2. Structural features
3. Content features

You are asked to extract suitable features in order to train a discriminative model on dataset to classify promoter and non-promoter sequences.

In the implementations, you should notice:
- Related papers are attached in order to get idea about feature definitions.
- You can use the conversion table to calculate structural features.
- You can use any feature selection method to reduce dimensionality.
- Running time is important so, you should choose suitable classifier.
- Implement K-fold CV and calculate precision, recall and Fscore to evaluate your method.
- Choose proper K according to the dataset.

Dataset:
Your dataset has 40000 samples witch contain promoter, exon, utr3 and intron as a samples. Promoter samples are labeled as class one and others class zero.
