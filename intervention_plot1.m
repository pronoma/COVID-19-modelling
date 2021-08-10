clear all;
close all;
S0 = 1;
I0= 0.001;
R0 = 0;
t0 =0 ;
tf = 900;
tspan = t0:0.1:tf;

[T I] = ode45('SIR_intervention1',tspan,[S0,I0,R0]);
[T U] = ode45('SIR',tspan,[S0,I0,R0]);
[T H] = ode45('SIR_intervention2',tspan,[S0,I0,R0]);

plot(T,U(:,2),'b',T,I(:,2),'r',T,H(:,2),'g')
title('Intervention Plot');
ylabel('Infected Population(fraction)');
xlabel('Number of days');
ylim([-0.05 0.5]);
legend('No Intervention','30% contact reduction','60% contact reduction');
grid on;
