
function handle = ShowImage(I,ax,cmap)

    if nargin < 3
        cmap = bone(1000);
    end
    if nargin < 2 || isempty(ax)
        ax = gca;
    end

    if size(I,4)>1
        I = squeeze(max(I,[],4));
    end
    
    try
        handle = ax.Children(1);
        mr = size(handle.CData,1);
        nc = size(handle.CData,2);
        pl = size(handle.CData,3);
        if size(I,1)==mr && size(I,2)==nc && size(I,3)==pl
            handle.CData = I;
        else
            errrrrrrror;
        end
    catch
        nchan = size(I,3);
        if nchan==3 || nchan == 2
            if nchan == 2
                I = imfuse(I(:,:,1),I(:,:,2));
            end
            handle = imshow(I,'Parent',ax);
        else
            if size(I,3)~=1
                I = max(I,[],3);
            end
            handle = imagesc(ax,I);
            colormap(ax,cmap);
            axis(ax,'image')
            axis(ax,'off')
        end
    end

end