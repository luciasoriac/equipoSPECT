%% Train U-Net for semantic segmentation
% Load training images and pixel labels
dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
imageDir = fullfile(dataSetDir,'trainingImages');
labelDir = fullfile(dataSetDir,'trainingLabels');

% Create an imageDatastore object to store the training images.
imds = imageDatastore(imageDir);

% Define the class names and their associated label IDs.
classNames = ["triangle","background"];
labelIDs   = [255 0];

% Create a pixelLabelDatastore object to store the ground truth pixel 
% labels for the training images.
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);

% Crating the U-Net network
imageSize = [32 32];
numClasses = 2;
lgraph = unetLayers(imageSize, numClasses)

ds = combine(imds,pxds); % Datastore for training the network.

% Training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-2, ...
    'MaxEpochs',30, ...
    'VerboseFrequency',10);

% Train the network
net = trainNetwork(ds,lgraph,options)

%% Test your trained U-Net
% Specify test images and labels
testImagesDir = fullfile(dataSetDir,'testImages');
testimds = imageDatastore(testImagesDir);
testLabelsDir = fullfile(dataSetDir,'testLabels');

% Ground truth pixel labels for the test images
pxdsTruth = pixelLabelDatastore(testLabelsDir,classNames,labelIDs);

% Prediction
pxdsResults = semanticseg(testimds,net,"WriteLocation",tempdir);

% Evaluate the Quality of the Prediction
metrics = evaluateSemanticSegmentation(pxdsResults,pxdsTruth);

% Inspect class metrcis
metrics.ClassMetrics

% Display confusion matrix
metrics.ConfusionMatrix

% Visualize the normalized confusion matrix as a confusion chart in a figure window.
figure (2)
cm = confusionchart(metrics.ConfusionMatrix.Variables, ...
  classNames, Normalization='row-normalized');
cm.Title = 'Normalized Confusion Matrix (%)';

% Inspect an Image Metric
imageIoU = metrics.ImageMetrics.MeanIoU;

figure (3)
histogram(imageIoU)
title('Image Mean IoU')

%% Test image with the lowest IoU.
% Find the test image with the lowest IoU.
[minIoU, worstImageIndex] = min(imageIoU);
minIoU = minIoU(1);
worstImageIndex = worstImageIndex(1);

% Read the test image with the worst IoU, its ground truth labels, and its predicted labels for comparison.
worstTestImage = readimage(imds,worstImageIndex);
worstTrueLabels = readimage(pxdsTruth,worstImageIndex);
worstPredictedLabels = readimage(pxdsResults,worstImageIndex);

% Convert the label images to images that can be displayed in a figure window.
worstTrueLabelImage = im2uint8(worstTrueLabels == classNames(1));
worstPredictedLabelImage = im2uint8(worstPredictedLabels == classNames(1));

% Display the worst test image, the ground truth, and the prediction.
worstMontage = cat(4,worstTestImage,worstTrueLabelImage,worstPredictedLabelImage);
worstMontage = imresize(worstMontage,4,"nearest");

figure (4)
montage(worstMontage,'Size',[1 3])
title(['Test Image vs. Truth vs. Prediction. IoU = ' num2str(minIoU)])

%% Test image with the highest IoU.

% Complete the following section by yourself

%{
[maxIoU, bestImageIndex] = ????;
maxIoU = ?????;
bestImageIndex = ????;

bestTestImage = ?????;
bestTrueLabels = ????????;
bestPredictedLabels = ????????;

bestTrueLabelImage = ???????;
bestPredictedLabelImage = ??????;

bestMontage = ???????;
bestMontage = ?????????;

figure (5)
montage(bestMontage,'Size',[1 3])
title(['Test Image vs. Truth vs. Prediction. IoU = ' num2str(maxIoU)])
%}
