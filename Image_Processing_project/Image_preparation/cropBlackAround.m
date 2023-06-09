function [image_croped] = cropBlackAround(image)


[sizeX,sizeY,~]=size(image);
crop_top=0;
crop_bottom=0;
crop_left=0;
crop_right=0;

for i=1:sizeX
    if sum(abs(image(i,:,:))) == 0
        if i<sizeX/2
            crop_top = crop_top + 1;
        else
            crop_bottom = crop_bottom + 1;
        end         
    end 
end    

for i=1:sizeY
    if sum(abs(image(:,i,:))) == 0
        if i<sizeY/2
            crop_left = crop_left + 1;
        else
            crop_right = crop_right + 1;
        end         
    end 
end   
image_croped=image(crop_top+1:sizeX-crop_bottom,crop_left+1:sizeY-crop_right,:);
end