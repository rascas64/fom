clear all;
close all;

%% Signal test
fs = 40;
t = 0:1/fs:2*pi;
y = cos(2*pi*t);

figure
subplot(1, 2, 1);
TraceTI(t, y, false, true);
subplot(1, 2, 2);
TraceFFT(t, y);

%% Question 2 

fs = 30;
t = 0:1/fs:1;
n = length(t);
sign = randi([0, 1], 1, n);

figure
subplot(1, 2, 1);
TraceTI(t, sign, true, false);
subplot(1, 2, 2);
TraceFFT(t, sign);

%% Question 3

[signOOK, carrier] = OOK(sign, t(length(t)), fs, 10, 5);
figure
subplot(3, 1, 1);
TraceTI(t, sign, true, false);
subplot(3, 1, 2);
TraceTI(t, carrier, false, true);
subplot(3, 1, 3);
TraceTI([], signOOK, false, true);