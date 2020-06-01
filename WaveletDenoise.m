function I = WaveletDenoise(I,level,FDR)
cl = class(I);
I = double(I);

FDR = min(FDR,0.5);
FDR = max(FDR,eps);

level = round(level);
level = max(1,level);
for k = 1:size(I,4)
    I(:,:,:,k) = wdenoise2(I(:,:,:,k),level,...
        'DenoisingMethod',{'FDR',FDR});
end

I = cast(I,cl);
end