
clear;

load('OrgData.mat');
y = Labels;
%X(:,[1 5 7 9 11 16])= XX;
x = Data ;
%corrInd = ind(771:870);
indxxx = [3,10,11,12,14,30,36,38,44,63,67,1044,4718,4917];

CVO = cvpartition(y,'k',4); % Stratified cross-validation
for i = 1:CVO.NumTestSets
    trIdx = CVO.training(i);
    teIdx = CVO.test(i);
    mdl = TreeBagger(60,x(trIdx,indxxx),y(trIdx,:),'Method','classification');
    ypred = predict(mdl , x(teIdx,indxxx));
    ytest = y(teIdx);
    %ytest = classify(x(teIdx,:),x(trIdx,:),y(trIdx,:));
    %err(i) = sum(~strcmp(ytest,species(teIdx)));
    
    acc(i)=(length(ytest) - sum(ytest ~= str2num(cell2mat(ypred))) ) / length(ytest) 

    % precision
    % ind1 = 1 == ypred;
    % ind0 = 0 == ypred;
    ind1 = 1 == str2num(cell2mat(ypred));
    ind0 = 0 == str2num(cell2mat(ypred));
    
    
    tp = sum(ytest(ind1) == str2num(cell2mat(ypred(ind1))));
    tn = sum(ytest(ind0) == str2num(cell2mat(ypred(ind0))));
    fp = sum(ytest(ind1) ~= str2num(cell2mat(ypred(ind1))));
    fn = sum(ytest(ind0) ~= str2num(cell2mat(ypred(ind0))));
    % tp = sum(ytest(ind1) == ypred(ind1));
    % tn = sum(ytest(ind0) == ypred(ind0));
    % fp = sum(ytest(ind1) ~= ypred(ind1));
    % fn = sum(ytest(ind0) ~= ypred(ind0));
    precision(i) = (tp)/(tp+fp)
    recall(i) = (tp)/(tp+fn)
    Fmeasure(i) = 2*((precision(i)*recall(i))/(precision(i)+recall(i)))
end


