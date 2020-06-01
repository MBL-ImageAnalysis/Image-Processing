

function Q = DenoiseSurface(volume,control_points,model)

if nargin < 3
    model = 'poly33';
end

volume = squeeze(volume);
[y,x]  = ndgrid(1:size(volume,1),1:size(volume,2));

 sf = fit([control_points(:,1),control_points(:,2)],control_points(:,3),model);
 z  = feval(sf,[x(:) y(:)]);
 z  = reshape(z,size(x));
 z  = round(z);
 z = min(z,size(volume,3)); z = max(1,z);
 idx = sub2ind(size(volume),y(:),x(:),z(:));
 Q   = zeros(size(volume));
 Q(idx)=1;
 Q   = imdilate(uint8(Q),ones(3,3,3));
 Q   = imfilter(Q,ones(3,3,3)/27);
 Q   = double(Q).*volume;
 
end