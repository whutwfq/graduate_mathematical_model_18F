function [newChromsome]=selection(Chromsome,obj,chromnum,n_pucks)
fitness=obj(:,3);
fitness=fitness/sum(fitness);
addfitness=cumsum(fitness); %ÀÛ¼Ó
addfitness=[0;addfitness];
newChromsome=zeros(chromnum,n_pucks);
for i=1:1:chromnum
    pp=rand(1);
    for j=1:1:chromnum
        if(pp>=addfitness(j)&&pp<addfitness(j+1))
            newChromsome(i,:)=Chromsome(j,:);
            break;
        end
    end
end
end