
function J = filterSeparate(I,r)

w = 2*ceil(r)+1;
StructuringElement = ones(w);

J = imdilate(I,StructuringElement);
J = imreconstruct(imcomplement(J),imcomplement(I));
J = imcomplement(J);

end