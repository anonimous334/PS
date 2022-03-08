function ex2()
  N = 64;
  ft = 3000;
  B = 1000;
  fs = 2500;
  ##fs = ft + B/2;

  t = [0:1/fs:100/fs];
  x1 = sin(2 * pi * ft *t);

  fx = zeros(1, N);
  fidx = (fs/N) * linspace(0,N-1,N);
  spectrum = fft(x1, N);
  stem(fidx, abs(spectrum));
  xlabel('Frequency (Hz)');
  ylabel('Amplitude');
  title('Spectrum of x1');

  figure;
  fidx = (fs/N)*linspace(-N/2, N/2-1, N);
  stem(fidx, abs(fftshift(spectrum)));
  xlabel('Frequency (Hz)');
  ylabel('Amplitude');
  title('Zero-centred frequency spectrum of x1');
endfunction
