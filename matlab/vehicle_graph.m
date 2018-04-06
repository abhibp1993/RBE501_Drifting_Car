clear all

%% Stationary Velocity graph based on Numerical Calculation of: 
%"Analysis and control of high sideslip manoeuvres" Christoph Voser, Rami
%Hindeyeh

%Comment: Still wrong, infinite values near gamma = 0;
% Need to change to equations and parameters from: 
%"Optimization-Based Autonomous Racing of 1:43 Scale RC Cars" ALexander
%Liniger

%% Initialize
global a b m g Iz
a = 1.35 ; %m
b = 1.15;
m = 1724; %Kg
g = 9.8; %m/s^2
Iz = 1300; %Kg



%% Identified Variables
Ca_f = 57500;
Ca_r = 92500; 
mew_f= 0.56;
mew_r = 0.5;

mew_p = 0.7;
%% 
Fz_r = a*m*g/(a+b);
Fz_f = m*g-Fz_r;

as1_f = atan(3*mew_f*Fz_f/Ca_f);
as1_r = atan(3*mew_r*Fz_r/Ca_r);


%% Input Variables
vx = linspace(1,20,50);
gamma = linspace(-1.5,1.5,50);
syms vy_s r_s

%% Equations
i =20 ;
%j =2;

% Fyf = m*b*(a + b) *cos(gamma)*vx*r; 
% Fyr = m*a/(a + b)*vx*r;
%for i=1:length(vx)
 for j = 1:length(gamma)
[Fyf] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_f,mew_f, mew_p,Ca_f,Fz_f, 1);
[Fyr] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_r,mew_r, mew_p,Ca_r,Fz_r, 0);

eqn3=(Fyf * cos(gamma(j)) +Fyr)/m- r_s*vx(i)==0;
eqn4=(a*Fyf*cos(gamma(j))-b*Fyr)/Iz == 0;

S=vpasolve([eqn3,eqn4],[vy_s, r_s]);

if(~isempty(S.vy_s))
vy(i,j) = double(S.vy_s)
r1(i,j) = double(S.r_s)
elseif(length(S.vy_s)>0)
vy(i,j)=12345;
end

eqn3=[];
eqn4=[];
end
%end
figure()
scatter(gamma(:),vy(20,:))

figure()
scatter(gamma(:),r1(20,:))


function [Fy] = lateral_force(vy,vx, r, gamma, as1,mew_s,mew_p,Ca,Fz,FOR)
global a b 

if FOR ==1
alpha = atan(vy+a*r)/vx-gamma;
else 
alpha = atan(vy-b*r)/vx;
end

%Need to Check this Function
Fy1 = -Ca*tan(alpha)+Ca^2*(2-mew_s/mew_p)/(3*mew_p*Fz)*abs(tan(alpha))*tan(alpha)-Ca^3*(1-2*mew_s/3*mew_p)/(9*mew_p^2*Fz^2)*tan(alpha)^2;

Fy2 = -mew_s*Fz*sign(alpha);

Fy = Fy1*(sign(as1-abs(alpha))+1)/2+Fy2*(sign(-as1+abs(alpha))+1)/2;
end
