f=imread('radiograph1.jpg');
f=imresize(f,0.25);
f=double(f(:,:,1));
imshow(f,[])
title('Radiograph Og')
%%
edgex=[1,-1]
g1=conv2(f,edgex,'same');
imshow(g1,[-10,10]);
title('Radiograph edges')
%%
edgey=[-1 -2 -1;0,0,0;1,2,1]/8
g2=conv2(f,edgey,'same');
figure(3)
subplot(1,2,1)
imshow(g1,[-10,10])
title('Dx')
subplot(1,2,2)
imshow(g2,[-10,10])
title('Dy')
%%
figure(4)
subplot(1,1,1)
%%
edgex=[1,0,-1;2,0,-2;1,0,-1]/8
gx=conv2(f,edgex,'same');
gy=conv2(f,edgey,'same');
mag=abs(gx)+abs(gy);
figure(5)
imshow(mag,[]);
%%
noisemask = [-1, 0 1];
noiseimage = conv2(f,noisemask,'same');
noisevariance = mean2(noiseimage.^2);
noisestd = sqrt(noisevariance/2);
edgedetection1 = mag > noisestd;
edgedetection2 = mag > 2*noisestd;
figure(6)
subplot(1,2,1)
imshow(edgedetection1,[]);
title('edge detection s1')
subplot(1,2,2)
imshow(edgedetection2,[]);
title('edge detection s2')
figure(7)
subplot(1,1,1)
angle=atan2(gy,gx);
imshow(angle,[]);
title('gradient orentation')
%%
edgcany=edge(f,'Canny');
figure(8)
imshow(edgcany,[]);
title('edge canny')