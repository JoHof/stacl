% (c) 2019 Johannes Hofmanninger, johannes.hofmanninger@meduniwien.ac.at
% For academic research / private use only, commercial use prohibited
%
%% function [ clusterassignment ] = stacl(data, parameters)
%
% Performs clutering of alternative representations of one dataset. If only
% one dataset is provided it will be subsampled
%
% p.maxK = number of k with which stacl will start
% p.minK = number of k until which k will be reduced
% p.jaccthresh = jaccard score that must be obtained to keep a cluster
% p.minClSize = minimum cluster size to keep a cluster
% p.resampleIterations = Nubmer sampling or subsampling steps during one
% iteration
% p.subsampling = subset percentage of the data will be sampled when a
% single dataset is provided
%
% Detailed description of the algorithm can be found in the supplementary
% materials of the paper:
%
% Unsupervised Machine Learning in Large-Scale Routine Data Identifies
% Image Signatures and Phenotypes that Predict Outcome
% by. Johannes Hofmanninger, Sebastian Roehrich, Markus Krenn, Markus
% Holzer, Florian Prayer, Michael Weber, Helmut Prosch and Georg Langs.
% 
% 
function final_clustering = stacl(data, p)

dp = {};
dp.minK = 2;
dp.maxK = 20;
dp.jaccthresh = 0.6;
dp.minClSize = 30;
dp.resampleIterations = 20;
dp.subsampling = .10; %subsample percentage 
p = defaultParams(p,dp);

data_is_generated = false;
multiple_datasets = false;
if isequal(class(data),'function_handle')
    disp('-Function handle provided, data will be sampled')
    data_is_generated = true;
    ds = data();
elseif length(size(data)) == 2
    disp('-Single dataset provided, data will be subsampled')
    ds = data; 
elseif length(size(data)) == 3
    disp('-Multiple datasets provided, data will not be subsampled')
    ds = squeeze(data(1,:,:));
    p.resampleIterations = size(data,1)-1;
    multiple_datasets = true;
end

if exist('yael_kmeans') == 3
    disp('-Yael toolbox found, will use yael toolbox for kmeans clustering')
else
    disp(['-Yael toolbox not found, matlab kmeans will be used. Note, that ' ...
          'this is significantly slower. Consider installation of the yael toolbox!'])
end

dims = size(ds,2);
disp(['-Data dimensionality is: ' num2str(dims)]);

final_clustering = zeros(size(ds,1),1);
k = p.maxK;

while k >= p.minK && k<sum(final_clustering==0)

    disp(['Iteration with k set to: ' num2str(k)]);
    subsidx = find(final_clustering==0);
    
    if data_is_generated
        ds = data();
    end
    
    tds = ds(subsidx,:);

    [~, ~, assignments1] = yael_kmeans(single(tds)', k, 'verbose',0, 'niter', 2000, 'redo',5);


    jaccs = zeros(1,length(unique(assignments1)));
    assigns_sub =  [];
    matchlist =  zeros(1,length(unique(assignments1)));
    tassignments = assignments1;
    for i = 1:p.resampleIterations
        
        if data_is_generated
        	tds = data();
            tds = tds(subsidx,:);
            randselect=1:size(tds,1);
        elseif multiple_datasets
            tds = squeeze(data(i+1,:,:));
            tds = tds(subsidx,:);
            randselect=1:size(tds,1);
        else
            tds = ds(subsidx,:);
            randselect = randperm(size(tds,1));
            randselect = randselect(1:round(size(tds,1)*p.subsampling));
            tds = tds(randselect,:);
        end

        [~, ~, assignments2] = yael_kmeans(single(tds)', k, 'verbose',0, 'niter', 2000, 'redo',15);

        tassignments1 = tassignments(randselect);
        tassignments2 = assignments2;
        assigns_sub(:,i) = tassignments2;
        matchlist(i,length([assignments2; assignments1])) = 0;
        jaccs(i,length([assignments2; assignments1])) = 0;
        [jaccs(i,1:max(tassignments1)), matchlist(i,unique(tassignments2))] = cluster_jaccards(tassignments1, tassignments2);

    end
    
    xjaccs = mean(jaccs);  
    st_cluster = find(xjaccs>p.jaccthresh);
    
    found = false;
    if data_is_generated || multiple_datasets
        for m = 1:length(st_cluster)
            counts = zeros(numel(subsidx),1);
            for j= 1:size(assigns_sub,2)
                count_selection = (assigns_sub(:,j)==find(matchlist(j,:)==st_cluster(m)));
                counts(count_selection) = counts(count_selection)+1;
            end
            rel_cases = counts>=round(p.resampleIterations/3);
            cl_size_median = sum(rel_cases);
            if cl_size_median>p.minClSize
                found = true;
                final_clustering(subsidx(rel_cases)) = max(final_clustering)+1;
            end
        end   
    else
        for m = 1:length(st_cluster)
            cl_size = sum(subsidx(tassignments==st_cluster(m)));
            if cl_size>p.minClSize
                found = true;
                final_clustering(subsidx(tassignments==st_cluster(m))) = max(final_clustering)+1;
            end
        end
    end

    
    if ~found
        k = k-1;
    end
    
    disp(['Number of clusters: ' num2str(max(final_clustering))]);
    disp(['Max Jaccard was: ' num2str(max(xjaccs)) ', threshold is ' num2str(p.jaccthresh)]);

end