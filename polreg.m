function [errmat,e,in] = polreg(xt,yt,xv,yv,degmax)
d = size(xt,2);
x1 = xt(:,2); %training x values
xv1=xv(:,2); %validation x values
if d==3 %2D data
    x2 = xt(:,3);
    xv2=xv(:,3);
    betalin = zeros((degmax+1)*(degmax+2)/2,degmax);
elseif d==2 %1D data
    betalin = zeros(degmax+1,degmax);
end

%polynomial fitting for 2nd degree to degmax th degree polynomial
err = zeros(1,degmax);
for i = 1:degmax
    if i ~= 1 
        if d==2 %1D  
            xt = [xt,x1.^i];
            xv = [xv,xv1.^i];
            d1b = i+1;
        elseif d==3 %2D
            d1b = (i+1)*(i+2)/2;
            for k = 0:i
                x(1:size(xt,1),k+1)=(x1.^(i-k)).*(x2.^k);
                xva(1:size(xv,1),k+1)=(xv1.^(i-k)).*(xv2.^k);
            end
            xt = [xt,x];
            xv = [xv,xva];     
        end
    else %linear,ie, degree 1 polynomial
        d1b = d;
    end
    %validation for each degree
    betalin(1:d1b,i) = inv((xt')*xt)*(xt')*yt;
    ymodel(:,i) = xv*betalin(1:d1b,i);
    err(i) = norm(ymodel(:,i)-yv);
end
%Best degree estimation for min norm error
[er,ind] = min(err);
e = er;
in = ind;
errmat = err;
end