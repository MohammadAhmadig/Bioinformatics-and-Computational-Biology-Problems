
% load data
load('twoPerms.mat');
load('threePerms.mat');
disp('loaded');
seq_len = 251;
win_size = 10;
win = [1:10];
features2 = [];

% structural
Address = 'F:\Mohammad\BIO_HW#1\conversion\';
FolderInfo = dir(Address);
conversion = cell(16,1);
Num_of_files = length(FolderInfo(not([FolderInfo.isdir])));
for i = 3 : (Num_of_files+2)
    i
    s=strcat(Address,num2str(FolderInfo(i).name));
    conversion{i} = tdfread(s,'\t');
    
    if(size(conversion{i}.x1,2) == 2)
        f = zeros(size(TWO));
    elseif(size(conversion{i}.x1,2) == 3)
        f = zeros(size(THREE));
    end
    
    for j =1:size(conversion{i}.x1,1)
        j
        if(size(conversion{i}.x1,2) == 2)
            f(ismember(TWO,conversion{i}.x1(j,:)))=conversion{i}.x2(j);
        elseif(size(conversion{i}.x1,2) == 3)
            f(ismember(THREE,conversion{i}.x1(j,:)))=conversion{i}.x2(j);
        end
    end
    % window
    for w = 1:size(f,2) - win_size
        f(:,w) = sum(f(:,win),2);% jaame radifi
        win = win + 1;
    end
    win = [1:10];
    
    features2 = [features2 f(:,1:size(f,2) - win_size)];
    f=[];

end


