function J = LehmerMean(I,radius,p)

if nargin == 0
    J.name = 'Lehmer Mean';
    J.var1 = 'radius';
    J.range1 = [0 10];
    J.val1   = 0;
    J.var2 = 'p';
    J.range2 = [-10 10];
    J.val2   = 0;
    J.nvars = 2;
    J.handle = @(i,u,v) LehmerMean(i,u,v);
    return
end

cl   = Class(I);
I    = double(I);
w    = 2*ceil(radius)+1;
Jtop = imfilter(I.^p,ones(w)/w^2,'replicate');
Jbot = imfilter(I.^(p-1),ones(w)/w^2,'replicate');
J    = Jtop./(Jbot+0.01);
J    = cast(J,cl);
end

function cl = Class(i)

if isa(i,'gpuArray')
    cl = classUnderlying(i);
else
    cl = class(i);
end

end