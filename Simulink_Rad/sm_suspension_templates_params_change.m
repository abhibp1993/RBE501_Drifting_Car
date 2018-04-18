% SM_SUSPENSION_TEMPLATES_PARAMS Parameters used in the model

% Copyright 2016 The MathWorks, Inc.

%% Colors and densities
color = simmechanics.demohelpers.colors;
density = simmechanics.demohelpers.densities;

scale=0.2;
%% Test Platforms
platform.cylinder.outerradius     = 12*scale; %cm
platform.cylinder.innerradius     = 10*scale; %cm
platform.cylinder.flangeradius    = 20*scale; %cm
platform.cylinder.flangethickness = 2*scale;  %cm
platform.cylinder.height          = 40*scale; %cm
platform.cylinder.color           = color.dgrey;
platform.cylinder.leftlocation    = [-80 -25 0]*scale; %cm
platform.cylinder.rightlocation   = [80 -25 0]*scale;  %cm

platform.piston.innerradius = 8*scale;  %cm
platform.piston.height      = 60*scale; %cm
platform.piston.color       = [0.6 0.6 0.6];

platform.base.length    = 40*scale; %cm
platform.base.width     = 40*scale; %cm
platform.base.thickness = 3*scale;  %cm
platform.base.color     = [0.6 0.6 0.6];

platform.controller.k  = 1e4*scale;
platform.controller.kd = 100*scale;

platform.density = density.aluminum; %kg/m^3

%% Wheels
wheel.tire.innerradius   = 25*scale; %cm
wheel.tire.outerradius   = 30*scale; %cm
wheel.tire.width         = 15*scale; %cm
wheel.tire.chamferradius = 1*scale;  %cm
wheel.tire.density       = 1000*scale; %kg/m^3
wheel.tire.color         = color.black;

wheel.hub.radius         = 5*scale;  %cm
wheel.hub.outerradius    = 23*scale; %cm
wheel.hub.numspokes      = 5*scale;
wheel.hub.spokethickness = 1*scale;  %cm
wheel.hub.width          = 11*scale; %cm
wheel.hub.density        = density.aluminum; %kg/m^3
wheel.hub.color          = color.grey;

wheel.shaft.length   = 6*scale;  %cm
wheel.shaft.radius   = 2*scale;  %cm
wheel.disc.radius    = 10*scale; %cm
wheel.disc.thickness = 1*scale;  %cm

%% Double Wishbone

% Knuckle
dwb.knuckle.height                 = 43*scale;  %cm
dwb.knuckle.length                 = 8*scale;   %cm
dwb.knuckle.thickness              = 1*scale;   %cm
dwb.knuckle.wheelattachprojwidth   = 2.5*scale; %cm
dwb.knuckle.wheelattachprojheight  = 8*scale;   %cm
dwb.knuckle.wishboneconnectorwidth = 10*scale;  %cm
dwb.knuckle.driveshaftradius       = 2.5*scale; %cm
dwb.knuckle.driveshaftheight       = 6*scale;   %cm
dwb.knuckle.chamferradius          = 0.3*scale; %cm
dwb.knuckle.transitionradius       = 2*scale;   %cm
dwb.knuckle.density                = density.aluminum; %kg/m^3
dwb.knuckle.color                  = color.dgrey;

dwb.knuckle.ball.radius = 1*scale;   %cm
dwb.knuckle.pin.radius  = 0.5*scale; %cm
dwb.knuckle.pin.height  = 3*scale;   %cm

dwb.knuckle.steerarm.length     = 20*scale;   %cm
dwb.knuckle.steerarm.width      = 2*scale;    %cm
dwb.knuckle.steerarm.thickness  = 1*scale;    %cm
dwb.knuckle.steerarm.forkheight = 13*scale;   %cm
dwb.knuckle.steerarm.forklength = 4*scale;    %cm
dwb.knuckle.steerarm.forkoffset = 3*scale;    %cm
dwb.knuckle.pinradius           = 0.25*scale; %cm
dwb.knuckle.chamferradius       = 0.25*scale; %cm

