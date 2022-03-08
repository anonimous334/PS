
T = 100;
D = T/5;
A = 1;
delta = D;
t = [1:T];
s = [A*ones(1,D), zeros(1, T-D)];


figure
plot(t,s)
ylim([-A-1; A+1])
title("Semnal puls")

k = [0 : 30];

for i = 1 : length(k)
ck(i) = A * exp((-j / T) * pi * k(i) * delta) * (delta / T) * sinc(k(i) * delta / T);
end

figure
stem(abs(ck))
