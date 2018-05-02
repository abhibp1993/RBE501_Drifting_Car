function [vxl, vyl, phi, diff, delta] = look_up(turn, vx, vy, vx_local, vy_local, r1, lastphi, gamma, lastgamma, yr)
    v = (vx^2 + vy^2)^0.5;
    min = 999999999;
    for i = 1:81
        for j = 1:81
            v_local = (vx_local(j)^2  + vy_local(turn, i, j)^2)^0.5; 
            if abs(v_local - v) + abs((turn == 1)*gamma(i)) < min && gamma(i)<=0 && r1(turn, i, j) <= 0 && vy_local(turn, i, j) >= 0                
                min = abs(v_local - v) + abs((turn == 1)*gamma(i)); 
                vxl = vx_local(j);
                vyl = vy_local(turn, i, j);
                phi = r1(turn, i, j);
                delta = gamma(i);

            end
        end
    end
    diff = min;
end