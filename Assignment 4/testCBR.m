function [y] = testCBR(cbr,testData)

    [setSize, ~] = size(testData);
    y = zeros(setSize, 1);

    for testIndex = 1:setSize
        newCase = CBR_newCase(testData(testIndex,:),0);
        bestMatchingCase = retrieve(cbr,newCase);
        solvedCase = reuse(bestMatchingCase,newCase);
        cbr = retain(cbr,solvedCase);
        y(testIndex) = solvedCase.solution;
    end
    
end