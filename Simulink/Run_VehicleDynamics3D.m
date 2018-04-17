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

% simcase = 'drive_straight';
% simcase = 'shallow_turn';
simcase = 'PID_sample';
% simcase = 'throttle_control';
ste_gain = 1;
thl_gain = 0;

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
        latv_setpoint   =    0; % lateral velocity setpoint,  [kph]
        
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
        switch_steering_control  = 3.4;  
                                % time when PI receives setpoint,       [s]
        switch_steering =   3.5;  % switch from fixed steering to PI,    [s]
%         switch_steering =   100;  % switch from fixed steering to PI,    [s]
        steering_step_t =  0.01;  % steering step time to induce drift,  [s]
        steering_step   =  -30;  % steering angle to induce drift
        switch_throttle =  90;  % switch from fixed throttle to PI,     [s]
        switch_speed_control  = 100;  
                                % time when speed PI receives setpoint, [s]    
        max_speed       =   70;  % kph 
        lat_xmin        = -100;  % min x value, position plot, [m]
        lat_ymin        =  -10;  % min y value, position plot, [m]
        lat_xmax        =   25; % max x value, position plot,  [m]
        lat_ymax        =   50; % max y value, position plot,  [m]
        latv_setpoint   =  -12; % lateral velocity setpoint,   [kph]
        
    case 'throttle_control'
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
plot(tout,Vx_NR)
grid on
ylabel('[kph]')
ylim([-30 30])
title('Car Lateral Velocity')

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

