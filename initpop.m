%% 产生初始种群
function [Chromsome]=initpop(Pucks,Gates,chromnum)
n_pucks=length(Pucks);
n_gates=length(Gates);
Chromsome=zeros(chromnum,n_pucks); 
for m=1:1:chromnum
% 产生一条染色体
    chrom=zeros(1,n_pucks);
    dtime=cell(n_gates,1);  %记录每个登机口飞机离开的时间
    for i=1:1:n_gates
        dtime{i}=[];   %第i个停机口飞机离开时间
        dtime{i}(1,1)=-45;
    end
    for i=1:1:n_pucks
        ind=randperm(n_gates);
        for j=1:1:n_gates+1
            if(j<=n_gates)
                if(Pucks{i,5}*Gates{ind(j),4}>=0&&Pucks{i,10}*Gates{ind(j),5}>=0&&...
                        Pucks{i,6}==Gates{ind(j),6}&&Pucks{i,13}-dtime{ind(j)}(end)>=45)
                    dtime{ind(j)}(end+1)=Pucks{i,14};
                    chrom(i)=ind(j);
                    break;
                end
            else
                chrom(i)=70;  %临时停机位
            end
        end
    end
    Chromsome(m,:)=chrom;
end
end