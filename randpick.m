function [x,y,dleft] = randpick(s,rw)
sizin = size(s);
obs = sizin(1);
d = sizin(2);
x1 = zeros(rw,d);
for i = 1:rw
    sizin = size(s);
    obs = sizin(1);
    r = randi(obs,1);
    x1(i,:) = s(r,:);
    s(r,:) = [];
end
x1 = [ones(rw,1),x1];
y = x1(:,d+1);
x = x1(:,1:d);
dleft = s;
end