function [new_pieces] = removePieces(pieces,id,nb_pieces)
new_pieces=struct;
i_new=0;
for i=1:nb_pieces
    if i==id
        continue;
    else
        i_new=i_new+1;
        new_pieces.s(i_new) = pieces.s(i);
    end
end
end