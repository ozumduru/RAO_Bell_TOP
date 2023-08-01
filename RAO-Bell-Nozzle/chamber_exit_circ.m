function[x,y]=chamber_exit_circ(Rc,Rt,Lc,theta_t_i,step_count)

chamber_e_l = Lc;

angles = linspace(90, 90 - theta_t_i, step_count);

Xc = chamber_e_l;
Yc = Rc -1.5*Rt;

x = 1.5*Rt*cosd(angles) + Xc ;
y = 1.5*Rt*sind(angles) + Yc ;

end
