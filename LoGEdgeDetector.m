
function J = LoGEdgeDetector(I,scale,radius)

    if nargin == 0
        J.name = '|Laplacian of Gaussian|^2 Edge Detector';
        J.var1 = 'scale';
        J.range1 = [0 10];
        J.val1 = 0;
        J.var2 = 'sigma';
        J.range2 = [0 10];
        J.val2   = 0;
        J.nvars  = 2;
        J.handle = @(i,u,v) LoGEdgeDetector(i,u,v);
        return
    end
     cl = class(I);

    if nargin < 3
        radius = 2.3;
    end
    if nargin < 2
        scale = ceil(6*radius)+1;
    else
        scale = scale*2+1;
        scale = ceil(scale);
        scale = max(3,scale);
        scale = scale+1-mod(scale,2);
    end
    
    J     = double(I);
    
    h = fspecial('log',[scale scale],radius);
    J = abs(imfilter(J,h,'replicate')).^2;
    J = (255/max(J(:)))*J;
    J = cast(J,cl);
    
    
end
