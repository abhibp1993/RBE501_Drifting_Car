clear all

%% Stationary Velocity graph based on Numerical Calculation of: 
%Procedure from : "Analysis and control of high sideslip manoeuvres" Christoph Voser, Rami
%Hindeyeh 

%Equations from: "Optimization-Based Autonomous Racing of 1:43 Scale RC Cars" ALexander
%Liniger 

%Parameters from: "Autonomous Drift Control" Nikolaos Kariotoglou

%% Initialize
global a b m g Iz
a = 1.5/1.45 ; %m
b = 1.5/2;
m = 200; %kg
g = 9.8; %m/s^2

k = 1.4478;
Iz =  (1.5/1.45+0.75)^2*m/12*k; %kgm^2



%% Identified Variables
% Ca_f = 57500;
% Ca_r = 92500; 
% mew_f= 0.56;
% mew_r = 0.5;
% 
% mew_p = 0.7;

Bf=10.43;
Cf=1.337;
Df=1376;

Br=Bf;
Cr=Cf;
Dr=Df;


%% 
Fz_r = a*m*g/(a+b);
Fz_f = m*g-Fz_r;
% 
% as1_f = atan(3*mew_f*Fz_f/Ca_f);
% as1_r = atan(3*mew_r*Fz_r/Ca_r);


%% Input Variables
vx = linspace(1,21,81);
gamma = linspace(-0.45,0.45,81);
syms vy_s r_s

zero_vy = 10;
zero_yaw = 4;

init_vy = [ 0,  .000001,         1; 
            0,       10,       8];
init_r  = [ 0,  .000001, .0000001 ;
            0,        5,        3];
        
num = find(vx>10);

init_s = linspace(0.1,1,length(num));
init_y = linspace(0.7,0.3, length(num));

z=2;
%% Equations
i =25 ;
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

% vx_s = vx(i);
% gamma_s=gamma(j);
% fsolve(@eqs,[0,0]);

% S = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]);
%  [vy,r1]=structput(vy,r1,S,i,j,1);
% S = vpasolve([eqn3,eqn4],[vy_s, r_s],[zero_vy,-zero_yaw]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering
%  [vy,r1]=structput(vy,r1,S,i,j,2);
%  
% S = vpasolve([eqn3,eqn4],[vy_s, r_s],[-zero_vy,zero_yaw]); %% Try to solve for negative vy_s, positive r_s oversteering/understeering
%  [vy,r1]=structput(vy,r1,S,i,j,3);

 if vx(i) >10
 S = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]);
 [vy,r1]=structput(vy,r1,S,i,j,1);
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[init_s(find(num==i)), init_vy(2,z);-init_r(2,z), -init_y(find(num==i))]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering
 [vy,r1]=structput(vy,r1,S,i,j,2);
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[-init_vy(2,z),-init_s(find(num==i));init_s(find(num==i)), init_r(2,z)]); %% Try to solve for negative vy_s, positive r_s oversteering/understeering
 [vy,r1]=structput(vy,r1,S,i,j,3);
    
     
 else
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]);
 [vy,r1]=structput(vy,r1,S,i,j,1);
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[init_vy(1,z), init_vy(2,z);-init_r(2,z), -init_r(1,z)]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering
 [vy,r1]=structput(vy,r1,S,i,j,2);
S = vpasolve([eqn3,eqn4],[vy_s, r_s],[-init_vy(2,z),-init_vy(1,z);init_r(1,z), init_r(2,z)]); %% Try to solve for negative vy_s, positive r_s oversteering/understeering
 [vy,r1]=structput(vy,r1,S,i,j,3);

 end

eqn3=[];
eqn4=[];
 end

