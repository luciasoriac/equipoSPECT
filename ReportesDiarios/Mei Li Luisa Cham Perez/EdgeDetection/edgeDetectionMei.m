%%
% Ejemplo de Edge Detecion
% Equipo SPECT: Mei Li Cham
% Cargar la imagen radiograph1
f=imread('radiograph1.jpg');
f=imresize(f,1);
f=double(f(:,:,1));
imshow(f,[])
%%
% Deteccion de orillas utilizando una mascara
edgex=[1,-1] % se crea la mascara de convolucion, el -1 1 implica sacar el escalon
g1=conv2(f,edgex,'same');
imshow(g1,[-10,10]);
title('Derivada en x')
% La derivada en x, de blanco a negro
%%
% Sobel Mask
edgey=[-1 -2 -1;0,0,0;1,2,1]/8
g2=conv2(f,edgey,'same');
imshow(g2,[-10,10])
figure(2)
subplot(1,2,1)
imshow(g1,[-10,10])
title('Derivada en x')
subplot(1,2,2)
imshow(g2,[-10,10])
title('Derivada en y')
%%
figure(3)
subplot(1,1,1)
%%
%Soberl Mask dx
edgex=[1,0,-1;2,0,-2;1,0,-1]/8
gx=conv2(f,edgex,'same');
gy=conv2(f,edgey,'same');
%Gradiente Magnitud
mag=abs(gx)+abs(gy);
imshow(mag,[]);
title('Gradient Magnitud = |dx| + |gy|')

% recocimiento en base a las orillas

%%

% Estimar el nivel de ruido
noisemask = [-1, 0 1];
noiseimage = conv2(f,noisemask,'same');
noisevariance = mean2(noiseimage.^2); %estimacion de la varianza
noisestd = sqrt(noisevariance/2); %estimacion de la desviacion estandar
edgedetection1 = mag > noisestd; % si la magnitud es mayor del ruido, estimacion de orillas
edgedetection2 = mag > 2*noisestd;
subplot(1,2,1)
imshow(edgedetection1,[]);
title('Edge detection at sigma')
subplot(1,2,2)
imshow(edgedetection2,[]);
title('Edge detection at 2 sigma')
%%
figure(4)
subplot(1,1,1)
angle=atan2(gy,gx); %angulo entre las gradientes
imshow(angle,[]);
title('Gradient Orientation')
colormap('autumn')
% reconocer objetos basado en solo el contenido de orillas
% es importante la magnitud y el angulo

%%


edgcany=edge(f,'Canny');
imshow(edgcany,[]);
title('Canny Edge')

