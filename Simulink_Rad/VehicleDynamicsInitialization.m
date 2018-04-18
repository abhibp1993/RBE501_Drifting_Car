%% Vehicle Contact Initizialization Script
% Copyright 2017 The MathWorks, Inc.
%
%% Add Paths
curDir = pwd;
cd([curDir filesep 'CFL_Libs']);
startup_Contact_Forces
cd(curDir);
addpath([curDir filesep 'CAD']);
addpath([curDir filesep 'Images']);
addpath([curDir filesep 'Scripts_Data']);

%% Simulation Parameters
SetPaceSampleTime = 0.1;
initHeight = 0.35;

relTol = 1E-4;
absTol = 1E-5;
maxStep = 1E-2;

%% Floor parameters
Floor.l = 1000;  % m
Floor.w = 1000;  % m
Floor.h = 0.1; % m

% Grid parameters
Grid.clr = [1 1 1]*1;
Grid.numSqrs = 250;
Grid.lineWidth = 0.02;
Grid.box_h = (Floor.l-(Grid.lineWidth*(Grid.numSqrs+1)))/Grid.numSqrs;
Grid.box_l = (Floor.l-(Grid.lineWidth*(1+1)))/1;
Grid.extr_data = Extr_Data_Mesh(Floor.w,Floor.w,Grid.numSqrs,1,Grid.box_h,Grid.box_l);

%% Contact Parameters
contactStiffness = 1E+6;
contactDamping = 1200;
kineticFrictionCoeff = 0.88;
staticFrictionCoeff =0.90;

% kineticFrictionCoeff = 0.1;
% staticFrictionCoeff =0.1;

velocityThreshold = 1.5;

%% Vehicle Parameters
scale = 1;

Load = 200*scale; %Kg
%Load = .0401;
%Load = 3;
% a = 0.029 ; %m
% b = 0.033;


steeringInput = 0;
vehicleSpeed_kph = 0; %km/h

wheelbase = 1.5*scale; %m
%wheelbase =0.029 + 0.033 ;
%wheelbase =0.2 ;
wheelFilterTimeConst = 0.5;
wheelJointDamping = 0.1;

steeringFilterTimeConst = 0.5;
steeringJointStiffness = 1;
steeringJointDamping = 1;

maxSteeringDisplacement = 10; %cm
minSteeringDisplacement = -10; %cm

SixDOFdamp = 16;

wheel.tire.innerradius = 10;

%% Camera Setup
frontCameraX = -1.75;
frontCameraZ = 0.35;

followerCameraX = 7.5;
followerCameraZ = 3;

isoCameraX = -3.1;
isoCameraY = 3.5;
isoCameraZ = 1.5;
isoCameraAimX = (1/2)*wheelbase;

IsoCameraDamping = 30;
IsoCameraStiffness = 5;
Filtering1Dto3DConnection = 0.1;

%% Variant Controls
UserInput = 1;
StopTime = 30;
SlalomVariant = Simulink.Variant('UserInput == 1');
RightTurnVariant = Simulink.Variant('UserInput == 2');
LeftTurnVariant = Simulink.Variant('UserInput == 3');
SteepSteerVariant = Simulink.Variant('UserInput == 4');
BurnoutVariant = Simulink.Variant('UserInput == 5');
SkidpadVariant = Simulink.Variant('UserInput ==6');
DashboardVariant = Simulink.Variant('UserInput == 7');
