function J = GradNormEdgeDetector(I,scale,radius)

    if nargin == 0
        J.name = 'Gradient Norm Edge Detector';
        J.var1 = 'scale';
        J.range1 = [0 10];
        J.val1 = 0;
        J.var2 = 'strength';
        J.range2 = [0 10];
        J.val2   = 0;
        J.nvars  = 2;
        J.handle = @(i,u,v) GradNormEdgeDetector(i,u,v);
        return
    end
    
    cl    = class(I);
    if nargin < 3
        radius = 2.3;
    end
    if nargin < 2
        scale = 1;
    end
    J     = double(I);
    if radius > 0
        J     = GaussBlur(J,radius,1);
    end
    Dx     = NeumannDx(J,scale,radius);
    Dy     = NeumannDy(J,scale,radius);
    J      = sqrt(Dx.^2+Dy.^2);
    J      = cast(J,cl);
    
end