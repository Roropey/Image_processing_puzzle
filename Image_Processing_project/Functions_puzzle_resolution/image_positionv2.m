function y = image_positionv2(im)

   
    m = size(im.s,2);
    y = zeros(m,m);
    pieces_list = [1:size(im.s,2)];
    max_widht = m;
    for i = 1:m
        for j = 1:m
            count2 = -1;
            count1 = -1;
            count = -1;
            piece_found = 0;
            if(j==1 && i ==1)
               for p = 1 : m 
                    is_corner = getfield(im.s,{p},'shape');
                    count = sum(structfun(@(x) x == 0, is_corner));
                    if(count == 2 )
                        y(i,j) = p;
                        pieces_list(pieces_list == p) = [];
                        break; 
                    end
               end
             elseif(j == 1 && i ~= 1)
                 for p = 1:m
                     above_piece = [im.s(y(i-1,j)).correl.piece];
                     potential_piece = above_piece(p);
                     if (ismember(potential_piece,pieces_list) == 1)
                         is_corner = getfield(im.s,{potential_piece},'shape');
                         count = sum(structfun(@(x) x == 0, is_corner));
                         if(count ~= 0)
                             linked_above = [im.s(potential_piece).correl.piece];
                             inx_abv = find(linked_above == y(i-1,j));
                             compatible_abv = isequal(sort(im.s(y(i-1,j)).correl(p).pos), sort(im.s(potential_piece).correl(inx_abv).pos));
                             if(compatible_abv)
                                y(i,j) = potential_piece;
                                pieces_list(pieces_list == potential_piece) = [];
                                break;
                             end  
                         end
                     end
                 end
            else 
                if (i == 1)
                    for p = 1:m
                            previous_piece = [im.s(y(i,j-1)).correl.piece];
                            potential_piece = previous_piece(p);
                            if (ismember(potential_piece,pieces_list) == 1)
                                linked_pieces = [im.s(potential_piece).correl.piece];
                                inx = find(linked_pieces == y(i,j-1));
                                compatible = isequal(sort(im.s(y(i,j-1)).correl(p).pos), sort(im.s(potential_piece).correl(inx).pos));
                                is_first = getfield(im.s,{potential_piece},'shape');
                                count1 = sum(structfun(@(x) x == 0, is_first));
                                if (compatible ~= 1 || count1 == 0)
                                    continue;
                                else
                                    y(i,j) = potential_piece;
                                    pieces_list(pieces_list == potential_piece) = [];
                                    piece_found = 1;
                                    break;
                                end
                            end
                    end 
                    max_widht = j;
                else
                    for p = 1:m
                        piece_above = y(i-1,j);
                        previous_piece = [im.s(y(i,j-1)).correl.piece];
                        linked_top2 = [im.s(piece_above).correl.piece];
                        potential_piece = linked_top2(p);
                        if (ismember(potential_piece,pieces_list) == 1)
                            linked_pieces = [im.s(potential_piece).correl.piece];
                            inx = find(linked_pieces == y(i,j-1));
                            inxtop = find(linked_pieces == piece_above);
                            
                            inxleft = find(previous_piece == potential_piece);
                            inxtop2 = find(linked_top2 == potential_piece);
                            
                            compatible_line = isequal(sort(im.s(y(i,j-1)).correl(inxleft).pos), sort(im.s(potential_piece).correl(inx).pos));
                            compatible_above = isequal(sort(im.s(potential_piece).correl(inxtop).pos), sort(im.s(piece_above).correl(inxtop2).pos));
                            if (compatible_line == 1 && compatible_above == 1)
                                y(i,j) = potential_piece;
                                pieces_list(pieces_list == potential_piece) = [];
                                piece_found = 1;  
                                is_first = getfield(im.s,{potential_piece},'shape');
                                count2 = sum(structfun(@(x) x == 0, is_first));
                                break;
                            end 
                        end
                    end
                end
                if (piece_found == 0)
                    y(i,j) = 0;
                end
                if (count1 == 2)
                    count1 = 0;
                    break;
                end
                if (count2 == 1  && j == max_widht)
                    count2 = 0;
                    break;
                elseif (count2 == 2)
                    count2 = 0;
                    break;
                end
            end
        end
        if (isempty(pieces_list) ==1)
            break;
        end
    end
    debug = 1;


    
    

% size_row = sum(y~=0,1); % check the nnz along all the rows
% size_column = sum(y~=0,2); % check the nnz along all the columns
% 
% while (isempty(pieces_list) == 0)
%     for i = 1 : length(pieces_list)
%         lateral_pieces = find(strcmp({im.s(y(i-1,j)).shape}, 0)==1);
%         if (length(lateral_pieces == 2))
%             if y(size_row,size_column) == 0)
%                 y(size_row,size_column) = 
%             elseif
%             elseif
%             else
%         elseif
%     end
% end
%     
    

