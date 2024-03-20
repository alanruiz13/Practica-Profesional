% PCA2: Realiza el calculo de PCA mediante SVD.
% data - MxN matriz de datos de entrada
% (M dimensions, N trials)
% signals - MxN matrix of projected data
% PC - each column is a PC
% V - Mx1 matrix of variances
function [signals,PC,V] = pca2(data)
% [signals,PC,V] = pca2(abs(X(1:100,:)));
[M,N] = size(data);
% subtract off the mean for each dimension
mn = mean(data,2);
data = data - repmat(mn,1,N);
% construct the matrix Y
Y = data' / sqrt(N-1);
% SVD does it all
[u,S,PC] = svd(Y,'econ');
% calculate the variances
S = diag(S);
V = S .* S;
% project the original data
signals = PC' * data;
end