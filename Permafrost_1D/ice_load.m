    
    if  (tt<=delt0)
        Lt = 1.0;
        Ht = 0.0;
        
    end
    
    if(tt>delt0) && (tt<=delt1);
        
        
        Lsl1 = Lo/(delt1-delt0);
        Hsl1 = Ho/(delt1-delt0);
        
        Lt = Lsl1*(tt-delt0);
        Ht = Hsl1*(tt-delt0);
    end
    
    if(tt>delt1) && (tt<=delt2)
        Lt = Lo;
        Ht = Ho;
    end
    

    if(tt>delt2)  && (tt<delt3)
%         Lt = Lo;
%         Ht = Ho;
                 Lsl2 = Lo/(delt3-delt2);
                 Hsl2 = Ho/(delt3-delt2);
                 Lt = Lo - Lsl2*(tt-delt2);
                 Ht = Ho - Hsl2*(tt-delt2);
        
    end
    
    if (tt>=delt3)
         Lt = 1;
         Ht = 0;
     end
    
        
    
    
    
    % These commands are for the thickness evolution calculation
    
    for n=1:icenode
        arg = abs( 1.0 - ( xls(n)/Lt )^2 );
        nu_i(it,n) = Ht*( arg^0.5 );
        nun(n)= Ht*( arg^0.5 );
        if(xls(n)>Lt)
            nu_i(it,n) = 0.0;
            nun(n) = 0.0;
        end
        xx_ice(it,n) = xls(n);
    end
    

    if(it==1) 
        del_nu(it,1)= 0;
    end
    if(it>1) 
        del_nu(it,1) = nu_i(it,1) - nu_i(it-1,1);
    end

% v_ice(it,1) = del_nu(it,1)/delt;
% delt_ice(it,1) = delt;
% if(abs(v_ice(it,1)) > 0.0)
% delt_ice(it,1) = delz/(1.1*abs(v_ice(it,1)));
% end

