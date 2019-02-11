# stacl
A consensus clustering algorithm based on stabiliy criteria. The current implementation uses k-means as backend clustering algorithm, howerver alternative clustering algorithms could be used. The number of clusters is estimated automatically.

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
![Toy 1](https://github.com/JoHof/stacl/blob/master/figures/toy_1_subsampled.jpg)
![Toy 2](https://github.com/JoHof/stacl/blob/master/figures/toy_2_subsampled.jpg)

The challenging birch3 dataset:
![Birch3](https://github.com/JoHof/stacl/blob/master/figures/birch3.jpg)
