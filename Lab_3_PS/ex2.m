T = 100;
A = 1;
t = 0 : 1 : T;
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



kmax = 500;
kmin = 0;
c = kmin : kmax;
ck = c;



for s = 1 : length(c)
if mod(s,2)
ck(s) = (A * 2) / (1j * pi * c(s));
else
ck(s) = 0;
end
end



for i = 1 : length(c)
ck(s) = ck(s) * ck(s);
end



figure();



stem(abs(ck));



N = 500;
sq= ck(1) * ck(1);
for n = 1:N
  e(n-1) = sqrt(ck(n) - (2 * ck(n) + sq));
end

for i=1:N
  if (e(i) < 0.05)
    i
  endif
end
plot(t, e)

