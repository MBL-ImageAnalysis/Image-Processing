function Stack = SlicesToFrames(Stack)

M = size(Stack,1);
N = size(Stack,2);
C = size(Stack,3);
S = size(Stack,4);
Stack = reshape(Stack,[M N 1 C*S]);

end