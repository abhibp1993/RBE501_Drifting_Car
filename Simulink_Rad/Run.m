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
    
for i = 1:test_iter
for j=1:length(simout(i).tout)
    S(i).F_Fl_whe(1:3,j)=perm_Fl*simout(i).rot_l(:,:,j).'*[simout(i).F_Fl(j,1:2), 0 ].';
    S(i).F_Fr_whe(1:3,j)=perm_Fr*simout(i).rot_R(:,:,j).'*[simout(i).F_Fr(j,1:2), 0 ].';
    
    S(i).F_Rl_whe(1:3,j)=perm_Rl*simout(i).rot_Rl(:,:,j).'*[simout(i).F_Rl(j,1:2), 0 ].';
    S(i).F_Rr_whe(1:3,j)=perm_Rr*simout(i).rot_Rr(:,:,j).'*[simout(i).F_Rr(j,1:2), 0 ].';
    S(i).steer_ang = get_steer(simout(i).rot_R,simout(i).rot_l);
    
end
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


