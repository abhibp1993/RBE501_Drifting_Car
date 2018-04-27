
%clear all

Binit=10.43;
Cinit=1.337;
Dinit=1376;

start=2000;
en = 8000;

fun = @(z) rear_ident(z,S(1).V_Ravg(1,start:en),S(1).steer_ang(start:en),S(1).V_Ravg(2,start:en),S(1).yaw_rate(start:en),[0.5 0.5]);
[vars, Fin]=fmincon(fun,[Binit,Cinit,Dinit]);

