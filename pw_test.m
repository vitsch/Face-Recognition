%
% PW_TEST evaluates the performance on test datasets
%
% INPUTS:
% - D are the fold data (test sets)
% - Yc are PWNNs outputs for nf-fold data sets
% - nf is the given number of folds (e.g. 5)
% - learn more about parameters of newff from Matlab Neural Network Toolbox
% - Cij are the pairs of PWNNs prepared by 
% OUTPUT:
% - mp is the mean performance
% - sp is the standard deviation in performance
%
% (C) Vitaly Schetinin, Livia Jakaite, www.nnalb.co.uk
%
nf = 5;
perf = zeros(nf,1);

for ifo = 1:nf
  T2 = D{ifo,4};    % test target
  ntest = length(T2);
  B = Yc{ifo};  % outputs of BCs
  Y = zeros(ntest,noc); % class posterior for test data
  
  for c = 1:noc
    A1 = find(Cij(:,1) == c);
    A2 = find(Cij(:,2) == c);
    B1 = sum(B(:,A1)',1)';    
    B2 = sum(B(:,A2)',1)';    
    Y(:,c) = B1 - B2;
  end
  
  [Ym,Yi] = max(Y');
  perf(ifo) = mean(Yi == T2');
  
  fprintf('fo = %2i perf = %5.3f\n',ifo,perf(ifo))
end

fprintf('mp = %6.4f sp = %6.4f\n',mean(perf),std(perf))
return