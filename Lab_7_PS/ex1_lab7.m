#semnalul initial
A1 = 1;
A2 = 0.5;
fs = 8000;
f1 = 0;
f2 = 2000;
ft = 1 / fs;
N = 8;
k2 = [0:7];
K = 64;



s1 = zeros(1, N);
s2 = zeros(1, N);
s = zeros(1, N);


for n = 1: N
  s1(n) = A1 * sin(2 * pi * f1 * k2(n) * ft);
endfor

for n = 1: N
  s2(n) = A2 * sin(2 * pi * f2 * k2(n) * ft);
endfor

for n = 1: N
  s(n) = s1(n) + s2(n);
endfor

plot(s);
figure

#fft
fx1 = zeros(1, N);
fidx1 = (fs / N) * linspace(0,N-1,N);
spectrum2 = fft(s, N);
stem(fidx1, abs(spectrum2));
figure

#add 0 + fft
s_prim = zeros(1, K);
for i = 1 : N
  s_prim(i) = s(i);
endfor

fx1 = zeros(1, K);
fidx1 = (fs / K) * linspace(0,K-1,K);
spectrum2 = fft(s_prim, K);
stem(fidx1, abs(spectrum2));