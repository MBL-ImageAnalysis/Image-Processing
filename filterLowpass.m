

function J = filterLowpass(I,sigma,method)

if nargin < 3
    method = 'space';
end

if nargin <2 || isempty(sigma)
    sigma = 3;
end

if size(I,3) > 1
    for j = 1:size(I,3)
        I(:,:,j) = filterLowpass(I(:,:,j),sigma,method);
    end
    J = I;
    return
end


F = Fourier2D(I);
h = fspecial('gaussian',size(I),sigma);

if strcmp(method,'space')
    J = imfilter(I,h,'replicate');
elseif strcmp(method,'frequency')
    H = Fourier2D(fftshift(h));
    F = F.*H;
    J = InverseFourier2D(F,1);
end


end

