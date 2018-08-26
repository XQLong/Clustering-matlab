clc
clear
data = load('E:\0\lw\workplace1\dataset\Spiral.mat');
%data = load('E:\0\lw\workplace1\dataset\nba.mat');
x = data.A(:,1:2);
%x = data.X(:,1:2);
%x = data.data.A;
%name = data.data.name(:,2);
n = size(x,1);
k=3;
z=zeros(k,2);
z1=zeros(k,2);
z=x(100:k+99,1:2);
% z=[5,2.5;
%    7,12;
%    9,22;
%    18,8;
%    22,23;
%    33,9;
%    33,23
%     ];
ind1 = zeros(n,1);
num = 0;
while 1
    num = num + 1;
    %计算样本数据到聚类中心的距离
    d = pdist2(x,z); %n行k列的距离矩阵
    [dmin, ind] = min(d, [], 2);
    if(ind1 == ind)
        break;
    end
    ind1 = ind;
    %计算新的聚类中心
    pause(0.01);
    PlotClusterinResult(x,ind,z);
    for i=1:k
        m = x(ind==i,:);
        z1(i,:) = mean(m);
    end
    if (z == z1)
        break;
    else
        z=z1;
    end
end
%聚类结果展示
% a = size(name,1);
% cluster = cell(a,2);
% for i=1:a
%     c = {num2str(ind(i))};
%     cluster(i,1) = name(i);
%     cluster(i,2) = c;
% end
% group = cell(k,1);
% for i=1:k
%     hh = 0;
%     disp(['第',num2str(i),'组球员有：']);
%     for j=1:a
%         if ismember(num2str(i),cluster(j,2))
%             hh = hh + 1;
%             fprintf('%s',[char(cluster(j,1)),' ，']);
%             if hh==10
%                 fprintf('%d\n','');
%             end
%         end
%     end
%     fprintf('%d\n','');
% end
