f1 = 1600;
f2 = 1800;

T = 1/200;

t = [0: T/100: T];
y1 = sin(2*pi*f1*t);
y2 = sin(2*pi*f2*t);

y = y1+y2;
figure;
plot(t,y);
hold on;
plot(t,y1);
hold on;
plot(t,y2);