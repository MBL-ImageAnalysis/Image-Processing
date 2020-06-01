
function J = HighpassEdgeDetector(I,scale,radius)
    if nargin == 0
        J.name = 'Highpass Edge Detector';
        J.var1 = 'scale';
        J.range1 = [0 10];
        J.val1 = 0;
        J.var2 = 'sigma';
        J.range2 = [0 10];
        J.val2   = 0;
        J.nvars  = 2;
        J.handle = @(i,u,v) HighpassEdgeDetector(i,u,v);
        return
    end

if nargin < 3
    radius = 5;
end
if nargin < 2
    scale = ceil(7*radius)+1;
else
    scale = scale*2+1;
    scale = ceil(scale);
    scale = max(3,scale);
    scale = scale+1-mod(scale,2);
end

cl    = Class(I);
I     = double(I);

h     = fspecial('gaussian',ceil([scale scale]),radius);
h     = tanh((4/max(h(:)))*h);
h     = h/sum(h(:));
J     = imfilter(I,h,'replicate');

J = I-J;
J = J+min(J(:));
J = (255/max(J(:)))*J;
J = cast(J,cl);

end