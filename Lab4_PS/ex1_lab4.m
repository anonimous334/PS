T = 100;
A = 1;
t = 0 : T;
st = zeros(1,length(t));



for s = 1 : length(t)
if s < T / 2
st(s) = A;
else
st(s) = -A;
end
end



figure()
plot(t, st);
xlabel('T');
ylabel('signal');
ylim([-A - 1, A + 1]);



kmax = 81;
kmin = -kmax;
c = kmin : kmax;
ck = c;
for s = 1 : length(c)
if mod(s,2)
ck(s) = (A * 2) / (1j * pi * c(s));
else
ck(s) = 0;
end
end



figure();
stem(abs(ck));



ck2 = zeros(length(ck), 1);
for k = 1 : length(ck)
ck2(k) = ck(k) * exp((-1i * 2 * pi * c(k) * T/4) / T);
end
figure();
stem(abs(ck2));
rad2deg(angle(ck2))';




st_new = zeros(1, length(st));
for s = 1 : length(t)
for k = 1 : length(c)
st_new(s) = st_new(s) + ck(k) * exp((1i * 2 * pi * c(k) * s) / T);
end
end




st_new_2 = zeros(1, length(st));
for s = 1 : length(t)
for k = 1 : length(c)
st_new_2(s) = st_new_2(s) + ck2(k) * exp((1i * 2 * pi * c(k) * s) / T);
end
end



figure();
plot(t, real(st_new_2));