% 
% load('Data.mat');
% %TWOpermutation = cell(4000,250);
% TWOpermutation1 = [];
% count =0;
% xx = 1:250;
% yy = 2:251;
% for k =1:4% num_rows of data
%     for m = 1: 10000% num_rows of subData
%         count = count + 1;
%         
%         %size(conversion{i}.x1,2) == 2)
% 		%TWOpermutation{count,:} = data{k,1}{m}([xx;yy]');
%         temp = data{k,1}{m}([xx;yy]');
%         TWOpermutation{count} = cellstr(temp);   
% 		%permutation_mat = data{k,1}{m}([xx;yy;zz]');
%         
%     end
% end
% 
% for i = 1:40000
%     i
%     for j=1:250
%         TWO{i,j} = TWOpermutation{i}{j};
%     end
% end

load('Data.mat');
THREEpermutation1 = [];
count =0;
xx = 1:249;
yy = 2:250;
zz = 3:251;
for k =1:4% num_rows of data
    for m = 1: 10000% num_rows of subData
        count = count + 1
        
        %size(conversion{i}.x1,2) == 2)
		%TWOpermutation{count,:} = data{k,1}{m}([xx;yy]');
        temp = data{k,1}{m}([xx;yy;zz]');
        THREEpermutation{count} = cellstr(temp);   
		%permutation_mat = data{k,1}{m}([xx;yy;zz]');
        
    end
end

for i = 1:40000
    i
    for j=1:249
        THREE{i,j} = THREEpermutation{i}{j};
    end
end

