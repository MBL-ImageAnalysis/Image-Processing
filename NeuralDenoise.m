

function I = NeuralDenoise(I,scale,iterations)

if nargin == 0
    I.name = 'dnCNN';
    I.var1 = 'scale';
    I.range1 = [0 2];
    I.val1 = 1;
    I.var2 = 'passes';
    I.range2 = [1 10];
    I.val2   = 1;
    I.nvars  = 2;
    I.handle = @(i,u,v) NeuralDenoise(i,u,v);
    return
    
end

if nargin < 3
    iterations = 1;
end

if nargin < 2
    scale = 1;
end

net = denoisingNetwork('DnCNN');
    
cl  = class(I);

if scale ~= 1
    I   = cast(scale*single(I),cl);
end
for j = 1:iterations
    for slice = 1:size(I,4)
        for color = 1:size(I,3)
            I(:,:,color,slice) = denoiseImage(I(:,:,color,slice),net);
        end
    end
end

if scale ~= 1
    I = cast(single(I)/scale,cl);
end
I   = cast(I,cl);

end