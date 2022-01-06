clear all;
close all;
clc;

%% Signal test
fs = 40;
t = 0:1/fs:2*pi;
y = cos(2*pi*t);

figure
subplot(1, 2, 1);
TraceTI(t, y, false, true, "Signal test");
subplot(1, 2, 2);
TraceFFT(t, y);


%% Paramètres

Ts = 2.5*10^-2 ; % durée symbolique
fs = 1/Ts ; % fréquence d'échantillonage
fc = 10 ; % fréquence de la porteuse à l'émetteur
fcr = 10 ; % fréquence de la porteuse au récepteur
phic = 0 ; % différence de phase entre l'émetteur et le récepteur
M = 0 ;
Amax = 5 ; % Amplitude maximale à l'émetteur
snr = 5 ; % ration signal / bruit
sync = 0 ; % desynchronization entre l'émetteur et le récepteur

%% Question 2 

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
[signOOK, carrier] = OOK(signal, Ts, fs, fc, Amax);

figure
subplot(3, 1, 1);
TraceTI(t, signal, true, false, "Signal");
subplot(3, 1, 2);
TraceTI(t, carrier, false, true, "Carrier");
subplot(3, 1, 3);
TraceTI([], signOOK, false, true, "Signal OOK");

%% Question 4

[signDSSS, chips, fact] = mod_DSSS(signal, 0);
[signDSSS_OOK, carrier] = OOK(signDSSS, Ts, fs, fc, Amax);

figure
subplot(3, 1, 1)
TraceTI([], signal, true, false, "input");
subplot(3, 1, 2)
TraceTI([], chips, true, false, "chips");
subplot(3, 1, 3)
TraceTI([], signDSSS, true, false, "output");

%% Question 5

signalOOKNoisy = awgn(signOOK, snr);

figure
subplot(2, 1, 1)
TraceTI([], signOOK, false, true, "Signal");
subplot(2, 1, 2)
TraceTI([], signalOOKNoisy, false, true, "Signal modulé OOK bruité");

signalDSSSNoisy = awgn(signDSSS_OOK, snr);
figure
subplot(2, 1, 1)
TraceTI([], signDSSS, false, true, "Signal");
subplot(2, 1, 2)
TraceTI([], signalDSSSNoisy, false, true, "Signal modulé DSSS bruité");


%% Question 6

% calculer le signal reçu ==> multiplication des signaux bruités avec une
% porteuse de réception
% puis filtre passe bas pour virer les hautes fréquences
% puis démodulation : m(t) * cos((w1c + w2c)t) 


% % DSSSDemod = demod_DSSS(signDSSSNoisy, chips, fact);
% n=length(t);
% OOKDemod = demod_OOK(signalOOKNoisy, n);
% 
% figure
% subplot(3, 1, 1)
% TraceTI([], signal, true, false, "input");
% subplot(3, 1, 2)
% % TraceTI([], DSSSDemod, true, false, "demod DSSS");
% subplot(3, 1, 3)
% TraceTI([], OOKDemod, true, false, "demod OOK");

%% Question 7
% ber_OOK = ber(OOKDemod, signal)
% ber_DSSS = ber(DSSSDemod, signal)
