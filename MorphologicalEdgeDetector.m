function K = MorphologicalEdgeDetector(I,low,high)

    if nargin == 0
        K.name = 'Perimeter Edge Detector';
        K.var1 = 'low';
        K.range1 = [0 100];
        K.val1 = 0;
        K.var2 = 'high';
        K.range2 = [0 100];
        K.val2   = 100;
        K.nvars  = 2;
        K.handle = @(i,u,v) MorphologicalEdgeDetector(i,u,v);
        return
    end
    
    scale = max(I(:));
    
    high = high*scale/100;
    low  = low*scale/100;
    
    H = (I>=high);
    mask = ones(3);
    J = zeros(size(H),'logical');
    for k = 1:size(I,4)
        for j = 1:size(I,3)
            J = ordfilt2(I(:,:,j,k),1,mask)<low;
        end
    end
    K = H.*J;
    if isa(I,'uint8')
        K = 255*uint8(K);
    elseif isa(I,'uint16')
        K = 255*uint16(K);
    else
        K = cast(K,class(I));
    end
    
end
    
    
    