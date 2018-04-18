function [steer]=get_steer(rot_R,rot_l)

for i=1:length(rot_R)
Rot_R2(:,:,i) =[rot_R(1,2:3,i) 0;rot_R(2,2:3,i) 0;0 0 1] ;
end 

for i=1:length(rot_l)
Rot_L2(:,:,i) =[rot_l(1,2:3,i) 0; rot_l(2,2:3,i)  0;0 0 1] ;
end

eul = rotm2eul(Rot_R2);
eul = eul-pi()/2;

eul_L = rotm2eul(Rot_L2);
eul_L = eul_L+pi()/2;

steer=(-eul(:,1)+(-eul_L(:,1)))./2;

%b = simout.steering_input(beg:en);
%constant=-b\avg;



end