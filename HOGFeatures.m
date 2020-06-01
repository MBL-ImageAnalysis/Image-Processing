

function [F,V] = HOGFeatures(I,cellWidth,resolution,sigma,outputMode)

% Static Parameters
NumBins   = 9;
BlockSize = [2 2];
M = size(I,1);
N = size(I,2);

    if nargin < 5
        outputMode = 1;
    end

    if nargin < 2 || isempty(cellWidth)
        cellWidth = 5;
    end

    
    if nargin < 3 || isempty(resolution)
        resolution = 50;
    end
    
    if nargin < 4 || isempty(sigma)
        sigma = 4;
    end
    clipper = @(u) u(2:(end-1));
    yy = clipper(linspace(1,M,resolution+2));
    xx = clipper(linspace(1,N,resolution+2));
    [y,x] = ndgrid(yy,xx);
    p = [x(:) y(:)];


    if size(I,3)==3
        i = rgb2gray(I);
    else
        i = I;
    end
    if sigma > 0
        i = imgaussfilt(i,sigma);
    end
    
    i = ExtendImage(i,cellWidth);
    p = p+cellWidth;
    
    [F,~,V] = extractHOGFeatures(i,p,...
        'CellSize',cellWidth*[1 1],...
        'BlockSize',BlockSize,...
        'NumBins',NumBins,...
        'UseSignedOrientation',false);
    
    if nargout == 0
        if size(I,3)==3
            imshow(I);
        else
            imagesc(I);axis image;axis off;
        end
        hold on
        plot(V,'Color','r');
    end
    
    if outputMode == 1
        Q = prod([NumBins,BlockSize]); % should equal number of cols in F
        f = reshape(F,[resolution resolution Q]);
        F = zeros(M,N,Q);
        [Y,X] = ndgrid(1:M,1:N);
        for j = 1:Q
            F(:,:,j) = interp2(...
                xx,yy,f(:,:,j),X,Y,'bicubic');
        end
    end
        
        
        
        
        
       

end

