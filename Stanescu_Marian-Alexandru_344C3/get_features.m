function [filters, feat_train] = get_features(audio_train, fs, plot_figs);

  size = floor(25 * fs / 1000);
  M = 12;
  h= zeros(M,size);
  fc = get_equal_bark_freqs(M,fs);
  
  for i = 1 : M
    
    h(i,:) = gammatone_filter(size, fc(i), fs);
  
  endfor
  
  if (plot_figs == true)
    
    x = gammatone_filter(size, 1000, fs);
    plot(1:size, x);
    figure;
    for i = 1 : M
      
      hold on;
      c = fft(h(i, :));
      c = c(1 : size / 2);
      plot(linspace(0, (size / 2) - 1, size / 2) * (fs / size), abs(c));
      
    endfor
    
  endif
  
  filters = h;
  
endfunction