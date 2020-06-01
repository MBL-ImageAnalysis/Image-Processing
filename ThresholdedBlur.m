function J = ThresholdedBlur(I,sigma,bd)

if nargin == 0
    J.name = 'Thresholded Blur';
    J.var1 = 'sigma';
    J.range1 = [0 12];
    J.val1 = 0;
    J.var2 = 'bound';
    J.range2 = [0 100];
    J.val2   = 1;
    J.nvars = 2;
    J.handle = @(i,u,v) ThresholdedBlur(i,u,v);
    return
end

cl  = class(I);
I   = double(I);
w   = 2*ceil(2*sigma)+1;
idx = (w^2+1)/2;
h   = fspecial('gaussian',[w w],sigma);

MM = size(I,1); 
NN = size(I,2);
ii = (1:(MM-w+1))+(w+1)/2;
jj = (1:(NN-w+1))+(w+1)/2;

I = gpuArray(I);
J = imfilter(I,h,'replicate');

for j = 1:size(I,4)
    for k = 1:size(I,3)
        J(ii,jj,k,j) = processChannel(I(:,:,k,j),h,bd,idx);
    end
end
J = gather(J);
J = cast(J,cl);

end

function C = processChannel(A,h,bd,idx)

M  = size(h,1);
N  = M;
MM = size(A,1); 
NN = size(A,2);
B  = im2col(A,[M N]);

Mask = abs(B-B(idx,:))<bd;
Mask = Mask.*h(:);
Mask = Mask./(sum(Mask,1)+sqrt(eps));
Ap   = sum(B.*Mask,1);

C    = reshape(Ap,[MM-M+1,NN-N+1]);

end