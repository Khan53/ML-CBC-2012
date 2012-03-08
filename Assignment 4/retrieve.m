function [ mostSimilarCase ] = retrieve( cbr, newCase )
    % Initializations
    casesList = []; 		% retrieved cases from indexing
    groupList = {}; 	    % retrieved groups from indexing

    % select groups for each AU in newCase
    for caseIndex = 1:length(newCase.problem)
        newCaseAU = newCase.problem(caseIndex);

        % check if an index of any group contains newCaseAU
        for emotion = 1:length(cbr.groups)
            groupIndex = cbr.groups{emotion}.index;
            groupLabel = cbr.groups{emotion}.label;
            groupCases = cbr.groups{emotion}.cases;
            
            % check if this group's cases have not been added to casesList
            if (ismember(newCaseAU,groupIndex) && ~ismember(groupLabel, groupList))
                % if not, then add the cases from this group and flag that the cases
        		% of this group were added to caseList
                casesList = [casesList,groupCases];
                groupList{1,length(groupList) + 1} = groupLabel;
            end
        end

    end

    mostSimilarCase = findMostSimilarCase(newCase, casesList);
end



function mostSimilarCase = findMostSimilarCase(newCase, casesList)
    % We want to find the most similar case in caseList to that of newCase.
    % We assume that there is at least one element in casesList.

    bestHeuristic = -Inf;
    for caseIndex = 1:length(casesList)
        currentCase = casesList(caseIndex);

        % compute factors of heuristic
        similarityValue = caseSimilarity(newCase,currentCase);
        lengthValue = length(currentCase);
        typicalityValue = currentCase.typicality;

	    % the higher the heuristic, the better.
        heuristic = similarityValue + lengthValue + typicalityValue;
        
        if (heuristic > bestHeuristic)
           mostSimilarCase = currentCase;
           bestHeuristic = heuristic;
        end
    end
end















