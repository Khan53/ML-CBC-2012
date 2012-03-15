function [tTests, anovaTests_P, anovaTests_ANOVATAB, anovaTests_STATS, multiCompareTests] = test_algorithms(fMeasuresDT, fMeasuresANN, fMeasuresCBR)

%% Run T-Tests
alpha = 0.5;

%6 emotions, 3 algorithms
emotions = 6;
algorithms = 3;
tTests = zeros(emotions,algorithms);

for emotion = 1:emotions
  % DT vs ANN
  tTests(emotion,1) = ttest2(fMeasuresDT(emotion,:)',fMeasuresANN(emotion)',alpha);
  % DT vs CBR
  tTests(emotion,2) = ttest2(fMeasuresDT(emotion,:)',fMeasuresCBR(emotion)',alpha);
  % ANN vs CBR
  tTests(emotion,3) = ttest2(fMeasuresANN(emotion,:)',fMeasuresCBR(emotion)',alpha);
end


%% Run ANOVA Tests and Multi Comparison Tests
anovaTests_P = cell(1,emotions);
anovaTests_ANOVATAB = cell(1,emotions);
anovaTests_STATS = cell(1,emotions);

multiCompareTests = cell(1,emotions);

for emotion = 1:emotions
  DT_Col = fMeasuresDT(emotion,:)';
  ANN_Col = fMeasuresANN(emotion,:)';
  CBR_Col = fMeasuresCBR(emotion,:)';

  [P, ANOVATAB, STATS] = anova1([DT_Col ANN_Col CBR_Col],{'DTs','ANNs','CBR'},'off');
  anovaTests_P(emotion) = {P};
  anovaTests_ANOVATAB(emotion) = {ANOVATAB};
  anovaTests_STATS(emotion) = {STATS};

  %% Carry out Multi Comparison Test here
  C = multcompare(STATS,'alpha',alpha,'display','off');
  multiCompareTests(emotion) = {C};

end