% Upper Wishbone
dwb.uwb.longlength      = 25*scale; %cm
dwb.uwb.shortlength     = 15*scale; %cm
dwb.uwb.wheellinklength = 5*scale;  %cm
dwb.uwb.wheellinkwidth  = 5*scale;  %cm
dwb.uwb.width           = 25*scale; %cm
dwb.uwb.thickness       = 2*scale;  %cm
dwb.uwb.baseradius      = 8*scale;  %cm
dwb.uwb.basearcoffset   = 5*scale;  %cm
dwb.uwb.density         = density.aluminum; %kg/m^3
dwb.uwb.color           = [0.3 0.2 0.0];

dwb.uwb.bracket.length = 4*scale;    %cm
dwb.uwb.bracket.radius = 0.75*scale; %cm

dwb.uwb.socket.radius     = 2*scale;   %cm
dwb.uwb.socket.height     = 1.4*scale; %cm
dwb.uwb.socket.ballradius = 1*scale;   %cm
dwb.uwb.socket.offset     = 3*scale;   %cm

% Lower Wishbone
dwb.lwb.longlength      = 36*scale;    %cm
dwb.lwb.shortlength     = 25*scale;    %cm
dwb.lwb.wheellinklength = 5*scale;     %cm
dwb.lwb.wheellinkwidth  = 5*scale;     %cm
dwb.lwb.width           = 14.75*scale; %cm
dwb.lwb.thickness       = 2*scale;     %cm
dwb.lwb.baseradius      = 2.875*scale; %cm
dwb.lwb.basearcoffset   = 15*scale;    %cm
dwb.lwb.density         = density.aluminum;  %kg/m^3
dwb.lwb.color           = [167 108 52]/255;

dwb.lwb.bracket.length = 4*scale;    %cm
dwb.lwb.bracket.radius = 0.75*scale; %cm

dwb.lwb.socket.radius     = 2*scale;      %cm
dwb.lwb.socket.height     = 1.4*scale;    %cm
dwb.lwb.socket.holeradius = 1*scale/4;      %cm
dwb.lwb.socket.holeoffset = 3.0625*scale; %cm

dwb.lwb.damperbracket.offset     = 10*scale;  %cm
dwb.lwb.damperbracket.width      = 4*scale;   %cm
dwb.lwb.damperbracket.length     = 4*scale;   %cm
dwb.lwb.damperbracket.thickness  = 1*scale;   %cm
dwb.lwb.damperbracket.spacing    = 1.5*scale; %cm
dwb.lwb.damperbracket.holeradius = 1*scale;   %cm

% Spring-Damper
dwb.springdamp.k       = 100000*scale; %N/m
dwb.springdamp.b       = 11000*scale;  %Ns/m
dwb.springdamp.length0 = 18.5*scale;   %cm
dwb.springdamp.density = density.aluminum;   %kg/m^3

dwb.springdamp.cylinder.length      = 22*scale;  %cm
dwb.springdamp.cylinder.innerradius = 2*scale;   %cm
dwb.springdamp.cylinder.outerradius = 3*scale;   %cm
dwb.springdamp.cylinder.color       = [0.9 0.7 0.2];
dwb.springdamp.piston.length        = 16*scale;  %cm
dwb.springdamp.piston.color         = [0.3 0.2 0.0];
dwb.springdamp.chamferradius        = 0.3*scale; %cm

dwb.springdamp.bracket.length     = 6*scale;    %cm
dwb.springdamp.bracket.width      = 4*scale;    %cm
dwb.springdamp.bracket.thickness  = 1*scale;    %cm
dwb.springdamp.bracket.holeradius = 0.75*scale; %cm

% Chassis
dwb.chassis.frame.longlength   = 100*scale; %cm
dwb.chassis.frame.shortlength  = 75*scale;  %cm
dwb.chassis.frame.height       = 40*scale;  %cm
dwb.chassis.frame.cornerradius = 2*scale;   %cm
dwb.chassis.frame.thickness    = 2*scale;   %cm
dwb.chassis.frame.barthickness = 5*scale;   %cm
dwb.chassis.frame.density      = density.aluminum; %kg/m^3
dwb.chassis.frame.color        = [255 140 0]/255;

