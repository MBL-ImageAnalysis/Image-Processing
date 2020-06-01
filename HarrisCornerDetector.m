function J = HarrisCornerDetector(I,radius,scale)
if nargin == 0
     J.Name     = 'corner detector';
else
    cl = class(I);
    I = double(I);
    scale = scale*2+1;
    scale = ceil(scale);
    scale = max(3,scale);
    scale = scale+1-mod(scale,2);
    w     = 2*ceil(radius)+1;
    h     = fspecial('gaussian',[w w],radius);
    I     = imfilter(I,fspecial('gaussian',[w w],radius),'replicate');
    sc    = linspace(-1,0,scale); 
    sc    = [fliplr(sc(1:(end-1))) sc*-1];
    maskX = [1;2;1]*sc;
    fx    = imfilter(I,maskX,'replicate');
    maskY = sc'*[1 2 1];
    fy    = imfilter(I,maskY,'replicate');

    J  = imfilter(fx.^2,h,'replicate').*imfilter(fy.^2,h,'replicate')-...
        imfilter(fx,h,'replicate').*imfilter(fy,h,'replicate');
    
    J = cast(J,cl);

end

end