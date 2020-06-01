function J = BoxBlur(I,radius,mixture)

if nargin == 0
    J.name = 'Box Blur';
    J.var1 = 'radius';
    J.range1 = [0 12];
    J.val1 = 0;
    J.var2 = 'mixture';
    J.range2 = [0 1];
    J.val2   = 1;
    J.nvars = 2;
    J.handle = @(i,u,v) BoxBlur(i,u,v);
    return
end

if nargin < 3
    mixture = 1;
end

if nargin < 2
    radius = 1;
end

if radius > 0 && mixture > 0
    cl    = Class(I);
    width = 2*ceil(radius)+1;
    J     = imfilter(I,ones(width)/width^2,'replicate');

    if mixture > 0
        J = (1-mixture)*double(I)+mixture*double(J);
    end
    
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