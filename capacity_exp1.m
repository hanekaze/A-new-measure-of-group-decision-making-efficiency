% This program show you how to calculate Capacity of Experiment 1 (oddball
% task). 
% Programming by Cheng-Ju Hsieh 03-19-2020
close all
clear;clc;

for tt=1:7
    data_uncommun=xlsread('exp1 noncollaborate.xlsx',['s' num2str(tt)],'A2:F1281');
    
    %% seperate noncollaborate ata by individuals and trumcate
    data_ind1=data_uncommun((data_uncommun(:,4)==1 & data_uncommun(:,5)==0),:);
    data_ind2=data_uncommun((data_uncommun(:,4)==0 & data_uncommun(:,5)==1),:);
    r1_max = prctile(data_ind1(:,3),97.5);r1_min = prctile(data_ind1(:,3),2.5);
    r2_max = prctile(data_ind2(:,3),97.5);r2_min = prctile(data_ind2(:,3),2.5);
    data_ind1(data_ind1(:,3)>=r1_max,:)=[];data_ind1(data_ind1(:,3)<=r1_min,:)=[];
    data_ind2(data_ind2(:,3)>=r2_max,:)=[];data_ind2(data_ind2(:,3)<=r2_min,:)=[];
    
    data_uncommun=[data_ind1;data_ind2];
    
    %% trumcate collaborate data
    data_commun=xlsread('exp1 collaborate.xlsx',['s' num2str(tt)],'A2:F1281');
    r_max = prctile(data_commun(:,3),97.5);r_min = prctile(data_commun(:,3),2.5);
    data_commun(data_commun(:,3)>=r_max,:)=[];data_commun(data_commun(:,3)<=r_min,:)=[];
    
    %% filter (correct response)
    ind1_data=data_uncommun((data_uncommun(:,4)==1 & data_uncommun(:,5)==0),:);
    ind1_data_correct=ind1_data(ind1_data(:,2)==1,:);
    ind2_data=data_uncommun((data_uncommun(:,4)==0 & data_uncommun(:,5)==1),:);
    ind2_data_correct=ind2_data(ind2_data(:,2)==1,:);
    commun_data_correct=data_commun(data_commun(:,2)==1,:);
    
    %% caculate C(t)
    t=[0:0.01:5]; %t span
    r1=ind1_data_correct(:,3); %sub 1 RT
    r2=ind2_data_correct(:,3); %sub 2 RT
    rt=commun_data_correct(:,3); %team RT
    
    % The empirical distribution function
    F_r1=edf(t,r1);
    F_r2=edf(t,r2);
    F_rt=edf(t,rt);
    
    % calculate capacity coefficient
    ct = (log(F_r1.*F_r2))./(log(F_rt));
    
    ct(cb==0)=nan;
    
    %% color code
    % sdyam/Smax for each group (collective benefit)
    % we color the function by those in order to show the comparison
    % between C(t) and collective benefit
    color=[1.028084769    1.298277959        1.087920287        0.833652854        0.873983021        0.758676028        1.015648237]';
    cn=min(color);cm=max(color);
    % group with lower collective benefit is black (color parameter
    % is 1)
    % group with higher collective benefit is gray (color parameter
    % is 0.6)
    % color parameter 1(black) to 0(white)
    color=(color-cn)/(cm-cn)*0.6*ones(1,3);
    
    %% plot
    plot (t,cb,'k.','MarkerSize',10,'Color',color(tt,:),'DisplayName','C(t)')
    hold on
end

%% plot design
% colormap(gray(256));
colormap([0:0.01:0.6]'*ones(1,3));
z=colorbar;
set(get(z,'ylabel'),'string','S_{dyad}/S_{max}');
caxis([cn cm])

set(gca,'XTick',-1:1:5)
set(gca,'YTick',0 :2:15)

axis([0 2 0 10])
%     Create xlabel
xlabel('RT (sec)');
%     Create ylabel
ylabel('C_{AND}(t)');
%     line (t,1)

hold on

plot([0 10],[1 1],'k-')
h=figure(1)
set(gca,'Fontsize',15,'FontWeight','bold')
set(gcf,'position',[100,100, 600, 400]);
saveas(h,['EXP1_AND_' 'Ct'],'jpg');
saveas(h,['EXP1_AND_' 'Ct'],'fig');
saveas(h,['EXP1_AND_' 'Ct'],'tif');