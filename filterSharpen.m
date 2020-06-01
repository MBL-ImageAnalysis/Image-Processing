function J = filterSharpen(I,radius,coef)

        J = zeros(size(I,1),size(I,2),numel(radius),numel(coef));
        for j = 1:numel(radius)
            w = ceil(2*radius(j)+1);
            h = fspecial('gaussian',[w w],radius(j));
            i = imfilter(I,h,'symmetric');
            for k = 1:numel(coef)
                J(:,:,j,k) = (1+coef(k))*I-coef(k)*i;
            end
        end

        J(J<0)=0;
end

end