% init_v(1,z)= max(abs(vy(1,:,i)))+0.00001;
% init_r(1,z)= max(abs(r1(1,:,i)))+0.00001;
%  
% 
%   for j = 1:length(gamma)
% %[Fyf] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_f,mew_f, mew_p,Ca_f,Fz_f, 1);
% %[Fyr] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_r,mew_r, mew_p,Ca_r,Fz_r, 0);
% 
% alpha_f=-atan((r_s*a+vy_s)/vx(i))+gamma(j);
% alpha_r=atan((r_s*b-vy_s)/vx(i));
% 
% Fyf=Df*sin(Cf*atan(Bf*alpha_f));
% Fyr=Dr*sin(Cr*atan(Br*alpha_r));
% 
% eqn3=(Fyf * cos(gamma(j)) +Fyr)/m- r_s*vx(i)==0;
% eqn4=(a*Fyf*cos(gamma(j))-b*Fyr)/Iz == 0;
% 
% % vx_s = vx(i);
% % gamma_s=gamma(j);
% % fsolve(@eqs,[0,0]);
% 
% % S = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]);
% %  [vy,r1]=structput(vy,r1,S,i,j,1);
% % S = vpasolve([eqn3,eqn4],[vy_s, r_s],[zero_vy,-zero_yaw]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering
% %  [vy,r1]=structput(vy,r1,S,i,j,2);
% %  
% % S = vpasolve([eqn3,eqn4],[vy_s, r_s],[-zero_vy,zero_yaw]); %% Try to solve for negative vy_s, positive r_s oversteering/understeering
% %  [vy,r1]=structput(vy,r1,S,i,j,3);
% 
% 
%  S = vpasolve([eqn3,eqn4],[vy_s, r_s],[init_vy(1,z), init_vy(2,z);-init_r(2,z), -init_r(1,z)]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering
%   [vy,r1]=structput(vy,r1,S,i,j,2);
%  S = vpasolve([eqn3,eqn4],[vy_s, r_s],[-init_vy(2,z),-init_vy(1,z);init_r(1,z), init_r(2,z)]); %% Try to solve for negative vy_s, positive r_s oversteering/understeering
%   [vy,r1]=structput(vy,r1,S,i,j,3);
% 
% 
% eqn3=[];
% eqn4=[];
%  end
%  
 
 
%end
figure()
scatter(gamma(:)',vy(1,:,i),'b')
hold on
scatter(gamma(:)',vy(2,:,i),'r')
hold on
scatter(gamma(:)',vy(3,:,i),'g')
titlename = sprintf('Vy vs gamma, vx = %d m/s',vx(i));
title(titlename)
xlabel('gamma [rad]')
ylabel('vy [m/s]')
hold off 
savefig('vy_ex.fig')

figure()
scatter(gamma(:)',r1(1,:,i),'b')
hold on
scatter(gamma(:)',r1(2,:,i),'r')
hold on
scatter(gamma(:)',r1(3,:,i),'g')

titlename = sprintf('yaw rate vs gamma, vx = %d m/s',vx(i));
title(titlename)
xlabel('gamma [rad]')
ylabel('r [rad/s]')
hold off
savefig('yaw_ex.fig')


% %% Try Regression
% vy_init=zeros(size(vy));
% yaw_init=zeros(size(vy));
% 
% [vy_init(:,:,i),yaw_init(:,:,i)]=linear_regression(gamma(:),vy,r1,i);
% 
% 
% %% Vpa again
%  for j = 1:length(gamma)
% %[Fyf] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_f,mew_f, mew_p,Ca_f,Fz_f, 1);
% %[Fyr] = lateral_force(vy_s,vx(i), r_s, gamma(j),as1_r,mew_r, mew_p,Ca_r,Fz_r, 0);
% 
% alpha_f=-atan((r_s*a+vy_s)/vx(i))+gamma(j);
% alpha_r=atan((r_s*b-vy_s)/vx(i));
% 
% Fyf=Df*sin(Cf*atan(Bf*alpha_f));
% Fyr=Dr*sin(Cr*atan(Br*alpha_r));
% 
% eqn3=(Fyf * cos(gamma(j)) +Fyr)/m- r_s*vx(i)==0;
% eqn4=(a*Fyf*cos(gamma(j))-b*Fyr)/Iz == 0;
% 
% S = vpasolve([eqn3,eqn4],[vy_s, r_s],[0,0]);
%  [vy,r1]=structput(vy,r1,S,i,j,1);
% S = vpasolve([eqn3,eqn4],[vy_s, r_s],[vy_init(2,j,i),yaw_init(2,j,i)]); %% Try to solve for positive vy_s, negative r_s oversteering/understeering
%  [vy,r1]=structput(vy,r1,S,i,j,2);
% S = vpasolve([eqn3,eqn4],[vy_s, r_s],[vy_init(3,j,i),yaw_init(3,j,i)]); %% Try to solve for negative vy_s, positive r_s oversteering/understeering
%  [vy,r1]=structput(vy,r1,S,i,j,3);
% 
% eqn3=[];
% eqn4=[];
%  end
% 
%  %% Plot again
%  
% figure()
% scatter(gamma(:)',vy(1,:,i),'b')
% hold on
% scatter(gamma(:)',vy(2,:,i),'r')
% hold on
% scatter(gamma(:)',vy(3,:,i),'g')
% title('Vy vs gamma')
% xlabel('gamma [rad]')
% ylabel('vy [m/s]')
% hold off 
% savefig('vy_ex.fig')
% 
% figure()
% scatter(gamma(:)',r1(1,:,i),'b')
% hold on
% scatter(gamma(:)',r1(2,:,i),'r')
% hold on
% scatter(gamma(:)',r1(3,:,i),'g')
% 
% title('yaw rate vs gamma')
% xlabel('gamma [rad]')
% ylabel('r [rad/s]')
% hold off
% savefig('yaw_ex.fig')
%  
%% Functions

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
