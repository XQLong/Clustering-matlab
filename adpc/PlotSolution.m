%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML101
% Project Title: Evolutionary Automatic Clustering in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function PlotSolution(X, m ,k)

    % Cluster Centers
%     m = sol.Out.m;
    
    % Cluster Indices
    %ind = sol.Out.ind;
    
    Colors = hsv(k);
    plot(X(:,1),X(:,2),'x','LineWidth',1,'Color','red');
    hold on;
    for i=1:size(m,1)
        color = m(i,3);
        if i == 8
            d=1;
        end
        plot(m(i,1),m(i,2),'ok','LineWidth',2,'MarkerSize',12,'Color',Colors(color,:));
    end
    hold off;
    grid on;
    
end