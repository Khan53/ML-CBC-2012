function [predictions] = testANN(network, testSet)
    [noExamples, ~] = size(testSet.examples)
    multi_nets = false;
    if length(network) > 1
        multi_nets = true;
    end
    predictions = zeros(noExamples, 1);
    for index=1:noExamples
        example = testSet.examples(index, :)';        
        if multi_nets
            individualClassifications = zeros(6, 1);
            for emotion = 1:6
                individualClassifications(emotion) = sim(network{emotion}, example);
            end
            predictions(index) = NNout2labels(individualClassifications);
        else
            predictions(index) = NNout2labels(sim(network, example));
        end
    end     
    
end