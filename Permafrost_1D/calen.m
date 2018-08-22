
function [len] = calen(nelem,i,j,z);

for m=1:nelem
    len(m) = z(j(m)) - z(i(m)); % too many marks in this class
end
