

%% Load
ecg_signal_1=load('ecg_signal_1.dat');
ecg_signal_2=load('ecg_signal_2.dat');
%% Frequency
fs=1000;
time=1/fs;
%% length
n=length(ecg_signal_1);
n_1=length(ecg_signal_2);
%% time
time_1=linspace(0,9.519,n);

%% Plot_ECG signal
fig1=figure
subplot(5,2,1)
plot(time_1,ecg_signal_1);
title('ecg signal  full duration')
ylabel('ecg signal in a.u')
xlabel('time in s')
%% plot_cardic cycle
subplot(5,2,2)
plot(ecg_signal_1(1000:2000));
title('ecg signal over one cardic signal')
ylabel('ecg signal in a.u')
xlabel('time in s')

%% fft
% fft_1=fft(ecg_signal_1,n);

% after_noise=cj/n;
% 
% plot(ecg_signal_1,after_noise);
% fft_2=fft(ecg_signal_2,n_1);
% subplot(5,2,4)
% plot(fft_2);
%% fft
 fft_1=fft(ecg_signal_1,n);
 s2=(fft_1.*conj(fft_1))/n;
 f=(0:(n/2))*fs/n;
 fig2=figure
 subplot(5,1,1)
 semilogy(f,s2(1:length(f)));
 title('Power Spectrum');
 xlabel('frequency in HZ');
 ylabel('arbitary unit in a.u.');
 
 %% 2. 10-point moving average filter
b=1/10*ones(10,1);
a=1;
filtere_signai=filter(b,a,ecg_signal_1);

figure(fig1);
subplot(5,2,3)
plot(time_1,filtere_signai);

subplot(5,2,4);
plot(filtere_signai(1000:2000));

fft_2=fft(filtere_signai,length(filtere_signai));
s2_1=(fft_2.*conj(fft_2))/length(filtere_signai);
figure(fig2);
subplot(5,1,2)
semilogy(f,s2_1(1:length(f)));

fig3=figure;
freqz(b,a,[],fs);

%% derivative based filter 
b1=[1 -1];
a1=[1 -0.995]*1000;
filter_signal2=filter(b1,a1,ecg_signal_1);

figure(fig1);
subplot(5,2,5);
plot(time_1,filter_signal2);


subplot(5,2,6);
plot(filter_signal2(1000:2000));

fft_3=fft(filter_signal2,length(filter_signal2));
s2_2=(fft_3.*conj(fft_3))/length(filter_signal2);
figure(fig2);
subplot(5,1,3)
semilogy(f,s2_2(1:length(f)));

fig4=figure;
freqz(b1,a1,[],fs)

%% comb filter
b_comb=[0.6310 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310];
a_comb=1;
filter_signa3=filter(b_comb,a_comb,ecg_signal_1);

figure(fig1);
subplot(5,2,7);
plot(time_1,filter_signa3);


subplot(5,2,8);
plot(filter_signa3(1000:2000));

fft_4=fft(filter_signa3,length(filter_signa3));
s2_3=(fft_4.*conj(fft_4))/length(filter_signa3);
figure(fig2);
subplot(5,1,4)
semilogy(f,s2_3(1:length(f)));

fig5=figure;
freqz(b_comb,a_comb,[],fs);

%% conv function 

combine1=conv(a,a1)
n_a=conv(combine1,a_comb);
combine2=conv(b,b1)
n_b=conv(combine1,b_comb);

filter_signa4=filter(n_b,n_a,ecg_signal_1);

figure(fig1);
subplot(5,2,9);
plot(time_1,filter_signa4);


subplot(5,2,10);
plot(filter_signa4(1000:2000));

fft_5=fft(filter_signa4,length(filter_signa4));
s2_4=(fft_5.*conj(fft_5))/length(filter_signa4);
figure(fig2);
subplot(5,1,5)
semilogy(f,s2_4(1:length(f)));

fig6=figure;
freqz(n_b,n_a,[],fs);






 
 

 
 
 
 
 
 
