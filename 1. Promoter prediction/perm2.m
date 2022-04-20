

%load('twoPerms.mat');
%TWO = TWO';
%[x,y]=find(cellfun(@strcmp , TWO,cellstr(repmat(cellstr(repmat('aa',40000,1)),1,250))));
[x,y]=find(ismember(TWO,'aa'));
f(x,y)=2;% tool mikeshe
%f(ind) = 1;
