function [f] = myAHE(inImg)
I=imread(inImg);

   adt = rgb2lab(I);
   m = adt(:,:,1)/100;
   adt(:,:,1) = adapthisteq(m,'NumTiles',...
                         [8 8],'ClipLimit',0.005)*100;
                     im = lab2rgb(adt);
                     
   imshow(im);
end

