function J = filterLaplacianGaussian(I,radius,footprints)

    J = zeros(size(I,1),size(I,2),numel(radius),numel(footprints));
    for j = 1:numel(radius)
        for k = 2:numel(iterations)
            w = 2*ceil(footprints(k))+1;
            h = fspecial('log',[w w],radius(j));
            J(:,:,j,k) = imfilter(J(:,:,j,k-1),h,'replicate');
        end
    end


end
