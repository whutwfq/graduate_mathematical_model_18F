clc;clear;close all
%% 飞机转场计划Pucks有用数据
[~,~,raw_pucks]=xlsread('./InputData.xlsx',1);
title=raw_pucks(1,:);
title=[title,'到达时间','出发时间','停机时间'];
date1=raw_pucks(2:end,2);
date2=raw_pucks(2:end,7);
n_puck=length(date1);
select=zeros(n_puck,1);
for i=1:1:n_puck   %取日期为20号的数据
    num1=str2double(date1{i}(end-1:end));
    num2=str2double(date2{i}(end-1:end));
    if(num1==20||num2==20)
        select(i)=1;
    end
end
used_pucks=raw_pucks(2:end,:);
clear num1 num2 %raw_pucks;
for i=0:1:n_puck-1   %删除不是20号的数据
    if(select(n_puck-i)==0)
        used_pucks(n_puck-i,:)=[];
    end
end
clear n_puck;
n_pucks=length(used_pucks);
for i=1:1:n_pucks  %只要日期的后两位数，不要年，只要日，再转化成浮点数
    used_pucks{i,2}=used_pucks{i,2}(end-1:end);
    used_pucks{i,7}=used_pucks{i,7}(end-1:end);
    used_pucks{i,2}=str2double(used_pucks{i,2});
    used_pucks{i,7}=str2double(used_pucks{i,7});
end
for i=1:1:n_pucks   %到达和出发的航班，国内航班记为-1，国际航班记为1
    if(used_pucks{i,5}=='D')
        used_pucks{i,5}=-1;
    elseif(used_pucks{i,5}=='I')
        used_pucks{i,5}=1;
    end
    if(used_pucks{i,10}=='D')
        used_pucks{i,10}=-1;
    elseif(used_pucks{i,10}=='I')
        used_pucks{i,10}=1;
    end
end
for i=1:1:n_pucks   %机型宽记为1，机型窄记为0
    if(isnumeric(used_pucks{i,6}))
        if((used_pucks{i,6}==332)||used_pucks{i,6}==333||used_pucks{i,6}==773)  %宽机型
            used_pucks{i,6}=1;
        elseif(used_pucks{i,6}==319||used_pucks{i,6}==320||used_pucks{i,6}==321||used_pucks{i,6}==323||...
                used_pucks{i,6}==325||used_pucks{i,6}==738)  %窄机型
            used_pucks{i,6}=0;
        end
    else
        if(strcmp(used_pucks{i,6},'33E')||strcmp(used_pucks{i,6},'33H')||strcmp(used_pucks{i,6},'33L'))  %宽机型
            used_pucks{i,6}=1;
        elseif(strcmp(used_pucks{i,6},'73A')||strcmp(used_pucks{i,6},'73E')||strcmp(used_pucks{i,6},'73H')||strcmp(used_pucks{i,6},'73L'))  %窄机型
            used_pucks{i,6}=0;
        end
    end
end
for i=1:1:n_pucks   %时间转化，每天的第多少分钟
    if(isnumeric(used_pucks{i,3}))
        used_pucks{i,3}=used_pucks{i,3}*24*60;
    else
        used_pucks{i,3}=str2double(used_pucks{i,3}(1:2))*60+str2double(used_pucks{i,3}(4:end));
    end
    if(isnumeric(used_pucks{i,8}))
        used_pucks{i,8}=used_pucks{i,8}*24*60;
    else
        used_pucks{i,8}=str2double(used_pucks{i,8}(1:2))*60+str2double(used_pucks{i,8}(4:end));
    end
end
%used_pucks=[title;used_pucks];  %不带标题的pucks数据，共303条
 %% 画每个航班puck的停留时间图
 time=cell(n_pucks,3);
 for i=1:1:n_pucks
     time{i,1}=(used_pucks{i,2}-19)*24*60+used_pucks{i,3}-300;  %5:00
     time{i,2}=(used_pucks{i,7}-19)*24*60+used_pucks{i,8}-300;
     time{i,3}=time{i,2}-time{i,1};
 end
 temp=[used_pucks,time];
 Pucks=cell(size(temp));
 [~,ind]=sort(cell2mat(time(:,1)));  %Pucks 按到达时间顺序排列好的303个有效航班
 for i=1:1:n_pucks                   %Pucks(:,13)到达时间，相较于19 5:00
     Pucks(i,:)=temp(ind(i),:);      %Pucks（:,14)离开时间，相较于19 5:00
 end                                 %Puck(:,15)停机时间
 figure;   %画甘特图
 for i=1:1:n_pucks
            plot([Pucks{i,13},Pucks{i,14}],[i,i],'linewidth',1.5);
            hold on;
 end
 axis([0 (max(cell2mat(Pucks(:,14)))+1) 0 n_pucks+1]);
 xlswrite('./data.xlsx',title,1,'A1');
 xlswrite('./data.xlsx',Pucks,1,'A2');
 %%
 