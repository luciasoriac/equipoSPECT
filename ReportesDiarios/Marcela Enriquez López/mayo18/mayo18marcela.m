% Skeletonize 2-D Grayscale Image
% Image display
I = imread('threads.png');
figure(1)
subplot(2,3,1)
imshow(I)
title('image original')
% Complement of original image
Icomplement = imcomplement(I);
subplot(2,3,2)
imshow(Icomplement)
title('complement for binarization')
% Binarization of complement
BW = imbinarize(Icomplement);
subplot(2,3,3)
imshow(BW)
title('binarization')
% Performing skeletonization of the binarization once it is black and
% white(1,0)
out = bwskel(BW);
subplot(2,3,4)
imshow(out)
title('skeletonization')
% Display skeleton over original image (blue lines)
subplot(2,3,5)
imshow(labeloverlay(I,out,'Transparency',0))
title('skeleton and original image')
% Alternative method with bwmorph
BW3 = bwmorph(BW,'skel',Inf);
subplot(2,3,6)
imshow(BW3)
title('bwmorph method')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
% Skeletonize 2-D Grayscale Image
% Image display
I=imread('radiograph1.jpg');
I=double(I(:,:,1));
I=I/max(max(I));
I=imresize(I,0.25);
figure(2)
subplot(2,3,1)
imshow(I)
title('image original')
% Complement of original image
Icomplement = imcomplement(I);
subplot(2,3,2)
imshow(Icomplement)
title('complement for binarization')
% Binarization of complement
BW = imbinarize(Icomplement);
subplot(2,3,3)
imshow(BW)
title('binarization')
% Performing skeletonization of the binarization once it is black and
% white(1,0)
out = bwskel(BW);
subplot(2,3,4)
imshow(out)
title('skeletonization')
% Display skeleton over original image (blue lines)
subplot(2,3,5)
imshow(labeloverlay(I,out,'Transparency',0))
title('skeleton and original image')
%Alternative method with bwmorph
BW3 = bwmorph(BW,'skel',Inf);
subplot(2,3,6)
imshow(BW3)
title('bwmorph method')