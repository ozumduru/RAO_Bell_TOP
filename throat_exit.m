function[x,y,throat_e_l,throat_e_h]=throat_exit(Rt,theta_N)

theta_N = theta_N * pi / 180;

throat_e_l = 0.382*Rt*sin(theta_N);
throat_e_h = 1.382*Rt - 0.382*Rt*cos(theta_N);

angles = linspace(3*pi/2 , 3*pi/2 + theta_N ,50);

Xc = throat_e_l;
Yc = 1.382*Rt;

x = 0.382*Rt*cos(angles) + Xc ;
y = 0.382*Rt*sin(angles) + Yc ;

end