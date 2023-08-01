function[x,y]=bell_curve(Rt,Re,theta_N,theta_e,Ln_ratio,step_count)

% bezler quadratic curve equation %

expansion_ratio = (Re/Rt)^2;

Nx = 0.382*Rt*cosd(theta_N - 90);
Ny = 1.382*Rt + 0.382*Rt*sind(theta_N - 90) ;

Ex = Ln_ratio*( (sqrt(expansion_ratio) -1)*Rt + 1.5*Rt*(secd(15) -1))/tand(15) ; % Ln
Ey = Re;

m1 = tand(theta_N);
m2 = tand(theta_e);

C1 = Ny - m1*Nx;
C2 = Ey - m2*Ex;

Qx = (C2 - C1)/(m1-m2);
Qy = (m1*C2 -m2*C1)/(m1-m2);

x = zeros(1,step_count);
y = zeros(1,step_count);
i=1;

for t = linspace(0,1,step_count)

x(i) = (1-t)^2*Nx + 2*(1-t)*t*Qx + t^2*Ex ;
y(i) = (1-t)^2*Ny + 2*(1-t)*t*Qy + t^2*Ey ;

i=i+1;

end
end
