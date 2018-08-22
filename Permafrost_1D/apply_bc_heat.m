%
% this subroutine imposes b.c. for heat flow equation
%

% impose spec. head b.c.

tb(1) = tp_bc(it);

for l=1:ntbc
    for n=1:nnode
        a(nt(l),n) = 0.0d+0;
    end
  
    for n=1:nnode
        b(n) = b(n) - a(n,nt(l))*tb(l);
        a(n,nt(l)) = 0.0d+0;
    end
    a(nt(l),nt(l)) = 1.0d+0;
    b(nt(l)) = tb(l);
end

% impose spec. fluid flux b.c.

for m=1:njbc
    b(nj(m)) = b(nj(m)) + jb(m);
end

