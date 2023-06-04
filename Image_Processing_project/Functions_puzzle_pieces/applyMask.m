function outImage = applyMask(Image,mask)

    switch ndims(Image)
        case 2
            outImage = Image.*mask;
        case 3
            outImage = Image.*repmat(mask,[1,1,3]);
    end
    
end