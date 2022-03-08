N = 20;
x = 60*ones(1,N);
y = zeros(1,N);
y(1) = 7;
figure
plot(y)
hold on;
for i=1:N-1
  e = x(i) - y(i);
  if (e == 0)
    y(i+1) = y(i);
  endif
  
  if (e > 0 && e <= 10)
    y(i+1) = y(i)+1;
  endif
  
  if (e > 10)
    y(i+1) = y(i)+10;
  endif
  plot(y);
  hold on;
end
