function J = GaussBlur(I,sigma,mixture)

if nargin == 0
    J.name = 'Gaussian Blur';
    J.var1 = 'sigma';
    J.range1 = [0 12];
    J.val1 = 0;
    J.var2 = 'mix';
    J.range2 = [0 1];
    J.val2   = 1;
    J.nvars  = 2;
    J.handle = @(I,u,v) GaussBlur(I,u,v);
    return
end

if nargin < 3
    mixture = 1;
end

if nargin < 2
    sigma = 1;
end

cl = Class(I);

if sigma > 0
    width = 2*ceil(3*sigma+1)+1;
    J = imgaussfilt(I,sigma,...
        'FilterSize',[width width],...
        'Padding','replicate',...
        'FilterDomain','spatial');

    if mixture > 0
        J = (1-mixture)*double(I)+mixture*double(J);
    end
    J  = cast(J,cl);
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