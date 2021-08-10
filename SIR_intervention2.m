function Z = SIR_intervention2(t,H)
beta = 0.0863;
gama = 0.0186;

dx(1) = - 0.4*beta*H(1)*H(2);
dx(2) = 0.4*beta*H(1)*H(2) - gama*H(2);
dx(3) = gama*H(2);
Z = [dx(1);dx(2);dx(3)];

end