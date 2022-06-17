%% cargar archivos

%subject 101
free_101_brain = niftiread('101brain.nii.gz');
free_101_seg = niftiread('101seg.nii.gz');
free_101_info_brain = niftiinfo("101brain.nii.gz");
free_101_info_seg = niftiinfo("101seg.nii.gz");

fsl_101_grey = niftiread('sub-101_ses-BL_anat_sub-101_ses-BL_T1w_brain_seg_1.nii.gz');
fsl_101_white = niftiread('sub-101_ses-BL_anat_sub-101_ses-BL_T1w_brain_seg_2.nii.gz');
fsl_101_brain = niftiread('sub-101_ses-BL_anat_sub-101_ses-BL_T1w_brain.nii.gz');

% subject 207
free_207_brain = niftiread('207brain.nii.gz');
free_207_seg = niftiread('207seg.nii.gz');
free_207_info_brain = niftiinfo("207brain.nii.gz");
free_207_info_seg = niftiinfo("207seg.nii.gz");

fsl_207_grey = niftiread('sub-207_ses-BL_T1w_brain_seg_1.nii.gz');
fsl_207_white = niftiread('sub-207_ses-BL_T1w_brain_seg_2.nii.gz');
fsl_207_brain = niftiread('sub-207_ses-BL_T1w_brain.nii.gz');

%subject 320
free_320_brain = niftiread('320brain.nii.gz');
free_320_seg = niftiread('320aseg.nii.gz');
free_320_info_brain = niftiinfo("320brain.nii.gz");
free_320_info_seg = niftiinfo("320aseg.nii.gz");

fsl_320_grey = niftiread('sub-320_ses-BL_T1w_brain_seg_1.nii.gz');
fsl_320_white = niftiread('sub-320_ses-BL_T1w_brain_seg_2.nii.gz');
fsl_320_brain = niftiread('sub-320_ses-BL_T1w_brain.nii.gz');

%% separar los indices

% subject 101
white_free_101 = free_101_seg == 2 | free_101_seg == 41;   % white matter, los labels se obtuvieron de aseg.mgz en freeview
grey_free_101 = free_101_seg == 3 | free_101_seg == 42;

white_fsl_101 = fsl_207_white == 1;     % fsl ya los separa, por eso index 1, es el unico
grey_fsl_101 = fsl_207_grey == 1;

% subject 207
white_free_207 = free_207_seg == 2 | free_207_seg == 41;   % white matter, los labels se obtuvieron de aseg.mgz en freeview
grey_free_207 = free_207_seg == 3 | free_207_seg == 42;

white_fsl_207 = fsl_207_white == 1;     % fsl ya los separa, por eso index 1, es el unico
grey_fsl_207 = fsl_207_grey == 1;

% subject 320
white_free_320 = free_320_seg == 2 | free_320_seg == 41;   % white matter, los labels se obtuvieron de aseg.mgz en freeview
grey_free_320 = free_320_seg == 3 | free_320_seg == 42;

white_fsl_320 = fsl_207_white == 1;     % fsl ya los separa, por eso index 1, es el unico
grey_fsl_320 = fsl_207_grey == 1;
%% Analisis previo

% Subject 101
volume_101 = free_101_brain;
mitad_101 = size(volume_101,3)/2;

% volumen y layover con segmentacion freesurfer
slice_grey_free_101  = labeloverlay(volume_101(:,:,mitad_101),int16(grey_free_101(:,:,mitad_101)));
slice_white_free_101 = labeloverlay(volume_101(:,:,mitad_101), int16(white_free_101(:,:,mitad_101)));


% rotar para mejor visualizacion
slice_grey_free_101 = imrotate(slice_grey_free_101,-90);
slice_white_free_101 = imrotate(slice_white_free_101,-90);


