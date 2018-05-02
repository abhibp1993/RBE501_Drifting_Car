function [vxl, vyl, phi, diff, delta] = look_up(turn, vx, vy, vx_local, vy_local, r1, lastphi, gamma, lastgamma, yr)
    v = (vx^2 + vy^2)^0.5;
    min = 999999999;
    for i = 1:81
        for j = 1:81
            v_local = (vx_local(j)^2  + vy_local(turn, i, j)^2)^0.5; %abs(v_local - v) ,abs(r1(turn, i, j)-lastphi)
            if abs(v_local - v) + abs((turn == 1)*gamma(i)) + abs(gamma(i)-lastgamma) + abs(r1(turn, i, j)-lastphi) < min && gamma(i)<=0 % && abs(r1(turn, i, j)-lastphi) > 0 && vx_local(j) > 0 %&& gamma(i)<=0
%             if abs(r1(turn, i, j)-yr) < min && abs(r1(turn, i, j)-lastphi) > 0 && vx_local(j) > 0
                min = abs(v_local - v) + abs(gamma(i)-lastgamma) + abs(r1(turn, i, j)-lastphi) + abs((turn == 1)*gamma(i)); % - lastphi
%                 min = abs(r1(turn, i, j)-yr);
                vxl = vx_local(j);
                vyl = vy_local(turn, i, j);
                phi = r1(turn, i, j);
                delta = gamma(i);
%                 while phi > pi/2
%                     phi = phi - pi/2;
%                 end
%                 abs(r1(turn, i, j)-yr)
            end
        end
    end
    diff = min;
end