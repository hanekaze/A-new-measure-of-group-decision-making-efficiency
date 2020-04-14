datname={'Exp1 and cf','Exp1 and cs','Exp1 and if','Exp1 and is'};
Titlename={'(a) Correct and Fast','(b) Correct and Slow','(c) Incorrect and Fast','(d) Incorrect and Slow'};

for i=1:4
    
    dat=csvread([datname{i},'.csv'],1,1);
    dat(dat==0)=nan;
    
    color=[1.028084769    1.298277959        1.087920287        0.833652854        0.873983021        0.758676028        1.015648237]';
    cn=min(color);cm=max(color);
    color=(color-cn)/(cm-cn)*0.8*ones(1,3);
    subplot(2,2,i)
    for tt=1:length(color)
        plot(dat(1,:),dat(tt+1,:),'k.','Color',color(tt,:));
        hold on
    end
    set(gca,'Fontsize',15,'FontWeight','bold')
    
    
    hold on
    plot([0 dat(1,end)],[1 1],'k-','LineWidth',2)
    mm=max(dat(2:end,:));
    m=max(mm);
    
    axis([0 dat(1,end) 0 m])
    title([Titlename{i}])
    ylabel('A_{AND}(t)')
    xlabel('RT (sec)')
    %     saveas(h,[datname{i} '.jpg']);
    %     close all
    
end
set(gcf,'position',[0,0, 1450, 1000]);
colormap([0:0.01:0.8]'*ones(1,3));
h=colorbar('Position',[     0.9198    0.0978    0.0214    0.8462]);
set(get(h,'ylabel'),'string','S_{dyad}/S_{max}','Fontsize',15);
caxis([cn cm])
h=figure(1);
saveas(h,'Exp1 Assessment','jpg');
saveas(h,'Exp1 Assessment','fig');
saveas(h,'Exp1 Assessment','tif');
%
