function neualNets = buildSingleOutputNeuralNets(P, T)

  for i=1:6
    selectedT = T(i,:);
    
    network = feedforwardnet(30,'trainlm');
    network = configure(network, P, selectedT); 
    network.trainParam.epochs =100;
    network.trainParam.lr = 0.005;
    network.trainParam.lr_inc = 1.05;
    network.trainParam.goal = 0.01 ;
    network.trainParam.min_grad = 0.01;
    network.performFcn = 'msereg';
    network.performParam.ratio = 0.5;
    
    neualNets(i).net = train(network, P, selectedT);
  end