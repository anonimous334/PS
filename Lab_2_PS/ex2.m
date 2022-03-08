N = 200;
T = 100;
t = [1: 200];

x1 = ramp(N);
x2 = [zeros(1,T), x1(1:N-T)];
x3 = unit_unit(N);
x4 = T*[zeros(1,T), x3(1:N-T)];

s = x1 - x2 - x4;

figure;

plot(t,x1);
hold on;

plot(t,x2);
hold on;

plot(t,x4);
hold on;

plot(t,s);