dwb.chassis.upperlink.length                 = 30*scale;   %cm
dwb.chassis.upperlink.outerradius            = 1.5*scale;  %cm
dwb.chassis.upperlink.innerradius            = 0.75*scale; %cm
dwb.chassis.upperlink.wishboneslotlength     = 5.5*scale;  %cm
dwb.chassis.upperlink.springdamperslotlength = 3*scale;    %cm
dwb.chassis.upperlink.wishboneseparation     = 20.5*scale; %cm
dwb.chassis.upperlink.wishboneoffset         = 0*scale;    %cm
dwb.chassis.upperlink.chamferradius          = 0.2*scale;  %cm
dwb.chassis.upperlink.density                = density.aluminum; %kg/m^3
dwb.chassis.upperlink.color                  = [255 140 0]/255;

dwb.chassis.lowerlink.length             = 30*scale;    %cm
dwb.chassis.lowerlink.outerradius        = 1.5*scale;   %cm
dwb.chassis.lowerlink.innerradius        = 0.75*scale;  %cm
dwb.chassis.lowerlink.wishboneslotlength = 5.5*scale;   %cm
dwb.chassis.lowerlink.wishboneseparation = 10.25*scale; %cm
dwb.chassis.lowerlink.wishboneoffset     = 5.125*scale; %cm
dwb.chassis.lowerlink.chamferradius      = 0.2*scale;   %cm
dwb.chassis.lowerlink.density            = density.aluminum;  %kg/m^3
dwb.chassis.lowerlink.color              = [255 140 0]/255;

dwb.chassis.steering.bracket.length        = 4*scale;    %cm
dwb.chassis.steering.bracket.width         = 4*scale;    %cm
dwb.chassis.steering.bracket.thickness     = 4*scale;    %cm
dwb.chassis.steering.bracket.holelength    = 2*scale;    %cm
dwb.chassis.steering.bracket.holewidth     = 2*scale;    %cm
dwb.chassis.steering.bracket.chamferradius = 0.5*scale;  %cm
dwb.chassis.steering.bracket.density       = density.aluminum; %kg/m^3
dwb.chassis.steering.bracket.color         = [255 140 0]/255;

dwb.chassis.steering.tierod.rod.length            = 16.5*scale; %cm
dwb.chassis.steering.tierod.rod.radius            = 1.25*scale; %cm
dwb.chassis.steering.tierod.rod.chamferradius     = 0.25*scale; %cm
dwb.chassis.steering.tierod.bracket.length        = 3*scale;    %cm
dwb.chassis.steering.tierod.bracket.width         = 2*scale;    %cm
dwb.chassis.steering.tierod.bracket.thickness     = 0.5*scale;  %cm
dwb.chassis.steering.tierod.bracket.flangespacing = 0.75*scale; %cm
dwb.chassis.steering.tierod.bracket.socketradius  = 0.75*scale; %cm
dwb.chassis.steering.tierod.bracket.ballradius    = 0.5*scale;  %cm
dwb.chassis.steering.tierod.bracket.holeradius    = 0.3*scale/2;  %cm
dwb.chassis.steering.tierod.density               = density.aluminum; %kg/m^3
dwb.chassis.steering.tierod.rod.color             = [0.9 0.7 0.2];
dwb.chassis.steering.tierod.ballcolor             = [0.3 0.2 0.0];

