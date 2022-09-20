function [x,y]=rocket_engine(Rc,Rt,Re, ...
                             theta_t_i,theta_N,theta_e,Ln_ratio,Lc, ...
                             step_count_c,step_count_c_e,step_count_ce_ti, ...
                             step_count_t_i,step_count_t_e,step_count_nozzle)

% chamber section %

[x_c,y_c]=chamber(Rc,step_count_c,Lc);

% chamber exit section %

[x_c_e,y_c_e]=chamber_exit_circ(Rc,Rt,Lc,theta_t_i,step_count_c_e);
x_c_e = x_c_e + x_c(end) - x_c_e(1);


% throat inlet section %

[x_t_i,y_t_i]=throat_inlet(Rt,theta_t_i,step_count_t_i);

% chamber exit to throat inlet line % 

y_ce_ti = linspace(y_c_e(end),y_t_i(1),step_count_ce_ti);
x_ce_ti = tand(90 + theta_t_i)*y_ce_ti;

x_ce_ti = x_ce_ti + x_c_e(end) - x_ce_ti(1);
x_t_i = x_t_i + x_ce_ti(end) - x_t_i(1);

% throat exit section %

[x_t_e,y_t_e]=throat_exit(Rt,theta_N,step_count_t_e);
x_t_e = x_t_e + x_t_i(end) - x_t_e(1);

% bell section %

[x_bell,y_bell]=bell_curve(Rt,Re,theta_N,theta_e,Ln_ratio,step_count_nozzle);

x_bell = x_bell + x_t_e(end) - x_bell(1);


% plot %
x = [x_c x_c_e x_ce_ti x_t_i x_t_e x_bell];
y = [y_c y_c_e y_ce_ti y_t_i y_t_e y_bell];
y_low = -y;


plot(x,y)
hold on
plot(x,y_low)

daspect([1 1 1])

xlim([-5 x(end)+5])
ylim([-Re-10 Re+10])

figure;

end
