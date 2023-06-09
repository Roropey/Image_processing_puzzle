function y = edge_detector(I,rayon_found)
    %% Function that returns -1 if there is a hole, 0 if it's a side and 1 if there is an extra part
    % It returns it for the 4 side of the piece
    [m, n, p] = size(I);
    y = [];
   
    
    if p == 3
        Im = rgb2gray(I);
    else
        Im = I;
    end
    
    [rows, columns] = find(Im);
    Px = 1;
    Py = 1;
    Qx = m;
    Qy = n;
    
    padding = round(rayon_found/2);
    % Finding the indexes of 2 point : the nearest coin and the farest one from
    % the origin : allows to find the egde lines.
    distancesP = sqrt((columns - Px).^2 + (rows - Py) .^ 2);
    [~, indexOfMinP] = min(distancesP);
    distancesQ = sqrt((columns - Qx).^2 + (rows - Qy) .^ 2);
    [~, indexOfMinQ] = min(distancesQ);

    index_coin1 = [rows(indexOfMinP), columns(indexOfMinP)];
    index_coin2 = [rows(indexOfMinQ), columns(indexOfMinQ)];

    size_row = index_coin2(1) - index_coin1(1);
    size_column = index_coin2(2) - index_coin1(2);
    
    %TOP 
    if ( Im(index_coin1(1)-padding, index_coin1(2) + round(size_column/2)) ~= 0 )
        y(1) = 1;
    elseif  (Im(index_coin1(1)+padding, index_coin1(2) + round(size_column/2)) == 0 )
        y(1) = -1;
    else
        y(1) = 0;
    end
    % RIGHT
    if ( Im(index_coin2(1) - round(size_row/2), index_coin2(2)+padding) ~= 0 )
        y(2) = 1;
    elseif  (Im( index_coin2(1) - round(size_row/2),index_coin2(2)-padding) == 0 )
        y(2) = -1;
    else
        y(2) = 0;
    end
  % BOTTOM
    if ( Im(index_coin2(1)+padding, index_coin2(2) - round(size_column/2)) ~= 0 )
        y(3) = 1;
    elseif  (Im(index_coin2(1)-padding, index_coin2(2) - round(size_column/2)) == 0 )
        y(3) = -1;
    else
        y(3) = 0;
    end
   %LEFT
    if ( Im(index_coin1(1) + round(size_row/2), index_coin1(2)-padding) ~= 0 )
        y(4) = 1;
    elseif  (Im( index_coin1(2) + round(size_row/2), index_coin1(1)+padding) == 0 )
        y(4) = -1;
    else
        y(4) = 0;
    end 
    
    
    % TOP
%     for i = 0:1
%         side_up = I(1 + bord*i :2 + bord*i, bord+1:n-bord);
%         if (nnz(side_up) > 0 && i == 0) 
%             y(1) = 1 ;
%             break;
%         elseif (nnz(~side_up) >= bord && i == 1)
%             y(1) = -1;
%             break;
%         else 
%             y(1) = 0;
%         end
%     end
%     % RIGHT
%     for i = 0:1
%         side_up = I(bord+1:m-bord, n-bord-1 +bord*i : n-bord + bord*i);
%         if (nnz(side_up) > 0 && i == 1) 
%             y(2) = 1 ;
%             break;
%         elseif (nnz(~side_up) >= bord && i == 0)
%             y(2) = -1;
%             break;
%         else 
%             y(2) = 0;
%         end
%     end
%       
%     % BOTTOM
%     for i = 0:1
%         side_up = I(m-bord-1 + bord*i :m-bord+ bord*i, bord+1:n-bord);
%         if (nnz(side_up) > 0 && i == 1) 
%             y(3) = 1 ;
%             break;
%         elseif (nnz(~side_up) >= bord && i == 0)
%             y(3) = -1;
%             break;
%         else 
%             y(3) = 0;
%         end
%     end
%      
%         
%     % LEFT
%     for i = 0:1
%         side_up = I(bord+1:m-bord, 1 + bord*i :2 + bord*i);
%         if (nnz(side_up) > 0 && i == 0) 
%             y(4) = 1 ;
%             break;
%         elseif (nnz(~side_up) >= bord && i == 1)
%             y(4) = -1;
%             break;
%         else 
%             y(4) = 0;
%         end
%     end
        
        
    end
   
    
    