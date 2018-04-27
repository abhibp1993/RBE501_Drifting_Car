%% Initialize
function [cost]=rear_ident(z,vx,gamma,vy_meas,r_meas,weight)

a = 1.5/1.45 ; %m
b = 1.5/2;
m = 200; %kg
g = 9.8; %m/s^2
Iz = 2.78*10; %kgm^2

%% Identified Variables
syms vy_s r_s

Bf=10.43;
Cf=1.337;
Df=1376;

Br=z(1);
Cr=z(2);
Dr=z(3);

zero_vy = max(abs(vy_meas));
zero_yaw = -max(abs(r_meas)); 

%% Equations
 for i = 1:length(gamma)
%[Fyf] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_f,mew_f, mew_p,Ca_f,Fz_f, 1);
%[Fyr] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_r,mew_r, mew_p,Ca_r,Fz_r, 0);

alpha_f=-atan((r_s*a+vy_s)/vx(i))+gamma(i);
alpha_r=atan((r_s*b-vy_s)/vx(i));

Fyf=Df*sin(Cf*atan(Bf*alpha_f));
Fyr=Dr*sin(Cr*atan(Br*alpha_r));



eqn3=(Fyf * cos(gamma(i)) +Fyr)/m- r_s*vx(i)==0;
eqn4=(a*Fyf*cos(gamma(i))-b*Fyr)/Iz == 0;

Solve = vpasolve([eqn3,eqn4],[vy_s, r_s],[zero_vy,zero_yaw]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering

Solve = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering


vy=Solve.vy_s;
r1=Solve.r_s;

Cost(i) = weight(1)*(vy_meas(i)-vy)^2-weight(2)*(r_meas(i)-r1)^2;

end

cost = sum(Cost);

end



 
 

