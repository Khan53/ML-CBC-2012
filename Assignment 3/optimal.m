function optimal()
    % loading test data ( inputData data -> rows in AUs, labels -> emotion enum)
    [inputData,labels] = loaddata('cleandata_students.txt');

    maxFMeasure = 0;
    bestNetwork = feedforwardnet([]); % just a default value

    % parameters which vary
    transferFunctions = {'tansig','logsig','purelin'};
    [~, transferFunctionsNum] = size(transferFunctions);

    % constant parameters
    epochsNumber = 200;

    iterationCounter = 1;

    % divide the data once - in order to reduce the randomness of the search,
    % all networks will be using the same set to do training and validation
    % train set = 80%, test set = 20%
    [trainSet, testSet] = computeTrainingTestSets(inputData, labels, 0.8);

    % Brute force, iterate through the space of all parameters
    for hiddenLayersNumber = 1:6
        if hiddenLayersNumber == 1
            layerSizeMax = 50;
        elseif hiddenLayersNumber == 2
            layerSizeMax = 30;   
        else
            layerSizeMax = 20; 
        end
        for hiddenLayerSize = 22:22
            for epochsNumber = 150:150

                % for layerNumber = 1:hiddenLayersNumber
                % net.layers{layerNumber}.transferFcn = transferFunctions{transferFunctionIndex};
                % end

                % Build the network with appropirate hidden layers
                hiddenLayers = zeros(1,hiddenLayersNumber);
                hiddenLayers = arrayfun(@(x) hiddenLayerSize, hiddenLayers);
                net = feedforwardnet(hiddenLayers, 'trainbr');

                % Set all constant parameters
                net.trainParam.epochs = epochsNumber;

                % Disable training info
                net.trainParam.showWindow = false;
                net.trainParam.showCommandLine = false;

                % Check network performans. In order to roboustly measure the
                % performance, perform validation five times and take 
                % the average
                validationsNum = 5;
                fMeasures = zeros(1, validationsNum);
                for i = 1:validationsNum
                    % compute performance with train set = 80%, test set = 20%
                    fMeasure = computeNetworkPerformance(net, trainSet, testSet);
                    fMeasures(i) = fMeasure;
                end
                fMeasure = mean(fMeasures);

                % Update best so far if required
                if (fMeasure > maxFMeasure)
                   maxFMeasure = fMeasure;
                   bestNetwork = net;
                end

                % Log the results
                date = datestr(now);
                logString([date ' - Iteration Counter: ' num2str(iterationCounter) ', Train Function: ' net.trainFcn ', Layer Number: ' num2str(net.numLayers) ', Layer Size: ' num2str(net.layers{1}.size) ', Epochs Number: ' num2str(epochsNumber) ', FMeasure: ' num2str(fMeasure)]);

                iterationCounter = iterationCounter + 1;
            end
        end
    end

    logString('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    logString('Best result: ');
    logString(['Layer Number: ' num2str(bestNetwork.numLayers)]); 
    logString(['Layer Size: ' num2str(bestNetwork.layers{1}.size)]);
    logString(['FMeasure: ' num2str(maxFMeasure)]);
end

function [ trainSet, testSet ] = computeTrainingTestSets( inputData, labels, trainRatio )

    % divide the data into training data and test data. Test data must
    % accurately resemble the underlying distribution of all available data
    testDataIndex = round(trainRatio * 100);
    outputData = equalSampling(inputData,labels,trainRatio);
    trainSet = outputData(1:testDataIndex, :);
    testSet = outputData((testDataIndex+1):end, :);

end

function [ outputData ] = equalSampling( data ,labels ,learnR)

    [dataRows, ~] = size(data);

    happiness = [];
    sadness = [];
    anger = [];
    fear =[];
    disgust = [];
    surprise = [];
    training = [];
    validation = [];
    test = [];

    % paring data and alocating to specific vectors

        for counter = 1 : (dataRows)

            n = labels(counter);

            switch n
                case 1
                    % anger
                    anger = [anger; data(counter,:) n];
                case 2
                    % disgust
                    disgust = [disgust; data(counter,:) n];
                case 3
                    % fear
                    fear = [fear; data(counter,:) n];
                case 4
                   % happiness 
                    happiness = [happiness; data(counter,:) n];
                case 5
                    % sadness
                    sadness = [sadness; data(counter,:) n];
                case 6
                    % surprise
                    surprise = [surprise; data(counter,:) n];
            end 

        end


        [A,B] = devideData(anger,learnR);
        training = [training;A];
        validation = [validation;B];

        [A,B] = devideData(disgust,learnR);
        training = [training;A];
        validation = [validation;B];

        [A,B] = devideData(fear,learnR);
        training = [training;A];
        validation = [validation;B];

        [A,B] = devideData(happiness,learnR);
        training = [training;A];
        validation = [validation;B];

        [A,B] = devideData(sadness,learnR);
        training = [training;A];
        validation = [validation;B];

        [A,B] = devideData(surprise,learnR);
        training = [training;A];
        validation = [validation;B];

        trainingOrder = randperm(size(training,1));
        validationOrder = randperm(size(validation,1));

        training = training(trainingOrder,:);
        validation = validation(validationOrder,:);


        outputData = [training;validation];
    

end

function [training, validation] = devideData(A,learnR, ~)


    [rows, ~] = size(A);
    
    index = round(rows*learnR);
    training =  A(1:index, :);
    lowerIndex = index +1;
    validation = A(lowerIndex:size(A,1) ,:);
   

end

function [avgf] = computeNetworkPerformance(networkParameters, trainSet, testSet)

    % extract labels
    testData = testSet(:, 1:45);
    testLabels = testSet(:, 46);
    trainData = trainSet(:, 1:45);
    trainLabels = trainSet(:, 46);

    % build classification network
    [trainingDataNN, trainingLabelsNN] = ANNdata(trainData,trainLabels);

    % network training
    [network, ~] = train(networkParameters, trainingDataNN, trainingLabelsNN);

    % validate the network
    classifications = testSingleNetwork(network, testData);

    % compute confusion matrix
    confusionMatrix = computeConfusionMatrix(classifications, testLabels, 6);

    % compute recall and precision for each class
    [recalls, precisions] = computeRecallPrecision(confusionMatrix);

    % compute average F measures with alpha = 1
    fMeasures = computeFMeasure(recalls, precisions, 1);
    [precSize, ~] = size(precisions);
    avgf = sum(fMeasures)/precSize;

end

function [ predictions ] = testSingleNetwork( network, inputs )

    % Transposing the inputs matrix in order to match sim function
    inputs = inputs';
    
    % Produces prediction for a given network
    sim_out = sim(network, inputs);
    
    % Produce labels as used in the rest of CBC coursework
    [predictions] = NNout2labels(sim_out);
    
end

function [ confMat ] = computeConfusionMatrix(classifications, testLabels, args)

assert(isequal(size(classifications),size(testLabels)));

[N,M] = size(classifications);

assert(M == 1);
assert(max(classifications) <= args);
assert(max(testLabels) <= args);

assert(min(classifications) > 0);
assert(min(testLabels) > 0);

confMat = zeros(args,args);

for i = 1:N
   
    row = classifications(i,1);
    column = testLabels(i,1);
    
    if(row == column)
        row = column;
    end;
    
    confMat(row,column) = confMat(row,column) + 1;
    
end

end

function [precisions, recalls] = computeRecallPrecision(averageConfusionMatrix) 

[N,M] = size(averageConfusionMatrix);

assert(N == M);
assert(N ~= 0);
precisions = zeros(N, 1);
recalls = zeros(N, 1);

for column = 1:N 
   
   tp = 0;
   fp = 0;
   fn = 0;
    
   for row = 1:N
      if(row == column)
          tp = averageConfusionMatrix(row,column);
      else
          fn = fn + averageConfusionMatrix(row,column);
          fp = fp + averageConfusionMatrix(column,row);
      end
   end
  
   
   if (tp ~= 0 || fp ~= 0)
        precisions(column) = tp/(tp+fp);
   end
   
   if (tp ~= 0 || fn ~= 0)
        recalls(column) = tp/(tp+fn);
   end
   
end

end

function F_measures = computeFMeasure(recalls, precisions, alpha)

[arSize, ~] = size(recalls);
F_measures = zeros(arSize, 1);

for count = 1: arSize

    recall = recalls(count);
    precision = precisions(count);
    
    if (alpha*precision + recall == 0) 
        F_measures(count) = 0;
    else
        F_measures(count) = (1+alpha)*(precision*recall)/(alpha*precision+recall);
    end
end

end

function logString(Data) 

persistent FID;

if isempty(FID) 
  FID = fopen(strcat('LogFile',datestr(now)), 'w');
  if FID < 0
     error('Cannot open file');
  end
elseif strcmp(Data, 'close')
  fclose(FID);
  FID = -1;
  return;
end

fprintf(FID, '%s\n', Data);

end
