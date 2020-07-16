

function list = ListImages(pth,type,fl)

try

    if nargin < 3
        fl = 1;
    end

    ncharsSuffix = numel(type);
    list         = dir(fullfile(pth,['*' type]));
    count        = 0;
    flag         = false;
    fid = list(fl).name;
    while ~flag
        if isnan(str2double(fid(count+1)))
            count = count+1;
        else
            flag = true;
        end
    end
    ncharsPrefix = count;     
    list = SortDirectory(list,ncharsPrefix,ncharsSuffix);
    
catch
    list = [];
end
    

end


function list = SortDirectory(list,ncharsPrefix,ncharsSuffix)

if nargin < 2
    ncharsPrefix = 5; % Image...
end

if nargin < 3
    ncharsSuffix = 4; % ... .tif
end

L  = {list(:).name};

for j = 1:numel(L)
    L{j} = L{j}((ncharsPrefix+1):end);
end

for j = 1:numel(L)
    L{j} = L{j}(1:(end-ncharsSuffix));
end

l = zeros(numel(L),1);

for j = 1:numel(l)
    l(j) = str2double(L{j});
end

[~,idx] = sort(l);

list = list(idx);


 
end