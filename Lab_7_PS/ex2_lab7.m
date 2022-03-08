%semnalul initial
load('notes_signal.mat')
plot(notes_signal)
N = length(notes_signal);
figure

fx1 = zeros(1, N);
fidx1 = (fs / N) *linspace(0,N-1,N);
spectrum = fft(notes_signal, N);
stem(fidx1, abs(spectrum));
figure



%inmultire semnale
s = zeros(1, N);
s = notes_signal .* transpose(hanning(N));
plot(s);
figure



%fft semnal rezultat
fx1 = zeros(1, N);
fidx1 = (fs / N) *linspace(0,N-1,N);
spectrum = fft(s, N);
stem(fidx1, abs(spectrum));