dwb.chassis.steering.rack.rod.length          = 120*scale;  %cm
dwb.chassis.steering.rack.rod.width           = 2*scale;    %cm
dwb.chassis.steering.rack.rod.height          = 2*scale;    %cm
dwb.chassis.steering.rack.rod.bracketdistance = 70*scale;   %cm
dwb.chassis.steering.rack.rod.chamferradius   = 0.5*scale;  %cm
dwb.chassis.steering.rack.bracket.length      = 4*scale;    %cm
dwb.chassis.steering.rack.bracket.width       = 2*scale;    %cm
dwb.chassis.steering.rack.bracket.thickness   = 0.5*scale;  %cm
dwb.chassis.steering.rack.bracket.holeradius  = 0.5*scale/2;  %cm
dwb.chassis.steering.rack.density             = density.aluminum; %kg/m^3
dwb.chassis.steering.rack.color               = [0.3 0.2 0.0];

%% MacPherson

% Knuckle
mp.knuckle.springdamperangle = 30*scale; %deg
mp.knuckle.balldiameter      = 1*scale;  %cm
mp.knuckle.hublength         = 15*scale; %cm
mp.knuckle.density           = density.aluminum; %kg/m^3
mp.knuckle.color             = color.grey;

% Spring-Damper
mp.springdamp.k       = 50000*scale;  %N/m
mp.springdamp.b       = 1500*scale;   %Ns/m
mp.springdamp.length0 = 15*scale;     %cm
mp.springdamp.density = density.aluminum;   %kg/m^3

mp.springdamp.cylinder.length      = 22*scale;  %cm
mp.springdamp.cylinder.innerradius = 2*scale;   %cm
mp.springdamp.cylinder.outerradius = 3*scale;   %cm
mp.springdamp.cylinder.color       = [0.9 0.7 0.2];
mp.springdamp.piston.length        = 15*scale;  %cm
mp.springdamp.piston.color         = [0.55 0.35 0.17];
mp.springdamp.chamferradius        = 0.3*scale; %cm

mp.springdamp.bracket.length     = 4*scale;    %cm
mp.springdamp.bracket.width      = 4*scale;    %cm
mp.springdamp.bracket.thickness  = 1*scale;    %cm
mp.springdamp.bracket.holeradius = 0.75*scale/4; %cm

% Wishbone
mp.wb.longlength      = 20*scale;    %cm
mp.wb.shortlength     = 10*scale;    %cm
mp.wb.wheellinklength = 5*scale;     %cm
mp.wb.wheellinkwidth  = 5*scale;     %cm
mp.wb.width           = 14.75*scale; %cm
mp.wb.thickness       = 2*scale;     %cm
mp.wb.baseradius      = 2.875*scale; %cm
mp.wb.basearcoffset   = 5*scale;     %cm
mp.wb.density         = density.aluminum;  %kg/m^3
mp.wb.color           = color.grey;

mp.wb.bracket.length = 4*scale; %cm
mp.wb.bracket.radius = 1*scale; %cm

mp.wb.socket.radius     = 2*scale;      %cm
mp.wb.socket.height     = 1.4*scale;    %cm
mp.wb.socket.ballradius = 1*scale;      %cm
mp.wb.socket.offset     = 3*scale;      %cm

% Chassis
mp.chassis.frame.longlength   = 125*scale; %cm
mp.chassis.frame.shortlength  = 100*scale;  %cm
mp.chassis.frame.height       = 50*scale;  %cm
mp.chassis.frame.cornerradius = 2*scale;   %cm
mp.chassis.frame.thickness    = 2*scale;   %cm
mp.chassis.frame.barthickness = 5*scale;   %cm
mp.chassis.frame.density      = density.aluminum; %kg/m^3
mp.chassis.frame.color        = [255 140 0]/255;

mp.chassis.upperlink.length                 = 30*scale;   %cm
mp.chassis.upperlink.outerradius            = 1.5*scale;  %cm
mp.chassis.upperlink.innerradius            = 0.75*scale; %cm
mp.chassis.upperlink.springdamperslotlength = 3*scale;    %cm
mp.chassis.upperlink.springdamperoffset     = 8*scale;    %cm
mp.chassis.upperlink.chamferradius          = 0.2*scale;  %cm
mp.chassis.upperlink.density                = density.aluminum; %kg/m^3
mp.chassis.upperlink.color                  = [255 140 0]/255;

