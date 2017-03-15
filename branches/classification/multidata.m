close all;
clear all;
  

grp4multi=[];
for i=1:3131
    a=load(sprintf('/home/cs16m029/KMPA/A2/3.Group_4/%d.feats',i));
    grp4multi=[grp4multi;a];
end     

aa=load('/home/cs16m029/KMPA/A2/3.Group_4/Group_4_data.mat');
labels=aa.final_labels;
grp4labelnames=(aa.labelname)';

for i=1:3131
    for j=2:6
        if(labels(i,j)==1)
            temp(i)=j-1;
        end
    end
end
temp=temp';

grp4multilabels=[temp,grp4multi];