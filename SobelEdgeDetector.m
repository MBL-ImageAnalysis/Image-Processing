function J = SobelEdgeDetector(I,scale,radius)

    if nargin == 0
        J.name = 'Sobel Edge Detector';
        J.var1 = 'scale';
        J.range1 = [0 10];
        J.val1 = 0;
        J.var2 = 'sigma';
        J.range2 = [0 10];
        J.val2   = 0;
        J.nvars  = 2;
        J.handle = @(i,u,v) SobelEdgeDetector(i,u,v);
        return
    end
    
    cl    = class(I);
    
    
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
    sc    = linspace(-1,0,scale); 
    sc    = [fliplr(sc(1:(end-1))) sc*-1];
    hx    = [1;2;1]*sc;
    Dx    = imfilter(J,hx,'replicate');
    hy    = sc'*[1 2 1];
    Dy    = imfilter(J,hy,'replicate');
    J     = sqrt(Dx.^2+Dy.^2);
    
    J = (255/max(J(:)))*J;
    J = ArrayCast(J,cl);
    
end