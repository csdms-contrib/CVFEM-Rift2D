for i=1:ntime/iprint-1

    plot(temp(i,:),elevation(i,:),'ro')
    %axis([0 10 900 1000])
    axis([-20 60 0 5000])
    xlabel('Temp (oC)')
    ylabel('Elevation (meters)')
   pause(0.000000003)
end