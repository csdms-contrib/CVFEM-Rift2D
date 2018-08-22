% grow or oblate grid due to changes in ice sheet thickness

z(nnode) = z(nnode)  + del_nu(it,1);
if(z(nnode)<z_ls) 
    z(nnode)=z_ls;
    %z(nnode-1) = z_ls - 3;
end

zcheck(it,1) = z(nnode) - z(nnode-1);
del_tp = (tp(nnode) - tp(nnode-1))/zcheck(it,1);

% if ice sheet is growing

%if (zcheck(it,1) >1.1*delz)
if (zcheck(it,1) >delz)
    nnode = nnode + 1;
    nelem = nelem + 1;
    % djd resize a matrix and b vector
    a = zeros(nnode,nnode);
    b = zeros(nnode,1);
    i(nelem) = nnode - 1;
    j(nelem) = nnode;
    c_b(nelem) = c_b(nelem-1);
    % djd resize phi and perm vectors
    nt(1) = nnode;
    z(nnode) = z(nnode-1);
    tp(nnode) = tp(nnode-1);
    z(nnode-1) = z(nnode-2) + delz;
    tp(nnode-1) = tp(nnode-2) + del_tp*delz;
end

% if ice sheet is oblating
if(it>=delt2/delt)
% if(z(nnode)>z_ls)
    if ( zcheck(it,1)<0)
        nnode = nnode - 1;
        nelem = nelem - 1;
        % djd resize a matrix and b vector
        a = zeros(nnode,nnode);
        b = zeros(nnode,1);
        nt(1) = nnode;
        z(nnode) = z(nnode+1);
    end
 %end
end
