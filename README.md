# stacl
A consensus clustering algorithm based on stabiliy criteria. The current implementation uses k-means as backend clustering algorithm, howerver alternative clustering algorithms could be used. The algorithm aims to identify the smallest stable clusters in the dataset and at the same time estimates the number of clusters automatically. To this end, the algorithm makes use of the fact, that choosing k too high or too low leads to unstable solutions for various clustering algorithms such as k-means. Stable cluster identification is achieved via a bottom up appraoch that starts from a fine grained clustering solution and only saves clusters that are consistently reidentified in perturbed datasets. After each iteration, the number of clusters is decreased to identify larger structures. Note, that the algorithm is compute-intensive. While for moderate datasets less than 10000 items runtime is up to one minute. Clustering 100k samples using the current implementation takes up to 1.5 hours on a single core.

## Contents

- [Getting Started](#getting-started)
- [Examples](#examples)
- [Comparison to HDBSCAN](#comparison-to-hdbscan)
- [Citation](#citation)

## Getting Started

This is a Matlab(c) implementation and works with Matlab 2015 and newer. Input to the clustering algorithm can be either:
- a generator that generates a new dataset in the form NxD with N samples in D dimensions. Each item has to be generated from the same corresponding probability distribution.
- a single dataset in the form NxD with N samples. In this case the perturbation of the dataset will be achieved by subsampling
- mulitple datasets in the form SxNxD with S alternative datasets. Again, items at certain positions in N have to correspond to each other. E.g alternative embeddings of the same dataset.

Examples for each of these three modes are given in the "example.m" file. The main advantage of this method is, that the number of clusters will be determined automatically. 

## Examples
Results for toy datasets without specifically optimizing the parameters for each dataset. For the results based on generated data and for results based on subsampling. Only one set of parameters for each was used.  

When data can be generated:
![Toy 1](https://github.com/JoHof/stacl/blob/master/figures/toy_1_generated.jpg)
![Toy 2](https://github.com/JoHof/stacl/blob/master/figures/toy_2_generated.jpg)

When only one dataset is availabe and subsampling is performed:
<br />-The birch3 datset (http://cs.joensuu.fi/sipu/datasets/)
![Birch3](https://github.com/JoHof/stacl/blob/master/figures/birch3.jpg)
![Toy 1](https://github.com/JoHof/stacl/blob/master/figures/toy_1_subsampled.jpg)
![Toy 2](https://github.com/JoHof/stacl/blob/master/figures/toy_2_subsampled.jpg)

## Comparison to HDBSCAN
Results for the toy datasets using HDBSCAN:
![Birch3](https://github.com/JoHof/stacl/blob/master/figures/birch3_hdbscan.jpg)
![Toy 1](https://github.com/JoHof/stacl/blob/master/figures/toy1_hdbscan.jpg)
![Toy 2](https://github.com/JoHof/stacl/blob/master/figures/toy2_hdbscan.jpg)

## Citation
```
@article{hofmanninger:2019,
        Title = {Unsupervised Machine Learning in Large-Scale Routine Data Identifies Image Signatures and Phenotypes that Predict Outcome},
        Year = {2019}}
```
