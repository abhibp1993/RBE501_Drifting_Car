%% NURBS Trajectory Planning

clear all, close all, clc

load('lookup_clean.mat');

%% Parameter definitions

% Distance from COM to Rear wheel
LF = 1.0345;
LR = 0.7500; 

% Nurbs parameters
POLY_ORDER = 5;
SCALE = 5;
UMIN = 0.0;
UMAX = 15;
SAMPLES = 1000; 

% Parameter Vector - u
ut = linspace(UMIN, UMAX, SAMPLES);
dt = (UMAX - UMIN) / SAMPLES;


%% Define NURBS trajectory

% Define the NURBS control points
nurbs_pts = [0.0, -8.0;
             0.0, -8.0;
             0.0, -8.0;
             0.0, -7.5;
             0.0, -6.5;
             0.0, -5.0;
             0.0, -3.0;
             0.0, 0.0;
             0.0, 2.0;
             1.0, 4.0;
             2.5, 5.0;
             4.0, 4.0;
             5.0, 2.0;
             5.0, 0.0;
             5.0, 0.0;
             5.0, 0.0]';

% nurbs_pts = [0.0, 0.0;
%              0.0, 0.0;
%              0.0, 0.0;
%              0.0, 0.0;
%              1.0, 0.0;
%              2.5, 0.0;
%              4.0, 0.0;
%              5.0, 0.0;
%              5.0, 0.0;
%              5.0, 0.0;
%              5.0, 0.0]';
         
nurbs_pts(1, :) = nurbs_pts(1, :) * 2 * SCALE;
nurbs_pts(2, :) = nurbs_pts(2, :) * SCALE;

% Define knots
[~, num_mid_knots] = size(nurbs_pts);
num_mid_knots = num_mid_knots - POLY_ORDER + 2;     % +2 is to add UMIN, UMAX as well.
knots = [repmat(UMIN, [1, POLY_ORDER - 1]), linspace(UMIN, UMAX, num_mid_knots), repmat(UMAX, [1, POLY_ORDER - 1])];  % 3-rd order polynomial NURBS

% Create NURBS structure
crv = nrbmak(nurbs_pts, knots); 

% Compute derivatives of NURBS
[dcrv, ddcrv] = nrbderiv(crv); 

% Evaluate NURBS trajectory
[pts, dpts, ddpts] = nrbdeval(crv, dcrv, ddcrv, ut);

p2 = vecnorm(dpts);
% Plot trajectory
figure(1),
plot([-2, pts(1, :)], [-40, pts(2, :)]), title('Position XY plot')
hold on
plot(nurbs_pts(1,:), nurbs_pts(2,:))
hold on
plot(nurbs_pts(1,:), nurbs_pts(2,:),'ro')
hold on
h = quiver(pts(1,1:100:end),pts(2,1:100:end),p2(1,1:100:end),p2(2,1:100:end),0); 
set(h,'Color','black'); 
set(h,'MaxHeadSize',1);
set(h,'LineWidth',2);
set(h,'AutoScaleFactor',1);
hold off;
% subplot(311), plot(pts(1, :), pts(2, :)), title('Position XY plot')
% subplot(312), plot(dpts(1, :), dpts(2, :)), title('Velocity XY plot')
% subplot(313), plot(ddpts(1, :), ddpts(2, :)), title('Acceleration XY plot')

figure(2),
subplot(311), plot(ut, pts(1, :), 'r', ut, pts(2, :), 'b'), title('Pos vs. Time plot'), legend('X-Pos','Y-Pos')
subplot(312), plot(ut, dpts(1, :), 'r', ut, dpts(2, :), 'b'), title('Vel vs. Time plot'), legend('X-Vel','Y-Vel')
subplot(313), plot(ut, ddpts(1, :), 'r', ut, ddpts(2, :), 'b'), title('Acc vs. Time plot'), legend('X-Acc','Y-Acc')


%% Computing alpha_r

phi = [pi/2];  % yaw rate
kappa = [];  % 1/radius of curvature
delta = [0]; % steering angle
vx_l = []; % local vx
vy_l = []; % local vy
u_ref = [];
delta_ref = [];
fun_delta_out = [];
fun_u_out = [];
diff = [];
Rd = [0];
yaw_rate = [pi/2]; % yaw_rate

Br = 10.43;
Cr = 1.337;
Dr = 1336;

Bf = 10.43;
Cf = 1.337;
Df = 1336;
m = 200;
I = 79;

t0 = 1; % initial time

% solve for all sample times
for t = t0:SAMPLES
    
    x = pts(1, t); y = pts(2, t);
    vx = dpts(1, t); vy = dpts(2, t);
    ax = ddpts(1, t); ay = ddpts(2, t);
    
    if t == t0
        phi(t) = 0;
        delta(t) = 0;
        vxl = 0;
        vyl = 0;
    else
        k = ((vx * ay - ax * vy) / (vx^2 + vy^2)^(3/2));
        yaw_rate(t) = k*(vx^2+vy^2)^(1/2);
        if t == 1000
            yaw_rate(t) = yaw_rate(t-1);
        end
        % search for lookup table in simple constrained linear programming 
        if x == 0
            [vxl, vyl, phi(t), diff(t), delta(t)] = look_up(1, vx, vy, vx_local, vy_local, r1, phi(t-1), gamma, delta(t-1));
        else
            [vxl, vyl, phi(t), diff(t), delta(t)] = look_up(2, vx, vy, vx_local, vy_local, r1, phi(t-1), gamma, delta(t-1));
        end
    end

    if t > t0
        phi_t = phi(t) + pi/2;
    else
        phi_t = phi(t);
    end
    
    invR = [cos(phi(t)) , sin(phi(t)); 
            -sin(phi(t)), cos(phi(t))];
    
    axl = cos(phi_t) * ax + sin(phi_t) * ay;
    ayl = -sin(phi_t) * ax + cos(phi_t) * ay;
    
    kappa(t) = ((vxl * ayl - axl * vyl) / (vxl^2 + vyl^2)^(3/2));
    alpha_r(t) = atan(kappa(t) * LR - (vyl / vxl));
    
    vx_l(t) = vxl;
    vy_l(t) = vyl;

end

figure(3), 
subplot(211), plot(ut, abs(kappa)), title('Kappa'), hold on
subplot(212), plot(ut, (alpha_r)), title('alpha_r')

% filtering the result
windowSize = 100;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
ft_delta = filter(b, a, delta);
ft_phi = filter(b, a, phi);
ft_vx = filter(b, a, vx_l);
ft_vy = filter(b, a, vy_l);

figure(4),
subplot(311), plot(ut, dpts(1, :), 'r', ut, dpts(2, :), 'b'), title('Global Frame Vel vs. Time plot'), legend('X-Vel','Y-Vel')
subplot(312), plot(ut, ft_vx, 'r', ut, ft_vy, 'b'), title('Local Frame Vel vs. Time plot'), legend('X-Vel','Y-Vel')
subplot(313), plot(ut, ft_delta, 'r'), title('Steering vs. Time plot'), %legend('X-Vel','Y-Vel')

figure(5),
plot(ut, ft_phi), title('phi vs. Time plot')



