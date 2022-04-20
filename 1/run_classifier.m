
clear;

% load('OData.mat');
% y = Labels;
% %X(:,[1 5 7 9 11 16])= XX;
% x = Data ;
% %corrInd = ind(771:870);
% indxxx = [3,10,11,12,14,30,36,38,44,63,67,1044,4718,4917];
load('myData.mat');
y = myData(:,end);
%X(:,[1 5 7 9 11 16])= XX;
x = myData(:,1:end-1);
%corrInd = ind(771:870);
indxxx = [3,29,42,68,73,85,88,91,101,110,121,126,134,139,145,146,172,175,179,181,184,209,220,222,223,234,238,282,285,296,298,324,349,357,418,469,494,556,584,600,603,610,626,632,633,646,647,648,658,669,681,724,729,740,750,755,756,758,760,781,793,801,870,878,894,936,938,940,942,966,990,998,1002,1005,1064,1158,1182,1185,1194,1205,1221,1226,1245,1253,1266,1305,1306,1325,4704,4903];

CVO = cvpartition(y,'k',5); % Stratified cross-validation
for i = 1:CVO.NumTestSets
    trIdx = CVO.training(i);
    teIdx = CVO.test(i);
    mdl = TreeBagger(60,x(trIdx,indxxx),y(trIdx,:),'Method','classification');
    ypred = predict(mdl , x(teIdx,indxxx));
    c=1;
    mdl = fitcsvm(x(trIdx,indxxx), y(trIdx,:),'KernelFunction','RBF','KernelScale','auto','BoxConstraint',c);
    ypred = predict(mdl , x(teIdx,indxxx));
    ytest = y(teIdx);
    %ytest = classify(x(teIdx,:),x(trIdx,:),y(trIdx,:));
    %err(i) = sum(~strcmp(ytest,species(teIdx)));
    
    acc(i)=(length(ytest) - sum(ytest ~= ypred) ) / length(ytest) 

    % precision
    % ind1 = 1 == ypred;
    % ind0 = 0 == ypred;
    ind1 = 1 == ypred;
    ind0 = 0 == ypred;
    
    
    tp = sum(ytest(ind1) == ypred(ind1));
    tn = sum(ytest(ind0) == ypred(ind0));
    fp = sum(ytest(ind1) ~= ypred(ind1));
    fn = sum(ytest(ind0) ~= ypred(ind0));
    % tp = sum(ytest(ind1) == ypred(ind1));
    % tn = sum(ytest(ind0) == ypred(ind0));
    % fp = sum(ytest(ind1) ~= ypred(ind1));
    % fn = sum(ytest(ind0) ~= ypred(ind0));
    precision(i) = (tp)/(tp+fp)
    recall(i) = (tp)/(tp+fn)
    Fmeasure(i) = 2*((precision(i)*recall(i))/(precision(i)+recall(i)))
end

mean(acc)
std(acc)

figure
plot(acc,'-o')
title('10 Fold Accuracy ')
xlabel('Folds')
ylabel('Accuracy')

figure
plot(precision,'-o')
title('10 Fold Precision ')
xlabel('Folds')
ylabel('Precision')

figure
plot(recall,'-o')
title('10 Fold Recall ')
xlabel('Folds')
ylabel('Recall')

figure
plot(Fmeasure,'-o')
title('10 Fold Fmeasure ')
xlabel('Folds')
ylabel('Fmeasure')


% %x(:,21) = y + rand(345,1)*0.1;
% holdoutCVP = cvpartition(y,'holdout',4000);%%%%
% xtrain = x(holdoutCVP.training,:); xtest = x(holdoutCVP.test,:);
% ytrain = y(holdoutCVP.training); ytest = y(holdoutCVP.test);
% %for i = [0.01 , 0.1 , 1 ,10,100]
% c=1;
% sigma=1;
% mdl = fitcsvm(xtrain(:,indxxx), ytrain,'KernelFunction','RBF','KernelScale','auto','BoxConstraint',c);
% ypred = predict(mdl , xtest(:,indxxx));
% % acc
% acc=(length(ytest) - sum(ytest ~= ypred) ) / length(ytest) 
% % precision 
% ind1 = 1 == ypred;
% ind0 = 0 == ypred;
% tp = sum(ytest(ind1) == ypred(ind1));
% tn = sum(ytest(ind0) == ypred(ind0));
% fp = sum(ytest(ind1) ~= ypred(ind1));
% fn = sum(ytest(ind0) ~= ypred(ind0));
% precision = (tp)/(tp+fp)
% recall = (tp)/(tp+fn)
% Fmeasure = 2*((precision*recall)/(precision+recall))
% %end
% % cp = cvpartition(y,'k',10); % Stratified cross-validation
% % opts = statset('display','iter');
% % 
% % c= 1;
% % f = @(xtrain, ytrain, xtest, ytest) sum(predict(fitcsvm(xtrain, ytrain,'Standardize',true,'ClassNames',[1,0],'BoxConstraint',c),xtest) ~= ytest);
% % 
% % fs = sequentialfs(f,x,y,'cv',cp,'options',opts,'nfeatures',9)
% % 
