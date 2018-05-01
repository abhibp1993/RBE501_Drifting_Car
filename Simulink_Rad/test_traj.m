clear all
close all 

load('constant.mat')
load('traj_8.mat')

ft_delta_c = ft_delta/-constant;
steer1 = timeseries(ft_delta_c,ut);

ft_vx_c = ft_vx*3.6;

vel1 = timeseries(ft_vx_c,ut);
 
vy_des = timeseries(ft_vy,ut);


run('VehicleDynamicsInitialization.m');
limit = 50;
Stoptime=max(ut);
%Stoptime=10;
simout=sim('VehicleDynamics3D_traj.slx');

%% 
figure()
%title('')
subplot(3,1,1)
plot(ut,ft_vy,simout.tout,simout.vy)
legend('Desired v_y','Actual v_y')
ylabel('v_y [m/s]')
%title('car frame')

% figure()
% plot(ut,pts(2,:),simout.tout,simout.y+2.2345)
% legend('Desired','y')
% title('')

subplot(3,1,2)
plot(ut,ft_vx_c/3.6,simout.tout,simout.vx)
legend('Desired v_x','Actual v_x')
ylabel('v_x [m/s]')
%title('velocities')

subplot(3,1,3)
plot(ut,ft_delta_c,simout.tout,simout.steer_outpid)
legend('Desired Steering','Actual Steering')
xlabel('Time [s]')
ylabel('Steer [cm]')
%title('velocities')

figure()
plot(pts(1,:),pts(2,:)+40)
hold on
xlim([-10,100])
plot(simout.x-0.3,simout.y+2.2345)
hold off
title('Position xy Plot Results')
legend('Desired', 'Actual')
xlabel('[m]')
ylabel('[m]')
grid('on')



