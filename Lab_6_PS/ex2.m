function fs=ex2()
  close all
  
  S = load('noisy_sound.mat');
  s = S.noisy_sound;
  fs = S.fs;
  
  N = length(s);
  t = linspace(0,1,N);
  
  figure 1
  plot(t,s);
  
  s_fft = fft(s);
  
  figure 2
  stem(abs(s_fft));
  
  K = zeros(1, 500);
  for i = 1:500
    K(i) = i * N / fs; 
  endfor
  
  s_fft_z = zeros(1, N);

  for i = 1 : 1500
    s_fft_z(i) = s_fft(i);
  endfor
  
  NN = N - 1500;
  for i = 1 : 1500
    s_fft_z(NN + i) = s_fft(NN + i);
  endfor
 
  
  figure 3
  stem(abs(s_fft_z));
  s_ifft = ifft(s_fft_z);
  plot(t,s_ifft)
  sound(s_ifft);