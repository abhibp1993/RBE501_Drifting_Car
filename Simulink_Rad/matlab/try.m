clear all
%% Initialize
a = 1.35 ;
b = 1.15;
m = 1724;
g = 9.8;
I = 1300;

global a b m g I

%% Identified Variables
Ca_f = 57500;
Ca_r = 92500; 
mew_f= 0.56;
mew_r = 0.5;

%% 
Fzr = a*m*g/(a+b);
Fzf = m*g-Fzr;

as1_f = atan(3*mew_f*Fzf/Ca_f);
as1_r = atan(3*mew_r*Fzr/Ca_r);


%% Input Variables
vx = 10;
gamma = 0.1;
syms vy_s r_s

%% Equations


% Fyf = m*b*(a + b) *cos(gamma)*vx*r; 
% Fyr = m*a/(a + b)*vx*r;
Fyf = lateral_force(vy_s,vx, r_s, gamma,as1_f,mew_f, mew_f, 1);
Fyr = lateral_force(vy_s,vx, r_s, gamma,as1_f,mew_r, mew_r, 0);

eqn=[(Fyf * cos(gamma) +Fyr)/m- r*vx==0;
(a*Fyf*cos(gamma)-b*Fyx)/Iz == 0];

vpasolve(eqn,vy,r)

function [Fy] = lateral_force(vy,vx, r, gamma, as1,mew_s,mew_p, FOR)

if FOR ==1
alpha= atan(vy+a*r)/vx-gamma;
else 
alpha = atan(vy-b*r)/vx;
end

if abs(alpha)<as1
Fy = -Ca*tan(alpha)+Ca^2*(2-mew_s/mew_p)/(3*mew_p*Fz)*abs(tan(alpha))*tan(alpha)-Ca^3*(1-2*mew_s/3*mew_p)/(9*mew_p^2*Fz^2)*tan(alpha)^2;
else 
Fy = -mew_s*Fz*sign(alpha);
end

end