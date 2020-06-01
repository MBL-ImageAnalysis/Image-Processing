function J = Lowpass(I,radius,steepness)

if nargin == 0
     J.name     = 'lowpass filter';
     J.var1     = 'radius';
     J.range1   = [0 100];
     J.val1     = 0;
     J.var2     = 'steepness';
     J.range2   = [1 10];
     J. val2    = 1;
     J.handle   = @(i,u,v) Lowpass(i,u,v);
     return
end

if radius>0
    cl    = Class(I);
    F     = fft2(I);
    M     = size(F,1);
    N     = size(F,2);
    t     = fspecial('gaussian',[M N],radius); 
    t     = t/max(t(:)); t = t.^steepness;
    Ft    = F.*fftshift(t);
    J     = real(ifft2(Ft));
    J     = cast(J,cl);
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