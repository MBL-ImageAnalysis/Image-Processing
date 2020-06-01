function i = Detrend2D(i)

i = double(i);

for j = 1:size(i,3)

I = i(:,:,j);
    
% size of image
[M,N] = size(I);

% centered grid with (0,0) in the center
[y,x] = ndgrid(1:M,1:N);
x = x-ceil(N/2);
y = y-ceil(M/2);

% Basis matrix (1,x,y) at each pixel per row
B = [ones(M*N,1) x(:) y(:)];

% Fitting Image Intensityto an Affine a+bx+cy
c = (B'*B)\(B'*I(:));

% Getting Affine Profile underlying image
h = B*c;

% subtracting background affine form underlying image
i(:,:,j) = I-reshape(h,[M,N]);

end


end
