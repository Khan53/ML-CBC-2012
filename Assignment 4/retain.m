function [ cbr ] = retain( cbr, solvedCase )
% Updates the CBR system by storing the solved case

casePresent = 0;

% look for the case in the CBR systems it stands now
for i = 1:length(cbr.groups)
    if(casePresent == 1)
        break;
    end
    for j = 1:length(cbr.groups{i}.cases)
        if(casePresent == 1)
            break;
        end

        currentCase = cbr.clusters{i}.cases(j);
        
        if (isequal(currentCase.problem, solvedCase.problem))
            % Increment typicality for finding identical cases
            currentCase.typicality = currentCase.typicality + 1;          
            if (newCase.solution ~= 0)
            	% copy over the solution if we need one
                currentCase.solution = solvedCase.solution;
            end
            casePresent = 1;
        end
    end
end

% We may have a completely new case to deal with.
if (casePresent == 0)
    % Find the labeled emotion for the case in question
    solvedCaseEmotion = solvedCase.solution;

    % Update this group with the solvedCase
    cbr.groups{solvedCaseEmotion}.cases =...
		[cbr.groups{solvedCaseEmotion}.cases, solvedCase];
    
    % set new index
    cbr.groups{solvedCaseEmotion}.index =...
		union(cbr.groups{solvedCaseEmotion}.index, solvedCase.problem);
    
end
end


