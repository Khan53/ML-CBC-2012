function neuralNet = buildMultipleOutputNeuralNet(P, T, generalizationMethod)

    %Setup parameters
    hiddenLayers = 2;
    performanceFunction = 'mse';
    epochs = 100;
    
    %Depending on the generalization method provided
    %the code performs either earlystopping or BR
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
    
    for layerNum = 1:hiddenLayers
        network.layers{layerNum}.transferFcn = 'tansig';
    end
    network.trainFcn =  'trainlm';
    network.performFcn = performanceFunction; 
    network.trainParam.epochs = epochs;
    network.trainParam.lr = 0.001;
    network = configure(network, P, T);
    neuralNet = train(network, P, T);