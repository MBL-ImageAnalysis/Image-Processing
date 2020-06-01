
function J = MaxFilt(I,w)
J = 0*I;

for j = 1:size(I,3)
J(:,:,j) = colfilt(I(:,:,j),[w w],'sliding',@max);
end

J = permute(J,[1 3 2]);

for j = 1:size(I,3)
    J(:,:,j) = colfilt(J(:,:,j),[w w],'sliding',@max);
end


end