
clear;
close all;
clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTIE I


% Signaux
x = rand(1000, 1);
h = [1 0.8 -0.3 0.4]';
d = conv(x, h);

% Question 2 

% Paramètres de l'algorithme RLS
order = 4; % Ordre du filtre 
alpha = 0.95; % Alpha
lambda = 0.98; % vers 0 LSM, vers 1 gradient deterministe

% figure
% subplot(1, 2, 1)
% plot(x)
% title("Signal x")
% subplot(1, 2, 2)
% plot(d)
% title("Signal d")


% Question 3

[w, y, e] = algoms_RLS(x, d, order, alpha, lambda);

% figure
% plot(d)
% hold on
% plot(y)
% hold off
% title("Signaux y, d et l'erreur en fonction du temps")
% legend("Signal d", "Signal y")

% figure
% plot(e)
% title("Erreur en fonction du nombre d'itération")

w;

% Question 4 

x = rand(1000, 1);
h = fir1(5, 0.5);
d = conv(x, h) + rand(1000, 1)';

[w, y, e1] = algoms_RLS(x, d, 5, alpha, 0.1);
[w, y, e2] = algoms_RLS(x, d, 5, alpha, 0.5);
[w, y, e3] = algoms_RLS(x, d, 5, alpha, 0.9);

% figure
% plot(e1)
% hold on
% plot(e2)
% hold on
% plot(e3)
% hold off
% title("Erreur pour P = 5 et différentes valeures de lambda")
% legend("lambda = 0.1", "lambda = 0.5", "lambda = 0.9")

[w, y, e1] = algoms_RLS(x, d, 10, alpha, 0.9);
[w, y, e2] = algoms_RLS(x, d, 5, alpha, 0.9);

% figure
% plot(e1)
% hold on
% plot(e2)
% hold off
% title("Erreur pour lambda = 0.9 et différentes valeures de P")
% legend("P = 10", "P = 5")


% Question 5

x = rand(1000, 1);
h = [1 0.8 -0.3 0.4]';
d = conv(x, h);

[w, y, elms] = algoms_LMS(x, d, 4, 0.5);
[w, y, erls] = algoms_RLS(x, d, 4, alpha, 0.9);

% figure
% plot(elms(1:200))
% hold on
% plot(erls(1:200))
% hold off
% title("Erreur pour les deux algorithmes LMS et RLS avec un signal simulé")
% legend("Erreur de LMS", "Erreur de RLS")



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTIE II


[signal_ref, fs] = audioread('Voix1.wav');
n_signal = length(signal_ref);
t = (0:n_signal-1)/fs;

% figure
% plot(t, signal_ref)
% title("Signal de référence")

N1 = rand(n_signal, 1);

% figure
% plot(N1)
% title("Bruit de référence")

h = fir1(32, 0.5);
N0 = conv(N1, h);
N0 = N0(1:n_signal);
signal = signal_ref + N0;

% figure
% plot(signal)
% title("Signal plus le bruit filtré")

[w, y, e] = algoms_RLS(signal, signal_ref, 32, alpha, 0.9);
% 
% figure
% plot(t, signal_ref)
% hold on
% plot(t, y)
% hold off
% title("Signaux avant et après estimation")
% legend("Signal de référence", "Signal estimé")

w;
%sound(signal, fs)
%sound(y, fs)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARTIE III


% Question 3

x = rand(1000, 1);
h = fir1(5, 0.5);
d = conv(x, h) + rand(1000, 1)';

[w, y, e1] = algoms_nLMS(x, d, 20, 0.01);
[w, y, e2] = algoms_nLMS(x, d, 20, 0.1);
[w, y, e3] = algoms_nLMS(x, d, 20, 1);
[w, y, e4] = algoms_nLMS(x, d, 20, 0.9);

% figure
% plot(e1)
% hold on
% plot(e2)
% hold on
% plot(e3)
% hold on
% plot(e4)
% hold off
% title("Erreur pour P = 20 et différentes valeures de mu")
% legend("mu = 0.01", "mu = 0.1", "mu = 0.5", "mu = 0.9")


% Question 4

[w, y, e1] = algoms_nLMS(x, d, 20, 0.5);
[w, y, e2] = algoms_nLMS(x, d, 10, 0.5);
[w, y, e3] = algoms_nLMS(x, d, 5, 0.5);

% figure
% plot(e1)
% hold on
% plot(e2)
% hold on
% plot(e3)
% hold off
% title("Erreur pour mu = 0.5 et différentes valeures de P")
% legend("P = 20", "P = 10", "P = 5")


% Question 5

x = rand(1000, 1);
h = fir1(5, 0.5);
d = conv(x, h) + rand(1000, 1)';

[w, y, elms] = algoms_LMS(x, d, 5, 0.5);
[w, y, enlms] = algoms_nLMS(x, d, 5, 0.5);
[w, y, erls] = algoms_RLS(x, d, 5, alpha, 0.9);

% figure
% plot(enlms)
% hold on
% plot(elms)
% hold on
% plot(erls)
% hold off
% title("Comparaison des 3 algorithmes  avec un signal simulé")
% legend("Erreur de NLMS", "Erreur de LMS", "Erreur de RLS")


[w, yrls, erls] = algoms_RLS(signal, signal_ref, 32, alpha, 0.9);
[w, ylms, elms] = algoms_LMS(signal, signal_ref, 32, 0.5);
[w, ynlms, enlms] = algoms_nLMS(signal, signal_ref, 32, 0.5);

% figure
% subplot(4, 1, 1)
% plot(t, signal_ref)
% title("Signal de référence")
% subplot(4, 1, 2)
% plot(t, ynlms)
% title("NLMS")
% subplot(4, 1, 3)
% plot(t, ylms)
% xlim([0 6])
% title("LMS")
% subplot(4, 1, 4)
% plot(t, yrls)
% title("RLS")

%sound(yrls, fs)
%sound(ylms, fs)
%sound(ynlms, fs)
