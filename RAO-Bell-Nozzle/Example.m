clc
clear
close all
Rc = 71; % [mm]
Rt = 35.5; % [mm]
Re = 65; % [mm]

Lc = 100; % [mm]
Ln_ratio = 0.8; % Ratio of conical nozzle 

theta_t_i = 30; %[deg]
theta_N = 30; %[deg]
theta_e = 7; %[deg]


step_count_c = 10;
step_count_c_e = 20;
step_count_ce_ti = 30;
step_count_t_i = 40; 
step_count_t_e = 50; 
step_count_nozzle = 60; 


[x,y]=rocket_engine(Rc,Rt,Re, ...
                    theta_t_i,theta_N,theta_e,Ln_ratio,Lc, ...
                    step_count_c,step_count_c_e,step_count_ce_ti, ...
                    step_count_t_i,step_count_t_e,step_count_nozzle);
