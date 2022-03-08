function ex1()
  f = [1, 2, 10, 20, 100];
  n = length(f);

  t = linspace(0, 1, 128);
  nt = length(t);

  y(1:n, 1:nt) = 0;

  for i = 1 : n
    y(i, 1:nt) = sin(2 * pi * f(i) * t);
  endfor

  y_out(1:n, 1:4) = 0;

  for i = 1 : n
    for j = 5:nt
      y_out(i, j) = sum([y(i, j-4:j)]) / 5;
    endfor
  endfor

  for i = 1 : n
    plot(t, y(i, 1:nt));
    hold on
    plot(t, y_out(i, 1:nt));
    figure
  endfor


endfunction
