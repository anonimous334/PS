function ex3()
  fa  = 1;
  N_analog = 5000;
  t = linspace(0, 5, N_analog);
  y = sin(2 * pi * t);

  plot(t, y);

  div_factor = 10;
  N_digital = N_analog / div_factor;
    figure;
  samples_digital(1:N_analog) = 0;

  for i = 1 : N_digital
    samples_digital(i * div_factor) = y(i * div_factor);
  endfor

  hold on;
  plot(t, samples_digital);
  figure

  N_sinc = N_analog;
  t_sinc = linspace(-2 *  fa, 2 * fa, N_sinc/10);
  sincvec = sinc(N_digital*t_sinc);
  s_cont_filtered = conv(samples_digital, sincvec);

  plot(s_cont_filtered);

endfunction
