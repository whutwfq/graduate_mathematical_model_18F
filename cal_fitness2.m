%obj(:,1)目标1  obj(:,2)目标2  obj(:,3)fitness
%bestchrom 最优个体，  bestfitness最优个体对应的fitness
function [obj,bestchrom,bestfitness]=cal_fitness2(Chromsome,Pucks,Tickets,n_pucks,n_gates,n_tickets)
[chromnum,~]=size(Chromsome);
obj=zeros(chromnum,4);  %1目标函数1  2目标函数2  3目标3  4适应度函数
for i=1:1:chromnum
    chrom=Chromsome(i,:);
    park_out=sum(chrom==70);  %  min停机在临时点的航班数  max(303-park_out)
    init=ones(n_gates,1);    %没被用的登机口
    for m=1:1:n_gates
        for j=1:1:n_pucks
            if(chrom(j)==m)
                init(m)=0;  %被用
            end
        end
    end
    freegates=sum(init);     % max没有用的停机口数
    obj(i,1)=303-park_out;      % max安排到合适停机口的航班数  max(303-park_out)
    obj(i,2)=freegates;         % max没有用的停机口数
    minprocesstime=0;
    time=0;
    for ii=1:1:n_tickets
        indcome=Tickets{ii,7};
        indgo=Tickets{ii,8};
        people=Tickets{ii,2};
        park1=chrom(indcome);
        park2=chrom(indgo);
        if(park1<=28)
            place1=0;
        else
            place1=1;
        end
        if(park2<=28)
            place2=0;
        else
            place2=1;
        end
        type1=Pucks{indcome,5};
        type2=Pucks{indgo,10};
        if(type1==-1&&type2==-1)
            if(place1+place2~=1)
                time=15;
            else
                time=20;
            end
        end
        if(type1==-1&&type2==1)
            if(place1+place2~=1)
                time=35;
            else
                time=40;
            end
        end
        if(type1==1&&type2==-1)
            if(place1+place2==1)
                time=40;
            elseif(place1+place2==0)
                time=35;
            else
                time=45;
            end
        end
        if(type1==1&&type2==1)
            if(place1+place2~=1)
                time=20;
            else
                time=30;
            end
        end
        time=time*people;
        minprocesstime=minprocesstime+time;  %最短流程时间
    end
    obj(i,3)=minprocesstime;     %最短流程时间 越小越好
end
obj(:,4)=obj(:,1)+obj(:,2)-obj(i,3)/1000;
[~,ind]=max(obj(:,4));  %~最大的适应度值，ind它的索引
bestfitness=obj(ind,:);  %每一代
bestchrom=Chromsome(ind,:);    %每一代
end