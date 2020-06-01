

function J = MuAbsDiff(I,h)

m = size(h,1);
n = size(h,2);
I = ExtendImage(I,[m n]);

S = 0;
h = h/numel(h(:));
for j = 1:m
   for k = 1:n
     S = S+circshift(I,[j-floor(m/2) k-floor(n/2)])*h(j,k);
   end
end


J = sum(abs(I-reshape(h,[1 1 m*n])),3);
J = TrimImage(J,[m n]);

end
        