mp.chassis.lowerlink.length             = 30*scale;    %cm
mp.chassis.lowerlink.outerradius        = 1.5*scale;   %cm
mp.chassis.lowerlink.innerradius        = 0.75*scale;  %cm
mp.chassis.lowerlink.wishboneslotlength = 5.5*scale;   %cm
mp.chassis.lowerlink.wishboneseparation = 10.25*scale; %cm
mp.chassis.lowerlink.wishboneoffset     = 3.125*scale; %cm
mp.chassis.lowerlink.chamferradius      = 0.2*scale;   %cm
mp.chassis.lowerlink.density            = density.aluminum;  %kg/m^3
mp.chassis.lowerlink.color              = [255 140 0]/255;

%% Pushrod

% Knuckle
pr.knuckle.height                 = 43*scale;  %cm
pr.knuckle.length                 = 8*scale;   %cm
pr.knuckle.thickness              = 1*scale;   %cm
pr.knuckle.wheelattachprojwidth   = 2.5*scale; %cm
pr.knuckle.wheelattachprojheight  = 8*scale;   %cm
pr.knuckle.wishboneconnectorwidth = 10*scale;  %cm
pr.knuckle.driveshaftradius       = 2.5*scale; %cm
pr.knuckle.driveshaftheight       = 6*scale;   %cm
pr.knuckle.chamferradius          = 0.3*scale; %cm
pr.knuckle.transitionradius       = 2*scale;   %cm
pr.knuckle.density                = density.aluminum; %kg/m^3
pr.knuckle.color                  = color.dgrey;

pr.knuckle.ball.radius = 1*scale;   %cm
pr.knuckle.pin.radius  = 0.5*scale; %cm
pr.knuckle.pin.height  = 3*scale;   %cm

pr.knuckle.steerarm.length     = 20*scale;   %cm
pr.knuckle.steerarm.width      = 2*scale;    %cm
pr.knuckle.steerarm.thickness  = 1*scale;    %cm
pr.knuckle.steerarm.forkheight = 13*scale;   %cm
pr.knuckle.steerarm.forklength = 4*scale;    %cm
pr.knuckle.steerarm.forkoffset = 3*scale;    %cm
pr.knuckle.pinradius           = 0.25*scale; %cm
pr.knuckle.chamferradius       = 0.25*scale; %cm

% Upper Wishbone
pr.uwb.longlength      = 25*scale; %cm
pr.uwb.shortlength     = 15*scale; %cm
pr.uwb.wheellinklength = 5*scale;  %cm
pr.uwb.wheellinkwidth  = 5*scale;  %cm
pr.uwb.width           = 25*scale; %cm
pr.uwb.thickness       = 2*scale;  %cm
pr.uwb.baseradius      = 8*scale;  %cm
pr.uwb.basearcoffset   = 5*scale;  %cm
pr.uwb.density         = density.aluminum; %kg/m^3
pr.uwb.color           = [0.3 0.2 0.0];

pr.uwb.bracket.length = 4*scale;    %cm
pr.uwb.bracket.radius = 0.75*scale; %cm

pr.uwb.socket.radius     = 2*scale;   %cm
pr.uwb.socket.height     = 1.4*scale; %cm
pr.uwb.socket.ballradius = 1*scale;   %cm
pr.uwb.socket.offset     = 3*scale;   %cm

% Lower Wishbone
pr.lwb.longlength      = 36*scale;    %cm
pr.lwb.shortlength     = 25*scale;    %cm
pr.lwb.wheellinklength = 5*scale;     %cm
pr.lwb.wheellinkwidth  = 5*scale;     %cm
pr.lwb.width           = 14.75*scale; %cm
pr.lwb.thickness       = 2*scale;     %cm
pr.lwb.baseradius      = 2.875*scale; %cm
pr.lwb.basearcoffset   = 15*scale;    %cm
pr.lwb.density         = density.aluminum;  %kg/m^3
pr.lwb.color           = [167 108 52]/255;

pr.lwb.bracket.length = 4*scale;    %cm
pr.lwb.bracket.radius = 0.75*scale; %cm

