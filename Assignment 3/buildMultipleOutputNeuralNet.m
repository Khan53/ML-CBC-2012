function neuralNet = buildMultipleOutputNeuralNet(P, T)

    %Setup parameters
    hiddenLayers = 10;
    trainingFunction = 'trainlm'; 
    performanceFunction = 'mse';
    epochs = 100;

    network = feedforwardnet(hiddenLayers);
    network.trainFcn = trainingFunction;
    network.performFcn = performanceFunction; 
    network.trainParam.epochs = epochs;
    network = configure(network, P, T);
    neuralNet = train(network, P, T);

%   neuralNet = feedforwardnet(30,'trainscg');
%   neuralNet = configure(neuralNet,P,T); 
%   neuralNet.trainParam.epochs =100;
%   neuralNet.trainParam.lr = 0.05;
%   neuralNet.trainParam.lr_inc = 1.05;
%   neuralNet.trainParam.goal = 0.01 ;
%   neuralNet.trainParam.min_grad = 0.01;
%   neuralNet.performFcn = 'msereg';
%   neuralNet.performParam.ratio = 0.5;
% 
%   [neuralNet] = train(neuralNet, P, T);