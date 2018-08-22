for i=1:ntime/iprint-1
    
    plot(xice(i,:),nu_ice(i,:),'b+')
    %axis([0 10 900 4000])
    axis([-10 2.8e6 0 4000])
    xlabel('Distance (m)')
    ylabel('Elevation (meters)')
    pause(0.05)
end