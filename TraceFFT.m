function TraceFFT(t, y)
    dt = t(2) - t(1);
    fs = 1./dt;
%     fe = 3 * fs;
%     f = linspace(-fe/2, fe/2, length(t));
    n = numel(y);
    f = fs*(-n/2:(n/2-1))/n;
    stem(f, abs(fftshift(fft(y))));
    title("Transformée de Fourier du signal");
    xlabel("Fréquence en Hertz");
    ylabel("Amplitude");
end