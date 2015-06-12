%
% MCNN mulriclass neural network trained by backpropagation
%
% INPUTS:
% - xn are the data folds prepared by PW_XN (run first)
% - noff is the number of folds
% - nofhn is the number of hodden neurons
% - learn more about parameters of newff from Matlab Neural Network Toolbox
% Toolbox.
%
% OUTPUT:
% - mp is the mean performance
% - sp is the standard deviation in performance
%
% (C) Vitaly Schetinin, Livia Jakaite, www.nnalb.co.uk
%
load xn D
w = warning ('off','NNET:Obsolete');
noff = 5;   % nof folds
nofhn = 50; % max nof hidden neurons
Ptr = zeros(noff,1); % performance 
nofc1 = max(D{1,2});

for iof = 1:noff
      
    % data for train
    pt = D{iof,1};
    ta = full(ind2vec(D{iof,2}'));
  
    % data for test
    ps = D{iof,3};
    ts = D{iof,4};

    % create and train NN
    net = newff(minmax(pt),[nofhn nofc1],{'purelin' 'purelin'},'trainscg');
    net.trainParam.epochs = 200;
    net.trainParam.goal = 0.01;
    net.trainParam.showWindow = false;
    net.trainParam.showCommandLine = true;

  	net = init(net);
    net = train(net,pt,ta);
    Ys = sim(net,ps);  
    
    [mm,mi] = max(Ys);
    [m1,n1] = size(Ys); 
    Ys = zeros(m1,n1);
    
    for i = 1:n1
      Ys(mi(i),i) = 1;
    end
      
    Ptr(iof,1) = mean(vec2ind(Ys) == ts'); 
    fprintf(' %2i %5.3f\n',iof,Ptr(iof))
end

mp = mean(Ptr);
sp = std(Ptr);
fprintf('Average: mp = %5.3f, sp = %5.3f\n',mp,sp)
return
