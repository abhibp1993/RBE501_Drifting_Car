% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% Course : RBE501 Robotics Dynamics
% Authors: 
%      Asa Puckette (aupuckette@wpi.edu)
%      Racing Lounge Copyright 2017 The MathWorks, Inc. 
% Date   : March/April 2018
% -------------------------------------------------------------------------
% Title: Run_VehicleDynamics3D
% [PI Control of a Simmechanics / Driving Lounge Car Model]
% -------------------------------------------------------------------------
% Inputs:  None
% -------------------------------------------------------------------------
% Usage: Run_VehicleDynamics3D
% -------------------------------------------------------------------------
% 


%% Initalization

VehicleDynamicsInitialization

%% Open Simulink Model

open('VehicleDynamics3D_controller.slx');

%% Run Simulink Model

%% Pick a Sample Case, for Monte Carlo use PID
% simcase = 'drive_straight';
% simcase = 'shallow_turn';
simcase = 'PID_sample';
% simcase = 'throttle_control';

%% Choose Steering Control or Throttle Control
ste_gain = 1;
thl_gain = 0;

% Number of monte carlo cases
n_cases = 1;

% preallocate output vector
MCout = zeros(7,n_cases)*NaN;

for n = 1:n_cases
tic


%% Random PID for Monte Carlo
a = 1.25;
b = 1.4;
P = (b-a).*rand(1) + a;
% P = 1.2095; % recommended value

a = 0.50;
b = 0.6;
I = (b-a).*rand(1) + a;
% I =0.55564; % recommended value

a = 0.125;
b = 0.25;
D = (b-a).*rand(1) + a;
% D = 0.1341; % recommended value



switch simcase
    
    case 'drive_straight'
        stoptime        =  15;  % simulation end time,                  [s]
        switch_steering_control  = 100;  
                                % time when steer PI receives setpoint, [s]
        switch_steering = 100;  % switch from fixed steering to PI,     [s]
        steering_step_t = 100;  % steering step time to induce drift,   [s]
        steering_step   =   0;  % steering angle to induce drift
        switch_throttle = 100;  % switch from fixed throttle to PI,     [s]
        switch_speed_control  = 100;  
                                % time when speed PI receives setpoint, [s]
        max_speed       =  20;  % kph 
        lat_xmin        = -10;  % min x value, position plot, [m]
        lat_ymin        = -10;  % min y value, position plot, [m]
        lat_xmax        =  200; % max x value, position plot, [m]
        lat_ymax        =  200; % max y value, position plot, [m]
%         latv_setpoint   =    0; % lateral velocity setpoint,  [kph]
        
    case 'shallow_turn'
        stoptime        =  15;  % simulation end time,                  [s]
        switch_steering_control  = 100;  
                                % time when steer PI receives setpoint, [s]
        switch_steering = 100;  % switch from fixed steering to PI,     [s]
        steering_step_t =   5;  % steering step time to induce drift,   [s]
        steering_step   =  -1;  % steering angle to induce drift
        switch_throttle = 100;  % switch from fixed throttle to PI,     [s]
        switch_speed_control  = 100;  
                                % time when speed PI receives setpoint, [s]
        max_speed       =  15;  % kph 
        lat_xmin        = -10;  % min x value, position plot, [m]
        lat_ymin        = -10;  % min y value, position plot, [m]
        lat_xmax        =  200; % max x value, position plot, [m]
        lat_ymax        =  200; % max y value, position plot, [m]
        latv_setpoint   =    0; % lateral velocity setpoint,  [kph]
    case 'PID_sample'
        stoptime        =   25;  % simulation end time,                 [s]
        switch_steering_control  = 3.58;  
                                % time when PI receives setpoint,       [s]
        switch_steering =   3.58;  % switch from fixed steering to PI,    [s]
