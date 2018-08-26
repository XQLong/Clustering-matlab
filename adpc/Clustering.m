function [CInd] = Clustering(XC,D,P)
    num = size(XC,1);
    x = XC;  
    hold on;
    %将密度距离属性降序排列
    [p pind] = sort(P,1,'descend');
    for i=1:num
        %按数据点的密度从大到小进行处理
        if x(pind(i),3)==0
            disp(num2str(pind(i)));
            ClusterOthers(D,P,pind(i));
        end
    end
    
    function ClusterOthers(D,P,ind)
        near = ind; %搜寻聚类中心的点
        while 1
            [n,~] = find(P>P(near));
            if isempty(n)
                [~, di]=sort(D(ind,Cen(:,3)));
                x(ind,3) = Cen(di(1),3);
                break;
            end
            d=[D(n,near) n];
            [~,qSort] = sort(d(:,1),1);
            q=d(qSort(1),2); %取最近点的索引值
            % [~,q] =find(Dist(near,:)==min(Dist(near,n)));
            if x(q,3) %若该近邻点为聚类中心
                x(ind,3) = x(q,3);
                break;
            else
                near = q;
            end
        end
    end
    CInd = x(:,3);
end

