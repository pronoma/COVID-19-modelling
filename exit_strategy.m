clear all;
close all;
S0 = 1;
I0= 0.001;
R0 = 0;
t0 =0 ;
tf = 210;
hf = 900;
tspan = t0:0.1:tf;

hspan = tf:0.1:hf;

[T I] = ode45('SIR_intervention1',tspan,[S0,I0,R0]);
[T1 U] = ode45('SIR',hspan,[S0,0.3031,R0]);

plot(T,I(:,2),'b',T1,U(:,2),'r')
title('Exit Strategy Plot');
ylabel('Infected Population(fraction)');
xlabel('Number of days');
ylim([-0.05 1]);
legend('30% contact reduction','no contact reduction');
grid on;
