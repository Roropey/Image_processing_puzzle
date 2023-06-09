function y = reorder(im, positions)

 m = nnz(positions(1,:)); % nbr of pieces by row
 n = nnz(positions(:,1)); % nbr of rows
 
 all_pieces = n*m ;
 
 for i = 1 : n
%      figure; imshow(im.s(positions(i,1)).image);
%      figure; imshow(im.s(positions(i,2)).image);
%      figure; imshow(im.s(positions(i,3)).image);
%      figure; imshow(im.s(positions(i,4)).image);
     for j = 1 :m
         piece = positions(i,j);
         edge = [];
         edge_1 = [];
         if (i == 1 && j ==1)
             edge = edge_detector(im.s(piece).image);
             while  1
                 im.s(piece).image = rot90(im.s(piece).image,1);    
                 edge = edge_detector(im.s(piece).image);
                 if (edge(1) == 0 && edge(4) == 0)
                     break;
                 end 
             end
         elseif (j~= 1)
            edge = edge_detector(im.s(piece).image);
            edge_1 = edge_detector(im.s(positions(i,j-1)).image);
            possible_comb = edge*edge_1(2);
            if ( nnz(possible_comb == -1) == 1 )
                im.s(piece).image = rot90(im.s(piece).image,-(4-find(possible_comb == -1))); 
            else
                % HERE IS THE HARDEST
                previous = cote_isolation(im.s(positions(i,j-1)).image, 2);
                possible_previous = find(possible_comb == -1);
                correl = [];
                for s = 1 : length(possible_previous)
                    pretendant = cote_isolation(im.s(piece).image, possible_previous(s));
                    correl(s) = inv_mse(previous, pretendant, 1);
                    
                end 
                [~,which_piece] = max(correl);
                rotation_nbr = possible_previous(which_piece);
                if (isinteger(rotation_nbr))
                    im.s(piece).image = rot90(im.s(piece).image,-(4-rotation_nbr)); 
                end
            end         
         elseif (i~= 1 && j == 1 && i ~= n)
             edge = edge_detector(im.s(piece).image);
             while  1
                 im.s(piece).image = rot90(im.s(piece).image,1);    
                 edge = edge_detector(im.s(piece).image);
                 if (edge(4) == 0)
                     break;
                 end 
             end
         elseif (i == n && j == 1)
             edge = edge_detector(im.s(piece).image);
             while  1
                 im.s(piece).image = rot90(im.s(piece).image,1);    
                 edge = edge_detector(im.s(piece).image);
                 if (edge(3) == 0 && edge(4) == 0)
                     break;
                 end 
             end
         end
     end
%      figure; imshow(im.s(positions(i,1)).image);
%      figure; imshow(im.s(positions(i,2)).image);
%      figure; imshow(im.s(positions(i,3)).image);
%      figure; imshow(im.s(positions(i,4)).image);
 end
 y = im;