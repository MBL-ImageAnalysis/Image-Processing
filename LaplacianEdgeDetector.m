function J = LaplacianEdgeDetector(I,scale,radius)

    if nargin == 0
        J.name = '|Laplacian|^2 Edge Detector';
        J.var1 = 'scale';
        J.range1 = [0 10];
        J.val1 = 0;
        J.var2 = 'sigma';
        J.range2 = [0 10];
        J.val2   = 0;
        J.nvars  = 2;
        J.handle = @(i,u,v) LaplacianEdgeDetector(i,u,v);
        return
    end
    cl = class(I);
    if nargin < 3
        radius = 2.3;
    end
    if nargin < 2
        scale = 1;
    end
    scale = scale*2+1;
    scale = ceil(scale);
    scale = max(3,scale);
    scale = scale+1-mod(scale,2);
    J     = double(I);
    if radius > 0
        J     = GaussBlur(J,radius,1);
    end
    Jo    = J;
    J     = imfilter(J,ones(1,scale),'replicate');
    J     = imfilter(J,ones(scale,1),'replicate');
    J     = J-(scale^2)*Jo;
    J     = (255/max(J(:)))*J;
    J     = cast(J,cl);
end