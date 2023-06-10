%% Create a puzzled version of an image
% clear; 
% clc;
% close all;

addpath(".\Image_preparation")
addpath(".\Functions_puzzle_resolution");
addpath(".\Functions_puzzle_pieces");
% Image black and white

Image = imread('lena.png');
Image = im2double(Image);
% figure
% imshow(Image)
nbrPieces = 16;
Image = cutImage(Image,nbrPieces);
[M,N,L] = size(Image);
R = round(min([M,N])/25);
PuzzledImage = PuzzleCreator(Image,nbrPieces,R);
rayon=0;
shuffled_image = shuffle_color(PuzzledImage);

% figure ; imshow(shuffled_image);



[images_crop,pieces_nbr] = extract_pieces(shuffled_image);
[piece,rayon]=aligned_pieces(images_crop,pieces_nbr);
I.piece=piece;


% I=PuzzledImage;
% order=randperm(nbrPieces);
% for i=1:nbrPieces
%     I.piece(i).im=PuzzledImage.piece(order(i)).im;
% end    


pieces_nbr=nbrPieces;
switch pieces_nbr
    case 16
        piece_per_face=4;
    case 9
        piece_per_face=3;
    case 4
        piece_per_face=2;
end

% figure;
% for i=1:piece_per_face
%     for j=1:piece_per_face
%         subplot(piece_per_face,piece_per_face,(j-1)*piece_per_face+i)
%         imshow(I.piece((j-1)*piece_per_face+i).im)
%     end
% end
% pause(1);

color=0;
% Analyzing pieces shape
pieces = struct;
for k = 1:pieces_nbr
    shape = struct;
    pieces.s(k).image = I.piece(k).im;
    tip = edge_detector(I.piece(k).im,rayon);
    shape(k).top = tip(1);
    shape(k).right = tip(2);
    shape(k).bottom = tip(3);
    shape(k).left = tip(4);  
    pieces.s(k).shape = shape(k);
end



