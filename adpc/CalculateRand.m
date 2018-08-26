function [ Rand ] = CalculateRand(ind1,ind2)
    %遍历每一个数据点
    n = size(ind2,1);
    SS = zeros(n,1);
    SD = zeros(n,1);
    DS = zeros(n,1);
    DD = zeros(n,1);
    %数据聚类后的类编号
    [~,datanum] = sort(zeros(n,1),1);
    num1 = [ind1 datanum];
    num2 = [ind2 datanum];
    for i=1:n-1
        S = findSamaeCluater(ind1,i,num1); %i数据点之后与所有属于同一类的点
        Si = findSamaeCluater(ind2,i,num2); %实际聚类中i数据点之后与所有属于同一类的点
        D = findDefCluater(ind1,i,num1);
        Di = findDefCluater(ind2,i,num2);
        %计算S和Si中的相同点个数
        sam = intersect(S,Si);
        def = intersect(D,Di);
        SS(i,1) = size(sam,1);
        SD(i,1) = size(Si,1)-size(sam,1);
        DS(i,1) = size(S,1) - size(sam,1);
        DD(i,1) = size(def,1);
    end
    %寻找数据i后n-i个点中属于同一类的
    function resultInd =findSamaeCluater(ind,i,num)
        inum = num(i+1:n,:);
        cind = find(inum(:,1)==ind(i));
        %i后与第i个数据点在同一个类中的其他点的索引值iInd
        iInd = cind;
        for k = 1:size(iInd,1)
            iInd(k) = inum(cind(k),2);
        end
        resultInd = iInd;
    end
    %寻找数据i后n-i个点中不属于同一类的
    function resultInd =findDefCluater(ind,i,num)
        inum = num(i+1:n,:);
        cind = find(inum(:,1)~=ind(i));
        %i后与第i个数据点在同一个类中的其他点的索引值iInd
        iInd = cind;
        for k = 1:size(iInd,1)
            iInd(k) = inum(cind(k),2);
        end
        resultInd = iInd;
    end
    Rand = (sum(SS)+sum(DD))/(sum(SS)+sum(DD)+sum(SD)+sum(DS));
end

