for m=1:nelem
    
    ii = i(m);
    jj = j(m);
    tp_1(m) = (tp(ii)+tp(jj))/2;
    ze = z(ii);
    
    latheat(m) = 0;
    phi_e = 0.3;
    
    % Heat capacity in the subsurface
    if(ze<z_ls)
        c_b(m) = phi_e*1000*4120+(1-phi_e)*2650*800;%????
        
        % Heat capacity in the subsurface in frozen case
        if(tp_1(m)<-1)
            c_b(m) =  phi_e*900*2100+(1-phi_e)*2650*800;
        end
        
        if(tp_1(m)<0) && (tp_1(m)>-1)
            
            tp_2(m) = abs(tp_1(m));% should be tp_1(m)?
            
            for k=1:9
                if (tp_2(m) < 0.1)
                    latheat(m) = latent_dat(1);
                    c_b(m) = c_b(m) + latheat(m);
                end
                
                if (tp_2(m) >= dt_dat(k)) && (tp_2(m) < dt_dat(k+1))
                    ratio(m) = (tp_2(m) - dt_dat(k))/(dt_dat(k+1) - dt_dat(k));
                    latheat(m) = ratio(m)*(latent_dat(k)-latent_dat(k+1));
                    c_b(m) = c_b(m) + latheat(m);
                    
                end
            end
        end
        
        % Heat capacity in the ice
    else
        c_b(m) = 900*2100;
        
    end
    
    
end