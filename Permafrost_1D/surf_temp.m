% subroutine name: surf_temp
% written by Yipeng Zhang on 11/04/2015

% This subroutine is set up to calculate the temperature evolution history 
% overthe last 120 k years, based on Marshal et al. (2002)
%clc
%clear all
%close all

Tmax = -4;%-2;
Tmin = -24;%-22;
%delt = 1;
%ntime = 120000;
%time = 0;
delt0_t = 0;
delt1_t = 70000;
delt2_t = 80000;
delt3_t = 100000;
grad_1 = (Tmin - Tmax)/(delt1_t - delt0_t);
grad_2 = (Tmax - Tmin)/(delt2_t - delt1_t);

%for it=1:ntime
    %it
    %time = time + delt;
    if (time >= delt0_t && time < delt1_t)
        tb(1) = Tmax +  time*grad_1;
        
        
    elseif(time >= delt1_t && time < delt2_t)
        tb(1) = Tmin + (time-delt1_t)*grad_2;
    else
        tb(1) = Tmax;
    end
    
%end



