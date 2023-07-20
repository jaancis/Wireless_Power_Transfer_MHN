%% Comparison between the received power level with and without M-H node:
%   Setup
%
%   1) With MHN      
%    
%   2) Withouth MHN
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;clear; close all;

%---With MH node ----------------------------------------------------------%
load('./data/data1_MH_DLOS_ESN_received_power.mat');
d1 = distance;
P1_dBm_calib = Power_ESN_rx_av_all_cal_dBm;
P1_w_calib   = Power_ESN_rx_av_all_cal_w;

load('./data/data1_MH_DLOS_ESN_rectified_voltage.mat');
V1_rms = V_rms_all;

%--Withouth MH node -------------------------------------------------------%
load('./data/data1_noMH_DLOS_ESN_received_power.mat');
d2 = distance;
P2_dBm_calib = Power_ESN_rx_av_all_cal_dBm;
P2_w_calib   = Power_ESN_rx_av_all_cal_w;

load('./data/data1_noMH_DLOS_ESN_rectified_voltage.mat');
V2_rms = V_rms_all;

% k = same as in previous % interpolated samples

%--Interpolation-----------------------------------------------------------%
k = 100; % interpolated samples

d1_q= linspace(d1(1,1),d1(1,end),k); 
d2_q= linspace(d2(1,1),d2(1,end),k);  
V1_rmsq = interp1(d1,V1_rms,d1_q, 'spline');
V2_rmsq = interp1(d2,V2_rms,d2_q, 'spline');

P1_dBm_calibq = interp1(d1,P1_dBm_calib,d1_q, 'spline');
P2_dBm_calibq = interp1(d2,P2_dBm_calib,d2_q, 'spline');



figure(1)
set(gca,'ColorOrderIndex',1);
plot( d1_q,P1_dBm_calibq,'-',d2_q,P2_dBm_calibq,'-',  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,P1_dBm_calib,'*',d2,P2_dBm_calib,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;
grid on;xlabel('distance, m'), ylabel(['Power, dBm'])
legend('With MHN', 'Without MHN','Location','best');
xlim([min(d1) max(d1)])
saveas(gcf, append([ './graphs/comparsion_RX_power.fig']));
saveas(gcf, append([ './graphs/comparsion_RX_power.svg']));
saveas(gcf, append([ './graphs/comparsion_RX_power.jpeg']));

figure(2)
set(gca,'ColorOrderIndex',1);
plot(d1_q,V1_rmsq,'-',d2_q,V2_rmsq,'-', 'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,V1_rms,'*',d2,V2_rms,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;
grid on;xlabel('distance, m'), ylabel(['Voltage, V'])
legend('With MHN', 'Without MHN','Location','best');
xlim([min(d1) max(d1)])

saveas(gcf, append([ './graphs/comparsion_rectified_voltage.fig']));
saveas(gcf, append([ './graphs/comparsion_rectified_voltage.svg']));
saveas(gcf, append([ './graphs/comparsion_rectified_voltage.jpg']));


%% Other

figure(3)
subplot(2,1,1)
set(gca,'ColorOrderIndex',1);
plot(d1_q,P1_dBm_calibq,'-',  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,P1_dBm_calib,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d2) max(d2)])
grid on;xlabel('distance, m'), ylabel(['Received power level, dBm'])
legend('With MHN', 'Location','best');

subplot(2,1,2)
set(gca,'ColorOrderIndex',1);
plot(d1_q,V1_rmsq,'-', 'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,V1_rms,'*','Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d1) max(d1)])
legend('With MHN', 'Location','best');
xlabel('distance, m'), ylabel(['Rectified voltage, V'])

%saveas(gcf, append([ './final_calibrated_graphs/comparsion_RX_power_rectified_voltage_case1.fig']));
%saveas(gcf, append([ './final_calibrated_graphs/comparsion_RX_power_rectified_voltage_case1.svg']));

figure(4)
subplot(2,1,1)
set(gca,'ColorOrderIndex',1);
plot(d2_q,P2_dBm_calibq,'-',  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d2,P2_dBm_calib,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d1) max(d1)])
grid on;xlabel('distance, m'), ylabel(['Received power level, dBm'])
legend('Without MHN','Location','best');

subplot(2,1,2)
set(gca,'ColorOrderIndex',1);
plot(d2_q,V2_rmsq,'-', 'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d2,V2_rms,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d1) max(d1)])
legend('Without MHN','Location','best');
grid on;xlabel('distance, m'), ylabel(['Rectified voltage, V'])

%saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case2.fig']));
%saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case2.svg']));



diff_P2_P1 = (P1_dBm_calib - P2_dBm_calib);
diff_V2_V1rms = (V1_rms./V2_rms*100);

figure(5)
set(gca,'ColorOrderIndex',1);
plot(d1,diff_P2_P1,  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,diff_P2_P1,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d1) max(d1)])
grid on;xlabel('distance, m'), ylabel(['difference between power level, dB'])
legend('MHN DLOS minus No MHN','Location','best');
%saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_power.fig']));
%saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_power.svg']));

figure(6)
set(gca,'ColorOrderIndex',1);
plot(d1,diff_V2_V1rms,  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,diff_V2_V1rms,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d1) max(d1)])
grid on;xlabel('distance, m'), ylabel(['difference between rectified voltage, %'])
legend('MHN DLOS vs No MHN','Location','best');
%saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_voltage.fig']));
%saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_voltage.svg']));



[d1; P1_dBm_calib; V1_rms; V1_rms.^2/3000./P1_w_calib*100]'


[d2; P2_dBm_calib; V2_rms; V2_rms.^2/3000./P2_w_calib*100]'