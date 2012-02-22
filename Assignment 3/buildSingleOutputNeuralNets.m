function neuralNets = buildSingleOutputNeuralNets(P, T)
  neuralNets = cell(6, 1);
  for i=1:6
    targets = T(i, :);

    %Setup parameters
    hiddenLayers = 2;
    trainingFunction = 'trainlm'; 
    performanceFunction = 'mse';
    epochs = 100;
    trainRatio = 0.85;
    validationRatio = 0.15;
    divideFunc = 'dividerand'; 
    divideMode = 'sample'; 
    testRatio = 0.0;
    
    network = feedforwardnet(hiddenLayers);
    network.trainFcn = trainingFunction;
    network.performFcn = performanceFunction; 
    network.trainParam.epochs = epochs;
    network = configure(network, P, targets);
    network.divideFcn = divideFunc;
    network.divideMode = divideMode;
    network.divideParam.trainRatio = trainRatio;
    network.divideParam.valRatio = validationRatio;
    network.divideParam.testRatio = testRatio;
    [neuralNets{i}, ~] = train(network, P, targets);
  end
  
%   for i=1:6
%     selectedT = T(i,:);
%     
%     network = feedforwardnet(30,'trainlm');
%     network = configure(network, P, selectedT); 
%     network.trainParam.epochs =100;
%     network.trainParam.lr = 0.005;
%     network.trainParam.lr_inc = 1.05;
%     network.trainParam.goal = 0.01 ;
%     network.trainParam.min_grad = 0.01;
%     network.performFcn = 'msereg';
%     network.performParam.ratio = 0.5;
%     
%     neualNets(i).net = train(network, P, selectedT);
%   end