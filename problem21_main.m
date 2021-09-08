clc;clear;
[~,~,Pucks]=xlsread('./data.xlsx',1);
Pucks(1,:)=[];
n_pucks=length(Pucks);
%
[~,~,Tickets]=xlsread('./data.xlsx',2);
Tickets(1,:)=[];
n_tickets=length(Tickets);
%
[~,~,Gates]=xlsread('./data.xlsx',3);
Gates(1,:)=[];
n_gates=length(Gates);
%
sign=zeros(n_tickets,3);  %1来乘坐的  2出发乘坐的
for i=1:1:n_tickets
    for j=1:1:n_pucks
       if(Tickets{i,4}==Pucks{j,2}&&strcmp(Tickets{i,3},Pucks{j,4}))
           sign(i,1)=j;  %第i个乘客乘坐第j个航班，到达
           sign(i,3)=sign(i,3)+1;
       end
    end
end
for i=1:1:n_tickets
    for j=1:1:n_pucks
       if(Tickets{i,6}==Pucks{j,7}&&strcmp(Tickets{i,5},Pucks{j,9}))
           sign(i,2)=j;  %第i个乘客乘坐第j个航班，出发
           sign(i,3)=sign(i,3)+1;
       end
    end
end
fake=0;
dele=zeros(n_tickets,1);
for i=1:1:n_tickets
   if(sign(i,3)<2)
       fake=fake+1;
       dele(i)=1;
   end
end
xlswrite('./data.xlsx',sign,2,'G2');
[~,~,Tickets]=xlsread('./data.xlsx',2);
xlswrite('./data.xlsx',Tickets(1,:),4);
Tickets(1,:)=[];
for i=0:1:n_tickets-1
    if(dele(n_tickets-i)==1)
        Tickets(n_tickets-i,:)=[];
    end
end
xlswrite('./data.xlsx',Tickets,4,'A2');