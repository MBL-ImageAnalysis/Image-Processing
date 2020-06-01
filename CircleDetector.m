

function J = CircleDetector(I,radius,edgewidth)

if nargin < 3
    edgewidth = 1;
end

if nargin < 2
    radius = 10;
end

h = CircleKernel(radius,edgewidth);
I = LatentSurfaceDetector(I,3);
I = del2(I);
J = Similarity(I,h);

J = imgaussfilt(J,radius/4)./(1+imgaussfilt(J,radius));

end



function J = Similarity(I,h)
  
    hm = mean(h(:));
    hd = h-hm;
    
    t1 = sum(hd(:).^2);
    
    ii = ones(size(h));
    Iavg = imfilter(I,ii,'replicate')/numel(ii);
    
    t2 = imfilter(I,hd-ii/numel(ii))-Iavg*sum(h(:));
    
    t3 = imfilter(I.^2,ii,'replicate')...
        -2*Iavg ...
        +imfilter(I,ii,'replicate').*Iavg;
    J = t1-t2+t3;
    Nrm = sqrt(t3)*sqrt(sum(hd(:).^2));
    J = J./Nrm;
    J = J/max(abs(J(:)));
    
   

end






function A = LatentSurfaceDetector(I,pr)

if nargin < 2
    pr =6;
end

r = ceil(pr);

ps = 2*r+1;

ps = ps*[1 1];


[y,x] = ndgrid(1:ps(1),1:ps(2));

x = x-mean(x(:));
y = y - mean(y(:));
x = x/max(x(:));
y = y/max(y(:));

x0 = ones(size(x));
x1 = x;
y1 = y;
x1y1 = x1.*y1;
x2 = x.^2;
y2 = y.^2;
x3 = x.^3;
y3 = y.^3;
x1y2 = x.*y2;
x2y1 = x2.*y1;

B = [x0(:) x1(:) y1(:) x1y1(:) x2(:) y2(:) x1y2(:) x2y1(:) x3(:) y3(:)];
r = (ps-1)/2;
X = im2col(I,ps,'sliding');
Y = (B'*B)\(B'*X);
Offset = Y(1,:);
Y = col2im(Offset,ps,[size(I,1) size(I,2)]);
A = padarray(Y,r);


A(A<0)=0;
A = real(A);

end





