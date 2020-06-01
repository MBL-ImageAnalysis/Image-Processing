

function J = filterSweep(I,threshold)
if nargin == 0
    
    J.type    = 'filter';
    J.name    = 'Sweep';
    J.mode    = 'stack';
    J.vars    = 1;
    J.input1  = 'threshold';
    J.range1  = [0 2^15];
    
    return
    
end
 


% default threshold
if nargin < 2 || isempty(threshold)
    threshold = max(eps,0.05*mean(I(:)));
end

% Copying Image
J = I;

% Sweeping Floor
J(I<threshold)=0;

end
