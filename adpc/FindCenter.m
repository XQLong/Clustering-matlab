function [XC,centers,Count] = FindCenter(dc,X,R,RInd)
    num = size(X,1);
    x = [X zeros(num,1)];
    %确定聚类中心,及其属性标记
    %计算R排序后的前后变化大小矩阵gama
    Rsort = sort(R,1,'descend');
    gama = zeros(num,1);
    gama(1) = 0;
    for i=1:num-1
        gama(i) = abs(Rsort(i)-Rsort(i+1));
    end
    [G GInd]= sort(gama,1,'descend'); % GInd为数据按照gama降序排列后引值
    gmeans = mean(G(2:num));
    gInd  = find(gama>gmeans); %截取gama值大于平均值的数据点作为疑似聚类中心
    k = size(gInd,1);
    GInd = GInd(1:k,:);
    xIndex = RInd(GInd); %找到疑似聚类中心的索引值
    m=x(xIndex,:); %存储疑似聚类中心点
    %PlotSolution(X, [m(:,1:2) ones(size(m,1),1)],1);
    %计算聚类中心之间的距离，确定聚类个数
    CenterD = pdist2(m(:,1:2),m(:,1:2));
    cnum = 1;
    count = 0;%初始化聚类中心个数
    for i=1:k
        minid = find(CenterD(i,:)<2*dc);
        if ~m(i,3)
            count = count +1;
            if isempty(minid)
                m(i,3) = cnum;
            else
                m(minid,3) = cnum;
            end
            cnum = cnum +1;
        end
    end
    x(xIndex,3) = m(:,3);
    centers = m;
    Count = count;
    XC = x;
end

