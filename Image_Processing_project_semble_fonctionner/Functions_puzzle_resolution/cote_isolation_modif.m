function y = cote_isolation_modif(colorIm, cote)
% cote define which side you want as output : 1 = top; 2 = right; 3 =
% bottom and 4 = left.

% Modification pour que ça fonctionne (j'avais des erreurs)

color_type = 0;
if ndims(colorIm) == 3
    color_type = 1 ;
end

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
size_take = 0; % widht of the size to take
if cote == 1 
  
top = [];
for i = index_coin1(2)-1 : size_column + index_coin1(2)
    inter1 = zeros(size_take+1,1,3);
    for j = 1 : size_row
       if (colorIm(j,i,:) ~= 0)
           inter1 = colorIm(j:j+size_take,i,:);
           inter = inter1;
           break
       else 
            if color_type == 1
                inter = zeros(size_take+1,1,3);
           else
                inter = zeros(size_take+1,1);
           end
       end
    end
   
    top(:,end+1,:) = inter;
end
y = top; 

elseif cote == 2 

right = [];
for i = index_coin2(1)  - size_row-1 : index_coin2(1)
    inter_right1 = zeros(size_take+1,1,3);
    
    for j = 1 : size_column
       if (colorIm(i,end-j,:) ~= 0)
           if color_type==1
           inter_right1(:,:,1) = colorIm(i,end-j-size_take:end-j,1)';
            inter_right1(:,:,2) = colorIm(i,end-j-size_take:end-j,2)';
            inter_right1(:,:,3) = colorIm(i,end-j-size_take:end-j,3)';
            inter_right = inter_right1;
           else
               inter_right=colorIm(i,end-j-size_take:end-j)';
           end
%            inter_right2 = colorIm(i,end-j-1,:);
%            inter_right = (inter_right1 + inter_right2) / 2;
           
           break
       else 
           if color_type == 1
                inter_right = zeros(size_take+1,1,3);
           else
                inter_right = zeros(size_take+1,1);
           end
       end
    end
    
    right(:,end+1,:) = inter_right;
end
y = right; 


elseif cote == 3 
bottom = [];
for i = index_coin2(2)  - size_column - 1 : index_coin2(2)
    inter_bot1 = zeros(size_take+1,1,3);
    for j = 1 : size_row
       if (colorIm(end-j,i,:) ~= 0)
           inter_bot1 = colorIm(end-j-size_take:end-j,i,:);
            inter_bot = inter_bot1;
           break
       else 
            if color_type == 1
                inter_bot = zeros(size_take+1,1,3);
           else
                inter_bot = zeros(size_take+1,1);
           end
       end
    end
    

    bottom(:,end+1,:) = inter_bot	;
end
y = bottom; 

else
left = [];
for i = index_coin1(1)-1 : size_row + index_coin1(1)
    inter_left1 = zeros(size_take+1,1,3);
    for j = 1 : size_column
       if (colorIm(i,j,:) ~= 0)
           if color_type==1
            inter_left1(:,:,1) = colorIm(i,j:j+size_take,1)';
            inter_left1(:,:,2) = colorIm(i,j:j+size_take,2)';
            inter_left1(:,:,3) = colorIm(i,j:j+size_take,3)';
            inter_left=inter_left1;
           else
               inter_left=colorIm(i,j:j+size_take);
           end
%            inter_left2 = colorIm(i,j+1,:);
%            inter_left = (inter_left1 + inter_left2)/2;
            
           break
       else 
            if color_type == 1
                inter_left = zeros(size_take+1,1,3);
           else
                inter_left = zeros(size_take+1,1);
           end
       end
    end
    

    left(:,end+1,:) = inter_left;
end
y = left; 
end

