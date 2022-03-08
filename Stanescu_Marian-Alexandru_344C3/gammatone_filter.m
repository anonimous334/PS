function h = gammatone_filter(size, fc, fs);
  a = fc.^2.5;
  b = 1.019 * 24.7 * (4.37 * fc / 1000 + 1);
  h = zeros(1, size);
  
  for n = 1 : size
    
    h(n) = a * (n / fs).^3 * exp(-2 * pi * b * (n / fs)) * cos(2 * pi * fc * (n / fs)); % n / fs = t
    %disp(h(n));
  endfor
endfunction