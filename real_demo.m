clear,clc
currentFolder = pwd;
addpath(genpath(currentFolder))

load finsen.mat;
Img = finsen;

%%% for horizontal stripes
Y=Img;
% %%% for vertical stripes
% Y=rot90(Y);

[M,N,B]=size(Y);

%%% Parameters
param.p = 2;             %%% dense stripes: 2, sparse stripes: 1
param.lambda1 = 1e-03;   %%% dense stripes, recommend: 1e-03; sparse stripes, recommend: 1e-04
param.lambda2 = 100;     %%% dense stripes, recommend: 100; sparse stripes, recommend: 3
param.beta = 0.01;
param.lambda_gp = 2500;  %%% dense: 2500, sparse: 5000

param.eps = 1e-05;
param.MaxIter = 50;  

%%%Ìõ´øÈ¥³ı
clean_HSI=LRHP_destripe(Y,param);
% %%% for vertical stripes
% clean_HSI=rot90(clean_HSI,-1);