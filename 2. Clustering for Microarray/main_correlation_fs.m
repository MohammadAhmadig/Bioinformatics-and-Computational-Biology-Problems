clear;

load('data.mat');
load('y_kmeans.mat');
%load('y_linkage.mat');

list = [];
X= data(:,3:end);
Y = y;
for i =1: size(X,2)
    list(i) = corr(X(:,i),Y);
    
end
[vv,ind] = sort(list);
% az tahesh bayad bardasht

%data = [data ones(size(data,1),1)];
%save('Fdata.mat')
yind = find(ismember(Y,1));
plot(X(:,10),X(:,12),'b*',X(yind,10),X(yind,12),'r*');
