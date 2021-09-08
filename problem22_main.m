% 按飞机到达顺序依次按安排停机位
clc;clear
[~,~,Pucks]=xlsread('./data.xlsx',1);
Pucks(1,:)=[];
[~,~,Gates]=xlsread('./data.xlsx',3);
Gates(1,:)=[];
[~,~,Tickets]=xlsread('./data.xlsx',4);
Tickets(1,:)=[];
n_tickets=length(Tickets);
n_pucks=length(Pucks);
n_gates=length(Gates);
chromnum=50;   %种群染色体条数
N=100;      %迭代次数
Nbestfitness=zeros(N,4);       %记录每一代最佳适应度  1目标1  2目标2  3目标3   4fitness
Nbestchrom=zeros(N,n_pucks);   %记录没一代最优个体
%% 产生初始种群
[Chromsome]=initpop(Pucks,Gates,chromnum);
for gen=1:1:N
    %% 计算适应度，记录最优个体
    [obj,bestchrom,bestfitness]=cal_fitness2(Chromsome,Pucks,Tickets,n_pucks,n_gates,n_tickets);
    Nbestfitness(gen,:)=bestfitness;
    Nbestchrom(gen,:)=bestchrom;
    %% 选择算子
    [Chromsome]=selection2(Chromsome,obj,chromnum,n_pucks);
    %% 交叉变异算子
    [Chromsome]=crossover(Chromsome,Pucks,Gates,n_gates);
end
mostbest=zeros(N,1);
mostbest(1)=Nbestfitness(1,4);
IND=1;
for i=2:1:N
    if(Nbestfitness(i,4)<mostbest(i-1))
        mostbest(i)=mostbest(i-1);
    else
        mostbest(i)=Nbestfitness(i,4);
        IND=i;
    end
end
X=randperm(N);
X=sort(X);
for i=1:1:4
    figure(i);
    plot(X,Nbestfitness(:,i));
end
figure(5);
plot(X,mostbest);
disp(Nbestfitness(IND,:));
disp(Nbestchrom(IND,:));
result=Nbestchrom(IND,:);
cishu=zeros(n_gates,1);  %每个登机口用的次数
for i=1:1:n_gates
    for j=1:1:n_pucks
        if(result(j)==i)
            cishu(i)=cishu(i)+1;
        end
    end
end