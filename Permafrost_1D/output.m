


for n=1:nnode
    elevation(ic,n) = z(n);
    temp(ic,n) = tp(n);
  

end

for n=1:icenode
    nu_ice(ic,n) = nu_i(it,n);
    xice(ic,n) = xx_ice(it,n);
end
