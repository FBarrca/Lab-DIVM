function [A01,A02,A03,A04,A05,A06] = plotRobot(v_theta, info)

% Valores inicales de las variables
% Es el ángulo de la articulación del eje xi-1 al eje xi respecto del eje zi-1 (utilizando la regla de la mano derecha)

theta1 = v_theta(1); theta2 = v_theta(2); theta3 = v_theta(3); theta4 = v_theta(4); theta5 = v_theta(5); theta6 = v_theta(6);
% if true
%     forcePopupFigure()
% end
clf
axis equal;
hold on;
grid;
view(30,30);
% Tensores de las articulaciones
P0= eye(4);
A01=Transformacion_avance(theta1,-90,0,0.29);
A01=P0*A01;
A12=Transformacion_avance(theta2,0,0.27,0);
A02=A01*A12;
A23=Transformacion_avance(theta3,90,-0.07,0);
A03=A01*A12*A23;
A34=Transformacion_avance(theta4,-90,0,0.302);
A04=A01*A12*A23*A34;
A45=Transformacion_avance(theta5,90,0,0);
A05=A01*A12*A23*A34*A45;
A56=Transformacion_avance(theta6,0,0,0.072);
A06=A01*A12*A23*A34*A45*A56;

% Plot del robot y sus articulaciones
plotTensor(P0,"0");
Connect_axis(P0,A01);
plotTensor(A01,"1");
Connect_axis(A01,A02);
plotTensor(A02,"2");
Connect_axis(A02,A03);
plotTensor(A03,"3");
Connect_axis(A03,A04);
plotTensor(A04,"4");
Connect_axis(A04,A05);
plotTensor(A05,"5");
Connect_axis(A05,A06);
plotTensor(A06,"6");
% Plot de trayectoria de las articulaciones


drawnow
if info

    fprintf("<strong>Final Position:<strong> ")
    fprintf("   <strong>AXIS<strong>:")
    fprintf('       -%s: (%s, %s, %s) \n', [["x";"y";"z"],A06(1:3,1:3)].')
    fprintf("   <strong>POS<strong>:")
    fprintf('       -%s: (%s) \n', [["x";"y";"z"],A06(1:3,4)].')
    fprintf("<strong>Angles:<strong> ")
    fprintf('       -θ1: %.2f',theta1)
    fprintf('       -θ2: %.2f',theta2)
    fprintf('       -θ3: %.2f',theta3)
    fprintf('       -θ4: %.2f',theta4)
    fprintf('       -θ5: %.2f',theta5)
    fprintf('       -θ6: %.2f',theta6)

    %brazo
    brazo = A01(1:3,1)'*( A04(1:3,4)-A01(1:3,4))
    if(brazo<0)
        fprintf("Brazo derecho: 1")
    else
        fprintf("Brazo izq: -1")
    end

    % if((theta2>90 && theta2<180)||(theta2>270 && theta2<360) )
    %     fprintf("Brazo izq: w12>0=>dz6/dt>0 -1")
    % else
    %     fprintf("Brazo derecho: w12>0=>dz6/dt>0 1")
    % end
    A26=(A23*A34*A56);
    if(A26(2,4)>0)
        fprintf("Codo arriba 1")

    else

        fprintf("Codo abajo -1")
    end


    if (A04(1:3,1)'*A05(1:3,3)>0)
        fprintf("No flip 1")
    elseif (A04(1:3,1)'*A05(1:3,3)<0)
        fprintf("Flip -1")
    else
        fprintf("Indet")
    end
    % MUÑECA x4*z5>0  Noflip A04(1:3,1).*A05(1:3,3)'
end
end

