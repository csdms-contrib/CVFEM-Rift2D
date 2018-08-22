% This subroutine is developed to calculate the accumulation rate/ablation
% rate of ice


%Ht = 4000; % unit in meters
%Lt = 1300000; % unit in meters

alpha = 0.6;
Lacc = Lt*alpha;

x_col = 0.0;% column a

const1 = 2*alpha/(asin(alpha) - alpha*(1-alpha^2)^(1/2));
const2 = alpha/((1/2)*(pi/2-(1-alpha)*(1-(1-alpha)^2)^(1/2)-asin(1-alpha))...3
    -(1-alpha)*(1-alpha^2)^(1/2));
B_acc = 0.02; % average snow precipiation rate unit in m/a

beta_acc = B_acc*const1/Ht;
beta_abl = B_acc*const2/Ht;

eta_e = Ht*(1-alpha^2)^(1/2);    % unit in meters, equilibrium elevation

arg = abs(1-(x_col/Lt)^2);
eta_acc = Ht*(arg^(1/2)); % unit in meters, elevation
eta_abl = Ht*(arg^(1/2));
    
    
    if(x_col<Lacc)
        
        v_ice = beta_acc*(eta_acc - eta_e);
        
    elseif(x_col<Lt)&&(x_col>Lacc)
        
        v_ice = beta_abl*(eta_abl - eta_e);
    else
        
        v_ice = 0;
    end

    
    

%v_ice = beta_acc*(eta_acc - eta_e); 
%b_acc = beta_acc*(eta_acc - eta_e); 
%b_abl = beta_abl*(eta_abl - eta_e);

% if (x_col<Lacc)
%     v_ice = b_acc;
% else
%     v_ice = b_abl;
% end

% b = [b_acc b_abl];
% x = [x_acc x_abl];
% 
% 
% plot(x,b,'*')

