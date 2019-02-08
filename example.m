figure();
%% clustering of a generative dataset
% this data is generative and will be resampled from the underlying
% distributions. 
data = @()cl_toy_dataset; % in this case, data is a generator
ds = data(); % generates one set
subplot(1,2,1);
plotPointCloud(ds);

p = []; % we will use this set of parameters of all two datasets
p.jaccthresh = 0.4;
p.resampleIterations = 20;
clustering_solution = stacl(data,p);
subplot(1,2,2);
plotPointCloud(ds,'membership',clustering_solution);

figure();
data = @()cl_toy_dataset2;
ds = data(); 
subplot(1,2,1);
plotPointCloud(ds);

%perform clustering
clustering_solution = stacl(data,p);
subplot(1,2,2);
plotPointCloud(ds,'membership',clustering_solution);


%% clustering of a single dataset
figure();
% if only a single dataset is given and no new data can be generated data
% perturbation will be automatically done by subsampling.
data = cl_toy_dataset(); 
subplot(1,2,1);
plotPointCloud(data);
% if the data is subsampled, the variation within a clustering is much
% smaller across subsamples. Thus, the jaccard threshold has to be set to a
% higher value not to capture random structure. By default, 15% of the data is subsampled at each
% iteration. Increasing the number of resample iterations creatly improves
% stability.
p.jaccthresh = 0.90; 
p.resampleIterations = 300;
clustering_solution = stacl(data,p);
subplot(1,2,2);
plotPointCloud(data,'membership',clustering_solution);

figure();
data = cl_toy_dataset2(); 
subplot(1,2,1);
plotPointCloud(data);
clustering_solution = stacl(data,p);
subplot(1,2,2);
plotPointCloud(data,'membership',clustering_solution);

%% clustering of a fixed set of perturbed representations
% this data is generative and will be resampled from the underlying
% distributions.
data = [];
p = [];
for i = 1:20
    data(i,:,:) = cl_toy_dataset(); 
end
p.jaccthresh = 0.4;
clustering_solution = stacl(data,p);
figure();
plotPointCloud(squeeze(data(1,:,:)),'membership',clustering_solution);


data = [];
for i = 1:20
    data(i,:,:) = cl_toy_dataset2(); 
end
figure();
plotPointCloud(squeeze(data(1,:,:)));
clustering_solution = stacl(data,p);
figure();
plotPointCloud(squeeze(data(1,:,:)),'membership',clustering_solution);


%% clustering of the challenging birch3 dataset 
% Note, that this is not a generative dataset. Thus we set jaccthresh to
% 0.9 just like. We reduced the number resample Iterations to reduce the
% runtime. maxK is increased to 100 to account for the high number, and
% small size clusters expected.
% 
% Be aware, runtime can be up to 2 hours for this dataset with 100k points
% on a single core.
fileID = fopen('toydatasets/birch3.txt','r');
A = fscanf(fileID,'%d %d\n',[2 100000])';

rs = randsample(100000,40000); % subsample for better visualization. Not used during clustering
figure();
subplot(1,2,1);
plotPointCloud(A(rs,:),'MarkerSize',1)

data = A;
p.maxK = 100;
p.resampleIterations = 50;
p.jaccthresh = 0.92;
clustering_solution = stacl(data,p);
subplot(1,2,2);
plotPointCloud(data(rs,:),'membership',clustering_solution(rs),'MarkerSize',1);
