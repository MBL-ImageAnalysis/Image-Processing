

function J = filterHomomorphic(I,radius,waterLevel,coef)

if nargin < 4
    coef = 0.15;
end

if nargin < 3
    waterLevel = 1;
end

if nargin < 2
    radius = size(I,1)/5;
end

if size(I,3) > 1
    for j = 1:size(I,3)
        I(:,:,j) = filterHomomorphic(I(:,:,j),radius,waterLevel,coef);
    end
    J = I;
    return
end

I(I<0)=1;
J = log10(I+waterLevel);

H = filterLowpass(J,radius,'space');
J = (1+coef)*J-coef*H;
J = 10.^(J)-waterLevel;
J(J<0)=0;


end