pr.lwb.socket.radius     = 2*scale;      %cm
pr.lwb.socket.height     = 1.4*scale;    %cm
pr.lwb.socket.holeradius = 1*scale/4;      %cm
pr.lwb.socket.holeoffset = 3.0625*scale; %cm

pr.lwb.damperbracket.offset     = 10*scale;  %cm
pr.lwb.damperbracket.width      = 4*scale;   %cm
pr.lwb.damperbracket.length     = 4*scale;   %cm
pr.lwb.damperbracket.thickness  = 1*scale;   %cm
pr.lwb.damperbracket.spacing    = 1.5*scale; %cm
pr.lwb.damperbracket.holeradius = 1*scale/4;   %cm

% Pushrod
pr.pr.radius             = 1*scale;    %cm
pr.pr.length             = 30*scale;   %cm
pr.pr.bracket.length     = 4*scale;    %cm
pr.pr.bracket.width      = 4*scale;    %cm
pr.pr.bracket.thickness  = 1*scale;    %cm
pr.pr.bracket.holeradius = 0.75*scale/4; %cm
pr.pr.density            = density.aluminum; %kg/m^3
pr.pr.cylinder.color     = [0.9 0.7 0.2];
pr.pr.piston.color       = [0.55 0.35 0.17];

% Rocker
pr.rocker.armlength   = 10*scale;   %cm
pr.rocker.motionratio = 1*scale;
pr.rocker.thickness   = 3*scale;    %cm
pr.rocker.density     = density.steel; %kg/m^3
pr.rocker.color       = color.grey;

% Spring-Damper
pr.springdamp.k       = 200000*scale; %N/m
pr.springdamp.b       = 3000*scale;   %Ns/m
pr.springdamp.length0 = 15*scale;     %cm
pr.springdamp.density = density.aluminum;   %kg/m^3

pr.springdamp.cylinder.length      = 15*scale;  %cm
pr.springdamp.cylinder.innerradius = 2*scale;   %cm
pr.springdamp.cylinder.outerradius = 3*scale;   %cm
pr.springdamp.cylinder.color       = [0.9 0.7 0.2];
pr.springdamp.piston.length        = 10*scale;  %cm
pr.springdamp.piston.color         = [0.55 0.35 0.17];
pr.springdamp.chamferradius        = 0.3*scale; %cm

pr.springdamp.bracket.length     = 4*scale;    %cm
pr.springdamp.bracket.width      = 4*scale;    %cm
pr.springdamp.bracket.thickness  = 1*scale;    %cm
pr.springdamp.bracket.holeradius = 0.75*scale/4; %cm

% Chassis
pr.chassis.frame.pushrodoffset = 25*scale;  %cm
pr.chassis.frame.longlength    = 100*scale; %cm
pr.chassis.frame.shortlength   = 75*scale;  %cm
pr.chassis.frame.height        = 40*scale;  %cm
pr.chassis.frame.cornerradius  = 2*scale;   %cm
pr.chassis.frame.thickness     = 2*scale;   %cm
pr.chassis.frame.barthickness  = 5*scale;   %cm
pr.chassis.frame.density       = density.aluminum; %kg/m^3
pr.chassis.frame.color         = [255 140 0]/255;

pr.chassis.upperlink.length                 = 30*scale;   %cm
pr.chassis.upperlink.outerradius            = 1.5*scale;  %cm
pr.chassis.upperlink.innerradius            = 0.75*scale; %cm
pr.chassis.upperlink.wishboneslotlength     = 5.5*scale;  %cm
pr.chassis.upperlink.springdamperslotlength = 3*scale;    %cm
pr.chassis.upperlink.wishboneseparation     = 20.5*scale; %cm
pr.chassis.upperlink.wishboneoffset         = 0*scale;    %cm
pr.chassis.upperlink.chamferradius          = 0.2*scale;  %cm
pr.chassis.upperlink.density                = density.aluminum; %kg/m^3
pr.chassis.upperlink.color                  = [255 140 0]/255;

