function Z = SIR(t,U)
beta = 0.0863;
gama = 0.0186;

dx(1) = - beta*U(1)*U(2);
dx(2) = beta*U(1)*U(2) - gama*U(2);
dx(3) = gama*U(2);
Z = [dx(1);dx(2);dx(3)];

end