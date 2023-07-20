
clc;clear;close all
load('./data/data2_P10_VD_LowDCR_SMS7630.mat');

for m = 1:1:length(signal_power_dBm_cal)
    pause(1);
    for n = 1:1:length(signal_frequency_GHz)
       for o = 1:1          
            figure(1)  % change back to (m)
            sgtitle('VD with low DC resistance inductors, SMS7630 diodes')
            subplot(4,1,1)
            hold on;
            title('Voltage depending on load resistance');
            %colororder(distinguishable_colors(length(signal_frequency_GHz)));
            plot(R(:,:,m)/1e3,U(:,:,m),'LineWidth',2);xlim([0 30]);
            legend([label_signal_power],'Location','bestoutside')
%           legend([label_signal_frequency_GHz+', '+label_signal_power],'Location','bestoutside')
            xlabel('R, K\Omega'), ylabel('U, V')
            subplot(4,1,2)
            hold on;
            title('Current depending on load resistance');
            %colororder(distinguishable_colors(length(signal_frequency_GHz)));
            plot(R(:,:,m)/1e3,I(:,:,m)*1e6,'LineWidth',2);xlim([0 30]);
            legend([label_signal_power],'Location','bestoutside')
            xlabel('R, K\Omega'), ylabel('I, \muA')
            subplot(4,1,3)
            hold on;
            %colororder(distinguishable_colors(length(signal_frequency_GHz)));
            title('Power depending on load resistance'); 
            plot(R(:,:,m)/1e3,P(:,:,m)*1e6,'LineWidth',2);xlim([0 30]);
            legend([label_signal_power],'Location','bestoutside')
            xlabel('R, K\Omega'), ylabel('P, \muW')
            subplot(4,1,4)
            hold on;
            %colororder(distinguishable_colors(length(signal_frequency_GHz)));
            title('PCE depending on load resistance'); 
            plot(R(:,:,m)/1e3,E(:,:,m),'LineWidth',2);xlim([0 30]);
            legend([label_signal_power],'Location','bestoutside')
            xlabel('R, K\Omega'), ylabel('\eta, %')    
        end 
    end
end
for i=1:4
    subplot(4,1,i)
    grid minor;
end
save(append(['./data/data_',measurement_dataset,'.mat']))

% saveas(gcf, append([ './graphs/P10_VD_efficiency.fig']));
% saveas(gcf, append([ './graphs/P10_VD_efficiency.svg']));
% saveas(gcf, append([ './graphs/P10_VD_efficiency.jpeg']));