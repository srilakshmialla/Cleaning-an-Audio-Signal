%% Cleaning an audio signal
%
% Srilakshmi Alla

 %% Reading and plotting the given audio file
clc;
clear all;
close all;
[x,Fs] = audioread('C:\Srilakshmi\Signal Processing\DSP\imperial_march_noisy_Fall_2015.wav');
figure(1)
plot(x);
title('Noisy Imperial March .wav Plot');
xlabel('Time');
ylabel('Amplitude');
 
%% FFT Spectrum of Audio Signal
% performing FFT on Signal to conduct spectral analysis on a Normalized Freq
% View of the Signal Spectrum
X = fft(x);
Xmag = abs(X);
num_bins = length(Xmag);
figure(2)
plot([0:1/(num_bins/2 -1):1],Xmag(1:num_bins/2))
xlabel('Normalized Frequencies')
ylabel('Magnitude')
 
%% Design of filter1
% Designing a band stop filter which filters Normalized Freq @ .05143
figure(3)
[h1,a1]=fir1(5000,[0.050 0.052],'stop');
H1 = freqz(h1,a1,floor(num_bins/2));
plot([0:1/(num_bins/2 -1):1],abs(H1))
title('Frequency Response of First Filter to Block Norm Freq .051')
xlabel('Normalized Frequencies')
ylabel('Magnitude')

%% Design of filter2
% To Filter colored noise from Normalized Freq .14 to .2
figure(4)
[h2,a2]=fir1(1000,[0.14 0.2],'stop');
H2 = freqz(h2,a2,floor(num_bins/2));
plot([0:1/(num_bins/2 -1):1],abs(H2))
title('Frequency Response of Second Filter to Block Colored Noise')
xlabel('Normalized Frequencies')
ylabel('Magnitude')

%% Filtering signal using filter1
% Filtering Process one at a time
y1 = filter(h1,1,x);
Y1 = fft(y1);
Y1mag = abs(Y1);
figure(5)
plot([0:1/(num_bins/2 -1):1],Y1mag(1:num_bins/2))
title('Magnitude of Filtered Output After First Filter')
xlabel('Normalized Frequencies')
ylabel('Magnitude')
 
%% Filtering signal using filter2
y2 = filter(h2,1,y1);
Y2 = fft(y2);
Y2mag = abs(Y2);
figure(6)
plot([0:1/(num_bins/2 -1):1],Y2mag(1:num_bins/2))
title('Magnitude of Filtered Output After Second Filter')
xlabel('Normalized Frequencies')
ylabel('Magnitude')
 

%% Plotting signal after filtering using first and second filter
figure(7)
plot(y2)
title('Signal after filtering using first and second filter');
xlabel('Time');
ylabel('Amplitude');

%% Splitting result 
% split at approx. 5.265E5 samples
y21 = y2([1:5.265e5]);
ydelay=[1:2.2E4];
ydelay= ydelay';
ydelay(1:end)=0;
y21=[y21;ydelay];
y22 = y2([5.265e5+1:end]);
 
figure(8)
plot(y21)
title('First part of signal which is split');
xlabel('Time');
ylabel('Amplitude');
 
figure(9)
plot(y22)
title('Second part of signal which is split');
xlabel('Time');
ylabel('Amplitude');

%% Plot of First part of signal after split
Y21 = fft(y21);
Y21mag = abs(Y21);
figure(10)
plot([0:1/(length(y21)/2 -1):1],Y21mag(1:length(y21)/2))
title('Magnitude of First Part of Filtered Output After Second Filter')
xlabel('Normalized Frequencies')
ylabel('Magnitude')

 
%% Plot of Second part of signal after split
Y22 = fft(y22);
Y22mag = abs(Y22);
figure(11)
plot([0:1/(length(y22)/2 -1):1],Y22mag(1:length(y22)/2))
title('Magnitude of Second Part of Filtered Output After Second Filter')
xlabel('Normalized Frequencies')
ylabel('Magnitude')
 
 %% Design of filter3
% To Filter Normalized Freq @ .004988
figure(12)
[h3,a3]=fir1(10000,[0.0044 0.0055],'stop');
H3 = freqz(h3,a3,floor(num_bins/2));
plot([0:1/(num_bins/2 -1):1],abs(H3))
title('Frequency Response of Third Filter to Block Norm Freq .005')
xlabel('Normalized Frequencies')
ylabel('Magnitude')
 
 %% Filtering signal using filter3
% Filtering Process one at a time
y211 = filter(h3,1,y21);
Y211 = fft(y211);
Y211mag = abs(Y211);
figure(13)
plot([0:1/(length(Y211)/2 -1):1],Y211mag(1:length(Y211)/2))
title('Magnitude of Filtered Output After Third Filter')
xlabel('Normalized Frequencies')
ylabel('Magnitude')

 %% Design of filter4
% To Filter Normalized Freq @ .003538
figure(14)
[h4,a4]=fir1(10000,[0.003 0.004],'stop');
H4 = freqz(h4,a4,floor(num_bins/2));
plot([0:1/(num_bins/2 -1):1],abs(H4))
title('Frequency Response of Fourth Filter to Block Norm Freq .0035')
xlabel('Normalized Frequencies')
ylabel('Magnitude')
%% Filtering signal using filter4
% Filtering Process one at a time
y222 = filter(h4,1,y22);
Y222 = fft(y222);
Y222mag = abs(Y222);
figure(15)
plot([0:1/(length(Y222)/2 -1):1],Y222mag(1:length(Y222)/2))
title('Magnitude of Filtered Output After Fourth Filter')
xlabel('Normalized Frequencies')
ylabel('Magnitude')

figure(16)
plot(y211)
title('Signal after using filter3');
xlabel('Time');
ylabel('Amplitude');
 
figure(17)
plot(y222)
title('Signal after using filter4');
xlabel('Time');
ylabel('Amplitude');
 
%% Joining back the signal
xfilt = [y211(2.659E4:5.313E5);y222(5003:end)];
xfilt = xfilt(1:end)-.226;
 
figure(18)
plot(xfilt)
title('Final Signal free of noise');
xlabel('Time');
ylabel('Amplitude'); 
 
sound(xfilt,Fs)
audiowrite(xfilt,Fs,'Srilakshmi_Eymard.wav');
