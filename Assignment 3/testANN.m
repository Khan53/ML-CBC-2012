function [predictions] = testANN(network, testSet)
    multi_nets = false;
    if length(network) > 1
        multi_nets = true;
    end
    predictions = zeros(10, 1);
    for index=1:10
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