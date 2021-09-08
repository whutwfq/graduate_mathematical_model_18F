%obj(:,1)目标1  obj(:,2)目标2  obj(:,3)fitness
%bestchrom 最优个体，  bestfitness最优个体对应的fitness
function [obj,bestchrom,bestfitness]=cal_fitness(Chromsome,n_pucks,n_gates)
[chromnum,~]=size(Chromsome);
obj=zeros(chromnum,3);  %1目标函数1  2目标函数2  3适应度函数
for i=1:1:chromnum
    chrom=Chromsome(i,:);
    park_out=sum(chrom==70);  %  min停机在临时点的航班数  max(303-park_out)
    init=ones(n_gates,1);
    for m=1:1:n_gates
        for j=1:1:n_pucks
            if(chrom(j)==m)
                init(m)=0;  %被用
            end
        end
    end
    freegates=sum(init);   % max没有用的停机口数
    obj(i,1)=303-park_out;      % max安排到合适停机口的航班数  max(303-park_out)
    obj(i,2)=freegates;         % max没有用的停机口数
end
%obj(:,3)=10*exp((obj(:,1)-min(obj(:,1)))/10+(obj(:,2)-min(obj(:,2)))/2);  %fitness,越大越好
%obj(:,3)=(obj(:,1)-200)+obj(:,2)*5;
obj(:,3)=obj(:,1)+obj(:,2);
[~,ind]=max(obj(:,3));  %~最大的适应度值，ind它的索引
bestfitness=obj(ind,:);  %每一代
bestchrom=Chromsome(ind,:);    %每一代
end