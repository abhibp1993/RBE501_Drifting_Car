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
a = 0.029 ; %m
b = 0.033;
m = 0.0401; %kg
g = 9.8; %m/s^2
Iz = 2.78*10^-5; %kgm^2



%% Identified Variables
% Ca_f = 57500;
% Ca_r = 92500; 
% mew_f= 0.56;
% mew_r = 0.5;
% 
% mew_p = 0.7;

Bf=4.1;
Cf=1.1;
Df=0.22;

Br=3.8609;
Cr=1.4;
Dr=0.1643;


%% 
Fz_r = a*m*g/(a+b);
Fz_f = m*g-Fz_r;
% 
% as1_f = atan(3*mew_f*Fz_f/Ca_f);
% as1_r = atan(3*mew_r*Fz_r/Ca_r);


%% Input Variables
vx = linspace(1,20,50);
gamma = linspace(-0.4,0.4,140);
syms vy_s r_s


%% Equations
i =20 ;
vx(20)=1.5;
vy=[];
r1=[];
 for j = 1:length(gamma)
%[Fyf] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_f,mew_f, mew_p,Ca_f,Fz_f, 1);
%[Fyr] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_r,mew_r, mew_p,Ca_r,Fz_r, 0);

alpha_f=-atan((r_s*a+vy_s)/vx(i))+gamma(j);
alpha_r=atan((r_s*b-vy_s)/vx(i));

Fyf=Df*sin(Cf*atan(Bf*alpha_f));
Fyr=Dr*sin(Cr*atan(Br*alpha_r));

eqn3=(Fyf * cos(gamma(j)) +Fyr)/m- r_s*vx(i)==0;
eqn4=(a*Fyf*cos(gamma(j))-b*Fyr)/Iz == 0;

S = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]);
 [vy,r1]=structput(vy,r1,S,i,j,1);
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[3,6]);
 [vy,r1]=structput(vy,r1,S,i,j,2);
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[-3,-6]);
 [vy,r1]=structput(vy,r1,S,i,j,3);

eqn3=[];
eqn4=[];
end
%end
figure()
scatter(gamma(:)',vy(1,:,i),'b')
hold on
scatter(gamma(:)',vy(2,:,i),'r')
hold on
scatter(gamma(:)',vy(3,:,i),'g')
title('Vy vs gamma')
xlabel('gamma [rad]')
ylabel('vy [m/s]')
hold off 

figure()
scatter(gamma(:)',r1(1,:,i),'b')
hold on
scatter(gamma(:)',r1(2,:,i),'r')
hold on
scatter(gamma(:)',r1(3,:,i),'g')

title('yaw rate vs gamma')
xlabel('gamma [rad]')
ylabel('r [rad/s]')
hold off

function [vy,r1] = structput(vy,r1,S,i,j,k)

 if(~isempty(S.vy_s))
 vy(k,j,i) = double(S.vy_s);
 r1(k,j,i) = double(S.r_s);
 elseif(length(S.vy_s)>0)
     vy(i,j)=12345;
 end

end

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
