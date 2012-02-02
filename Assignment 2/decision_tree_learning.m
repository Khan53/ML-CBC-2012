function [tree] = decision_tree_learning(examples,attribs,targets)
%DECISION_TREE_LEARNING - creates a decision tree through the use of the ID3 algorithm
%
%IN:  examples: set of training examples [N x 45]
%     attribs: 	list of attributes
%     targets:	target labels for the training examples [N x 1]
%OUT: tree:	resulting structure, decision tree for a given emotion

  numTargets = length(targets);

  %Assume, for each example, all the labels are the same and look for the
  %first appearance of a label that proves the assumption wrong.
  allSameLabel = true;
  firstLabel = targets(1);					%We look for a label dissimilar to the first target
  for i = 1:numTargets
    if (firstLabel ~= targets(i))
      allSameLabel = false;
      break;							%We've found a disrepancy, no need to search further
    end
  end

  %Begin the algorithm.
  if (allSameLabel)
    %If all examples have the same label, return a leaf node with that label as the classification.
%DO WE NEED THIS LINE...	
    tree.op = -1;						%As a leaf node, we do not test any attribute.
    tree.kids = [];						%A leaf node has no kids, further exapnsion of the tree not needed.
    tree.class = firstLabel;					%Resulting classification of all examples having the same label.
  elseif (isempty(attribs))
    %If there are no more attributes to check for, return a leaf node classifying the most frequent target label.
%DO WE NEED THIS LINE...	
    tree.op = -1;
    tree.kids = [];						%The leaf node has a similar description as above, apart from
    tree.class = majority_value(targets);			%returning a resulting classification of the majority target label.
  else
    %Otherwise,select the attribute that performs best and use it as the root of the tree.
    best = choose_best_decision_attribute(attribs,examples,targets);
    tree.op = best;						%This node is testing the best chosen attribute.
    tree.kids = cell(1,2);					%The cell array representing the potential binary subtrees from this node.
%DO WE NEED A LINE FOR tree.class...
    %The best attribute is binary, it would hold only two values.
    for possibleValue = 0:1
      %First find the rows of 'examples' that correpsond to the 'best' column having value 'possibleValue'.
      %Secondly, create the matrix with the relevant rows.
      bestIndexRows = find(examples(:,best) == possibleValue);
      reducedExamples = examples(bestIndexRows,:);
      if (isempty(reducedExamples))
	%If our new reduced matrix of examples is empty, then do not recurse for a sub tree
	%and return as a leaf node classifying the most frequent target label (same description as before).
%DOW WE NEED THIS LINE...	
	tree.op = -1;
	tree.kids = [];
	tree.class = majority_value(targets);
      else
	%Otherwise do the recursion to find sub tree, making use of the reduced examples matrix, a reduced
	%vector of the relevant target labels and attributes that exclude the currently 'best' attribute.
	reducedTargets = targets(bestIndexRows);
	tree.kids{possibleValue + 1} = decision_tree_learning( ...
	  reducedExamples, ...
	  attribs(attribs ~= best), ...
	  reducedTargets);
      end
    end
  end
end
