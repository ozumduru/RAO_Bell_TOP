function[x,y]=bell_curve(Rt,Re,theta_N,theta_e,step_num,Ln_ratio)

% bezler quadratic curve equation %

theta_N= theta_N * pi/180 ;
theta_e= theta_e * pi/180 ;

expansion_ratio = (Re/Rt)^2;

Nx = 0.382*Rt*cos(theta_N - pi/2);
Ny = 1.382*Rt + 0.382*Rt*sin(theta_N - pi/2) ;

Ex = Ln_ratio*( (sqrt(expansion_ratio) -1)*Rt + 1.5*Rt*(sec(pi/12) -1))/tan(pi/12) ;
Ey = Re;

m1 = tan(theta_N);
m2 = tan(theta_e);

C1 = Ny - m1*Nx;
C2 = Ey - m2*Ex;

Qx = (C2 - C1)/(m1-m2);
Qy = (m1*C2 -m2*C1)/(m1-m2);

x = zeros(1,step_num);
y = zeros(1,step_num);
i=1;

for t = linspace(0,1,step_num)

x(i) = (1-t)^2*Nx + 2*(1-t)*t*Qx + t^2*Ex ;
y(i) = (1-t)^2*Ny + 2*(1-t)*t*Qy + t^2*Ey ;

i=i+1;

end
end