clc
clear
close all

Rt = 25; % [mm]
Re = 75; % [mm]

theta_t_i = 30; %[deg]
theta_N = 30; %[deg]
theta_e = 7; %[deg]

step_num = 20; 
Ln_ratio = 0.8; % Ratio of conical nozzle 

[x,y_up]=RAO_nozzle(Rt,Re,theta_t_i,theta_N,theta_e,step_num,Ln_ratio);

