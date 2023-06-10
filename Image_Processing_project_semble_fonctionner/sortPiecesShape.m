function [pieces_rotated] = sortPiecesShape(pieces,nb_pieces,rayon,left_wanted,top_wanted,right_wanted_abs,bottom_wanted_abs)
pieces_rotated=struct;
count=0;
% On parcours toutes les pièces
for i=1:nb_pieces
    piece = pieces.s(i);
    % On regarde si la position de base correspond
    if piece.shape.left==left_wanted & piece.shape.top==top_wanted & abs(piece.shape.right)==right_wanted_abs & abs(piece.shape.bottom)==bottom_wanted_abs
        % On incrémente le nombre
        count=count+1;
        im = piece.image;
        % Peut-être enlever ça (cela vient d'un copier coller général)
        shape = struct;
        tip = edge_detector(im,rayon);
        shape.top = tip(1);
        shape.right = tip(2);
        shape.bottom = tip(3);
        shape.left = tip(4);  
        pieces_rotated(count).image=im;
        pieces_rotated(count).shape=shape;
        pieces_rotated(count).idx=i;
    end
    if piece.shape.top==left_wanted & piece.shape.right==top_wanted  & abs(piece.shape.bottom)==right_wanted_abs & abs(piece.shape.left)==bottom_wanted_abs
        count=count+1;
        % On tourne la pièce pour que l'analyse soit dans le même sens pour
        % toutes
        im = imrotate(piece.image,90);
        % On met à jour l'analyse de la forme
        shape = struct;
        tip = edge_detector(im,rayon);
        shape.top = tip(1);
        shape.right = tip(2);
        shape.bottom = tip(3);
        shape.left = tip(4);  
        pieces_rotated(count).image=im;
        pieces_rotated(count).shape=shape;
        pieces_rotated(count).idx=i;
    end
    if piece.shape.right==left_wanted & piece.shape.bottom==top_wanted  & abs(piece.shape.left)==right_wanted_abs & abs(piece.shape.top)==bottom_wanted_abs 
        count=count+1;
        im = imrotate(piece.image,180);
        shape = struct;
        tip = edge_detector(im,rayon);
        shape.top = tip(1);
        shape.right = tip(2);
        shape.bottom = tip(3);
        shape.left = tip(4);  
        pieces_rotated(count).image=im;
        pieces_rotated(count).shape=shape;
        pieces_rotated(count).idx=i;
    end
    if piece.shape.bottom==left_wanted & piece.shape.left==top_wanted  & abs(piece.shape.top)==right_wanted_abs & abs(piece.shape.right)==bottom_wanted_abs
        count=count+1;
        im = imrotate(piece.image,270);
        shape = struct;
        tip = edge_detector(im,rayon);
        shape.top = tip(1);
        shape.right = tip(2);
        shape.bottom = tip(3);
        shape.left = tip(4);  
        pieces_rotated(count).image=im;
        pieces_rotated(count).shape=shape;
        pieces_rotated(count).idx=i;
    end
    
end    

end