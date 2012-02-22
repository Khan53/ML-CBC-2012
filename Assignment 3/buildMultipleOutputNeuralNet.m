function neuralNet = buildMultipleOutputNeuralNet(P, T, generalizationMethod)

    %Setup parameters
    hiddenLayers = 2;
    trainingFunction = 'trainlm'; 
    performanceFunction = 'mse';
    epochs = 100;
    
    if strcmpi(generalizationMethod, 'regularization')        
        network = feedforwardnet(hiddenLayers, 'trainbr' );
        network.divideFcn = '';
    elseif strcmpi(generalizationMethod, 'earlystop')
        network = feedforwardnet(hiddenLayers);
        network.divideFcn = 'dividerand';
        network.divideMode = 'sample';
        network.divideParam.trainRatio = 0.7;
        network.divideParam.valRatio = 0.3;
        network.divideParam.testRatio = 0.0;
    end
 
    network.trainFcn = trainingFunction;
    network.performFcn = performanceFunction; 
    network.trainParam.epochs = epochs;
    network = configure(network, P, T);
    neuralNet = trainbr(network, P, T);