
clear;close all;

% Load Train
Address = 'D:\arshad\BIO\Bio_HW#4\Bio_final\Bio_HW#4\train\';
FolderInfo = dir(Address);
Num_of_files = length(FolderInfo(not([FolderInfo.isdir])));

count = 1;
train =[];
for i = 3 : (Num_of_files+2)
    s=strcat(Address,num2str(FolderInfo(i).name));
    train =  [train ; fastaread(s)];
end

dist = seqpdist(train,'ScoringMatrix','BLOSUM62');
tree = seqlinkage(dist,'average',train);
ma = multialign(train,tree,'ScoringMatrix',{'BLOSUM62'});
showalignment(ma);

matchMatrix = zeros(1,length(ma(1).Sequence));
match = 0;
insertion = 0;
%detect match and insertion columns
for i =1:length(ma(1).Sequence)
    gapsize = 0;
    for j = 1 : length(ma)
        if(ma(j).Sequence(i) == '-')
            gapsize = gapsize + 1;
        end
    end
    if(gapsize > 8)
        if(i>1)
            if(matchMatrix(i-1) > 0)
                insertion = -1 * matchMatrix(i-1);
            end
        end
        matchMatrix(i) = insertion;
    else
        match = match + 1 ;
        matchMatrix(i) = match;
    end
end

emissionMatrix = zeros(675,21);
transMatrix = zeros(675,675);
Pi = zeros(1,21);
uniq = unique(ma(1).Sequence);

% calculate Pi for all characters
for i=1 : length(uniq)
    numOfi=0;
    for j = 1 : length(ma)
        numOfi = numOfi + sum(ismember(ma(j).Sequence,uniq(i)));
    end
    Pi(i) = numOfi / (length(ma) * length(ma(1).Sequence));
end
%set Emission matrix
indicesI = 2:3:675;
emissionMatrix(indicesI,:) = repmat(Pi,length(indicesI),1);
indicesD = 4:3:675;
emissionMatrix(indicesD,1) = 1;
indicesM = 3:3:672;% without start and end

for i = 1 : size(indicesM,2)
for k = 1: length(uniq)   
    numOfiCol = 0;
    numOfiColii = 0;
    for j = 1 : length(ma)
        if(ma(j).Sequence(i) ~= '-')
            numOfiColii = numOfiColii + 1;
        end
  
        if(ma(j).Sequence(i) == uniq(k))
            numOfiCol = numOfiCol + 1;
        end
    end
    if( '-' == uniq(k))
        numOfiCol =0;
    end
    numOfiColii
    emissionMatrix(indicesM(i),k) = (numOfiCol + 1) / (numOfiColii+21);%(length(ma)+21);
end
end

%set transition matrix
% M --> any
ma2 = ma;

for i = 1 : length(ma)
    ma2(i).Sequence = strcat('A',ma2(i).Sequence);
end
indicesM =[1, 3:3:675];
for i = 1 : size(indicesM,2)  
    
    numOfiColM = 0;
    numOfiColD = 0;
    numOfiColI = 0;
    for j = 1 : length(ma)
        if(i == 225)
            if(ma2(j).Sequence(i) ~= '-')
                numOfiColM = numOfiColM + 1;
            end
            if(ma2(j).Sequence(i) ~= '-' && ma2(j).Sequence(i+1) ~= '-')
                numOfiColI = numOfiColI + 1;
            end
        else
            if(ma2(j).Sequence(i) ~= '-' && ma2(j).Sequence(i+1) ~= '-')
                numOfiColM = numOfiColM + 1;
            end
            if(ma2(j).Sequence(i) ~= '-' && ma2(j).Sequence(i+1) == '-')
                numOfiColD = numOfiColD + 1;
            end

        end
    end
    if(i == 225)
        transMatrix(indicesM(i),indicesM(i+1)) = (numOfiColM + 1) / ((numOfiColM + 1)+(numOfiColI+1));%m->m
        transMatrix(indicesM(i),indicesI(i)) = (numOfiColI +1) / ((numOfiColM + 1)+(numOfiColI+1));%m->I
    elseif(i == 226)
 
    else
        transMatrix(indicesM(i),indicesM(i+1)) = (numOfiColM + 1) / ((numOfiColM + 1)+(numOfiColD+1)+1);%m->m
        transMatrix(indicesM(i),indicesD(i)) = (numOfiColD + 1) / ((numOfiColM + 1)+(numOfiColD+1)+1);%m->D
        transMatrix(indicesM(i),indicesI(i)) = (1) / ((numOfiColM + 1)+(numOfiColD+1)+1);%m->I
    end

