
clear;
load('data.mat');

% first criterion kmeans
% for k = 1:10
%     k
%     [idx,C,sumd,D] = kmeans(data(:,3:end)',k);
%     s(k) = sum(sumd);
% end
% plot(s)

% second criterion
% rng('default');  % For reproducibility
% eva = evalclusters(data(:,3:end)','kmeans','CalinskiHarabasz','KList',[1:10]);

%'DaviesBouldin' | 'gap' | 'silhouette'

[y,C] = kmeans(data(:,3:end),2);
