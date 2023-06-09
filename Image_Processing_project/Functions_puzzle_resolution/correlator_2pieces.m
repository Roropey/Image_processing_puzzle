%% Function that returns the mean 2-D correlation of a RGB matrix 
function y = correlator_2pieces(p1, p2, color_type)


c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c7=0;c8=0;c9=0;c10=0;
c11=0;c12=0;c13=0;c14=0;c15=0;c16=0;  

I1 = p1.image;
I2 = p2.image;
Shape1 = p1.shape;
Shape2 = p2.shape;

top_im1 = cote_isolation(I1, 1);
right_im1 = cote_isolation(I1, 2);
bottom_im1 = cote_isolation(I1, 3);
left_im1 = cote_isolation(I1, 4);

top_im2 = cote_isolation(I2, 1);
right_im2 = cote_isolation(I2, 2);
bottom_im2 = cote_isolation(I2, 3);
left_im2 = cote_isolation(I2, 4);

comparator = 0;

if (Shape1.top == 0) 
    c1 = comparator;
    c2 = comparator;
    c3 = comparator;
    c4 = comparator;
else
    if(Shape1.top ~= Shape2.top && Shape2.top ~= 0)
        c1 = inv_mse(top_im1,top_im2,color_type);
    else 
        c1 =comparator;
    end
    if(Shape1.top ~= Shape2.right && Shape2.right ~= 0)    
        c2 =inv_mse(top_im1,right_im2,color_type);
    else 
        c2 =comparator;
    end
    if(Shape1.top ~= Shape2.bottom && Shape2.bottom ~= 0)    
        c3 = inv_mse(top_im1,bottom_im2,color_type);
    else 
        c3 =comparator;
    end
    if(Shape1.top ~= Shape2.left && Shape2.left ~= 0)   
        c4 = inv_mse(top_im1,left_im2,color_type);
    else 
        c4 =comparator;
    end
end 

if (Shape1.right == 0) 
    c5 = comparator;
    c6 = comparator;
    c7 = comparator;
    c8 = comparator;
else
    if(Shape1.right ~= Shape2.top && Shape2.top ~= 0)
        c5 = inv_mse(right_im1,top_im2,color_type);
    else 
        c5 =comparator;
    end
    if(Shape1.right ~= Shape2.right && Shape2.right ~= 0)    
        c6 = inv_mse(right_im1,right_im2,color_type);
    else 
        c6 = comparator;
    end
    if(Shape1.right ~= Shape2.bottom && Shape2.bottom ~= 0)    
        c7 = inv_mse(right_im1,bottom_im2,color_type);
    else 
        c7 =comparator;
    end
    if(Shape1.right ~= Shape2.left && Shape2.left ~= 0)   
        c8 = inv_mse(right_im1,left_im2,color_type);
    else 
        c8 =comparator;
    end
end 

if (Shape1.bottom == 0) 
    c9 = comparator;
    c10 = comparator;
    c11 = comparator;
    c12 = comparator;
else
    if(Shape1.bottom ~= Shape2.top && Shape2.top ~= 0)
        c9 = inv_mse(bottom_im1,top_im2,color_type);
    else 
        c9 =comparator;
    end
    if(Shape1.bottom ~= Shape2.right && Shape2.right ~= 0)    
        c10 = inv_mse(bottom_im1,right_im2,color_type);
    else 
        c10 =comparator;
    end
    if(Shape1.bottom ~= Shape2.bottom && Shape2.bottom ~= 0)    
        c11 = inv_mse(bottom_im1,bottom_im2,color_type);
    else 
        c11 =comparator;
    end
    if(Shape1.bottom ~= Shape2.left && Shape2.left ~= 0)   
        c12 = inv_mse(bottom_im1,left_im2,color_type);
    else 
        c12 =comparator;
    end
end


if (Shape1.left == 0) 
    c13 = comparator;
    c14 = comparator;
    c15 = comparator;
    c16 = comparator;
else
    if(Shape1.left ~= Shape2.top && Shape2.top ~= 0)
        c13 = inv_mse(left_im1,top_im2,color_type);
    else 
        c13 =comparator;
    end
    if(Shape1.left ~= Shape2.right && Shape2.right ~= 0)    
        c14 = inv_mse(left_im1,right_im2,color_type);
    else 
        c14 =comparator;
    end
    if(Shape1.left ~= Shape2.bottom && Shape2.bottom ~= 0)    
        c15 = inv_mse(left_im1,bottom_im2,color_type);
    else 
        c15 =comparator;
    end
    if(Shape1.left ~= Shape2.left && Shape2.left ~= 0)   
        c16 = inv_mse(left_im1,left_im2,color_type);
    else 
        c16 =comparator;
    end
end  
y = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16];
