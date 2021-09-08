%%  登机口数据Gates
% title=      1登机口，    2终端厅（T\S)，     3区域，          4到达类型（D=-1国内，I=1国际，DI=0)
%     5出发类型（D=-1国内，I=1国际，DI=0)，    6机体类别（W=1宽，N=0窄）  7登机口区域
clc;clear;
[~,~,raw_gates]=xlsread('./InputData.xlsx',3);
% title=raw_gates(1,:);
title={'1登机口','2终端厅（T\S)','3区域','4到达类型（D=-1国内，I=1国际，DI=0)','5出发类型（D=-1国内，I=1国际，DI=0)',...
 '6机体类别（W=1宽，N=0窄）','7登机口区域'};
used_gates=raw_gates(2:end,:);
clear raw_gates;
Rgates=used_gates(:,4);  %到达类型
Lgates=used_gates(:,5);  %出发类型
Typegates=used_gates(:,6);  %机体类型
n_gates=length(used_gates);
for i=1:1:n_gates
    %到达，D=-1; I=1; D,I=0
    if(length(Rgates{i})==1)
        if(Rgates{i}=='D')
            Rgates{i}=-1;
            used_gates{i,4}=-1;
        end
        if(Rgates{i}=='I')
            Rgates{i}=1;
            used_gates{i,4}=1;
        end
    elseif(length(Rgates{i})==4)
        Rgates{i}=0;
        used_gates{i,4}=0;
    end
    %出发，D=-1; I=1; D,I=0
    if(length(Lgates{i})==1)
        if(Lgates{i}=='D')
            Lgates{i}=-1;
            used_gates{i,5}=-1;
        end
        if(Lgates{i}=='I')
            Lgates{i}=1;
            used_gates{i,5}=1;
        end
    elseif(length(Lgates{i})==4)
        Lgates{i}=0;
        used_gates{i,5}=0;
    end
end
 for i=1:1:n_gates  %6机体宽窄类别
    %机体类别，宽W=1,窄N=0
    if(Typegates{i}=='W')
        Typegates{i}=1;
        used_gates{i,6}=1;
    end
    if(Typegates{i}=='N')
        Typegates{i}=0;
        used_gates{i,6}=0;
    end
 end
 location=cell(n_gates,1);
 for i=1:1:n_gates
     if(used_gates{i,2}=='T'&&used_gates{i,3}(1)=='N')
         location{i}=1;
     elseif(used_gates{i,2}=='T'&&used_gates{i,3}(1)=='C')
         location{i}=2;
     elseif(used_gates{i,2}=='T'&&used_gates{i,3}(1)=='S')
         location{i}=3;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='N')
         location{i}=4;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='C')
         location{i}=5;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='S')
         location{i}=6;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='E')
         location{i}=7;
     end
 end
 Gates=[used_gates,location];
 xlswrite('./data.xlsx',title,3,'A1');
 xlswrite('./data.xlsx',Gates,3,'A2');