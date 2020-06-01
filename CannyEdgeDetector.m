function K = CannyEdgeDetector(I,thresholdMin,thresholdMax)
    
    if nargin == 0
        K.name = 'Canny Edge Detector';
        K.var1 = 'MinThresh';
        K.range1 = [0 1];
        K.val1 = 0;
        K.var2 = 'MaxThresh';
        K.range2 = [0 1];
        K.val2   = 0.25;
        K.nvars  = 2;
        K.handle = @(i,u,v) CannyEdgeDetector(i,u,v);
        return
    end
    cl = class(I);
    if nargin < 2
        thresholdMin = 0;
    end
    if nargin < 3
        thresholdMax = 0.2;
    end

    I      = double(I);
    I      = max(I,[],3);
    scale  = 1;
    scale  = scale*2+1;
    scale  = ceil(scale);
    scale  = max(3,scale);
    scale  = scale+1-mod(scale,2);
    radius = 1;
    if radius > 0
        I     = GaussBlur(I,radius,1);
    end
    
    sc    = linspace(-1,0,scale); 
    sc    = [fliplr(sc(1:(end-1))) sc*-1];
    hx    = [1;2;1]*sc;
    Dx    = imfilter(I,hx,'replicate');
    hy    = sc'*[1 2 1];
    Dy    = imfilter(I,hy,'replicate');
    J     = sqrt(Dx.^2+Dy.^2);
    Theta = atan2(Dy,Dx);
    [y,x] = ndgrid(1:size(I,1),1:size(I,2));
    F     = interp2(x,y,I,x+round(cos(Theta)),y+round(sin(Theta)));
    J(F<ordfilt2(I,8,ones(3)))=0;
    J = abs(J);
    J = J/max(J(:));
    
    K = zeros(size(J));
    K(J>thresholdMax)=1;
    K = imdilate(K,ones(3));
    K(J<thresholdMin)=0;
    K = 255*K;
    K = cast(K,cl);
    
end