clear all;
close all;

x = rand(100,1);               % domain - 0 to 1
y = exp(sin(2*pi.*x))+x;       % given function
yn = y + 0.1.*randn(size(x));       % noise added

figure
plot(x,y,'+');
hold on;
plot(x,yn,'*');