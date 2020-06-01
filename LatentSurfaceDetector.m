



function A = LatentSurfaceDetector(I,pr,order)

if nargin < 2
    pr =6;
end

if nargin < 3
    order = 4;
end

I = double(I);

r     = ceil(pr);
[y,x] = ndgrid(-r:r,-r:r);
x     = x(:)/r;
y     = y(:)/r;

B = zeros(numel(x),(order+1)^2);
k = 1;
for m = 0:order
    for n = 0:order
        B(:,k) = (x.^m).*(y.^n);
        k = k+1;
    end
end

if size(I,3) == 1
    I = ExpandDomain(I,2*r+1);
    X = im2col(I,(2*r+1)*[1 1],'sliding');
    Y = (B'*B)\(B'*X);
    A = Y(1,:);
    A = col2im(A,(2*r+1)*[1 1],[size(I,1) size(I,2)]);

else
    A = I*0;
    I = ExpandDomain(I,2*r+1);
    for j = 1:size(I,3)
        X = im2col(I(:,:,j),(2*r+1)*[1 1],'sliding');
        Y = (B'*B)\(B'*X);
        a = Y(1,:);
        a = col2im(a,(2*r+1)*[1 1],[size(I,1) size(I,2)]);
        A(:,:,j) = a;
    end

end


A(A<0)= 0;
A     = real(A);

end

function Js = ExpandDomain(Is,width)
width = width+mod(width,2)-1;
width = (width-1)/2; 

if size(Is,3)==1
Js = [repmat(Is(:,1),[1 width]) Is repmat(Is(:,end),[1 width])];
Js = [repmat(Js(1,:),[width 1]);Js;repmat(Js(end,:),[width 1])];
else
    Js = zeros(size(Is,1)+width*2,size(Is,2)+width*2,size(Is,3));
    for j = 1:size(Is,3)
        I = Is(:,:,j);
        J = [repmat(I(:,1),[1 width]) I repmat(I(:,end),[1 width])];
        J = [repmat(J(1,:),[width 1]);J;repmat(J(end,:),[width 1])];
        Js(:,:,j) = J;
    end
end

end

