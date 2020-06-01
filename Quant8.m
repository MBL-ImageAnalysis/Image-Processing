

function J = Quant8(I)
I = double(I);
I = (255/max(I(:)))*I;
J = uint8(I);
end