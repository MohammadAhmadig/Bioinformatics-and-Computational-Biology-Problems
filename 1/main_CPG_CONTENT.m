
% load data
load('Data.mat');
% CpG
features = [];
for i=1:4;
    features =[features ; (cellfun('length',strfind(data{i,1},'cg')))./((cellfun('length',strfind(data{i,1},'c')).*cellfun('length',strfind(data{i,1},'g')))/251)];
end % /250

feature2 = [];
for i=1:4;
    feature2 =[feature2 ; (cellfun('length',strfind(data{i,1},'c'))+cellfun('length',strfind(data{i,1},'g')))/251];
end

features = [features feature2];
temp = features(:,1) > 0.6;
temp2 = features(:,2) > 0.5;
features(:,3) = temp .* temp2;

% strfind

% content
chars = {'a' , 'c' , 'g' , 't'};
features_content_3gram =[];

%3 gram
%features_content = zeros(40000,64);
for i = 1 :4
    for j = 1 :4
        for k = 1 :4
            str = strcat(chars{i},chars{j});
            str = strcat(str,chars{k});
            features_content1 = cellfun('length',strfind(data{1,1},str));
            features_content2 = cellfun('length',strfind(data{2,1},str));
            features_content3 = cellfun('length',strfind(data{3,1},str));
            features_content4 = cellfun('length',strfind(data{4,1},str));
            features_content4 = [features_content1;features_content2;features_content3;features_content4];
            features_content_3gram = [features_content_3gram features_content4];
        end
    end
end
maxx= repmat(max(features_content_3gram),size(features_content_3gram,1),1);
features_content_3gram = features_content_3gram ./ maxx;
df = repmat((ones(1,size(features_content_3gram,2))*40000) ./ sum(features_content_3gram > 0),size(features_content_3gram,1),1);
df = log2(df);
features_content_3gram = features_content_3gram .* df;

features_content_4gram =[];
% 4 gram
for i = 1 :4
    i
    for j = 1 :4
        for k = 1 :4
            for l = 1 :4
                str = strcat(chars{i},chars{j});
                str = strcat(str,chars{k});
                str = strcat(str,chars{l});
                features_content1 = cellfun('length',strfind(data{1,1},str));
                features_content2 = cellfun('length',strfind(data{2,1},str));
                features_content3 = cellfun('length',strfind(data{3,1},str));
                features_content4 = cellfun('length',strfind(data{4,1},str));
                features_content4 = [features_content1;features_content2;features_content3;features_content4];
                features_content_4gram = [features_content_4gram features_content4];
             end
            
        end
    end
end
maxx= repmat(max(features_content_4gram),size(features_content_4gram,1),1);
features_content_4gram = features_content_4gram ./ maxx;
df = repmat((ones(1,size(features_content_4gram,2))*40000) ./ sum(features_content_4gram > 0),size(features_content_4gram,1),1);
df = log2(df);
features_content_4gram = features_content_4gram .* df;

features_content_5gram =[];
% 5 gram
for i = 1 :4
    i
    for j = 1 :4
        for k = 1 :4
            for l = 1 :4
                for m = 1 :4
                    str = strcat(chars{i},chars{j});
                    str = strcat(str,chars{k});
                    str = strcat(str,chars{l});
                    str = strcat(str,chars{m});
                    features_content1 = cellfun('length',strfind(data{1,1},str));
                    features_content2 = cellfun('length',strfind(data{2,1},str));
                    features_content3 = cellfun('length',strfind(data{3,1},str));
                    features_content4 = cellfun('length',strfind(data{4,1},str));
                    features_content4 = [features_content1;features_content2;features_content3;features_content4];
                    features_content_5gram = [features_content_5gram features_content4];
                end    
            end
        end
    end
end

maxx= repmat(max(features_content_5gram),size(features_content_5gram,1),1);
features_content_5gram = features_content_5gram ./ maxx;
df = repmat((ones(1,size(features_content_5gram,2))*40000) ./ sum(features_content_5gram > 0),size(features_content_5gram,1),1);
df = log2(df);
features_content_5gram = features_content_5gram .* df;

features = [features features_content_3gram features_content_4gram features_content_5gram];
%features = [features features_content_3gram features_content_4gram];





