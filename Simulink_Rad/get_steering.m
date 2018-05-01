%clear all
close all

load('steering_test.mat');


for i=1:length(simout.rot_R)
Rot_R2(:,:,i) =[simout.rot_R(1,2:3,i) 0;simout.rot_R(2,2:3,i) 0;0 0 1] ;
end 

for i=1:length(simout.rot_l)
Rot_L2(:,:,i) =[simout.rot_l(1,2:3,i) 0; simout.rot_l(2,2:3,i)  0;0 0 1] ;
end


eul = rotm2eul(Rot_R2);
eul = eul-pi()/2;

eul_L = rotm2eul(Rot_L2);
eul_L = eul_L+pi()/2;

% for i=1:length(eul_L)
% if eul_L(i,3)<0
%  eul_L(i,:) = eul_L(i,:)+pi();
% else
%     eul_L(i,:) = eul_L(i,:)-pi();
% end
%     
% 
% end

eul2 =rotm2eul(simout.rot_R);


%% Steering Constant
[c, beg]= min(abs(simout.tout-2.5));
[c, en] = min(abs(simout.tout-42.5));

avg=(-eul(beg:en,1)+(-eul_L(beg:en,1)))./2;
b = simout.steering_input(beg:en);
constant=-b\avg;

constant =avg./simout.steering_input(beg:en);

for i=length(constant):-1:1
    if(abs(constant(i))>1)
        constant(i)=[];
    end
end

t =[ simout.rot_l(1,2:3,1831) 0 ; simout.rot_l(2,2:3,1831) 0; 0 0 1];


%% Plot 
close all

figure()
plot(simout.tout.',eul(:,1).');
 %hold on
% plot(simout.tout.',eul2(:,1).');
%hold on
%plot(simout.tout.',simout.angle_r.'-pi()/2)
hold on
plot(simout.tout.',-simout.steering_input./10.')
legend('2drot_r','steering_input');
title('R angle')
grid('on')

figure()
plot(simout.tout.',eul_L(:,1).');
% hold on
% plot(simout.tout.',eul2(:,1).');
hold on
plot(simout.tout.',-simout.steering_input./10.')
legend('2drot_r','steering_input');
title('L angle')
grid('on')


figure()
plot(simout.steering_input(beg:en).',avg.');
xlabel('steering input [cm]')
ylabel('avgLandR steering output [rad]')
grid('on')

constant = ( avg(3500)-avg(3000))/(simout.steering_input(3500)-simout.steering_input(3000));
