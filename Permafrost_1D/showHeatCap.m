for i=2:2:ntime/iprint
   % color = ['r';'b';'g';'m';'k'];
    semilogx(heat_cap(i,:),ele_elem(i,:))
   % hold on
    xlabel('Heat_Capacity (J/m/^3/K/-1)')
    ylabel('Elevation (meters)')
    pause(0.03)
   
end