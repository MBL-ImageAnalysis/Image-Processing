
function handle = ShowCurve(poly,ax,Color,lineWidth)

    if norm((poly(1,:)-poly(end,:))')>eps
        poly = [poly;poly(1,:)];
    end

    if nargin < 4
        lineWidth = 3;
    end
    if nargin < 3
        Color = 'g';
    end
    if nargin < 2 || isempty(ax)
        ax = gca;
    end
    state = ishold(ax);
    if ~state
        hold(ax,'on')
    end
    handle = plot(poly(:,1),poly(:,2),'color',Color,'linewidth',lineWidth);
    if ~state
        hold(ax,'off');
    end
    
end
