% c^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% c			Subroutine matrix_heat
% c
% c
% c  This subroutine assembles local & global stiffness matrices 
% c  and load vectors
% c
% c^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

%  c_bulk - bulk heat capacity = rhof*cf*phi + (1-phi)*rhos*cs
%  lamda_bulk - bulk thermal conductivity = lamda_f*phi + (1-phi)*lamda_s
% T temperature
% units = number seconds in a year

units = 3600*365*24;

zt=z(nnode);
zb=z(76);
zlen = zt-zb; % zlen is the total length of the model domain
if(zlen<=0) 
    zlen = 1;
end
vel = -v_ice/units; 

for m=1:nelem
    
    if(len(m)<=0) 
        len(m) = 0.1;
    end
    
	ii = i(m);
	jj = j(m);
    ze = z(ii);
    ve = 0.0;
    te = (tp(ii)+tp(jj))/2;
    
    if(ze>zb) && (zlen>1);
        ve = vel*(ze-zb)/zlen;
    end
    
%     if(tb(1)>0)
%         ve = 0;
%     end
    
    phi_e = 0.3;
    
    
    if(ze<z_ls)
    % thermal conductivity in the subsurface meltwater case 
    
        lamda_b =  phi_e*0.6+(1-phi_e)*2.5;
    
    % thermal conductivity in the subsurface frozen case
    
        if(te<0)
            lamda_b =  phi_e*2.2+(1-phi_e)*2.5;
        end
    end
    
    % thermal conductivity in the ice
    if(ze>z_ls)
        lamda_b =  2.2;
    end
 
    pp(1,1) = c_b(m)*len(m)/3.d+0;
	pp(1,2) = c_b(m)*len(m)/6.d+0;
	pp(2,1) = pp(1,2);
	pp(2,2) = pp(1,1);
% 	aa(1,1) = lamda_b/len(m);
% 	aa(1,2) = -lamda_b/len(m);
% 	aa(2,1) = aa(1,2);
% 	aa(2,2) = aa(1,1);
    
    aa(1,1) = lamda_b/len(m) - 900*2100*ve/2;%4120 heat capacity of ice
	aa(1,2) = -lamda_b/len(m) + 900*2100*ve/2;
	aa(2,1) = -lamda_b/len(m) - 900*2100*ve/2;
	aa(2,2) = lamda_b/len(m) + 900*2100*ve/2;
    
	bb(1) =  (pp(1,1)/delt/units)*tp(ii) ...
          + (pp(1,2)/delt/units)*tp(jj);
	bb(2) = + (pp(2,1)/delt/units)*tp(ii) ...
          + (pp(2,2)/delt/units)*tp(jj);
	a(ii,ii) = a(ii,ii) + aa(1,1) + pp(1,1)/delt/units;
	a(ii,jj) = a(ii,jj) + aa(1,2) + pp(1,2)/delt/units;
	a(jj,ii) = a(jj,ii) + aa(2,1) + pp(2,1)/delt/units;
	a(jj,jj) = a(jj,jj) + aa(2,2) + pp(2,2)/delt/units;
  	b(ii) = b(ii) + bb(1);  
	b(jj) = b(jj) + bb(2);  
end
