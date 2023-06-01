function [image_closed] = closing(image)
mask=ones(3,3);
image_closed_binary = image>0;
image_closed_binary=imerode(image_closed_binary,mask);
image_closed_binary=imdilate(image_closed_binary,mask);

%image_closed_binary=imerode(image_closed_binary,mask);
image_closed_binary=imdilate(image_closed_binary,mask);
image_closed = image.*image_closed_binary; 
image_closed = regionfill(image_closed,(image_closed_binary & image_closed==0));
end

