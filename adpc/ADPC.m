clc;
clear;
close all;

%% 数据载入
%data = load('E:\0\lw\workplace1\dataset\Aggregation.mat');
%data = load('E:\0\lw\workplace1\dataset\Spiral.mat');
data = load('E:\0\lw\workplace1\dataset\D31.mat');
%data = load('mydata.mat');
X = data.A(:,1:2);
XCluster = data.A(:,3); %已知的数据分类情况
%% 定义参和函数
XSize = size(X,1); %数据大小
D=pdist2(X,X); %数据中个点的距离矩阵
r = unifrnd(0,1); % 0-1之间的随机值r
CenterFunction=@(s) ClusteringCenter(s, X);
%% 局部密度与较大密度最小距离计算
[P,R,RSort,RInd,dc]= ClusteringCenter(r,X,D);
%% 寻找聚类中心
[XC,centers,k]= FindCenter(dc,X,R,RInd);
% 显示找出的聚类中心
figure(2);
PlotSolution(X, centers,k); %centers为疑似聚类中心，k为个数
%% 按找到的疑似聚类中心聚类
[CInd] = Clustering(XC,D,P);
%% 显示聚类结果
figure(3);
PlotClusterinResult(X, CInd);
%% 计算聚类Rand系数
[Rand] = CalculateRand(XCluster,CInd);
title(['DPC Clustering (\dc = ' num2str(dc) ', Ri = ' num2str(Rand) ')']);
disp(['Rand系数为:',num2str(Rand)]);
