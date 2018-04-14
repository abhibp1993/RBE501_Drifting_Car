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
simcase = 'PI_sample';


switch simcase
    
    case 'drive_straight'
        stoptime        =  15;  % simulation end time,                [s]
        switch_control  = 100;  % time when PI receives setpoint,     [s]
        switch_steering = 100;  % switch from fixed steering to PI,   [s]
        steering_step_t = 100;  % steering step time to induce drift, [s]
        steering_step   =   0;  % steering angle to induce drift
        max_speed       =  48;  % kph 
        lat_xmin        = -10;  % min x value, position plot, [m]
        lat_ymin        = -10;  % min y value, position plot, [m]
        lat_xmax        =  200; % max x value, position plot, [m]
        lat_ymax        =  200; % max y value, position plot, [m]
        latv_setpoint   =    0; % lateral velocity setpoint,  [kph]
        
    case 'PI_sample'
        stoptime        =   25;  % simulation end time,                [s]
        switch_control  =    6;  % time when PI receives setpoint,     [s]
        switch_steering =    6;  % switch from fixed steering to PI,   [s]
        steering_step_t =  0.1;  % steering step time to induce drift, [s]
        steering_step   =  -30;  % steering angle to induce drift
        max_speed       =   15;  % kph 
        lat_xmin        = -100;  % min x value, position plot, [m]
        lat_ymin        =  -10;  % min y value, position plot, [m]
        lat_xmax        =   25; % max x value, position plot,  [m]
        lat_ymax        =   50; % max y value, position plot,  [m]
        latv_setpoint   =  -20; % lateral velocity setpoint,   [kph]
        
end

simout = sim('VehicleDynamics3D_controller.slx');
% rename outputs
Vx_NR = simout.Vx_NR.Data;  % car body velocity wrt non-rotating follower
Vy_NR = simout.Vy_NR.Data;  % car body velocity wrt non-rotating follower
tout  = simout.Vy_NR.Time;  % time vector
ster  = simout.SteeringAngle_deg.Data;
                            % steering angle
%% Plot Results

figure;
subplot(2,1,1)
plot(tout,Vx_NR)
grid on
ylabel('[kph]')
title('Car Lateral Velocity')

subplot(2,1,2)
plot(tout,ster)
grid on
ylabel('[degrees]')
title('Car Steering Angle')

