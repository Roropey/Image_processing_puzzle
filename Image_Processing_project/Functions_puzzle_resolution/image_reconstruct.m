function y = image_reconstruct(I, pieces_nbr, color,rayon)
    
    pieces = struct;
    for k = 1:pieces_nbr
        shape = struct;
        pieces.s(k).image = I.piece(k).im;
        tip = edge_detector(I.piece(k).im);
        shape(k).top = tip(1);
        shape(k).right = tip(2);
        shape(k).bottom = tip(3);
        shape(k).left = tip(4);  
        pieces.s(k).shape = shape(k);
    end
    
    h = waitbar(0,'Puzzle being solved...');
    for i = 1 :pieces_nbr
        for k = 1:pieces_nbr
            if k ~= i
                correlator(k,:,i) = correlator_2pieces(pieces.s(i),pieces.s(k),color);   
            else 
                correlator(k,:,i) = zeros(1,16); 
            end
            waitbar( (pieces_nbr*(i-1) +k) / (pieces_nbr*pieces_nbr))
        end
    end
    close(h)
   
   correl = struct;
   
   for i = 1:pieces_nbr 
       testing = correlator(:,:,i);
       pieces.s(i).correl = correlation(testing, pieces_nbr);
   end
   y_inter = image_positionv2(pieces);
   if (pieces_nbr == 9)
       y_inter = y_inter;
   end
   pieces = reorder(pieces,y_inter);
   m = nnz(y_inter(1,:));
   n = nnz(y_inter(:,1));
   for i=1:n
       y_init = pieces.s(y_inter(i,1)).image;
       for k=1:m-1
           y_init = cat(2,y_init,pieces.s(y_inter(i,k+1)).image);
       end
       if(i == 1)
           y = y_init ;
       else
           y = cat(1,y,y_init);
          
       end
   end
   figure
   imshow(y)

    
end
