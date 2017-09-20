
%figure(1);
subplot(2,3,1);
I = imread('snow.jpg');
imshow(I);
title('Original Image');

subplot(2,3,2);
myHistEqual('snow.jpg');
title('Histogram Equalization Image');

subplot(2,3,3);
myAHE('snow.jpg');
title('Adaptive Histogram Equalization Image');

myCegaHE('snow.jpg');


pause(2);

%figure(2);
subplot(2,3,1);
I = imread('lg-image9.jpg');
imshow(I);
title('Original Image');

subplot(2,3,2);
myHistEqual('lg-image9.jpg');
title('Histogram Equalization Image');

subplot(2,3,3);
myAHE('lg-image9.jpg');
title('Adaptive Histogram Equalization Image');

myCegaHE('lg-image9.jpg');

pause(2);

%figure(3);
subplot(2,3,1);
I = imread('cat-underexposed.jpg');
imshow(I);
title('Original Image');

subplot(2,3,2);
myHistEqual('cat-underexposed.jpg');
title('Histogram Equalization Image');

subplot(2,3,3);
myAHE('cat-underexposed.jpg');
title('Adaptive Histogram Equalization Image');

myCegaHE('cat-underexposed.jpg');

pause(2);

%figure(4);
subplot(2,3,1);
I = imread('squirrel-underexposed.jpg');
imshow(I);
title('Original Image');

subplot(2,3,2);
myHistEqual('squirrel-underexposed.jpg');
title('Histogram Equalization Image');

subplot(2,3,3);
myAHE('squirrel-underexposed.jpg');
title('Adaptive Histogram Equalization Image');

myCegaHE('squirrel-underexposed.jpg');

pause(2);

%figure(5);
subplot(2,3,1);
I = imread('Over.JPG');
imshow(I);
title('Original Image');

subplot(2,3,2);
myHistEqual('Over.JPG');
title('Histogram Equalization Image');

subplot(2,3,3);
myAHE('Over.JPG');
title('Adaptive Histogram Equalization Image');

myCegaHE('Over.JPG');




