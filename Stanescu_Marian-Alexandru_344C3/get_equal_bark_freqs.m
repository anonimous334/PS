function freqs = get_equal_bark_freqs(M,fs);
  
  sfq = 0;
  efq = fs/2;
  
  sfqbrk = 6*asinh(sfq/600);
  efbrk = 6*asinh(efq/600);
  
  brk = linspace(sfqbrk, efbrk, M+1);
   
  freqs = 600 * sinh(brk / 6);
   
  
endfunction