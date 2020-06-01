

function J = GaussianCorrelator(I,s,floorVal)
if nargin == 0
    J.name   = 'Gaussian Correlator';
    J.var1   = 'sigma';
    J.range1 = [0 12];
    J.val1   = 0;
    J.var2   = 'floor';
    J.range2 = [0 1];
    J.val2   = 1;
    J.nvars  = 2;
    J.handle = @(i,u,v) GaussianCorrelator(i,u,v);
    return
end

if nargin < 3
    floorVal = 0;
end

if nargin < 2
    s = 5;
end


w = 2*ceil(2*s)+1;
h = fspecial('gaussian',[w w],s);

I = mean(I,3); I = mean(I,4); 
h = mean(h,3);
wy = size(h,1);
wx = size(h,2);

    I = [repmat(I(:,1,:,:),[1 wx 1 1]) I repmat(I(:,end,:,:),[1 wx 1 1])];
    I = [repmat(I(1,:,:,:),[wy 1 1 1]);I;repmat(I(end,:,:,:),[wy 1 1 1])];
    J = normxcorr2(h,I);
    J = J((wy+1):(end-wy),(wx+1):(end-wx),:,:);
    
    J = J-floorVal;J(J<0)=0;

end