

function I = Denoise(I,rad,iterations)

if nargin == 0
    I.name = 'Median';
    I.var1 = 'radius';
    I.range1 = [0 12];
    I.val1 = 0;
    I.var2 = 'passes';
    I.range2 = [0 10];
    I.val2   = 1;
    I.nvars  = 2;
    I.handle = @(i,u,v) Denoise(i,u,v);
    return
end

if nargin < 2
    rad = 3;
end

if nargin < 3
    iterations = 1;
end

if rad > 0
    cl  = Class(I);
    rad = ceil(rad);
    rad = max(1,rad);


    Mask = fspecial('disk',rad)>0;
    n = sum(Mask(:));
    n = ceil((n+1)/2);
    for it = 1:iterations
        for k = 1:size(I,4)
            for j = 1:size(I,3)
                I(:,:,j,k) = ordfilt2(I(:,:,j,k),n,Mask,'symmetric');
            end
        end
    end

    I = cast(I,cl);

end


end

function cl = Class(i)

if isa(i,'gpuArray')
    cl = classUnderlying(i);
else
    cl = class(i);
end

end