% volumen y layover con segmentacion fsl
grey_fsl_101_resize = imresize3(grey_fsl_101,[256 256 256]);  % imresize only resized the first two dimensions
grey_fsl_101_permute = permute(grey_fsl_101_resize, [1 3 2]); % cambio de dimensiones para que concuerden entre fsl y freesurfer
grey_fsl_101_int16 = int16(grey_fsl_101_permute(:,:,mitad_101));  % hacer compatible el tipo de informacion entre los dos
slice_grey_fsl_101 = labeloverlay(volume_101(:,:,mitad_101),flip(grey_fsl_101_int16, 2));   % se hace un flip porque al visualizarlo se puede ver que esta al reves, espejeado
slice_grey_fsl_101 = imrotate(slice_grey_fsl_101,-90);   % rotar para mejor visualizacion

% v = slice_grey_fsl_101(:,:,3);
% figure()
% imshow(v,[])

white_fsl_101_resize = imresize3(white_fsl_101,[256 256 256]);  % imresize only resized the first two dimensions volume esta en 256x256x256, fsl esta en 256x182x256
white_fsl_101_permute = permute(white_fsl_101_resize, [1 3 2]);  % cambio de dimensiones para que concuerden entre fsl y freesurfer
white_fsl_101_int16 = int16(white_fsl_101_permute(:,:,mitad_101));
slice_white_fsl_101 = labeloverlay(volume_101(:,:,mitad_101),flip(white_fsl_101_int16, 2));   
slice_white_fsl_101 = imrotate(slice_white_fsl_101,-90);

% v = slice_white_fsl_207(:,:,3);
% figure()
% imshow(v,[])

%% Analisis de volumen
% Subject 207

volume_207 = free_207_brain;
mitad_207 = size(volume_207,3)/2;

% volumen y layover con segmentacion freesurfer
slice_grey_free_207  = labeloverlay(volume_207(:,:,mitad_207),int16(grey_free_207(:,:,mitad_207)));
slice_white_free_207 = labeloverlay(volume_207(:,:,mitad_207), int16(white_free_207(:,:,mitad_207)));


% rotar para mejor visualizacion
slice_grey_free_207 = imrotate(slice_grey_free_207,-90);
slice_white_free_207 = imrotate(slice_white_free_207,-90);


% volumen y layover con segmentacion fsl
grey_fsl_207_resize = imresize3(grey_fsl_207,[256 256 256]);  % imresize only resized the first two dimensions
grey_fsl_207_permute = permute(grey_fsl_207_resize, [1 3 2]); % cambio de dimensiones para que concuerden entre fsl y freesurfer
grey_fsl_207_int16 = int16(grey_fsl_207_permute(:,:,mitad_207));  % hacer compatible el tipo de informacion entre los dos
slice_grey_fsl_207 = labeloverlay(volume_207(:,:,mitad_207),flip(grey_fsl_207_int16, 2));   % se hace un flip porque al visualizarlo se puede ver que esta al reves, espejeado
slice_grey_fsl_207 = imrotate(slice_grey_fsl_207,-90);   % rotar para mejor visualizacion

% v = slice_grey_fsl_207(:,:,3);
% figure()
% imshow(v,[])

white_fsl_207_resize = imresize(white_fsl_207,[256 256]);  % imresize only resized the first two dimensions volume esta en 256x256x256, fsl esta en 256x182x256
white_fsl_207_permute = permute(white_fsl_207_resize, [1 3 2]);  % cambio de dimensiones para que concuerden entre fsl y freesurfer
white_fsl_207_int16 = int16(white_fsl_207_permute(:,:,mitad_207));
slice_white_fsl_207 = labeloverlay(volume_207(:,:,mitad_207),flip(white_fsl_207_int16, 2));   
slice_white_fsl_207 = imrotate(slice_white_fsl_207,-90);

% v = slice_white_fsl_207(:,:,3);
% figure()
% imshow(v,[])

%% Analisis de volumen
% Subject 320

volume_320 = free_320_brain;
mitad_320 = size(volume_320,3)/2;

% volumen y layover con segmentacion freesurfer
slice_grey_free_320  = labeloverlay(volume_320(:,:,mitad_320),int16(grey_free_320(:,:,mitad_320)));
slice_white_free_320 = labeloverlay(volume_320(:,:,mitad_320), int16(white_free_320(:,:,mitad_320)));


% rotar para mejor visualizacion
slice_grey_free_320 = imrotate(slice_grey_free_320,-90);
slice_white_free_320 = imrotate(slice_white_free_320,-90);