pr.chassis.lowerlink.length             = 30*scale;    %cm
pr.chassis.lowerlink.outerradius        = 1.5*scale;   %cm
pr.chassis.lowerlink.innerradius        = 0.75*scale;  %cm
pr.chassis.lowerlink.wishboneslotlength = 5.5*scale;   %cm
pr.chassis.lowerlink.wishboneseparation = 10.25*scale; %cm
pr.chassis.lowerlink.wishboneoffset     = 5.125*scale; %cm
pr.chassis.lowerlink.chamferradius      = 0.2*scale;   %cm
pr.chassis.lowerlink.density            = density.aluminum;  %kg/m^3
pr.chassis.lowerlink.color              = [255 140 0]/255;

pr.chassis.lowerlink2.length                 = 30*scale;    %cm
pr.chassis.lowerlink2.outerradius            = 1.5*scale;   %cm
pr.chassis.lowerlink2.innerradius            = 0.75*scale;  %cm
pr.chassis.lowerlink2.springdamperslotlength = 3*scale;     %cm
pr.chassis.lowerlink2.springdamperoffset     = 0*scale;     %cm
pr.chassis.lowerlink2.chamferradius          = 0.2*scale;   %cm
pr.chassis.lowerlink2.density                = density.aluminum;  %kg/m^3
pr.chassis.lowerlink2.color                  = [255 140 0]/255;

pr.chassis.steering.bracket.length        = 4*scale;    %cm
pr.chassis.steering.bracket.width         = 4*scale;    %cm
pr.chassis.steering.bracket.thickness     = 4*scale;    %cm
pr.chassis.steering.bracket.holelength    = 2*scale;    %cm
pr.chassis.steering.bracket.holewidth     = 2*scale;    %cm
pr.chassis.steering.bracket.chamferradius = 0.5*scale;  %cm
pr.chassis.steering.bracket.density       = density.aluminum; %kg/m^3
pr.chassis.steering.bracket.color         = [255 140 0]/255;

pr.chassis.steering.tierod.rod.length            = 16.5*scale; %cm
pr.chassis.steering.tierod.rod.radius            = 1.25*scale; %cm
pr.chassis.steering.tierod.rod.chamferradius     = 0.25*scale; %cm
pr.chassis.steering.tierod.bracket.length        = 3*scale;    %cm
pr.chassis.steering.tierod.bracket.width         = 2*scale;    %cm
pr.chassis.steering.tierod.bracket.thickness     = 0.5*scale;  %cm
pr.chassis.steering.tierod.bracket.flangespacing = 0.75*scale; %cm
pr.chassis.steering.tierod.bracket.socketradius  = 0.75*scale; %cm
pr.chassis.steering.tierod.bracket.ballradius    = 0.5*scale;  %cm
pr.chassis.steering.tierod.bracket.holeradius    = 0.3*scale/4;  %cm
pr.chassis.steering.tierod.density               = density.aluminum; %kg/m^3
pr.chassis.steering.tierod.rod.color             = [0.9 0.7 0.2];
pr.chassis.steering.tierod.ballcolor             = [0.3 0.2 0.0];

pr.chassis.steering.rack.rod.length          = 120*scale;  %cm
pr.chassis.steering.rack.rod.width           = 2*scale;    %cm
pr.chassis.steering.rack.rod.height          = 2*scale;    %cm
pr.chassis.steering.rack.rod.bracketdistance = 70*scale;   %cm
pr.chassis.steering.rack.rod.chamferradius   = 0.5*scale;  %cm
pr.chassis.steering.rack.bracket.length      = 4*scale;    %cm
pr.chassis.steering.rack.bracket.width       = 2*scale;    %cm
pr.chassis.steering.rack.bracket.thickness   = 0.5*scale;  %cm
pr.chassis.steering.rack.bracket.holeradius  = 0.5*scale/4;  %cm
pr.chassis.steering.rack.density             = density.aluminum; %kg/m^3
pr.chassis.steering.rack.color               = [0.3 0.2 0.0];