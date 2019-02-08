% (c) 2018 Johannes Hofmanninger, johannes.hofmanninger@meduniwien.ac.at
% For academic research / private use only, commercial use prohibited
%
%% function [ jaccards, midx2 ] = cluster_jaccards(d1, d2, varargin)
%
% Performs hungarian matching and calculates jaccard scores for the
% individual sets. 
function [ jaccards, midx2 ] = cluster_jaccards(d1, d2)%, varargin)

assert(length(d1) == length(d2));

% if ~isempty(varargin)
%     mval = varargin{1};
% else
mval = max(d1(:));
% end

cooc = zeros([mval max(d2(:))]);

for i = 1:length(d1)
    cooc(d1(i),d2(i)) = cooc(d1(i),d2(i))+1;
end

[midx2, ~] = munkres(cooc'*-1);

d2_ = midx2(d2)';

cls = 1:mval;
jaccards = zeros(length(cls),1);
for i = 1:length(cls)
   jaccards(i) = 1-pdist(double([d1==cls(i) d2_==cls(i)]'),'jaccard') ;
end

end

