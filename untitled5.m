d1=0;
theta2=0;
for i = 1:10
    clf
    clearvars -except d1 theta2 i  
    hold on;
    grid;
    view(45,45);

    theta2 = theta2+9;
    d1=d1+1;

    P0= eye(4);
    plotTensor(P0);
    A01=Transformacion_avance(0,-90,0,d1);
    plotTensor(A01);
    A12=Transformacion_avance(theta2,90,0,0);
    plotTensor(A01*A12);
    


    drawnow
end
