clear all

% syms x y z
% eqn1 = 2*x + y + z == 2;
% eqn2 = -x + y - z == 3;
% eqn3 = x + 2*y + 3*z == -10;
% 
% sol = solve([eqn1, eqn2, eqn3], [x, y, z]);

[f1, f2] = lateral();

function [eqn, eqn2]=lateral()
syms x y z
eqn = z==x+y;

if(z>1)
   eqn2 = x*y==0; 
else
    eqn2 = x+y==0;
end

end