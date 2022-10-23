function [theta1,theta2,theta3,theta4,theta5,theta6] = inverse (pos,rota,brazo,codo,muneca,info)
x1 = pos(1);
y1 = pos(2);
z1 = pos(3);
Ex = rota(1);
Ey = rota(2);
Ez = rota(3);

parametros.theta=[0,0,0,0,0,0];
parametros.d=[0.29,0,0,0.302,0,0.072];
parametros.a=[0,0.27,-0.07,0,0,0];
parametros.alpha=[-90,0,90,-90,90,0];


% Definimos codo, muneca y brazo
% Brazo: -1 izquierdo; 1 derecho
% Codo: -1 abajo; 1 arriba
% Muneca: -1 flip; 1 no flip


% Vectores n, s, a
n=[cosd(Ez)*cosd(Ey); sind(Ez)*cosd(Ey); -sind(Ey)];
s=[-sind(Ez)*cosd(Ex)+cosd(Ez)*sind(Ey)*sind(Ex); cosd(Ez)*cosd(Ex)+sind(Ez)*sind(Ey)*sind(Ex); cosd(Ey)*sind(Ex)];
a=[sind(Ez)*sind(Ex)+cosd(Ez)*sind(Ey)*cosd(Ex); -cosd(Ez)*sind(Ex)+sind(Ez)*sind(Ey)*cosd(Ex); cosd(Ey)*cosd(Ex)];

% Calculamos los valores de x, y, z
x=x1-parametros.d(6)*a(1);
y=y1-parametros.d(6)*a(2);
z=z1-parametros.d(6)*a(3);

% Inicializamos a cero
parametros.theta(1)=0;
parametros.theta(2)=0;
parametros.theta(3)=0;
parametros.theta(4)=0;
parametros.theta(5)=0;
parametros.theta(6)=0;

% Calculo de Articulaciones
% 1. Primera articulacion
R=sqrt(x^2+y^2);
parametros.theta(1)=atan2(-brazo*y*R/R^2,-brazo*x*R/R^2)*180/pi;

% 2. Segunda articulacion
R=sqrt(x^2+y^2+(z-parametros.d(1))^2);
r=sqrt(x^2+y^2);
a2=(parametros.a(2));
a3=(parametros.a(3));
d1=(parametros.d(1));
d4=(parametros.d(4));
% Beta
cos_beta=(a2^2+R^2-(d4^2+a3^2))/2/a2/R;
sen_beta=sqrt(1-cos_beta^2);
% Alpha
sen_alpha=-(z-d1)/R;
cos_alpha=-brazo*r/R;
% Theta 2
parametros.theta(2)=atan2((sen_alpha*cos_beta+(brazo*codo)*cos_alpha*sen_beta),(cos_alpha*cos_beta-(brazo*codo)*sen_alpha*sen_beta))*180/pi;

% 3. Tercera articulacion
% Phi
cos_phi=(a2^2+(d4^2+a3^2)-R^2)/2/a2/sqrt(d4^2+a3^2);
sen_phi=brazo*codo*sqrt(1-cos_phi^2);
% Gamma
sen_gamma=d4/sqrt(d4^2+a3^2);
cos_gamma=abs(a3)/sqrt(d4^2+a3^2);
% Theta 3
parametros.theta(3)=atan2(sen_phi*cos_gamma-cos_phi*sen_gamma, cos_phi*cos_gamma+sen_phi*sen_gamma)*180/pi;

% Matriz 0 a 6
vector_matriz=zeros(4, 4, height(parametros));
for i=1:(width(parametros.theta))

    vector_matriz(:,:,i)= Transformacion_avance(parametros.theta(i), parametros.alpha(i), parametros.a(i), parametros.d(i));
end


m_06=vector_matriz(:,:,1)*vector_matriz(:,:,2)*vector_matriz(:,:,3)*vector_matriz(:,:,4)*vector_matriz(:,:,5)*vector_matriz(:,:,6);

% 4. Cuarta articulacion
m_03=vector_matriz(:,:,1)*vector_matriz(:,:,2)*vector_matriz(:,:,3);
% Calculo ejes z
z3=[m_03(1,3);m_03(2,3);m_03(3,3)];
z4=cross(z3,a)/norm(cross(z3,a));
% Calculo ejes y
y4=-z3;
% Calculo ejes x
x3=[m_03(1,1);m_03(2,1);m_03(3,1)];
x4=cross(y4,z4);
% Theta 4
cos_theta4=dot(x3,x4);
sen_theta4=dot(-x3,z4);
parametros.theta(4)=atan2(sen_theta4, cos_theta4)*180/pi;

% 5. Quinta articulacion
% Ejes
z5=a;
y5=z4;
x5=cross(y5,z5);
% Theta 5
parametros.theta(5)=atan2(dot(x4,z5),dot(x4,x5))*180/pi;

% 6. Sexta articulacion
parametros.theta(6)=atan2(dot(-x5,s),dot(x5,n))*180/pi;
% disp(parametros.theta(:));


%Resultados
theta1 = parametros.theta(1);
theta2= parametros.theta(2);
theta3 = parametros.theta(3);
theta4 = parametros.theta(4);
theta5= parametros.theta(5);
theta6= parametros.theta(6);

if info
    fprintf("<strong>Angles:<strong> ")
    fprintf('       -θ1: %.2f',theta1)
    fprintf('       -θ2: %.2f',theta2)
    fprintf('       -θ3: %.2f',theta3)
    fprintf('       -θ4: %.2f',theta4)
    fprintf('       -θ5: %.2f',theta5)
    fprintf('       -θ6: %.2f',theta6)


end
end
