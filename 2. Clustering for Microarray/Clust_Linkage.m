
clear;
load('data.mat');

%evaluate linkage
% myfunc = @(X,K)(cluster(linkage(X,'average','correlation'),'maxclust',K));
% eva = evalclusters(data(:,3:end),myfunc,'DaviesBouldin','KList',[1:10]);

%c=cluster(linkage(data(:,3:end),'average','correlation'),'maxclust',2);


Z = linkage(data(:,3:end),'average','correlation');
c = cluster(Z,'maxclust',2);
dendrogram(Z);

