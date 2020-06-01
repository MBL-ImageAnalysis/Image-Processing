

function J = GeometricMean(I,radius,waterLevel)

if nargin == 0
    J.name = 'Geometric Mean';
    J.var1 = 'radius';
    J.range1 = [0 10];
    J.val1   = 0;
    J.var2 = 'water level';
    J.range2 = [0 1];
    J.val2   = 0;
    J.nvars = 2;
    J.handle = @(i,u,v) GeometricMean(i,u,v);
    return
end

cl = Class(I);
I  = double(I); I(I<0)=0;
J  = log2(I+waterLevel);

w  = 2*ceil(radius)+1;
J  = imfilter(J,ones(w)/w^2,'replicate');
J  = 2.^J - waterLevel;
J  = cast(J,cl);
end

function cl = Class(i)

if isa(i,'gpuArray')
    cl = classUnderlying(i);
else
    cl = class(i);
end

end