function [Ln,Ln_t_i]=nozzle_lenght(Rc,Rt)

expansion_ratio = Ae/At;

Ln = 0.8*( (sqrt(expansion_ratio) -1)*Rt + 1.5*Rt*(sec(pi/12) -1))/tan(pi/12);

Ln_t_i = sqrt((1.5*Rt)^2 - (2.5*Rt - Rc)^2);
end