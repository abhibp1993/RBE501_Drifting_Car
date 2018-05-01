clear all
%% Initialize
run('VehicleDynamicsInitialization.m');

%% Steering Test
% simout = sim('VehicleDynamics3D_old.slx');
% save('steering_test.mat','simout')

%% Front BCD Parameters Test
Stoptime = 60; 
test_iter=40;

%save_array = [3, 120; 4, 110; 4, 100; 4,105; 4, 90; 5, 80; 5, 90; 4.5, 85];

%save_array = [5, 80; 4.5, 85];
%save_array = [4.5,80; 4.0,85]; 
%save_array = [2.2, 90; 1.9,95];

save_array=[5, 80; 4.5, 85;4.5,80; 4.0,85;2.2, 90; 1.9,95];

limit=105;

steering_step = 1/4;
steering_step_t = 2;

 
 for i=1:length(save_array)
     steer_input_max = save_array(i,1);  %cm 
     vx_input = save_array(i,2);
 simout(i)=sim('VehicleDynamics3D_old.slx');
 end 
 

%% Data Processing
% 
% perm_Fl = [0 -1 0 ; 0 0 1; 1 0 0];
% perm_Fr = [0 1 0 ; 0 0 -1; 1 0 0];
% perm_Rl = [0 -1 0; 0 0 1; 1 0 0];
% perm_Rr = [0 1 0; 0 0 -1; 1 0 0];
%     
% for i = 1:length(save_array)
% for j=1:length(simout(i).tout)
%     S(i).F_Fl_whe(1:3,j)=perm_Fl*simout(i).rot_l(:,:,j).'*[simout(i).F_Fl(j,1:2), 0 ].';
%     S(i).F_Fr_whe(1:3,j)=perm_Fr*simout(i).rot_R(:,:,j).'*[simout(i).F_Fr(j,1:2), 0 ].';
%     
%     S(i).F_Rl_whe(1:3,j)=perm_Rl*simout(i).rot_Rl(:,:,j).'*[simout(i).F_Rl(j,1:2), 0 ].';
%     S(i).F_Rr_whe(1:3,j)=perm_Rr*simout(i).rot_Rr(:,:,j).'*[simout(i).F_Rr(j,1:2), 0 ].';
%   
%     
% end
%   S(i).steer_ang = get_steer(simout(i).rot_R,simout(i).rot_l);
% end
% 

perm_Fl = [0 -1 0 ; 0 0 1; 1 0 0];
perm_Fr = [0 1 0 ; 0 0 -1; 1 0 0];
perm_Rl = [0 -1 0; 0 0 1; 1 0 0];
perm_Rr = [0 1 0; 0 0 -1; 1 0 0];
    
for i = 1:length(save_array)
 %for i = 1:1
for j=1:length(simout(i).tout)
    S(i).F_Fl_whe(1:3,j)=perm_Fl*simout(i).rot_l(:,:,j).'*[simout(i).F_Fl(j,1:2), 0 ].';
    S(i).F_Fr_whe(1:3,j)=perm_Fr*simout(i).rot_R(:,:,j).'*[simout(i).F_Fr(j,1:2), 0 ].';
    S(i).F_Rl_whe(1:3,j)=perm_Rl*simout(i).rot_Rl(:,:,j).'*[simout(i).F_Rl(j,1:2), 0 ].';
    S(i).F_Rr_whe(1:3,j)=perm_Rr*simout(i).rot_Rr(:,:,j).'*[simout(i).F_Rr(j,1:2), 0 ].';
    
    S(i).V_Fl(1:3,j)=perm_Fl*simout(i).rot_l(:,:,j).'*[simout(i).Vx_Fl(j), simout(i).Vy_Fl(j), 0 ].';
    S(i).V_Fr(1:3,j)=perm_Fr*simout(i).rot_R(:,:,j).'*[simout(i).Vx_Fr(j), simout(i).Vy_Fr(j), 0 ].';
    S(i).V_Rl(1:3,j)=perm_Rl*simout(i).rot_Rl(:,:,j).'*[simout(i).Vx_Rl(j), simout(i).Vy_Rl(j), 0 ].';
    S(i).V_Rr(1:3,j)=perm_Rr*simout(i).rot_Rr(:,:,j).'*[simout(i).Vx_Rr(j), simout(i).Vy_Rr(j), 0 ].';
    
    S(i).slip_Fl(j) = atan(S(i).V_Fl(2,j)./S(i).V_Fl(1,j));
    S(i).slip_Fr(j) = atan(S(i).V_Fr(2,j)./S(i).V_Fr(1,j));
    S(i).slip_Rl(j) = atan(S(i).V_Rl(2,j)./S(i).V_Rl(1,j));
    S(i).slip_Rr(j) = atan(S(i).V_Rr(2,j)./S(i).V_Rr(1,j));
    
    
    S(i).F_Favg(1:3,j)=(S(i).F_Fl_whe(1:3,j)+S(i).F_Fr_whe(1:3,j))/2;
    S(i).F_Ravg(1:3,j)=(S(i).F_Rl_whe(1:3,j)+S(i).F_Rr_whe(1:3,j))/2;
    
    S(i).V_Favg(1:3,j)=(S(i).V_Fl(1:3,j)+S(i).V_Fr(1:3,j))/2;
    S(i).V_Ravg(1:3,j)=(S(i).V_Rl(1:3,j)+S(i).V_Rr(1:3,j))/2;
    
    S(i).Slip_Favg(j)=(S(i).slip_Fl(j)+S(i).slip_Fr(j))/2;
    S(i).Slip_Ravg(j)=(S(i).slip_Rl(j)+S(i).slip_Rr(j))/2;
    
end
S(i).steer_ang = get_steer2(simout(i).Rw_rc,simout(i).rot_R,simout(i).rot_l);
end


for i = 1:length(save_array)
    S(i).tout=simout(i).tout;
    S(i).yaw_rate=simout(i).yaw_rate;
    S(i).yaw_acc=simout(i).yaw_acc;
for j=length(simout(i).tout):-1:1
   if (S(i).slip_Rr(j)<0 || S(i).slip_Rl(j)<0) 
       
    S(i).F_Favg(:,j)=[];
    S(i).F_Ravg(:,j)=[];
    
    S(i).V_Favg(:,j)=[];
    S(i).V_Ravg(:,j)=[];
    
    S(i).Slip_Favg(j)=[];
    S(i).Slip_Ravg(j)=[];
    
    S(i).steer_ang(j) = [];
    S(i).yaw_rate(j)=[];
    S(i).yaw_acc(j)=[];
    S(i).tout(j)=[];
    
   end
end
end

%% Plot
close all 
figure()
plot(S(1).tout',S(1).Slip_Ravg(:),'r')

figure()
plot(S(2).tout',S(2).Slip_Ravg(:),'b')

legend('first','second')

figure()
scatter(S(2).Slip_Ravg(:),S(2).F_Ravg(2,:).')


%% Save

save('BCD_rear2.mat','simout','S','save_array');


