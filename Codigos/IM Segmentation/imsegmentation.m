% Equiop SPECT
% Integrantes
    % Mei Li Luisa Cham Perez A01139386
    % Ana Lucía Soria Cardona A00827565
    %
    %
    %

%%
%cargar la imagen con la cual se trabajará 

f=imread('xray_hand.jpg');
f=double(f(:,:,1));
f=f/max(max(f));
f=imresize(f,2);
figure(1)
imshow(f,[]);
title('Original radiograph')
%% Thresholding

%stablish the limits that will be used 
seg1 = f > 0.5;
subplot(3,2,1)
imshow(seg1,[])
title('f > 0.5')
subplot(3,2,2)
imshow(seg1.*f,[])
title('result f> 0.5')

seg1 = f < 0.75;
subplot(3,2,3)
imshow(seg1,[])
title('f >0.75')
subplot(3,2,4)
imshow(seg1.*f,[])
title('result f < 0.75')

seg1 = f > 0.1;
subplot(3,2,5)
imshow(seg1,[])
title('f >0.1')
subplot(3,2,6)
imshow(seg1.*f,[])
title('result f >0.1')

figure
imhist(f)

title('histogram')
% Use a third threshold based on the histogram
%% 
%% Otsu method

thr = graythresh(f)
seg1 = f > thr;
imshow(seg1,[])
dxp=[0,1;-1,0];
dyp=[1,0;0,-1];  % gradiente en y
edgemap = abs(conv2(seg1,dxp,'same'))+abs(conv2(seg1,dyp,'same'));    %mapa de orillas centrado
imshow(f+edgemap,[0,1]);     % ver las orillas de la imagen, otra forma de visualizar las imagenes

% Compare the otsu provided threshold vs the one you selected in the
% preview step.
% Do you trust the Otsu treshold?
% Select your own image and compute the otsu threshold
%% Kmeans segmentation
 % se especifica el numero de clases
[L,Centers] = imsegkmeans(int8(255*f),3);    % el numero despues de la coma es el numero de clases
B = labeloverlay(f,L);
imshow(B)
title("Labeled Image")
imshow(int8(255*f)<Centers(1),[])
imshow(int8(255*f)<Centers(2),[])
imshow(int8(255*f)>Centers(3),[])
edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));    
imshow(f+edgemap,[0,1]);

% Do the same procedure but now with 5 centers.
% Is the segmentation better?
%% Watershed segmentation

edgeC = edge(f,'Canny');
imshow(edgeC,[])
D = bwdist(edgeC);
imshow(D,[])
title('Distance Transform of Binary Image')  % que tan lejos estan de las orillas
L = watershed(D);

edgemap = abs(conv2(L,dxp,'same'))+abs(conv2(L,dyp,'same'));
imshow(f+edgemap,[0,1]);


L(edgeC) = 0;
%% 
% Display the resulting label matrix as an RGB image.

rgb = label2rgb(L,'jet',[.5 .5 .5]);
imshow(rgb)
title('Watershed Transform')

% provide an alterante segmentation based on a different edge detector
%utilizar otro edge detector 