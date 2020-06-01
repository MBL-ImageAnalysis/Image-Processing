function J = ConeBlur(I,radius,mixture)

if nargin == 0
    J.name = 'Cone Blur';
    J.var1 = 'radius';
    J.range1 = [0 12];
    J.val1 = 0;
    J.var2 = 'mixture';
    J.range2 = [0 1];
    J.val2   = 1;
    J.nvars  = 2;
    J.handle = @(i,u,v) ConeBlur(i,u,v);
    return
end

if radius> 0

    cl = Class(I);
    radius = ceil(radius);
    N      = 2*radius+1;

    % Forming taper input variable
    [y,x] = ndgrid(linspace(-1,1,N),linspace(-1,1,N));
    r     = sqrt(x.^2+y.^2);

    h     = zeros(size(r));
    idx   = find(r<1);
    h(idx)= 1-r(idx);
    h     = h/sum(h(:));

    n = radius+1;
    h = mixture*h;
    h(n,n) = h(n,n)+(1-mixture);

    J = imfilter(I,h,'replicate');
    J = cast(J,cl);
else
    J = I;
end

end

function cl = Class(i)

if isa(i,'gpuArray')
    cl = classUnderlying(i);
else
    cl = class(i);
end

end