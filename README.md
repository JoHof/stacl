# stacl
A consensus clustering algorithm based on stabiliy criteria. The current implementation uses k-means as backend clustering algorithm, howerver any clustering algorithm can be used.

## Getting Started

This is a Matlab(c) implementation and works with Matlab 2015 and newer. Input to the clustering algorithm can be either:
- a generator that generates a new dataset in the form NxD with N samples in D dimensions. Each item has to be generated from the same corresponding probability distribution.
- a single dataset in the form NxD with N samples. In this case the perturbation of the dataset will be achieved by subsampling
- mulitple datasets in the form SxNxD with S alternative datasets. Again, items at certain positions in N have to correspond to each other. E.g alternative embeddings of the same dataset.

Examples for each of these three modes are given in the "example.m" file.

## Examples
Results for toy datasets:
Dataset 1. 
