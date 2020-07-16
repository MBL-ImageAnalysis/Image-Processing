
function handle = ShowPoints(poly,ax,Color,MarkerSize,Marker)
    if nargin < 5
        Marker = '.';
    end
    if nargin < 4
        MarkerSize = 12;
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
    handle = plot(poly(:,1),poly(:,2),Marker,...
        'color',Color,...
        'MarkerSize',MarkerSize);
    if ~state
        hold(ax,'off');
    end
    
end
