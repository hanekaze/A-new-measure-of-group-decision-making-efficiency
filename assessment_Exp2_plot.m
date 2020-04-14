datname={'Exp2 and cf','Exp2 and cs','Exp2 and if','Exp2 and is'};

color1=[1.048 1.492 1.836 1.25 1.545 1.583 1.141 1.125 1.845 1.223 1.131 1.815 1.166]';
color2=[0.996 0.692 0.571 0.403 0.900 0.209 0.353 0.625 1.341 0.345 ]';
num=[color1;color2];
cn=min(num);cm=max(num);
color=(num-cn)/(cm-cn)*0.8*ones(1,3);
Titlename={'(a) Correct and Fast','(b) Correct and Slow','(c) Incorrect and Fast','(d) Incorrect and Slow'};
for i=1:4
    subplot(2,2,i);
    hold on
    dat=csvread([datname{i},'.csv'],1,1);
    dat(dat==0)=nan;
    for tt=[1:length(num)]
        plot(dat(1,:),dat(tt+1,:),'k.','Color',color(tt,:));
        hold on
    end
    plot([0 dat(1,end)],[1 1],'k-','LineWidth',2)
    mm=max(dat(2:end,:));
    m2=max(mm);
    
    set(gca,'Fontsize',15,'FontWeight','bold')
    axis([0 2 0 m2])
    title([Titlename{i}])
    ylabel('A_{AND}(t)')
    xlabel('RT (sec)')
    
    
    
end
set(gcf,'position',[0,0, 1300, 1000]);
colormap([0:0.01:0.8]'*ones(1,3));
h=colorbar('Position',[     0.9198    0.0978    0.0214    0.8462]);
set(get(h,'ylabel'),'string','S_{dyad}/S_{max}','Fontsize',15);
caxis([cn cm])

h=figure(1);
saveas(h,'Exp2 Assessment','jpg');
saveas(h,'Exp2 Assessment','fig');
saveas(h,'Exp2 Assessment','tif');