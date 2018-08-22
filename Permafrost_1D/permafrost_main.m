clc
close all
clear all


% set up parameters to run model
%--------------------------------------------------------------------------
get_data_permafrost
%--------------------------------------------------------------------------
% read in the D_theta_D_T term
heat_capacity_table
%-------------------------------------------------------------------------- 
runtime = 0;
ic = 0;
ipr = 0;

for it=1:ntime 
    time = time + delt;
    time_t(it) = time;
    ipr = ipr+1;
    it
    tt = mod(time,100000);
    %----------------------------------------------------------------------
    surf_temp
    %----------------------------------------------------------------------
%     tb(1) = 6;
%     if(time>delt0) && (time<delt2)
%         tb(1) = -12;
%     end
     %tb(1)
     %tt
    %----------------------------------------------------------------------
    interp 
    %----------------------------------------------------------------------
    ice_load
    %----------------------------------------------------------------------
    
    if(Ht==0)
        v_ice = 0;
    end
    
    if(Ht~=0)
        ice_rate
    end
    %v_ice
   v_t(it)=v_ice;
   
    %----------------------------------------------------------------------
    grow_grid
    %----------------------------------------------------------------------    
    z(nnode);
   
    nnode;
    nnode_t(it,1) = nnode;
    
    ice_elev(it,1) = nu_i(it,1)+750;
    zmax(it,1) = z(nnode);
    
    t_old(1:nnode) = tp(1:nnode);
    tp_bc(it) =  tb(1);
    time_bc(it) = runtime;

    % runtime is simulation time in millions of years
    runtime = runtime + delt;
    % atemp is the thickness of the top element
    atemp = (z(nnode)-z(1));
    % zero out global stiffness matrix and load vector
    a = zeros(nnode,nnode);
    b = zeros(nnode,1);

    % calculate element length
    len = calen(nelem,i,j,z);
    a = zeros(nnode,nnode);
    b = zeros(nnode,1);
    %----------------------------------------------------------------------
    matrix_heat;
    %----------------------------------------------------------------------
    apply_bc_heat
    %----------------------------------------------------------------------    
    tp = a\b;
    
    for n=1:nnode-1
        if(z(n)>zb);
            %t_freez(n) = 1.6/2000*(z(n)-ice_elev(it,1));
            %if(tp(n)>t_freez(n))
            if(tp(n)>0)
                tp(n)=0;
            end
        end
    end
    
    if(ipr==iprint)
        ipr = 0;
        ic=ic+1;
    output;
    end
    
   
end
figure(1)
 plot(time_t,zmax);
 hold on;
 plot(time_t,ice_elev,'r')
 hold on
 legend('zmax','ice elev');
 hold off
 xlabel('time(yrs)');
 ylabel('elevation(m)');
 
 
 figure(2)
 plot(time_t,del_nu,'k*')
 xlabel('time(yrs)');
 ylabel('meters');
 title('delnu vs time');



figure(4)
plot(v_t,'*');
xlabel('Time');
ylabel('Advection Velocity of Ice');

%--------------------------------------------------------------------------
% write out temprature profile for each column
%--------------------------------------------------------------------------

output_filename = 'temp_subsurface_col1.txt';
fid = fopen(output_filename,'w');

for i  = 1:100
    tmp_out(i,:) = temp(100*i,1:76);
    tmp_min(i,1) = min(tmp_out(i,:));
    fprintf(fid,'%6.3f ',tmp_out(i,:));
    fprintf(fid,'\n');
end


output_filename2 = 'temp_min_col1.txt';
fid = fopen(output_filename2,'w');

for i  = 1:100
    fprintf(fid,'%6.3f ',tmp_min(i,1));
    fprintf(fid,'\n');
end

