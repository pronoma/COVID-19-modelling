function Z = SIR_intervention1(t,I)
beta = 0.0863;
gama = 0.0186;

dx(1) = - 0.7*beta*I(1)*I(2);
dx(2) = 0.7*beta*I(1)*I(2) - gama*I(2);
dx(3) = gama*I(2);
Z = [dx(1);dx(2);dx(3)];

end