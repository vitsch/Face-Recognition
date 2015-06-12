%
% PW_NN trains pairwise neural networks (PWNN)
%
% INPUTS:
% - nofhn is the number of hidden neurons
% - nf is the given number of folds (e.g. 5)
% - learn more about parameters of newff from Matlab Neural Network Toolbox
% - Cij are the pairs of PWNNs prepared by 
% OUTPUT:
% - Yc are the outputs of PWNNs for nf fold data sets
%
% (C) Vitaly Schetinin, Livia Jakaite, www.nnalb.co.uk
%
nohn = 1;   % nof hidden neurons

for ifo = 1:nf
  fprintf('ifo = %4i \n',ifo)

  X1 = D{ifo,1};  % train data
  T1 = D{ifo,2};
  X2 = D{ifo,3};  % test data
  T2 = D{ifo,4};
    
  ntest = size(X2,2);
  Yij = zeros(ntest,nobc);    % outcomes of binary classifiers

  net = newff(minmax(X1),[nohn 1],{'tansig' 'tansig'},'trainlm'); 
  net.trainParam.showWindow = false;
  net.trainParam.epochs = 100; 
  net.trainParam.goal = 0.01;

  for ic = 1:nobc
    
    % data indeces for classes i & j
    
    I1 = find(T1 == Cij(ic,1));
    I2 = find(T1 == Cij(ic,2));
    n1 = length(I1);
    n2 = length(I2);
    
    T = [ones(n1,1); -1.*ones(n2,1)]'; % target for binary classifier
    X = [X1(:,I1) X1(:,I2)]; 
    
    net = init(net);
    net = train(net,X,T);
    Yij(:,ic) =  sim(net,X2); % output of classifier ic
  end

  Yc{ifo} = Yij;
end
return
