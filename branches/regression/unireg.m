clear all;
close all;

temp=load('uniyn.mat');
yn=temp.yn;
temp=load('unix.mat');
x=temp.x;
temp=load('uniy.mat');
y=temp.y;xxyy=horzcat(x,y);xxyy=sortrows(xxyy,1);

% figure
% plot(x,y,'+');    %data
% hold on;
% plot(x,yn,'*');   %with gaussian noise added

udata=horzcat(x,yn);

sudata = size(udata);
obs = sudata(1); %#observations
xdim = sudata(2)-1;
 
iterations = 20;    % #iterations with random partitioning of training and validation data
strain = floor(.7*obs); %training size
svalid = floor(.2*obs); %validation size
stest = obs - strain - svalid;  %test size
degmax = 20; %Max degree of polynomial for fitting

[xtest,ytest,dlef] = randpick(udata,stest); %randomly selecting the test data
 
errorpol=zeros(1,iterations);   
degpo=zeros(1,iterations);
errmat1 = zeros(degmax,iterations);  
for k =1:iterations
    [xtrain,ytrain,dle] = randpick(dlef,strain); %traindata and validation data split
    [xvalid,yvalid,dl] = randpick(dle,svalid);  
    [errmat1(1:degmax,k),errorpol(k),degpo(k)] = polreg(xtrain,ytrain,xvalid,yvalid,degmax); %polyfitting 1D
end 
[xt,yt,dle] = randpick(dlef,strain);%Random training dataset to determine coefficients(bpoly) of optimal degree 
[xv,yv,dl] = randpick(dle,svalid); 

%polynomial fitting  best degree plotting & estimation;plots of regression models with training set  x = xt(:,2);

    x = xt(:,2);
    errmat = mean(errmat1,2);
    [~,degoptim] = min(errmat); 
    for j = 2:degoptim
        xt = [xt,x.^j];
    end
    bpoly = inv((xt')*xt)*(xt')*yt;

    figure()
    plot(errmat,'b:*');
    ylabel('Average Training error ');
    xlabel('Polynomial degree');
    title('Average Training error vs Polynomial degree');
%     saveas(gcf,'1D001.png');
    
    figure()
    f1 = plot(x,yt,'r*');
    hold on;
    y = xt*bpoly; xy=horzcat(x,y); xy=sortrows(xy,1);
    f2 = plot(xy(:,1),xy(:,2),'b-','linewidth',1.5);
    hold on;
    f3 = plot(xxyy(:,1),xxyy(:,2),'g-','linewidth',1.5);
    legend([f1 f2 f3],'Actual Y with Noise','Model Output','Underlying Function')
    xlabel('X');
    ylabel('Y');
    str = sprintf('Polynomial Fitting for Degree %d - training data' ,degoptim);
    title(str); 
%     saveas(gcf,'1D002.png');
    
    ii=[1:20];
    figure()
    plot(ii,errmat1(degoptim,:),'b:*'); 
    xlabel('Iterations');
    ylabel('Validation Error');
    str = sprintf('Training Error vs Iterations during Cross-Validation for Optimal Degree=%d' ,degoptim);
    title(str); 
%     saveas(gcf,'1D003.png'); 
    
    yscatter=[xt(:,2),yt,y];
    yscatter=sortrows(yscatter,2);
    figure
    plot(yscatter(:,2),yscatter(:,2),'linewidth',1.5); 
    hold on
    plot(yscatter(:,2),yscatter(:,3),'*','markersize',5); 
    xlabel('Target Output');
    ylabel('Model Output');
    str = sprintf('Scatter Plot for Target vs Model Output');
    title(str); 
%   saveas(gcf,'1D004.png'); 
    
    
    

