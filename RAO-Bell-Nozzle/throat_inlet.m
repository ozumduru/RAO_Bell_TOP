function [x,y]=throat_inlet(Rt,theta_t_i,step_count)

throat_i_l = 1.5*Rt*sind(theta_t_i);

angles = linspace(270 - theta_t_i, 270, step_count);

Xc = throat_i_l;
Yc = 2.5*Rt;

x = 1.5*Rt*cosd(angles) + Xc ;
y = 1.5*Rt*sind(angles) + Yc ;

end
