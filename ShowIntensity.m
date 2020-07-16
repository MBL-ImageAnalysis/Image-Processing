

function ShowIntensity(I,titleStr)

imagesc(I)
axis image
axis off
cmap = hot(1000);
cmap = [cmap(:,2) cmap(:,[1 3])];
colormap(cmap)

title(titleStr)

end