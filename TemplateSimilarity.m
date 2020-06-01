

function J = TemplateSimilarity(I,h,method)

if nargin < 1
    I = ReadImage();
end

if nargin < 2 || isempty(h)
    h = TemplateExtractionTool(I);
end

if nargin < 3
    method = 'xcorr';
end

I = mean(I,3); I = mean(I,4); 
h = mean(h,3);
J = zeros(size(I));
wy = size(h,1);
wx = size(h,2);

if strcmpi(method,'L2 difference')
    hs = sum(h(:).^2);
    ii = ones(size(h));
    is = imfilter(I.^2,ii,'replicate');
    hI = imfilter(I,h,'replicate');
    J  = hs+is-2*hI;
    Nrm = sqrt(is)*sqrt(hs);
    J = J./Nrm;
    J = J/max(abs(J(:)));
    J = 1-J;
elseif strcmpi(method,'variational difference')
    
    hm = mean(h(:));
    hd = h-hm;
    
    t1 = sum(hd(:).^2);
    
    ii = ones(size(h));
    Iavg = imfilter(I,ii,'replicate')/numel(ii);
    
    t2 = imfilter(I,hd-ii/numel(ii))-Iavg*sum(h(:));
    
    t3 = imfilter(I.^2,ii,'replicate')...
        -2*Iavg ...
        +imfilter(I,ii,'replicate').*Iavg;
    J = t1-t2+t3;
    Nrm = sqrt(t3)*sqrt(sum(hd(:).^2));
    J = J./Nrm;
    J = J/max(abs(J(:)));
    J = 1-J;
    
    
elseif strcmpi(method,'xcorr')
    I = [repmat(I(:,1,:,:),[1 wx 1 1]) I repmat(I(:,end,:,:),[1 wx 1 1])];
    I = [repmat(I(1,:,:,:),[wy 1 1 1]);I;repmat(I(end,:,:,:),[wy 1 1 1])];
    J = normxcorr2(h,I);
    J = J((wy+1):(end-wy),(wx+1):(end-wx),:,:);
end

end