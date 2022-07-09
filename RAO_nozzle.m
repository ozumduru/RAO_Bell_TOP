function [x,y_up]=RAO_nozzle(Rt,Re,theta_t_i,theta_N,theta_e,step_num,Ln_ratio)

% throat inlet section %

[x_t_i,y_t_i,~,~]=throat_inlet(Rt,theta_t_i);

% throat exit section %

[x_t_e,y_t_e,~,~]=throat_exit(Rt,theta_N);
x_t_e = x_t_e + x_t_i(50) - x_t_e(1);

% bell section %

[x_bell,y_bell]=bell_curve(Rt,Re,theta_N,theta_e,step_num,Ln_ratio);

x_bell = x_bell + x_t_e(50) - x_bell(1);


% plot %
x = [x_t_i x_t_e x_bell];
y_up = [y_t_i y_t_e y_bell];
y_low = -y_up;



plot(x,y_up)
hold on
plot(x,y_low)
hold on
xlim([-5 x(100 + step_num)])
ylim([-Re-10 Re+10])

end