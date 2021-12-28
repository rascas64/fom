clear all;
close all;

%% Signal test
fs = 40;
t = 0:1/fs:2*pi;
y = cos(2*pi*t);

figure
subplot(1, 2, 1);
TraceTI(t, y, false, true, "Signal test");
subplot(1, 2, 2);
TraceFFT(t, y);

%% Question 2 

fs = 20;
t = 0:1/fs:1;
n = length(t);
signal = randi([0, 1], 1, n);

figure
subplot(1, 2, 1);
TraceTI(t, signal, true, false, "Signal en fct du temps");
subplot(1, 2, 2);
TraceFFT(t, signal);

%% Question 3

Ts = t(length(t));
[signOOK, carrier] = OOK(signal, Ts, fs, 10, 5);
figure
subplot(3, 1, 1);
TraceTI(t, signal, true, false, "Signal");
subplot(3, 1, 2);
TraceTI(t, carrier, false, true, "Carrier");
subplot(3, 1, 3);
TraceTI([], signOOK, false, true, "Signal OOK");

%% Question 4

[sign_DSSS, chips, fact] = mod_DSSS(signal, 0);
figure
subplot(3, 1, 1)
TraceTI([], signal, true, false, "input");
subplot(3, 1, 2)
TraceTI([], chips, true, false, "chips");
subplot(3, 1, 3)
TraceTI([], sign_DSSS, true, false, "output");

%% Question 6
signal_r = demod_DSSS(sign_DSSS, chips, fact);
t = 0:1/fs:Ts;
n=length(t);
up = demod_OOK(signOOK, n);

figure
subplot(3, 1, 1)
TraceTI([], signal, true, false, "input");
subplot(3, 1, 2)
TraceTI([], signal_r, true, false, "demod DSSS");
subplot(3, 1, 3)
TraceTI([], up, true, false, "demod OOK");
