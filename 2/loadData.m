
f = fopen('myData.txt');
t = textscan(f,'%s');
cellData = reshape(t{1,1},14,8050)';

% cellfun(@str2num,data(:,3:14),'un',0);
% cell2mat(ans);

data = [(1:size(data,1))' grp2idx(data(:,2)) cell2mat(cellfun(@str2num,data(:,3:14),'un',0))];
save('data.mat','data');
