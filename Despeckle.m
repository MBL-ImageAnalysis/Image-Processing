

function J = Despeckle(I,radius,spread)

if nargin == 0
    J.name = 'Despeckle';
    J.var1 = 'radius';
    J.range1 = [0 10];
    J.val1   = 0;
    J.var2 = 'spread';
    J.range2 = [0 40];
    J.val2   = 0;
    J.nvars = 2;
    J.handle = @(i,u,v) Despeckle(i,u,v);
    return
end

if nargin < 3
    spread = 40;
end

if nargin < 2
    radius = 10;
end

if radius >0 && spread > 0
    radius = max(1,radius);
    spread = max(spread,1);
    cl = Class(I);
    h     = fspecial('disk',radius)>0;
    n     = size(h,1);
    mp    = ceil((n+1)/2);
    h(mp,mp)=0;
    n     = sum(h(:));
    mp    = ceil((n+1)/2);
    low   = round(mp-spread); low = max(1,low);
    high  = round(mp+spread); high = min(high,n);
    J = zeros(size(I,1),size(I,2),size(I,3),size(I,4),class(I));
    for k = 1:size(J,4)
        for j = 1:size(J,3)
            Jlow  = ordfilt2(I(:,:,j,k),low,h);
            Jhigh = ordfilt2(I(:,:,j,k),high,h);
            J(:,:,j,k)= min(max(I(:,:,j,k),Jlow),Jhigh);
        end
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
