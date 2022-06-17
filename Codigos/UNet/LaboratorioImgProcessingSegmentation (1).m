% 1) Learn to create a U-net

%% Create a U-Net network with an encoder-decoder depth of 3.
imageSize = [32 32];
numClasses = 2;
encoderDepth = 3;
lgraph = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth);

plot(lgraph) % Plot the network

% 2) Train U-Net for semantic segmentation
%% Load training images and pixel labels
dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
imageDir = fullfile(dataSetDir,'trainingImages');
labelDir = fullfile(dataSetDir,'trainingLabels');

%% Create an imageDatastore object to store the training images.
imds = imageDatastore(imageDir);

%% Define the class names and their associated label IDs.
classNames = ["triangle","background"];
labelIDs   = [255 0];

%%
% Create a pixelLabelDatastore object to store the ground truth pixel 
% labels for the training images.
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);

%% Crating the U-Net network
imageSize = [32 32];
numClasses = 2;
lgraph = unetLayers(imageSize, numClasses)

ds = combine(imds,pxds); % Datastore for training the network.

%% Training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-5, ...
    'MaxEpochs',50, ...
    'VerboseFrequency',10);

%% Train the network
net = trainNetwork(ds,lgraph,options)