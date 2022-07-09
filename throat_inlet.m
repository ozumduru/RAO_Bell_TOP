function [x,y,throat_i_l,throat_i_h]=throat_inlet(Rt,theta_t_i)

theta_t_i = theta_t_i * pi /180;

throat_i_l = 1.5*Rt*sin(theta_t_i);
throat_i_h = 2.5*Rt - 1.5*Rt*cos(theta_t_i);

angles = linspace(3*pi/2 - theta_t_i ,3*pi/2,50);

Xc = throat_i_l;
Yc = 2.5*Rt;

x = 1.5*Rt*cos(angles) + Xc ;
y = 1.5*Rt*sin(angles) + Yc ;

end