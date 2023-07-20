%% === PA performance measurements: voltage, current, output power, gain graphs ==== %%
%% ==================2023.03.30====================== %%

clc;clear; close all;
format shortG;


%--Measurements-----------------------------------------------------------%
addpath('.\data\pa_gain_power')
load('PA_EH_BQ25570v2__5V0.mat')

DUT = 'PA_EH_BQ25570v2';

%=========================================================================%
figure(1)
legendStrings = "P_{in} = " + string(Pin_SINE_dBm_calibrated);
subplot(4,1,1)
plot(Pin_SINE_dBm_calibrated, av(PSMU_voltage,10),'Linewidth', 2)
hold on; set(gca,'ColorOrderIndex',1); plot(Pin_SINE_dBm_calibrated, av(PSMU_voltage,10),'o', 'MarkerSize', 3);
%legend(legendStrings);
xlabel('Pin, dBm'), ylabel('Voltage, V'); grid minor;
subplot(4,1,2)
plot(Pin_SINE_dBm_calibrated, av(PSMU_current,10)*1e3,'Linewidth', 2)
hold on; set(gca,'ColorOrderIndex',1); plot(Pin_SINE_dBm_calibrated, av(PSMU_current,10)*1e3, 'o', 'MarkerSize', 3);
%legend(legendStrings);
xlabel('Pin, dBm'), ylabel('current, mA'); grid minor;
subplot(4,1,3)
plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10),'Linewidth', 2)
hold on; set(gca,'ColorOrderIndex',1); plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10),'o', 'MarkerSize', 3);
%legend(legendStrings);
xlabel('Pin, dBm'), ylabel('Pout, dBm'); grid minor;
subplot(4,1,4)
plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10)-Pin_SINE_dBm_calibrated','Linewidth', 2)
hold on; set(gca,'ColorOrderIndex',1); plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10)-Pin_SINE_dBm_calibrated', 'o', 'MarkerSize', 3);
%legend(legendStrings);
xlabel('Pin, dBm'), ylabel('Gain, dB'); grid minor;

%  saveas(gcf, append([ './graphs/PA_gain_1' ,DUT,'.jpg']));
%  saveas(gcf, append([ './graphs/PA_gain_1' ,DUT,'.svg']));



figure(2)
subplot(2,1,1)
plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10), 'Linewidth', 2)
hold on; set(gca,'ColorOrderIndex',1); 
plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10),'o', 'MarkerSize', 3); xlim([-15 5])
%legend(legendStrings);
xlabel('P_{input}, dBm'), ylabel('P_{output}, dBm'); grid minor;
subplot(2,1,2)
plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10)-Pin_SINE_dBm_calibrated', 'Linewidth', 2)
hold on; set(gca,'ColorOrderIndex',1); 
plot(Pin_SINE_dBm_calibrated, av(Pout_power_dBm_calibrated,10)-Pin_SINE_dBm_calibrated', 'o', 'MarkerSize', 3); xlim([-15 5])
%legend(legendStrings);
xlabel('P_{input}, dBm'), ylabel('Gain, dB'); grid minor;

 saveas(gcf, append([ './graphs/PA_gain_' ,DUT,'.jpg']));
 saveas(gcf, append([ './graphs/PA_gain_' ,DUT,'.svg']));
