function[x,y]=throat_exit(Rt,theta_N,step_count)

throat_e_l = 0.382*Rt*sind(theta_N);

angles = linspace(270 , 270 + theta_N ,step_count);

Xc = throat_e_l;
Yc = 1.382*Rt;

x = 0.382*Rt*cosd(angles) + Xc ;
y = 0.382*Rt*sind(angles) + Yc ;

end
