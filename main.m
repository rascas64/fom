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

clear all;

Ts = 2.5*10^-2 ; % durée symbolique
fs = 1/Ts ; % fréquence d'échantillonage
fc = 10 ; % fréquence de la porteuse à l'émetteur
fcr = 100 ; % fréquence de la porteuse au récepteur
phic = pi ; % différence de phase entre l'émetteur et le récepteur
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

[signOOK, carrier] = OOK(signal, t(length(t)), fs, fc, Amax);

figure
subplot(3, 1, 1);
TraceTI(t, signal, true, false, "Signal");
subplot(3, 1, 2);
TraceTI(t, carrier, false, true, "Carrier");
subplot(3, 1, 3);
TraceTI(linspace(0, 1/fs * length(signOOK), length(signOOK)), signOOK, false, true, "Signal OOK");

%% Question 4

[signDSSS, chips, fact] = mod_DSSS(signal, 0);
[signDSSS_OOK, carrier] = OOK(signDSSS, t(length(t)), fs, fc, Amax);

figure
subplot(3, 1, 1)
TraceTI(t, signal, true, false, "input");
subplot(3, 1, 2)
TraceTI(linspace(0, 1/fs * length(chips), length(chips)), chips, true, false, "chips");
subplot(3, 1, 3)
TraceTI(linspace(0, 1/fs * length(signDSSS_OOK), length(signDSSS_OOK)), signDSSS_OOK, true, false, "output");

%% Question 5

signOOKNoisy = awgn(signOOK, snr);
figure
subplot(2, 1, 1)
TraceTI(linspace(0, 1/fs * length(signOOK), length(signOOK)), signOOK, false, true, "Signal");
subplot(2, 1, 2)
TraceTI(linspace(0, 1/fs * length(signOOKNoisy), length(signOOKNoisy)), signOOKNoisy, false, true, "Signal modulé OOK bruité");

signDSSSNoisy = awgn(signDSSS_OOK, snr);
figure
subplot(2, 1, 1)
TraceTI(linspace(0, 1/fs * length(signDSSS), length(signDSSS)), signDSSS, false, true, "Signal");
subplot(2, 1, 2)
TraceTI(linspace(0, 1/fs * length(signDSSSNoisy), length(signDSSSNoisy)), signDSSSNoisy, false, true, "Signal modulé DSSS bruité");


%% Question 6

% porteuse de réception
t = linspace(0, 1/fs * length(signOOKNoisy), length(signOOKNoisy));
receivingCarrier = Amax * cos(fcr.*t + phic);

signOOKRecu = signOOKNoisy.*receivingCarrier;
temp = lowpass(signOOKRecu, fc + fcr, fs);
signOOKDemod = demod_OOK(temp,n);

figure;
subplot(2, 1, 1);
TraceTI(0:1/fs:1, signal, true, false, "Signal original");
subplot(2, 1, 2);
TraceTI(0:1/fs:1, signOOKDemod, true, false, "Signal après réception et démodulation");


t = linspace(0, 1/fs * length(signDSSSNoisy), length(signDSSSNoisy));
receivingCarrier = Amax * cos(fcr.*t + phic);
signDSSSRecu = signDSSSNoisy.*receivingCarrier;
temp = lowpass(signDSSSRecu, fc + fcr, fs);
signDSSSDemod = demod_DSSS(demod_OOK(temp,n), chips, fact);

figure;
subplot(2, 1, 1);
TraceTI(0:1/fs:1, signal, true, false, "Signal original");
subplot(2, 1, 2);
TraceTI(0:1/fs:1, signDSSSDemod, true, false, "Signal après réception et démodulation");


ber(signOOKDemod, signal)
ber(signDSSSDemod, signal)

% calculer le signal reçu ==> multiplication des signaux bruités avec une
% porteuse de réception
% t = 0:1/fs:(length(signalDSSSNoisy)-1)/fs;
% carrier = Amax * cos(fcr * t);
% signalDSSSRecu = signalDSSSNoisy.*carrier;
% 
% puis filtre passe bas pour virer les hautes fréquences
% temp = lowpass(signalDSSSRecu, fc, fs);
% 
% 
% DSSSDemod = demod_DSSS(signalDSSSRecu, chips, fact);
% n=length(t);
% 
% OOKDemod = demod_OOK(signalOOKNoisy, n);
% 
% figure
% subplot(3, 1, 1)
% TraceTI([], signal, true, false, "input");
% subplot(3, 1, 2)
% TraceTI([], DSSSDemod, true, false, "demod DSSS");
% subplot(3, 1, 3)
% TraceTI([], OOKDemod, true, false, "demod OOK");

%% Question 7
% ber_OOK = ber(OOKDemod, signal)
% ber_DSSS = ber(DSSSDemod, signal)
