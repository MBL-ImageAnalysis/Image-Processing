function J = Quantize8bit(I,valMin)

if nargin == 2
    I = I-valMin;
end

mx = max(I(:));
if mx > 0
    I = double(I);
    I = (255/mx)*I;
end

J = uint8(I);
end