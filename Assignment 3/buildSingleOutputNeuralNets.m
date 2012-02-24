function neuralNets = buildSingleOutputNeuralNets(P, T, generalizationMethod)
  neuralNets = cell(6, 1);
  for i=1:6
    targets = T(i, :);
    
    %Setup parameters
    hiddenLayers = 2;
    trainingFunction = 'trainlm'; 
    performanceFunction = 'msereg';
    epochs = 100;
    
    if strcmpi(generalizationMethod, 'regularization')
        network = feedforwardnet([15,15], 'trainbr' );
        network.divideFcn = '';
    elseif strcmpi(generalizationMethod, 'earlystop')
        network = feedforwardnet([15,15]);
        network.divideFcn = 'dividerand';
        network.divideMode = 'sample';
        network.divideParam.trainRatio = 0.7;
        network.divideParam.valRatio = 0.3;
        network.divideParam.testRatio = 0.0;
    end
    
    network.trainFcn = trainingFunction;
    for layerNum = 1:hiddenLayers
        network.layers{layerNum}.transferFcn = 'tansig';
    end
    network.performFcn = performanceFunction; 
    network.trainParam.epochs = epochs;
    network.trainParam.lr = 0.001;
    network = configure(network, P, targets);
    
    [neuralNets{i}, ~] = train(network, P, targets);
  end
