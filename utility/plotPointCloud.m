function h =  plotPointCloud(points, varargin)

p = inputParser;
addRequired(p,'points');
addOptional(p,'membership',ones(size(points,1),1))
addOptional(p,'membershipLabels',[])
addOptional(p,'MarkerSize',5)
addOptional(p,'figTitle','')
addOptional(p,'ccmap',[])
parse(p,points,varargin{:})

membership = p.Results.membership;
membershipLabels = p.Results.membershipLabels;
markerSize = p.Results.MarkerSize;
figTitle = p.Results.figTitle;
ccmap = p.Results.ccmap;


% if isempty(membership)
%     membership = ones(size(points,1),1);
% end

% if isempty(figTitle)
%     figTitle = 'None';
% end

if isempty(membershipLabels)
    lbls = unique(membership);
    for i = 1:length(lbls)
        membershipLabels{i} = num2str(lbls(i));
    end
end
uClusters = unique(membership);
nClusters = length(uClusters);

if (nClusters>7)
    cmap = colorcube(nClusters+1);
    cmap = cmap(randsample(size(cmap,1),size(cmap,1)),:);
    cmap(size(cmap,1),:) = [];
else
    cmap = [0 0 0; prism(nClusters)];
end

noLabel=0;
if min(membership)==0
    noLabel = 1;
    cmap(1,:) = [ .1 .1 .1];
end

if ~isempty(ccmap)
    cmap = ccmap;
end

for iCluster = 1:nClusters
    clustIdx = membership==uClusters(iCluster);
    if noLabel %&& iCluster==1
        if size(points,2)>2
            h=plot3(points(clustIdx,1),points(clustIdx,2),points(clustIdx,3),'.','MarkerSize',markerSize,'Color',cmap(iCluster,:),'DisplayName',membershipLabels{iCluster});
        else
            h(iCluster)=plot(points(clustIdx,1),points(clustIdx,2),'.','MarkerSize',markerSize,'Color',cmap(iCluster,:),'DisplayName',membershipLabels{iCluster});
        end

    else
        if size(points,2)>2
           h= plot3(points(clustIdx,1),points(clustIdx,2),points(clustIdx,3),'.','MarkerSize',markerSize,'Color',cmap(iCluster,:),'DisplayName',membershipLabels{iCluster});
        else
           h(iCluster)= plot(points(clustIdx,1),points(clustIdx,2),'.','MarkerSize',markerSize,'Color',cmap(iCluster,:),'DisplayName',membershipLabels{iCluster});
        end
    end
    hold on;
end
if ~strcmp(figTitle, 'None')

    legend('show');
    axis off;
    title(figTitle);
end
hold off;
end

