%% Comparison between the received power level with and without M-H node:
%   Setup
%
%   0) Without MHN
%
%   1) With MHN      
%    
%   2) With MHN
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc;clear; close all;

%--Withouth MH node  Case0----------------------------------------------------------%
load('./data/data2_noMH_DLOS_ESN_received_power.mat');
d0 = distance;
P0_dBm_calib = Power_ESN_rx_av_all_cal_dBm;
P0_w_calib   = Power_ESN_rx_av_all_cal_w;
%---With MH node Case1----------------------------------------------------------%
load('./data/data2_MH_DLOS_ESN_received_power.mat');
d1 = distance;
P1_dBm_calib = Power_ESN_rx_av_all_cal_dBm;
P1_w_calib   = Power_ESN_rx_av_all_cal_w;
%--With MH node  Case2----------------------------------------------------------%
load('./data/data2_MH_NLOS_ESN_received_power.mat');
d2 = distance;
P2_dBm_calib = Power_ESN_rx_av_all_cal_dBm;
P2_w_calib   = Power_ESN_rx_av_all_cal_w;
% %--theoretical calc-------------------------------------------------------%

load('./data/data2_noMH_DLOS_ESN_rectified_voltage.mat');
V0_rms = V_rms_all;
load('./data/data2_MH_DLOS_ESN_rectified_voltage.mat');
V1_rms = V_rms_all;
load('./data/data2_MH_NLOS_ESN_rectified_voltage.mat');
V2_rms = V_rms_all;

% k = same as in previous % interpolated samples

%--Interpolation----------------------------------------------------------%
k = 70; % interpolated samples

d0_q= linspace(d0(1,1),d0(1,end),k); 
d1_q= linspace(d1(1,1),d1(1,end),k); 
d2_q= linspace(d2(1,1),d2(1,end),k);  

P0_dBm_calibq = interp1(d0,P0_dBm_calib,d0_q, 'spline');
P1_dBm_calibq = interp1(d1,P1_dBm_calib,d1_q, 'spline');
P2_dBm_calibq = interp1(d2,P2_dBm_calib,d2_q, 'spline');

V0_rmsq = interp1(d1,V0_rms,d0_q, 'spline');
V1_rmsq = interp1(d1,V1_rms,d1_q, 'spline');
V2_rmsq = interp1(d2,V2_rms,d2_q, 'spline');


%--formated data----------------------------------------------------------%

[d0; P0_dBm_calib; V0_rms;]'

[d1; P1_dBm_calib; V1_rms; V1_rms.^2/3000./P1_w_calib*100]'

[d2; P2_dBm_calib; V2_rms; V2_rms.^2/3000./P2_w_calib*100]'

%--Figures----------------------------------------------------------------%
figure(1)
subplot(2,1,1)
set(gca,'ColorOrderIndex',1);
plot(d0_q,P0_dBm_calibq,'-', d1_q,P1_dBm_calibq,'-',d2_q,P2_dBm_calibq,'-',  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d0,P0_dBm_calib,'*',d1,P1_dBm_calib,'*',d2,P2_dBm_calib,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;
grid on;xlabel('distance, m'), ylabel(['Received power level, dBm'])
legend('No MHN', 'MHN Case:DLoS', 'MHN Case:NLoS','Location','best');
xlim([min(d0) max(d0)])

subplot(2,1,2)
set(gca,'ColorOrderIndex',1);
plot(d0_q,V0_rmsq,'-',d1_q,V1_rmsq,'-',d2_q,V2_rmsq,'-', 'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d0,V0_rms,'*',d1,V1_rms,'*',d2,V2_rms,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;
grid on;xlabel('distance, m'), ylabel(['Rectified voltage, V'])
legend('No MHN', 'MHN Case:DLoS', 'MHN Case:NLoS','Location','best');
xlim([min(d0) max(d0)])

saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case1_and_2.fig']));
saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case1_and_2.svg']));
saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case1_and_2.jpg']));

figure(2)
subplot(2,1,1)
set(gca,'ColorOrderIndex',1);
plot(d0_q,P0_dBm_calibq,'-',d1_q,P1_dBm_calibq,'-',  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d0,P0_dBm_calib,'*',d1,P1_dBm_calib,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d0) max(d0)])
grid on;xlabel('distance, m'), ylabel(['Received power level, dBm'])
legend('No MHN', 'MHN Case:DLoS','Location','best');

subplot(2,1,2)
set(gca,'ColorOrderIndex',1);
plot(d0_q,V0_rmsq,d1_q,V1_rmsq,'-', 'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d0,V0_rms,'*', d1,V1_rms,'*','Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d0) max(d0)])
legend('No MHN','MHN Case:DLoS', 'Location','best');
xlabel('distance, m'), ylabel(['Rectified voltage, V'])

saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case1.fig']));
saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case1.svg']));
saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case1.jpg']));

figure(3)
subplot(2,1,1)
set(gca,'ColorOrderIndex',1);
plot(d2_q,P2_dBm_calibq,'-',  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d2,P2_dBm_calib,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d0) max(d0)])
grid on;xlabel('distance, m'), ylabel(['Received power level, dBm'])
legend('MHN Case:NLoS','Location','best');

subplot(2,1,2)
set(gca,'ColorOrderIndex',1);
plot(d2_q,V2_rmsq,'-', 'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d2,V2_rms,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d0) max(d0)])
legend('MHN Case:NLoS','Location','best');
grid on;xlabel('distance, m'), ylabel(['Rectified voltage, V'])

saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case2.fig']));
saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case2.svg']));
saveas(gcf, append([ './graphs/comparsion_RX_power_rectified_voltage_case2.jpg']));


diff_P0_P1 = (P1_dBm_calib - P0_dBm_calib);
diff_V0_V1rms = (V1_rms./V0_rms*100);

figure(4)
set(gca,'ColorOrderIndex',1);
plot(d1,diff_P0_P1,  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,diff_P0_P1,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d0) max(d0)])
grid on;xlabel('distance, m'), ylabel(['difference between power level, dB'])
legend('MHN DLOS minus No MHN','Location','best');
saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_power.fig']));
saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_power.svg']));
saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_power.jpg']));

figure(5)
set(gca,'ColorOrderIndex',1);
plot(d1,diff_V0_V1rms,  'Linewidth', 2);
hold on; 
set(gca,'ColorOrderIndex',1);
semilogx(d1,diff_V0_V1rms,'*', 'Linewidth', 3 ,'MarkerSize', 3.5);
grid minor;xlim([min(d0) max(d0)])
grid on;xlabel('distance, m'), ylabel(['difference between rectified voltage, %'])
legend('MHN DLOS vs No MHN','Location','best');
saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_voltage.fig']));
saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_voltage.svg']));
saveas(gcf, append([ './graphs/comparsion_MHN_vs_noMHN_DLOS_voltage.jpg']));
