clear all
%% Initialize
run('VehicleDynamicsInitialization.m');

%% Steering Test
% simout = sim('VehicleDynamics3D_old.slx');
% save('steering_test.mat','simout')

%% Front BCD Parameters Test
Stoptime = 50; 
test_iter=40;

steer_input_max = 10;  %cm 
vx_choice = linspace(30,70,test_iter+1); %kph;

steering_step = 7.5/30;
steering_step_t = 5;

for i=1:test_iter
    vx_input = vx_choice(i);
    simout(i)=sim('VehicleDynamics3D_old.slx');
end

%% Data Processing

perm_Fl = [0 -1 0 ; 0 0 1; 1 0 0];
perm_Fr = [0 1 0 ; 0 0 -1; 1 0 0];
perm_Rl = [0 -1 0; 0 0 1; 1 0 0];
perm_Rr = [0 1 0; 0 0 -1; 1 0 0];
    
for i = 1:40
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
S(i).steer_ang = get_steer(simout(i).rot_R,simout(i).rot_l);
end



%% Plot

figure()
plot(simout(2).tout',S(2).F_Fl_whe(1,:),'b')
hold on
plot(simout(2).tout',S(2).F_Fl_whe(2,:),'b--')

plot(simout(2).tout',S(2).F_Rl_whe(1,:),'r')
hold on
plot(simout(2).tout',S(2).F_Rl_whe(2,:),'r--')

%% Save

save('BCD_front.mat','simout','S');


