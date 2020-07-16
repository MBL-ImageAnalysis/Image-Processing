
function [I,meta] = ReadImage(I,zrange)
% Usage:
% [I,meta] = ReadImage(I,zrange)
% I        = ReadImage(I,zrange)
% [I,meta] = ReadImage(I)
% I        = ReadImage(I)
% Note: zrange only supported for tif stacks currently
%       if I is a plain old image, meta will be empty
%       meta is only returned nonempty for tif stacks and czi files
%
% Description:
% primary image reader. Will read tiff stacks, czi files, and standard
% formats. Currently it searches for .jpg .jpeg .png .bmp and .czi when you
% give it no inputs and select file via gui,

    if isnumeric(I)
        return
    end

    warning off
    % [] means get the whole stack
    if nargin < 2
        zrange = [];
    end

    % No input given
    if nargin == 0 || isempty(I)
        [I,pathname] = uigetfile(...
            {'*.jpg';...
            '*.jpeg';...
            '*.png';...
            '*.tiff';...
            '*.bmp';...
            '*.czi'}, ...
          'Select Image/Stack File','MultiSelect','off'); 
        I = fullfile(pathname,I);
    end

    % fid given
    if ischar(I) && numel(dir(I))==1
        [~,~,ext] = fileparts(I);
        if strcmp(ext,'.tif')
            [I,meta] = ReadStack(I,zrange);
        elseif strcmp(ext,'.czi')
            [I,meta] = ReadCZI(I);
        else
            I = imread(I); meta = [];
        end
    else
        error('That file is not in the current folder, give full path');
    end
    
    % making 4d array
    if size(I,3)~=3 && ndims(I)<4
        I = reshape(I,[size(I,1) size(I,2) size(I,3) size(I,4)]);
        if ~exist('meta','var')
            meta = [];
        end
    end

end

function [stack,meta] = ReadStack(fid,zrange)

% Getting tif and needed attributes
meta       = imfinfo(fid);
Depth      = size(meta,1);            % nslices
N          = meta(1).Width;           % nrows
M          = meta(1).Height;          % ncols
C          = meta(1).SamplesPerPixel; % ncolors

if nargin < 2 || isempty(zrange)
    zrange = [1 Depth];
end

% linker. This manner makes reading slightly faster 
% but it is still not quite as fast as ImageJ though.
tifLinker = Tiff(fid, 'r');

% Getting image stack, storing in double precision.
stack = zeros(M,N,C,zrange(2)-zrange(1)+1);
for slice = zrange(1):zrange(2)
    
    % pointing the linker to slice
    tifLinker.setDirectory(slice);
    
    % reading slice into stack
    stack(:,:,:,slice-zrange(1)+1)=tifLinker.read();
    
end

end

function [I,meta] = ReadCZI(path2file)

% calling bioformats reader
X       = bfopen(path2file);

% getting meta data reader from bioformats
reader  = bfGetReader(path2file);

% reading metadata
meta    = reader.getMetadataStore();

% processing image into standard matlab format
X = X{1};
sz = size(X);

if sz(1) == 3
    R = X{1,1}; X{1,1}=[];
    G = X{2,1}; X{2,1}=[];
    B = X{3,1}; X{3,1}=[];
    clear X
    I = cat(3,R,G,B); 
    clear R G B;
else
    Sz = size(X{1,1}); cl = class(X{1,1});
    if numel(Sz) == 2
        Sz = [Sz 1];
    end
    I = zeros(Sz(1),Sz(2),Sz(3),sz(1),cl);
    for j = 1:sz(1)
        I(:,:,:,j) = X{j,1};
    end
end


end