%init
% Trouver une permière pièce pour l'algorythme : un coin
sort=sortPiecesShape(pieces,pieces_nbr,rayon,0,0,1,1);
result={{}};
x=1;
y=1;
result{x}{y}=sort(1);
sizeX=0;
sizeY=0;
upX=0;
upY=0;
% Enlever ce coin de la liste
pieces=removePieces(pieces,sort(1).idx,pieces_nbr);
pieces_nbr=pieces_nbr-1;
% Adapter ce qu'on veut pour la prochaine pièce
want_left=sort(1).shape.right*-1;
want_top=0;
want_right=(piece_per_face>2)*1;
want_bottom=1;
while pieces_nbr>0   
    x=x+1;
    % Trouver toutes les pièces qui marchent d'un point de vue forme
    sort=sortPiecesShape(pieces,pieces_nbr,rayon,want_left,want_top,want_right,want_bottom);
    nb_candidate_shape = size(sort,2);
    best=0;
    best_score=inf;
    best_score_idx=0;
    dist_best=0;
    corr2D_best=0;
    grad_best=inf;
    % Mesurer chaque pièce pour garder que la meilleure
    for i=1:nb_candidate_shape
        score=0;
        corr2D=0;
        dist=0;
        grad=0;
        % Analyser l'ajout avec la pièce du dessus
        if y>1          
            top_candidate = sort(i).image;
            bottom_previous=result{x}{y-1}.image;   
            top_candidate_border = cote_isolation(top_candidate, 1);
            bottom_previous_border = cote_isolation(bottom_previous, 3);
            min_size=min(size(top_candidate_border,1),size(bottom_previous_border,1));
            top_candidate_border=top_candidate_border(1:min_size,:,:);
            bottom_previous_border=bottom_previous_border(1:min_size,:,:);
            dist = dist + inv_mse_chosen(top_candidate_border,bottom_previous_border,color,"euclidian distance");
            corr2D_tmp=[];
            for j=1:nb_color
                corr2D_tmp = [corr2D_tmp inv_mse_chosen(top_candidate_border(:,:,j),bottom_previous_border(:,:,j),color,"corr 2D")];
            end
            corr2D = corr2D + corr2D_tmp;
            % corr2D = corr2D + inv_mse_chosen(top_candidate_border,bottom_previous_border,color,"corr 2D");
            corr2D = corr2D.*(corr2D>=0);

            grad=grad+inv_mse_chosen(top_candidate_border,bottom_previous_border,color,"Gradient");

            % figure;
            % subplot(2,1,1);
            % imshow(bottom_previous);
            % subplot(2,1,2);
            % imshow(top_candidate);

            left_candidate=imrotate(top_candidate,90);
            right_previous=imrotate(bottom_previous,90);

            % figure;
            % subplot(1,2,1);
            % imshow(right_previous);
            % subplot(1,2,2);
            % imshow(left_candidate);

            [upX_left,upY_left,downX_left,downY_left]=findCorner(left_candidate);
            [upX_right,upY_right,downX_right,downY_right]=findCorner(right_previous);
            
            left_candidate=left_candidate(upX_left:downX_left-1,1:downY_left-1,:);
            right_previous=right_previous(upX_right:downX_right-1,upY_right:end,:);

            [sizeX_right,sizeY_right,nb_channels]=size(right_previous);
            [sizeX_left,sizeY_left,~]=size(left_candidate);

            % figure;
            % subplot(1,2,1);
            % imshow(right_previous);
            % subplot(1,2,2);
            % imshow(left_candidate);

            image_superposed = zeros(max(sizeX_right,sizeX_left),sizeY_right+sizeY_left,nb_channels);
            image_superposed(1:sizeX_right,1:sizeY_right,:)=right_previous;
            image_superposed(1:sizeX_left,downY_right-upY_right-upY_left+1:downY_right-upY_right-upY_left+sizeY_left,:)=image_superposed(1:sizeX_left,downY_right-upY_right-upY_left+1:downY_right-upY_right-upY_left+sizeY_left,:).*not(image_superposed(1:sizeX_left,downY_right-upY_right-upY_left+1:downY_right-upY_right-upY_left+sizeY_left,:)~=0 & left_candidate ~=0)+left_candidate;
            image_superposed=image_superposed(:,downY_right-upY_right-round(rayon/2):downY_right-upY_right+round(rayon/2)+1,:);
            
            % figure;
            % imshow(image_superposed) 

            switch nb_channels
                case 3	
                    [r,g,b] = imsplit(image_superposed);
                    maskR = image_superposed(:,:,1) == 0;
                    maskG = image_superposed(:,:,2) == 0;                    
                    maskB = image_superposed(:,:,3) == 0; 

                    r = regionfill(r, maskR);
                    g = regionfill(g, maskG);
                    b = regionfill(b, maskB);
                    image_superposed = cat(3, r, g, b);
                case 1
                    mask = image_superposed == 0;
                    image_superposed = regionfill(image_superposed,mask);
            end
            solbel_hor = -1*fspecial('sobel');
            solbel_ver = solbel_hor' ;

            % figure;
            % imshow(image_superposed) 

            if (nb_channels == 3)
                [count,binlocation]=imhist(image_superposed(:,:,1),64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed(:,:,1),[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); %conv2(image_superposed(:,:,1),solbel_ver,'same');%hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct)
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all"); 
                [count,binlocation]=imhist(image_superposed(:,:,2),64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed(:,:,2),[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); % conv2(image_superposed(:,:,1),solbel_ver,'same');% hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct)
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all"); 
                [count,binlocation]=imhist(image_superposed(:,:,3),64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed(:,:,3),[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); %conv2(image_superposed(:,:,1),solbel_ver,'same');% hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct)
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all");
                
                % image_superposed = rgb2gray(image_superposed);
            else 
                [count,binlocation]=imhist(image_superposed,64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed,[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); %conv2(image_superposed,solbel_ver,'same');% hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct) 
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all");
            end
            % figure;
            % imshow(image_superposed) 
            % edge_reconstruct = hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
            % figure;
            % imshow(edge_reconstruct) 
            % score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all");
            ;;


        end
        % Analyser l'ajout avec la pièce de gauche
        if x>1
            left_candidate = sort(i).image;
            right_previous=result{x-1}{y}.image;
            left_candidate_border = cote_isolation(left_candidate, 4);
            right_previous_border = cote_isolation(right_previous, 2);
            min_size=min(size(left_candidate_border,1),size(right_previous_border,1));
            left_candidate_border=left_candidate_border(1:min_size,:,:);
            right_previous_border=right_previous_border(1:min_size,:,:);
            dist = dist + inv_mse_chosen(left_candidate_border,right_previous_border,color,"euclidian distance");
            nb_color=size(left_candidate_border,3);
            corr2D_tmp=[];
            for j=1:nb_color
                corr2D_tmp = [corr2D_tmp inv_mse_chosen(left_candidate_border(:,:,j),right_previous_border(:,:,j),color,"corr 2D")];
            end
            corr2D = corr2D + corr2D_tmp;
            % corr2D = corr2D + inv_mse_chosen(left_candidate_border,right_previous_border,color,"corr 2D");
            corr2D = corr2D.*(corr2D>=0);

            grad=grad+inv_mse_chosen(left_candidate_border,right_previous_border,color,"Gradient");
            % figure;
            % subplot(1,2,1);
            % imshow(right_previous);
            % subplot(1,2,2);
            % imshow(left_candidate);
            [upX_left,upY_left,downX_left,downY_left]=findCorner(left_candidate);
            [upX_right,upY_right,downX_right,downY_right]=findCorner(right_previous);
            
            left_candidate=left_candidate(upX_left:downX_left-1,1:downY_left-1,:);
            right_previous=right_previous(upX_right:downX_right-1,upY_right:end,:);

            [sizeX_right,sizeY_right,nb_channels]=size(right_previous);
            [sizeX_left,sizeY_left,~]=size(left_candidate);
            % figure;
            % subplot(1,2,1);
            % imshow(right_previous);
            % subplot(1,2,2);
            % imshow(left_candidate);

            image_superposed = zeros(max(sizeX_right,sizeX_left),sizeY_right+sizeY_left,nb_channels);
            image_superposed(1:sizeX_right,1:sizeY_right,:)=right_previous;
            image_superposed(1:sizeX_left,downY_right-upY_right-upY_left+1:downY_right-upY_right-upY_left+sizeY_left,:)=image_superposed(1:sizeX_left,downY_right-upY_right-upY_left+1:downY_right-upY_right-upY_left+sizeY_left,:).*not(image_superposed(1:sizeX_left,downY_right-upY_right-upY_left+1:downY_right-upY_right-upY_left+sizeY_left,:)~=0 & left_candidate ~=0)+left_candidate;
            image_superposed=image_superposed(:,downY_right-upY_right-round(rayon/2):downY_right-upY_right+round(rayon/2)+1,:);
            
            % figure;
            % imshow(image_superposed) 

            switch nb_channels
                case 3	
                    [r,g,b] = imsplit(image_superposed);
                    maskR = image_superposed(:,:,1) == 0;
                    maskG = image_superposed(:,:,2) == 0;                    
                    maskB = image_superposed(:,:,3) == 0; 

                    r = regionfill(r, maskR);
                    g = regionfill(g, maskG);
                    b = regionfill(b, maskB);
                    image_superposed = cat(3, r, g, b);
                case 1
                    mask = image_superposed == 0;
                    image_superposed = regionfill(image_superposed,mask);
            end
            % figure;
            % imshow(image_superposed) 
            solbel_hor = -1*fspecial('sobel');
            solbel_ver = solbel_hor' ;
            % figure;
            % imshow(image_superposed) 
            if (nb_channels == 3)
                [count,binlocation]=imhist(image_superposed(:,:,1),64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed(:,:,1),[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); %conv2(image_superposed(:,:,1),solbel_ver,'same');%hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct)
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all"); 
                [count,binlocation]=imhist(image_superposed(:,:,2),64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed(:,:,2),[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); % conv2(image_superposed(:,:,1),solbel_ver,'same');% hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct)
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all"); 
                [count,binlocation]=imhist(image_superposed(:,:,3),64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed(:,:,3),[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); %conv2(image_superposed(:,:,1),solbel_ver,'same');% hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct)
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all");
                
                % image_superposed = rgb2gray(image_superposed);
            else 
                [count,binlocation]=imhist(image_superposed,64);
                binlocation_fill = binlocation(count>0);
                minimum = min(binlocation_fill);
                maximum = max(binlocation_fill);
                image_superposed_stretch = imadjust(image_superposed,[minimum maximum],[0 1],1);
                edge_reconstruct = edge(image_superposed_stretch,'prewitt',"vertical"); %conv2(image_superposed,solbel_ver,'same');% hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
                % figure;
                % imshow(edge_reconstruct) 
                score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all");
            end
            % figure;
            % imshow(image_superposed) 
            % edge_reconstruct = hypot(conv2(image_superposed(:,:,1),solbel_hor,'same'),conv2(image_superposed(:,:,1),solbel_ver,'same'));
            % figure;
            % imshow(edge_reconstruct) 
            % score = score + sum(edge_reconstruct(:,round(rayon/2):round(rayon/2)+3),"all");
            ;;



        end
        if score < best_score & max(grad)<grad_best %& corr2D >= corr2D_best %& dist > dist_best
            best=i;
            best_score=score; 
            grad_best=max(grad);
            dist_best=dist;
            corr2D_best=corr2D;
        end
        if dist > dist_best & corr2D >= corr2D_best 
            best_other = i;
            dist_best=dist;
            corr2D_best=corr2D;
        end
    end
    
    % figure;
    % subplot(1,2,1);
    % if x==1
    %     imshow(result{x}{y-1}.image);
    % else
    %     imshow(result{x-1}{y}.image);
    % end
    % subplot(1,2,2);
    % imshow(sort(best).image);

    % Récuperer le meilleur et l'enlever
    result{x}{y}=sort(best);
    pieces=removePieces(pieces,sort(best).idx,pieces_nbr);
    pieces_nbr=pieces_nbr-1;
    [sizeX_tmp,sizeY_tmp,~]=size(sort(best).image);
    sizeX=max(sizeX,sizeX_tmp);
    sizeY=max(sizeY,sizeY_tmp);
    [upX_tmp,upY_tmp,~,~]=findCorner(sort(best).image);
    upX=max(upX,upX_tmp);
    upY=max(upY,upY_tmp);
    % Mise à jour de la position dans la pseudo reconstruction
    if sort(best).shape.right==0 | x==piece_per_face
        x=0;
        y=y+1;
    end
    % Redéfinition de ce qu'on veut en terme de côté
    if x==0
        % Si on recommence une ligne, on veut un plat à gauche et un non
        % plat à droite
        want_left=0;
        want_right=1;        
    else
        % Sinon on veut le correspondant à gauche et soit un non plat soit
        % un plat en fonction de l'avancement de la ligne
        want_left=sort(best).shape.right*-1;
        want_right=(x<piece_per_face-1);
    end

    if y == 1
        % Si on est sur la première ligne, on veut un dessus plat et un
        % dessous non plat
        want_top=0;
        want_bottom=1;
    else
        % Sinon un dessus rentrant dans la pièce du dessus, et un dessous
        % soit plat si on est à la fin, soit non plat
        want_top=result{x+1}{y-1}.shape.bottom*-1;
        want_bottom=(y<piece_per_face);
    end
