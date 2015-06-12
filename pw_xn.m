%
% PW_XN forms data for nf cross-validation. It also normalises data and can
% add noise to main components.
% 
% INPUTS:
% - file_name = Faces94.mat, ORL.mat, Yale.mat
% - eps is the noise level (0., ...,1.2) added to principal components
% - nf is the number of folds
% - varpc is the maximum fraction of variance for components to be removed after
% PCA
% 
% OUTPUT:
% - D is the cell array containing nf data folds 
%
% (C) Vitaly Schetinin, Livia Jakaite
%
file_name = 'Yale1.mat'; % ORL, Yale, or Faces94
load(file_name); % data: images x pixels, target 1 x images

eps = 0;        % noise level
nf = 5;         % nof folds
varpc = 0.0001;     % nof PC
 
n1 = size(data,2); % nof images
X = zeros(size(data)); % matrix for normalised data

for i = 1:n1
  A = data(:,i);
  mm = minmax(A');
  A = 255*(A - mm(1))/(mm(2) - mm(1));  % mormalise grey images within [0,255]
  X(:,i) = A;
end

[m1,n1] = size(X);
T = target; 

% data for nf-fold cross validation
D = cell(nf,4); % train data, train target, test data, test target

for ifo = 1:nf
  fprintf('ifo = %4i \n',ifo)
  
  % data indeces I1 and I2 for train  and test subsets, respectively   
  I2 = ifo:nf:n1;      
  I1 = 1:n1;           
  I1(I2) = [];        
  
  X1 = X(:,I1);
  T1 = T(I1);
  X2 = X(:,I2);
  T2 = T(I2);
  
  % make principal components for train and test data    
  [X1p, Coef] = processpca(X1, varpc);  % for train
  [X1p,PS] = mapstd(X1p);          % normalising
  
  X2p = processpca('apply', X2, Coef); 
  
%   %
%   Xrev_map = mapstd('reverse',X1p,PS);
%   Xrev = processpca('reverse',Xrev_map,Coef);
%   Ir = reshape(Xrev(:,1),32,32);
%   figure; imagesc(Ir); colormap(gray);
  %
  
  X2p = mapstd('apply',X2p,PS);   % normalising
  
  % add noise to principal compnents for train anf test
  D{ifo,1} = (X1p + eps*randn(size(X1p)));  % for train
  D{ifo,2} = T1';
  D{ifo,3} = (X2p + eps*randn(size(X2p))); % for test
  D{ifo,4} = T2';
end

save xn D eps
return
