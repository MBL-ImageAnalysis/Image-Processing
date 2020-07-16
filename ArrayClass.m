

function cl = ArrayClass(I)

cl = class(I);

if strcmpi(cl,'gpuArray')
    cl = classUnderlying(I);
elseif strcmpi(cl,'py.numpy.ndarray')
    cl = ['NumpyArray_' char(I.dtype.name)];
end

end