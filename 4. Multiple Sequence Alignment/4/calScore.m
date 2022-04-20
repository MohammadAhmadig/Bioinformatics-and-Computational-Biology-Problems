
clear;close all;

% Load Train
Address = 'D:\arshad\BIO\Bio_HW#4\Bio_final\Bio_HW#4\train\';
FolderInfo = dir(Address);
Num_of_files = length(FolderInfo(not([FolderInfo.isdir])));
sequences = {};

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

log_odds_score = 0;
%sseq = 'VVGGTRAAQGEFPFMVRLSMGCGGALYAQDIVLTAAHCVSGSGNNTSITATGGVVDLQSSSAVKVRSTKVLQAPGYNGTGKDWALIKLAQPINQPTLKIATTTAYNQGTFTVAGWGANREGGSQQRYLLKANVPFVSDAACRSAYGNELVANEEICAGYPDTGGVDTCQGDSGGPMFRKDNADEWIQVGIVSWGYGCARPGYPGVYTEVSTFASAIASAARTL--------';
sseq = 'IVGGTSASAGDFPFIVSI-SRNGGPWCGGSLLNANTVLTAAHCVSGYAQ-SGFQIRAGSLSRTSGGITSSLSSVRVHPSYSGNNNDLAILKLSTSIPSGGNIGYARLAASGSDPVAGSSATVAGWGATSEGGSSTPVNLLKVTVPIVSRATCRAQY-GTSAITNQMFCAGVSSGGKDSCQGDSGGPIVD-SSNTLIGAVSWGNGCARPNYSGVYASVGALRSFIDTYA---';
for i=1 : length(ma(1).Sequence)
    
    numOfi=0;
    numOfiCol = 0;
    for j = 1 : length(ma)
        numOfi = numOfi + sum(ismember(ma(j).Sequence,sseq(i)));
        if(ma(j).Sequence(i) == sseq(i))
            numOfiCol = numOfiCol + 1;
        end
    end
    Pi = numOfi / (length(ma) * length(ma(1).Sequence))
    PiColumn = numOfiCol / length(ma)
    if(PiColumn ~= 0)
        log_odds_score = log_odds_score + (10 * (log10(PiColumn/Pi)))
    end
end

log_odds_score

