A1 = 3;
A2 = -3;

T = 100;
t1 = A1*ones(1, 50);
t2 = A2*ones(1, 50);
s = [t1, t2];
figure
plot(1:T, s);
ylim([A2 - 1, A1 + 1]);
title ("Semnal original");
xlabel ("timp");
ylabel ("Amplitudine");

k = [-3:3];
ck = zeros(1, length(k));

for i = 1:length(k)
  if (mod(i,2) == 1)
    ck(i) = 2*A1/(j*pi*k(i));
  else
    ck(i) = 0;
  endif
endfor

figure();

stem(abs(ck));

st_new = zeros(1, 100);



for i = 1 : T
for k = 1 : length(ck)
st_new(i) = st_new(i) + ck(k) * exp((1i * 2 * pi * ck(k) * i) / T);
end
end



figure();
plot(1:T, real(st_new));