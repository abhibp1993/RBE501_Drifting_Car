function [F]=eqs(x)

global Df Cf Bf Dr Cr Br m Iz a b gamma_s vx_s

alpha_f=-atan((x(2)*a+x(1))/vx_s)+gamma_s;
alpha_r=atan((x(2)*b-x(1))/vx_s);

Fyf=Df*sin(Cf*atan(Bf*alpha_f));
Fyr=Dr*sin(Cr*atan(Br*alpha_r));

eqn3=(Fyf * cos(gamma_s) +Fyr)/m- x(2)*vx_s;
eqn4=(a*Fyf*cos(gamma_s)-b*Fyr)/Iz ;

F(1)=eqn3;
F(2)=eqn4;

end