end    

image_f = zeros(piece_per_face*sizeX,piece_per_face*sizeY,size(result{1}{1}.image,3));
% figure;
nb_row=size(result,2);
nb_column = size(result{1},2);
for j=1:nb_column
    for i=1:nb_row  
        image=result{i}{j};
        [sizeX_tmp,sizeY_tmp,~]=size(image.image);
        [upX_tmp,upY_tmp,~,~]=findCorner(image.image);
        upX=max(upX,upX_tmp);
        upY=max(upY,upY_tmp);
        
        image_f(sizeX*(j-1)+1+(upX-upX_tmp):sizeX*(j-1)+sizeX_tmp+(upX-upX_tmp),sizeY*(i-1)+1+(upY-upY_tmp):sizeY*(i-1)+sizeY_tmp+(upY-upY_tmp),:) = image.image;
        % subplot(piece_per_face,piece_per_face,(j-1)*piece_per_face+i)
        % imshow(image.image)
    end
end
rayon=ceil(mean(rayon,min(upX,upY)));
% figure;
% imshow(image_f);
image_result=reformImage(image_f,rayon,nbrPieces);
figure;
imshow(image_result);
pause(5);

% figure;
% nb_row=size(result,2);
% nb_column = size(result{1},2);
% for j=1:nb_column
%     for i=1:nb_row  
%         image=result{i}{j};
%         subplot(piece_per_face,piece_per_face,(j-1)*piece_per_face+i)
%         imshow(image.image)
%     end
% end