%         switch_steering =   100;  % switch from fixed steering to PI,    [s]
        steering_step_t =  0.01;  % steering step time to induce drift,  [s]
        steering_step   =  -20;  % steering angle to induce drift
        switch_throttle =  80;  % switch from fixed throttle to PI,     [s]
        switch_speed_control  = 100;  
                                % time when speed PI receives setpoint, [s]    
        max_speed       =   80;  % kph 
        lat_xmin        = -100;  % min x value, position plot, [m]
        lat_ymin        =  -10;  % min y value, position plot, [m]
        lat_xmax        =   25; % max x value, position plot,  [m]
        lat_ymax        =   50; % max y value, position plot,  [m]
        latv_setpoint   =  -12.28; % lateral velocity setpoint,   [kph]
        
    case 'throttle_control' % still in work
        % still workong on throttle control
%         stoptime        =   25;  % simulation end time,                [s]
%         switch_steering_control  = 100;  
%                                  % time when PI receives setpoint,     [s]
%         switch_steering =  100;  % switch from fixed steering to PI,   [s]
%         steering_step_t =  0.01;  % steering step time to induce drift, [s]
%         steering_step   =  -13;  % steering angle to induce drift
%         switch_throttle =    6;  % switch from fixed throttle to PI,     [s]
%         switch_speed_control  = 6;  
%                                 % time when speed PI receives setpoint, [s]                
%         max_speed       =   60;  % kph 
%         lat_xmin        = -100;  % min x value, position plot, [m]
%         lat_ymin        =  -10;  % min y value, position plot, [m]
%         lat_xmax        =   25; % max x value, position plot,  [m]
%         lat_ymax        =   50; % max y value, position plot,  [m]
%         latv_setpoint   =   -6; % lateral velocity setpoint,   [kph]
        
end

simout = sim('VehicleDynamics3D_controller.slx');
% rename outputs
Vx_NR = simout.Vx_NR.Data;  % car body velocity wrt non-rotating follower
Vy_NR = simout.Vy_NR.Data;  % car body velocity wrt non-rotating follower
tout  = simout.Vy_NR.Time;  % time vector
ster  = simout.SteeringAngle_deg.Data;
                            % steering angle
spd   = simout.Speed_input.Data;       
%% Plot Results

figure;
subplot(3,1,1)
hold on
plot(tout,Vx_NR)
grid on
ylabel('[kph]')
ylim([-30 30])
title('Car Lateral Velocity')

[~,S] = polyfit(tout(250:end),Vx_NR(250:end),1);
% plot([5 stoptime],[p(1)*5+p(2) p(1)*stoptime+p(2)])
plot([5 stoptime],[mean(Vx_NR(501:end)) mean(Vx_NR(501:end))])
legend('drift v',['mean : ' num2str(mean(Vx_NR(501:end)))])

subplot(3,1,2)
plot(tout,ster)
grid on
ylabel('[degrees]')
title('Car Steering Angle')

% wheel outer radius is 30cm
wheel_rpm = spd/0.3/2/pi;

subplot(3,1,3)
plot(tout,wheel_rpm)
grid on
ylabel('[rpm]')
title('Rear Wheel Speed')

MCout(1,n) = steering_step;
MCout(2,n) = max_speed;
MCout(3,n) = mean(Vx_NR(501:end));
MCout(4,n) = S.normr;
MCout(5,n) = P;
MCout(6,n) = I;
MCout(7,n) = D;




toPPT(gcf); % By default a new slide is created when adding a figure
toPPT('setTitle',['P: ' num2str(P) ' I: ' num2str(I) ' D: ' num2str(D) ' normr: ' num2str(S.normr)]);
toc

close gcf

end

%% if desired, uncomment to save results to a randomly named .mat file
% uniquename = ['MCout' randseq(3) '.mat'];
% save(uniquename,'MCout')


%% if desired, uncomment to plot results
% figure
% scatter3(MCout(1,:),MCout(2,:),MCout(3,:),3,MCout(4,:))
% xlabel('steering angle [deg]')
% ylabel('real wheel speed [rpm]')
% zlabel('lateral (drift) vel [kph]')
% colormap(jet)
% h = colorbar;
% set(get(h,'title'),'string','norm of residuals \Sigma{\circ}^2 ','Interpreter','tex')