% volumen y layover con segmentacion fsl
grey_fsl_320_resize = imresize3(grey_fsl_320,[256 256 256]);  % imresize only resized the first two dimensions
grey_fsl_320_permute = permute(grey_fsl_320_resize, [1 3 2]); % cambio de dimensiones para que concuerden entre fsl y freesurfer
grey_fsl_320_int16 = int16(grey_fsl_320_permute(:,:,mitad_320));  % hacer compatible el tipo de informacion entre los dos
slice_grey_fsl_320 = labeloverlay(volume_320(:,:,mitad_320),flip(grey_fsl_320_int16, 2));   % se hace un flip porque al visualizarlo se puede ver que esta al reves, espejeado
slice_grey_fsl_320 = imrotate(slice_grey_fsl_320,-90);   % rotar para mejor visualizacion

% v = slice_grey_fsl_320(:,:,3);
% figure()
% imshow(v,[])

white_fsl_320_resize = imresize3(white_fsl_320,[256 256 256]);  % imresize only resized the first two dimensions volume esta en 256x256x256, fsl esta en 256x182x256
white_fsl_320_permute = permute(white_fsl_320_resize, [1 3 2]);  % cambio de dimensiones para que concuerden entre fsl y freesurfer
white_fsl_320_int16 = int16(white_fsl_320_permute(:,:,mitad_320));
slice_white_fsl_320 = labeloverlay(volume_320(:,:,mitad_320),flip(white_fsl_320_int16, 2));   
slice_white_fsl_320 = imrotate(slice_white_fsl_320,-90);

% v = slice_white_fsl_207(:,:,3);
% figure()
% imshow(v,[])

%% 
figure (1)
subplot(2,2,1)
imshow(slice_white_free_101,[])
title('White Matter Subject 101 (Freesurfer)')

subplot(2,2,2)
imshow(slice_white_fsl_101,[])
title('White Matter Subject 101 (FSL)')

subplot(2,2,3)
imshow(slice_grey_free_101,[])
title('Grey Matter Subject 101 (Freesurfer)')

subplot(2,2,4)
imshow(slice_grey_fsl_101,[])
title('Grey Matter Subject 101 (FSL)')
sgtitle('Subject 101')


figure(2)
subplot(2,2,1)
imshow(slice_white_free_207,[])
title('White Matter Subject 207 (Freesurfer)')

subplot(2,2,2)
imshow(slice_white_fsl_207,[])
title('White Matter Subject 207 (FSL)')

subplot(2,2,3)
imshow(slice_grey_free_207,[])
title('Grey Matter Subject 207 (Freesurfer)')

subplot(2,2,4)
imshow(slice_grey_fsl_207,[])
title('Grey Matter Subject 207 (FSL)')
sgtitle('Subject 207')


figure(3)
subplot(2,2,1)
imshow(slice_white_free_320,[])
title('White Matter Subject 320 (Freesurfer)')

subplot(2,2,2)
imshow(slice_white_fsl_320,[])
title('White Matter Subject 320 (FSL)')

subplot(2,2,3)
imshow(slice_grey_free_320,[])
title('Grey Matter Subject 320 (Freesurfer)')

subplot(2,2,4)
imshow(slice_grey_fsl_320,[])
title('Grey Matter Subject 320 (FSL)')
sgtitle('Subject 320')

%%
dice_white_101 = dice(flip(imrotate(white_free_101,-90),2),imrotate(white_fsl_101_permute,90));
dice_grey_101 = dice(flip(imrotate(grey_free_101,-90),2),imrotate(grey_fsl_101_permute,90));

dice_white_207 = dice(flip(imrotate(white_free_207,-90),2),imrotate(white_fsl_207_permute,90));
dice_grey_207 = dice(flip(imrotate(grey_free_207,-90),2),imrotate(grey_fsl_207_permute,90));

dice_white_320 = dice(flip(imrotate(white_free_320,-90),2),imrotate(white_fsl_320_permute,90));
dice_grey_320 = dice(flip(imrotate(grey_free_320,-90),2),imrotate(grey_fsl_320_permute,90));



