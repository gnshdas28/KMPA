close all;
clear all;
 
a=load('/home/cs16m029/KMPA/A2/2.Black and white image data/binaryData.mat');

a1=a.data.data;
a2=(a.data.labels)';
a3=(a.data.class_names)';

labeldata=[a2,a1];

grp4labels=[55,64,76,91,93]';
clslabels=[4,13,14,16,17,20,24,40,47,48,51,52,55,56,64,76,82,87,91,93,95]';

for i=1:5
    for j=1:size(clslabels,1)
        if(grp4labels(i)==clslabels(j))
            grp4clsnames{i}=a3{j};
        end
    end
end
grp4clsnames=grp4clsnames';

for i=1:5
grp4clsnames{i,2}=grp4labels(i);
end         


grp4data=[];
for i=1:5
    for j=1:size(labeldata,1)
        if(grp4labels(i)==labeldata(j,1))
            grp4data=[grp4data;labeldata(j,:)];
        end
    end
end
    
