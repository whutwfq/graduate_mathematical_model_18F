%交叉算子
function [newChromesome]=crossover(Chromsome,Pucks,Gates,n_gates)
[m,n]=size(Chromsome);
newChromesome=zeros(m,n);
for s=0:1:m/2-1
    chrom1=Chromsome(2*s+1,:);
    chrom2=Chromsome(2*s+2,:);
    pp=floor(rand(1)*n)+1;
    temp=chrom1(pp:end);
    chrom1(pp:end)=chrom2(pp:end);    %交叉操作
    chrom2(pp:end)=temp;
    %% 变异
    [newchrom1]=variation(chrom1,n_gates,pp,Pucks,Gates,n);
    [newchrom2]=variation(chrom2,n_gates,pp,Pucks,Gates,n);
    %%
    newChromesome(2*s+1,:)=newchrom1;
    newChromesome(2*s+2,:)=newchrom2;
end
end
