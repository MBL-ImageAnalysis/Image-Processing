
function [eh,ph] = ShowMesh(p,f,ax,pColor,eColor,MarkerSize,Marker)
    if nargin < 7 || isempty(Marker)
        Marker = '.';
    end
    if nargin < 6 || isempty(MarkerSize)
        MarkerSize = 15;
    end
    if nargin < 5 || isempty(eColor)
        eColor = 'g';
    end
    if nargin < 4 || isempty(pColor)
        pColor = 'b';
    end
    if nargin < 3 || isempty(ax)
        ax = gca;
    end
    if nargin < 2 || isempty(f)
        f = delaunay(p);
    end
    
    state = ishold(ax);
    if ~state
        hold(ax,'on')
    end
    eh = trimesh(f,p(:,1),p(:,2),'color',eColor,'linewidth',MarkerSize/20);
    ph = plot(p(:,1),p(:,2),Marker,...
        'color',pColor,...
        'MarkerSize',MarkerSize);
    if ~state
        hold(ax,'off');
    end
    
end
