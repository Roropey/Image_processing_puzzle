function y = cote_isolation_bis(colorIm, cote, color_type)
% cote define which side you want as output : 1 = top; 2 = right; 3 =
% bottom and 4 = left.

solbel_hor = -1*fspecial('prewitt');
solbel_ver = solbel_hor' ;
if (color_type == 1)
    piece = rgb2gray(colorIm);
else
   piece = colorIm;
end
Im = hypot(conv2(piece,solbel_hor),conv2(piece,solbel_ver));
% Im = my_treshold(Im,0.8,100);

[rows, columns] = find(Im);

[n, m] = size(Im);
Px = 1;
Py = 1;
Qx = m;
Qy = n;

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
% Finding the first side (TOP)
if cote == 1 
  
top = [];
for k=1:25
    top_row=[];
    for i = index_coin1(2)-1 : size_column + index_coin1(2)
        for j = 1 : size_row
           if (colorIm(j,i,:) ~= 0)
                inter = colorIm(j+k,i,:);
               break
           else 
                if color_type == 1
                    inter = zeros(1,3);
               else
                    inter = zeros(1,1);
               end
           end
        end
       
    
        top_row(end+1,:) = inter;
    end
    top=cat(2,top,top_row);
end
y = top; 

elseif cote == 2 

right = [];
for k=1:25
    right_column=[];
    for i = index_coin2(1)  - size_row-1 : index_coin2(1)
        for j = 1 : size_column
           if (colorIm(i,end-j,:) ~= 0)
    %            inter_right = (inter_right1 + inter_right2) / 2;
               inter_right = colorIm(i,end-j-k,:);
               break
           else 
               if color_type == 1
                    inter_right = zeros(1,3);
               else
                    inter_right = zeros(1,1);
               end
           end
        end
        
        right_column(end+1,:) = inter_right;
    end
    right=cat(2,right_column,right);
end
y = right; 


elseif cote == 3 
bottom = [];
for k=1:25
    bottom_row=[];
    for i = index_coin2(2)  - size_column - 1 : index_coin2(2)
        for j = 1 : size_row
           if (colorIm(end-j,i,:) ~= 0)
                inter_bot = colorIm(end-j-k,i,:);
               break
           else 
                if color_type == 1
                    inter_bot = zeros(1,3);
               else
                    inter_bot = zeros(1,1);
               end
           end
        end
        
    
        bottom_row(end+1,:) = inter_bot	;
    end
    bottom=cat(2,bottom_row,bottom);
end
y = bottom; 

else
left = [];
for k=1:25
    left_column=[];
    for i = index_coin1(1)-1 : size_row + index_coin1(1)
        for j = 1 : size_column
           if (colorIm(i,j,:) ~= 0)
                inter_left = colorIm(i,j+k,:);
               break
           else 
                if color_type == 1
                    inter_left = zeros(1,3);
               else
                    inter_left = zeros(1,1);
               end
           end
        end
        
    
        left_column(end+1,:) = inter_left;
    end
    left=cat(2,left,left_column);
end
y = left; 
end

