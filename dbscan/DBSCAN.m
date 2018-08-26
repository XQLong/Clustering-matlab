function [IDX, isnoise]=DBSCAN(X,epsilon,MinPts)
    %簇编号
    C=0;
    %数据集大小
    n=size(X,1);
    %数据对象簇标识数组
    IDX=zeros(n,1);
    %计算两两数据的距离得到距离n*n矩阵D
    D=pdist2(X,X);
    %将所有标记状态置位为未处理
    visited=false(n,1);
    isnoise=false(n,1);
    %遍历所有对象
    for i=1:n
        if ~visited(i)
            %如果对象未处理，则进行处理并将标记置为已读
            visited(i)=true;
            %获取对象epsilon邻域的索引值
            Neighbors=RegionQuery(i);
            %将邻域内包含的对象个数与MinPts比较
            if numel(Neighbors)<MinPts
                % X(i,:) 是噪声
                isnoise(i)=true;
            else
                %创建以X(i,:)核心对象的簇C
                C=C+1;
                %迭代地聚集从这些核心对象直接密度可达的对象 
                ExpandCluster(i,Neighbors,C);
            end
            
        end
    end
    
    function ExpandCluster(i,Neighbors,C)
        %标记第i个对象在簇C中
        IDX(i)=C;
        k = 1;
        while true
            j = Neighbors(k);
            %如果此对象未被处理
            if ~visited(j)
                visited(j)=true;
                Neighbors2=RegionQuery(j);
                if numel(Neighbors2)>=MinPts
                    %对epsilon邻域对象数组进行扩充
                    Neighbors=[Neighbors Neighbors2];   %#ok
                end
            end
            %如果此对象未被标记簇C
            if IDX(j)==0
                IDX(j)=C;
            end
            
            k = k + 1;
            
            if k > numel(Neighbors)
                break;
            end
        end
    end

    %获取对象的epsilon邻域对象，返回其索引值
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=epsilon);
    end
end
