function [steer]=get_steer2(rotw,rot_R,rot_l)

for i=1:length(rot_R)
Rot_R2(:,:,i) =rotw(:,:,i).'*rot_R(:,:,i);
eul(i) = tan(Rot_R2(1,2,i)/Rot_R2(3,2,i));
end 

for i=1:length(rot_l)
Rot_L2(:,:,i) =rotw(:,:,i).'*rot_l(:,:,i);
eul_L(i) = tan(-Rot_L2(1,2,i)/-Rot_L2(3,2,i));
end


steer(:)=(eul(:)+(eul_L(:)))./2;

%b = simout.steering_input(beg:en);
%constant=-b\avg;



end