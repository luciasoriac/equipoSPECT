%% Edge Detection
% Equipo Spect: Natalia Flores
% Cargar imagen
f=imread('radiograph1.jpg');
f=imresize(f,0.25);
f=double(f(:,:,1));
imshow(f,[])
title ('Imagen de radiografía')
%% Detección de edges usando una mascara 
edgex=[1,-1] % sacar el escalon 
g1=conv2(f,edgex,'same');
imshow(g1,[-10,10]);
title ('Derivada en x')
%% Sobel Mask
edgey=[-1 -2 -1;0,0,0;1,2,1]/8
g2=conv2(f,edgey,'same');
imshow(g2,[-10,10])
figure(2)
subplot(1,2,1)
imshow(g1,[-10,10])
title ('Derivada en x')
subplot(1,2,2)
imshow(g2,[-10,10])
title ('Derivada en y')
%%
figure(3)
subplot(1,1,1)
%% Sobel Mask dx
edgex=[1,0,-1;2,0,-2;1,0,-1]/8
gx=conv2(f,edgex,'same');
gy=conv2(f,edgey,'same');
%Gradiente Magnitud 
mag=abs(gx)+abs(gy);
imshow(mag,[]);
title ('Gradiente Magnitud')
%% Estimación de ruido
noisemask = [-1, 0 1];
noiseimage = conv2(f,noisemask,'same');
noisevariance = mean2(noiseimage.^2);
noisestd = sqrt(noisevariance/2);
edgedetection1 = mag > noisestd;
edgedetection2 = mag > 2*noisestd;
subplot(1,2,1)
imshow(edgedetection1,[]);
title ('Edge Detection sigma')
subplot(1,2,2)
imshow(edgedetection2,[]);
title ('Edge Detection 2 sigma')
%% 
figure(4)
subplot(1,1,1)
angle=atan2(gy,gx); %angulo entre gradientes
imshow(angle,[]);
title ('Gradient Orientation')
colormap ('autumn')
%%
edgcany=edge(f,'Canny');
imshow(edgcany,[]);
title ('Canny Edge')