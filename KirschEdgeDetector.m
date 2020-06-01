function K = KirschEdgeDetector(I,scale,radius)

    if nargin == 0
        K.name = 'Kirsch Edge Detector';
        K.var1 = 'scale';
        K.range1 = [0 10];
        K.val1 = 0;
        K.var2 = 'sigma';
        K.range2 = [0 10];
        K.val2   = 0;
        K.nvars  = 2;
        K.handle = @(i,u,v) KirschEdgeDetector(i,u,v);
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
    
    idx = [1 2 3 6 9 8 7 4];
    vals= [5 -3 -3 -3 -3 -3 5 5];
    
    K = zeros(size(I,1),size(I,2),1,size(I,4),'double');
    
    for slice = 1:size(I,4)
    
        for j = 1:8
            M = zeros(3);
            M(idx) = circshift(vals,1-j);
            g{j} =M;
        end

        if scale > 1
            for j = 1:8
                g{j} = kron(g{j},ones(scale));
            end
        end

        J     = double(I(:,:,:,slice));
        J = sum(J,3);
        if radius > 0
            J     = GaussBlur(J,radius,1);
        end
        Js = repmat(J,[1 1 8]);
        for j = 1:8
            Js(:,:,j) = imfilter(Js(:,:,j),g{j},'replicate');
        end
        J = max(Js,[],3);
        J = (255/max(J(:)))*J;
        K(:,:,:,slice) = J;
    end
    K = cast(J,cl);

  
end
    
    