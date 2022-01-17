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
fc = 1000 ; % fréquence de la porteuse à l'émetteur
fcr = 1000 ; % fréquence de la porteuse au récepteur
phic = 0 ; % différence de phase entre l'émetteur et le récepteur
Amax = 10 ; % Amplitude maximale à l'émetteur
snr = 50 ; % ration signal / bruit

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
receivingCarrier = Amax * cos(fcr.*t + phic); % création du vecteur de 
                                              % la porteuse de réception

signOOKRecu = signOOKNoisy.*receivingCarrier;
temp = lowpass(signOOKRecu, fc + fcr, fs);    % application du filtre passe bas
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