

function I = Sharpen(I,radius,strength)

if nargin == 0
    I.name = 'Sharpen';
    I.var1 = 'radius';
    I.range1 = [0 10];
    I.val1 = 0;
    I.var2 = 'strength';
    I.range2 = [0 1];
    I.val2   = 1;
    I.nvars  = 2;
    I.handle = @(i,u,v) Sharpen(i,u,v);
    return
end

cl = class(I);
I  = double(I);

I(I<0)= 0;

if radius > 0
    Blurred = imgaussfilt(I,radius,...
            'Padding','replicate',...
            'FilterDomain','frequency');
else
    Blurred = I;
end
I = (1+strength)*I-strength*Blurred;

I = cast(I,cl);

end