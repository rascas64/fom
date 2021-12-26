clear all;
close all;

%% Signal test
fs = 40;
t = 0:1/fs:2*pi;
y = cos(2*pi*15*t);

figure
subplot(1, 2, 1);
TraceTI(t, y);
subplot(1, 2, 2);
TraceFFT(t, y);

%% Question 2 

n = 10000; 
t = linspace(0, n, n);
sign = randn(1, n);

figure
subplot(1, 2, 1);
TraceTI(t, sign);
subplot(1, 2, 2);
TraceFFT(t, sign);

