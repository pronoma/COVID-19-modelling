clear all;
close all;
S0 = 1;
I0= 0.001;
R0 = 0;
t0 =0 ;
tf = 900;
tspan = t0:0.1:tf;

[T U] = ode45('SIR',tspan,[S0,I0,R0]);

plot(T,U)
title('spread of Covid-19 in absence of intervention ');
ylabel('Population');
xlabel('Number of days');
ylim([-0.1 1.1]);
legend('Susceptible','Infected','Recovered');
grid on;