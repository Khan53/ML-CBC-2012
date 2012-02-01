function [bestDecisionAttribute] = choose_best_decision_attribute(attribs,examples,targets)
%CHOOSE_BEST_DECISION_ATTRIBUTE - measuring how 'good' each attribute in the set is via ID3 algorithm,
%				  this returns the attribute with the largest information gain.
%
% AUTHOR:	A. Khan, G. Eracleous, G. Jones, V. Kriauciukas
% CREATED:	31012012
%
%IN:  attribs: 	list of attributes
%     examples: set of training examples with X columns less than or equal to 45
%     targets:	target labels for the training examples
%OUT: bestDecisionAttribute:	resulting attribute with largest information gain

  %First, we obtain the original information requirement which will help in calculation
  %of the attrribute with the largest information gain.
  positive = length(targets(targets == 1));
  negative = length(targets) - positive;
  originalInfoGain = calculate_entropy(positive, negative);

  %We then test each available attribute, calculting its entropy and judging its
  %extent of information gain.
  maxGain = 0;
  indexOfMaxGain = 1;
  for i = 1:length(attribs)
    remainder = calculate_remainder(positive,negative,i,attribs,examples,targets);
    attributeInfoGain = originalInfoGain - remainder;
    %USE 'GREATER THAN' OR USE 'GREATER THAN AND EQUAL' IN BELOW STATEMENT?...
    if (attributeInfoGain > maxGain)			%Check to retain the attribute with the largest information gain.
      maxGain = attributeInfoGain;
      indexOfMaxGain = i;
    end
  end
  bestDecisionAttribute = attribs(indexOfMaxGain);
end



function [entropy] = calculate_entropy(pos,neg)
%CALCULATE_ENTROPY - Calculating the information contained using a training set
%		     with positive and negative examples.
%
% AUTHOR:	A. Khan, G. Eracleous, G. Jones, V. Kriauciukas
% CREATED:	31012012
%
%IN:  pos: value of positive examples in the training set
%     neg: value of negative examples in the training set
%OUT: entropy:	value characterizing the impurity of the collection of examples

    posNum = pos / (pos + neg + eps);
    negNum = neg / (pos + neg + eps);
    entropy = abs(-posNum * log2(posNum + eps) - negNum * log2(negNum + eps));
end



function [remainder] = calculate_remainder(positive,negative,attributeIndex,attribs,examples,targets)
%CALCULATE_REMAINDER - Information requirement from testing an attribute, 'attributeIndex'. Dividing
%		       the training set into subsets given that the attributes are binary.
%
% AUTHOR:	A. Khan, G. Eracleous, G. Jones, V. Kriauciukas
% CREATED:	31012012
%
%IN:  positive: value of positive examples in the training set
%     negative: value of negative examples in the training set
%     attributeIndex: index to the attribute we are testing
%     attribs: 	list of attributes
%     examples: set of training examples with X columns less than or equal to 45
%     targets:	target labels for the training examples
%OUT: remainder: value characterizing the impurity of the collection of examples with respect to an attribute

  remainder = 0;
  %The attributes are binary, they will hold only two values.
  for possibleValue = 0:1
    %First find the rows of 'examples' that correpsond to the column of the attribute, 'atribIndex'.
    %having value 'possibleValue'. Secondly, create the target vector with the relevant rows.
    attributeIndexSet = find(examples(:,attribs(attributeIndex)) == possibleValue);
    reducedTargets = targets(attributeIndexSet);
    %Calculate the remainder contributed by the current attribute being tested.
    pos = length(reducedTargets(reducedTargets == 1));
    neg = length(reducedTargets) - pos;
    remainder = remainder + (pos + neg) * calculate_entropy(pos,neg);
  end
  remainder = remainder / (positive + negative + eps);
end
