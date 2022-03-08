
load('noisy_signal1.mat');
N = 128;
fs = 128;

# dft
signal = zeros(1, N);
k = N;
c = 0 : k - 1;

for i = 1 : N
  for l = 1 : N
    signal(l) += noisy_signal(i) * exp(-j * 2 * pi * c(i) * (l - 1)/k);
  endfor
endfor

figure();
stem(abs(signal));

# fft
figure();
signal_fft = fft(noisy_signal, N);
stem(abs(signal_fft));

signal_fftshift = fftshift(signal_fft);
figure();
stem(abs(signal_fftshift));

nn = 10;
signal_pw = 0;
noise_pw = 0;

for i = 1 : nn
  signal_pw += abs(signal_fft(i)) * abs(signal_fft(i));
endfor

for i = 120 : N
  signal_pw += abs(signal_fft(i)) * abs(signal_fft(i));
endfor

signal_pw = 1/19 * signal_pw;

for i = 1 : N
  noise_pw += abs(signal_fft(i)) * abs(signal_fft(i));
endfor

noise_pw = 1/N * noise_pw;

SNR = signal_pw / noise_pw
db_SNR = 10 * log10(SNR);

for i = 11 : 119
signal(i) = 0;
endfor

t = linspace(0, 1, N);
iDFT = zeros(1, N);
for i = 1 : N
  for l = 1: N
    iDFT(l) += signal_fft(i) * exp(1j * 2* pi * c(i) * (l - 1) / k);
  endfor
endfor

iDFT = iDFT / k;

figure();
plot(t, iDFT);

signal_ifft = ifft(signal, N);
figure();
plot(t, signal_ifft);