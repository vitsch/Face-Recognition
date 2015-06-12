%
% pw_nn5 - run nf-fold cross validation for pairwise neural networks (PWNN) nrun times  
%
% INPUTS:
% - xn are the data folds prepared by PW_XN (run first)
% - nrun is the number of times to run nf-fold cross validation
% - nf is the given number of folds (e.g. 5)
% - 
% CALLS:
% - PW__NN
% - PW_TEST
%
% OUTPUT
% - mp is the mean performance
% - sp is the standard deviation in performance
% - CiJ are the pairs of PWNNs
%
% (C) Vitaly Schetinin, Livia Jakaite, www.nnalb.co.uk
%
load xn D eps    %  data

nrun = 1;               % nof runs
nf = size(D,1);         % nof folds
T = [D{1,2}; D{1,4}];
noc = max(T);           % nof classes in the data

Cij = combnk(1:noc,2);  % pairwise classifiers indeces  
nobc = size(Cij,1);
Yc = cell(nf,1);
perf_f = [];


for irun = 1:nrun
  fprintf('\n %i run, noise = %5.3f:\n',irun,eps)
  
  pw_nn;            % Train parwise neural nets (PWNN)
  pw_test;          % Test PWNN
  
  perf_f = [perf_f; perf];
end

mp = mean(perf_f);
sp = std(perf_f);
fprintf('\nnoise = %5.3f, mp = %5.3f, sp = %5.3f\n',eps,mp,sp)
return