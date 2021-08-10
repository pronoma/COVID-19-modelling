clc;
clear;
close all;


%Getting raw data from the website
url='http://api.covid19india.org/csv/latest/state_wise_daily.csv';
raw=webread(url);

%% Creating confirmed and recovered arrays which will contain the infected
%% and recovered cumulative data respectively
j=1;
%Initialising the GJ column with the first row containing initial confirmed
%case
i=1;
%Initialising the GJ column with second-row containing initial recovered
%case
k=2;
confirmed (j) =0;
recovered (j) =0;
while (i<361)
    confirmed (j+1) =confirmed(j)+raw.GJ(i);
    recovered (j+1) =recovered(j)+raw.GJ(k);
    j=j+1;
    i=i+3;
    k=k+3;
end



%% Finding constants beta and Gamma from the data
 
%N is the assumed exposed population in Gujarat
N=60000000;
%"d" is the unique dates frm the raw data
d= 0:120;
%Creating infected and recovered arrays from "confirmed" and "recovered"
%arrays respectively
infected= confirmed(1:end)';
recovered= recovered(1:end)';
%Since N=suspectable+infected+recovered
susceptible= (N-infected-recovered);
%The step size is one day
dt=1;
 
for i=1:(length(susceptible)-1)
    b(i)=(susceptible(i)-susceptible(i+1))/(susceptible(i).*infected(i)*dt);
end
 
for i=1:(length(susceptible)-1)
    g(i) =(recovered(i+1)-recovered(i))/( infected(i)*dt ) ;
end
 
%Take the final value of b and g arrays as beta and gamma respectively
gamma=g(end);
beta=b(end);

%% Using the calculated "beta" and "gamma" we will predict future cases
%Susceptible, Infected and Recovered using SIR Model
 
%Initialising Sucseptable, Infected, and Recovered arrays with last date
%values in the raw data respectively
susc=[susceptible(end) inf];
infec=[infected(end) inf];
rec=[recovered(end) inf];
%The first date of prediction will be equal to last date of actual data
d1=120;
%Specify the last date of prediction
d2=1800;
d_interval=d1:d2;
 
%Finding Susceptible, Infected, and Recovered array elements starting from
%d1 to in "d2" variable using SIR Model
for i=1:length(d_interval)-1
    
    susc(i+1)=(susc(i)-((beta)*susc(i).*infec(i)*dt));
    infec(i+1)=(infec(i) +(((beta)*susc(i).*infec(i))-((gamma).*infec(i))) *dt);
    rec(i+1) =(rec(i) +(((gamma).*infec(i))*dt));
    
end
%Rounding the values
calculated_susceptible=round(susc');
calculated_infected=round(infec');
calculated_recovered=round(rec');





%% 
%Plotting the predicted data along with the actual data
 figure(2);
 hold on;
 plot(d(:),susceptible,d_interval,calculated_susceptible,'--b');
 plot(d(:),infected,d_interval,calculated_infected,'--r');
 plot(d(:),recovered,d_interval,calculated_recovered,'--g');
 ylim([-5000000 62000000]);
  
 title('Predicted Data (GUJ)');
 xlabel('Number of days');
 ylabel('Population');
 legend('Actual Suceptible','Predicted Future Susceptible','Actual Infected','Predicted Future Infected','Actual Recovered','Predicted Future Recovered','FontSize',8,'Location', 'Best');
 grid on;
