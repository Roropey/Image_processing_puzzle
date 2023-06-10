function y = image_positionv2(im)

   
    m = size(im.s,2);
    y = zeros(m,m);
    pieces_list = [1:size(im.s,2)];
    
    for i = 1:m
        for j = 1:m
            piece_found = 0;
            if(j==1 && i ==1)
               for p = 1 : m 
                    if(im.s(p).shape.top == 0 && im.s(p).shape.left == 0)
                        y(i,j) = p;
                        pieces_list(pieces_list == p) = [];
                        break; 
                    end
               end
             elseif(j == 1 && i ~= 1)
                 for p = 1:m
                     if (ismember(p,pieces_list) == 1)
                         if(im.s(p).shape.left == 0 )
                              index_of_top = find(strcmp({im.s(p).correl.pos}, 'TB')==1);
                              index_of_top = min(index_of_top);
                             if(im.s(p).correl(index_of_top).piece == y(i-1,j))
                                y(i,j) = p;
                                pieces_list(pieces_list == p) = [];
                                break;
                             end  
                         end
                     end
                 end
                 if (y(i,j) == 0 && y(i-1,j) ~= 0 )
                     index_of_top = find(strcmp({im.s(y(i-1,j)).correl.pos}, 'BT')==1);
                     index_of_top = min(index_of_top);
                     if (isempty(index_of_top) == 0)
                         new_piece =  im.s(y(i-1,j)).correl(index_of_top).piece;
                         if (ismember(new_piece, pieces_list))
                            y(i,j) = new_piece;
                            pieces_list(pieces_list == new_piece) = [];
                         end
                     end
                 end              
            else 
                for p = 1:m
                    if (ismember(p,pieces_list) == 1)
                        if (im.s(p).shape.left ~= 0)
                            index_of_left = find(strcmp({im.s(p).correl.pos}, 'LR')==1);
                            index_of_left = min(index_of_left);
                            if (isempty(index_of_left) == 1)
                                break;
                            end
                            if (im.s(p).correl(index_of_left).piece == y(i,j-1))
                                y(i,j) = p;
                                pieces_list(pieces_list == p) = [];
                                piece_found = 1;
                                break;
                            end
                        end
                    end
                end
                if (y(i,j) == 0 && y(i,j-1) ~= 0 )
                     index_of_left = find(strcmp({im.s(y(i,j-1)).correl.pos}, 'RL')==1);
                     index_of_left = min(index_of_left);
                     if (isempty(index_of_left) == 0)
                         new_piece =  im.s(y(i,j-1)).correl(index_of_left).piece;
                         if (ismember(new_piece, pieces_list))
                            y(i,j) = new_piece;
                            pieces_list(pieces_list == new_piece) = [];
                            piece_found = 1;
                         end
                     end
                
                elseif (y(i,j) == 0 && i~= 1 && y(i-1,j) ~= 0 )
                     index_of_top = find(strcmp({im.s(y(i-1,j)).correl.pos}, 'BT')==1);
                     index_of_top = min(index_of_top);
                     if (isempty(index_of_top) == 0)
                         new_piece =  im.s(y(i-1,j)).correl(index_of_top).piece;
                         if (ismember(new_piece, pieces_list))
                            y(i,j) = new_piece;
                            pieces_list(pieces_list == new_piece) = [];
                            piece_found = 1;
                         end
                     end
                end       
                  
                if (piece_found == 0)
                    y(i,j) = 0;
                end
            end
        end
    end

if (isempty(pieces_list) ==0)
    size_row = max(sum(y~=0,1)); % check the nnz along all the rows
    size_column = max(sum(y~=0,2)); % check the nnz along all the columns 
    for i = 1 : length(pieces_list)
        [result_row, result_column] = find(y(1:size_row,1:size_column)==0);
        y(result_row(i),result_column(i)) = pieces_list(i);
      
    end
end
    
    

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
    