end
% I --> any
i=225;
numOfiColM =0;
numOfiColI =11;
for j = 1 : length(ma)
    flag =0;
    if(sum(ismember(ma(j).Sequence(i:end),'-')) ~= 7)
        flag = 1;
    end
    numOfiColM = numOfiColM + flag;
end
for i = 1:length(indicesI)
    transMatrix(indicesI(i),[indicesI(i),indicesI(i)+1,indicesI(i)+2]) = 1/3;
end
transMatrix = transMatrix(:,1:end-1);
transMatrix(indicesI(i),indicesM(i+1)) = (numOfiColM + 1) / ((numOfiColM + 1)+(numOfiColI+1));%I->m
transMatrix(indicesI(i),indicesI(i)) = (numOfiColI+1) / ((numOfiColM + 1)+(numOfiColI+1));%I->I

% D --> any
for i = 1 : size(indicesD,2)  
    
    numOfiColM = 0;
    numOfiColD = 0;
    numOfiColI = 0;
    for j = 1 : length(ma)
        if(i == 224)
            if(ma(j).Sequence(i) == '-')
                numOfiColM = numOfiColM + 1;
            end
            if(ma(j).Sequence(i) == '-' && ma(j).Sequence(i+1) ~= '-')
                numOfiColI = numOfiColI + 1;
            end
        else
            if(ma(j).Sequence(i) == '-' && ma(j).Sequence(i+1) ~= '-')
                numOfiColM = numOfiColM + 1;
            end
            if(ma(j).Sequence(i) == '-' && ma(j).Sequence(i+1) == '-')
                numOfiColD = numOfiColD + 1;
            end

        end
    end
    if(i == 224)
        transMatrix(indicesD(i),indicesM(i+2)) = (numOfiColM + 1) / ((numOfiColM + 1)+(numOfiColI+1));%D->m
        transMatrix(indicesD(i),indicesI(i+1)) = (numOfiColI +1) / ((numOfiColM + 1)+(numOfiColI+1));%D->I
    else
        transMatrix(indicesD(i),indicesM(i+2)) = (numOfiColM + 1) / ((numOfiColM + 1)+(numOfiColD+1)+1);%D->m
        transMatrix(indicesD(i),indicesD(i+1)) = (numOfiColD + 1) / ((numOfiColM + 1)+(numOfiColD+1)+1);%D->D
        transMatrix(indicesD(i),indicesI(i+1)) = (1) / ((numOfiColM + 1)+(numOfiColD+1)+1);%D->I
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test1Address = 'D:\arshad\BIO\Bio_HW#4\Bio_final\Bio_HW#4\1os8.fasta.txt';% 8
test2Address = 'D:\arshad\BIO\Bio_HW#4\Bio_final\Bio_HW#4\1pqa.fasta.txt';% 7
test = fastaread(test2Address);

testVector = zeros(1,length(test.Sequence));
for i = 1 : length(test.Sequence)
    testVector(i) = find(ismember(uniq,test.Sequence(i)));
end
estimatedStates = hmmviterbi(testVector,transMatrix,emissionMatrix);
sum(ismember(estimatedStates,indicesI))

counter =0;
ss = '';
for i = 1:length(estimatedStates)
    if(sum(ismember(indicesM,estimatedStates(i)) == 1))
        ss = strcat(ss,test.Sequence(i));
    else
        ss = strcat(ss,'-');
        ss = strcat(ss,test.Sequence(i));
    end
end

%test.Sequence = strcat(test.Sequence,'--------');

%test = fastaread(test2Address);
log_odds_score = 0;
%[Score, Alignment] = hmmprofalign(ma(1:end).Sequence, test.Sequence);

% for i=1 : length(ma(1).Sequence)
%     test.Sequence(i)
%     numOfi=0;
%     numOfiCol = 0;
%     for j = 1 : length(ma)
%         numOfi = numOfi + sum(ismember(ma(j).Sequence,test.Sequence(i)));
%         if(ma(j).Sequence(i) == test.Sequence(i))
%             numOfiCol = numOfiCol + 1;
%         end
%     end
%     Pi = numOfi / (length(ma) * length(ma(1).Sequence))
%     PiColumn = numOfiCol / length(ma)
%     if(PiColumn ~= 0)
%         log_odds_score = log_odds_score + (10 * (log10(PiColumn/Pi)))
%     end
% end
% toc;
% log_odds_score


