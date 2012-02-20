function neuralNet = getMultiOutputNet(P,T)

  neuralNet = feedforwardnet(30,'trainscg');
  neuralNet = configure(neuralNet,P,T); 
  neuralNet.trainParam.epochs =100;
  neuralNet.trainParam.lr = 0.05;
  neuralNet.trainParam.lr_inc = 1.05;
  neuralNet.trainParam.goal = 0.01 ;
  neuralNet.trainParam.min_grad = 0.01;
  neuralNet.performFcn = 'msereg';
  neuralNet.performParam.ratio = 0.5;

  [neuralNet] = train(neuralNet, P, T);