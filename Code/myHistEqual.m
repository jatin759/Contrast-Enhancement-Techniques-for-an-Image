function [f] = myHistEqual(inImg)
I=imread(inImg);

rc = I(:,:,1);
gc = I(:,:,2);
bc = I(:,:,3);
rc=histeq(rc);
gc=histeq(gc);
bc=histeq(bc);

im = cat(3,rc,gc,bc);
imshow(im);

end

