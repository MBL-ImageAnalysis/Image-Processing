function J = RobertsCrossEdgeDetector(I,scale,radius)

    if nargin == 0
        J.name = 'Roberts Cross Edge Detector';
        J.var1 = 'scale';
        J.range1 = [0 10];
        J.val1 = 0;
        J.var2 = 'sigma';
        J.range2 = [0 10];
        J.val2   = 0;
        J.nvars  = 2;
        J.handle = @(i,u,v) RobertsCrossEdgeDetector(i,u,v);
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
    i     = ones(scale);
    hx    = [1 0;0 -1];
    hy    = [0 1;-1 0];
    if scale~=1
        hx    = kron(hx,i);
        hy    = kron(hy,i);
    end
    Dx    = imfilter(J,hx,'replicate');
    Dy    = imfilter(J,hy,'replicate');
    J     = sqrt(Dx.^2+Dy.^2);
    J = (255/max(J(:)))*J;
    J = cast(J,cl);
    
end