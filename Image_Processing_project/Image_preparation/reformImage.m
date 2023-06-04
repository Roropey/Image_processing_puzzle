function outImage = reformImage(Image, R, nbrPieces)

    rectVert = [];
    rectHoriz = [];

    % Start by removing the black rectangle at edges of image
    outImage = Image(:,R+1:end-R,:);
    outImage = outImage(R+1:end-R,:,:);
    %figure; imshow(outImage)
    analyze = outImage(:,:,1);
    [M,N,~] = size(outImage);
    sizePieceVert = (M-2*R*(sqrt(nbrPieces)-1))/sqrt(nbrPieces);
    sizePieceHoriz = (N-2*R*(sqrt(nbrPieces)-1))/sqrt(nbrPieces);

    switch nbrPieces

        case 4
            % Collect vertical area between pieces
            rectVert = [rectVert  outImage(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:)]; %figure; imshow(rectVert(:,1:end,:))

            % Collect horizontal area between pieces
            rectHoriz = [rectHoriz ; outImage(sizePieceVert+1:2*R+sizePieceVert,:,:)]; %figure; imshow(rectHoriz(1:end,:,:))

            % Remove useless part from original image
            outImage(sizePieceVert+1:2*R+sizePieceVert,:,:) = []; %figure; imshow(outImage)
            rectVert(sizePieceVert+1:2*R+sizePieceVert,:,:) = [];

            outImage(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:) = []; %figure; imshow(outImage)
            rectHoriz(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:) = [];
            analyze = outImage(:,:,1);
            %figure; imshow(outImage)

            % Circular shift              
            rectVert = [rectVert(:,end/2+1:end,:) rectVert(:,1:end/2,:)]; %figure; imshow(rectVert);
            rectHoriz = [rectHoriz(end/2+1:end,:,:) ; rectHoriz(1:end/2,:,:)]; %figure; imshow(rectHoriz)
    
            % Reassemble the puzzle
            outImage(:,sizePieceHoriz-R+1:sizePieceHoriz+R,:) = outImage(:,sizePieceHoriz-R+1:sizePieceHoriz+R,:) + rectVert;
            outImage(sizePieceVert-R+1:sizePieceVert+R,:,:) = outImage(sizePieceVert-R+1:sizePieceVert+R,:,:) + rectHoriz;
            %figure; imshow(outImage)

            switch ndims(Image)

                case 2
                    mask = outImage == 0;
                    outImage = regionfill(outImage,mask);

                case 3
                    % Filter the result
                    [r,g,b] = imsplit(outImage);
                    maskR = outImage(:,:,1) == 0;
                    maskG = outImage(:,:,2) == 0;
                    maskB = outImage(:,:,3) == 0;
                    % Fill holes in each channel individually.
                    r = regionfill(r, maskR);
                    g = regionfill(g, maskG);
                    b = regionfill(b, maskB);
                    outImage = cat(3, r, g, b);
                    %figure; imshow(outImage)             

            end

        case 9
            % Collect vertical area between pieces
            rectVert = [rectVert  outImage(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:)]; %figure; imshow(rectVert(:,1:end,:))
            rectVert = [rectVert  outImage(:,2*R+2*sizePieceHoriz+1:4*R+2*sizePieceHoriz,:)]; %figure; imshow(rectVert(:,end/2+1:end,:))

            % Collect horizontal area between pieces
            rectHoriz = [rectHoriz ; outImage(sizePieceVert+1:2*R+sizePieceVert,:,:)]; %figure; imshow(rectHoriz(1:end,:,:))
            rectHoriz = [rectHoriz  ; outImage(2*R+2*sizePieceVert+1:4*R+2*sizePieceVert,:,:)]; %figure; imshow(rectHoriz(end/2+1:end,:,:))

            % Remove useless part from original image
            outImage(sizePieceVert+1:2*R+sizePieceVert,:,:) = []; %figure; imshow(outImage)
            rectVert(sizePieceVert+1:2*R+sizePieceVert,:,:) = [];
            outImage(2*sizePieceVert+1:2*R+2*sizePieceVert,:,:) = []; %figure; imshow(outImage)
            rectVert(2*sizePieceVert+1:2*R+2*sizePieceVert,:,:) = []; %figure; imshow(rectVert(:,1:end/2,:)); figure; imshow(rectVert(:,end/2+1:end,:))

            outImage(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:) = []; %figure; imshow(outImage)
            rectHoriz(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:) = [];
            outImage(:,2*sizePieceHoriz+1:2*R+2*sizePieceHoriz,:) = []; %figure; imshow(outImage)
            rectHoriz(:,2*sizePieceHoriz+1:2*R+2*sizePieceHoriz,:) = []; %figure; imshow(rectHoriz(1:end/2,:,:)); figure; imshow(rectHoriz(end/2+1:end,:,:))
            analyze = outImage(:,:,1);

            % Circular shift              
            rectVert = [rectVert(:,end/4+1:end/2,:) rectVert(:,1:end/4,:) rectVert(:,3*end/4+1:end,:) rectVert(:,end/2+1:3*end/4,:)]; %figure; imshow(rectVert(:,1:end/2,:)); figure; imshow(rectVert(:,end/2+1:end,:))
            rectHoriz = [rectHoriz(end/4+1:end/2,:,:) ; rectHoriz(1:end/4,:,:) ; rectHoriz(3*end/4+1:end,:,:) ; rectHoriz(end/2+1:3*end/4,:,:)]; %figure; imshow(rectHoriz(1:end/2,:,:)); figure; imshow(rectHoriz(end/2+1:end,:,:))
    
            % Reassemble the puzzle
            outImage(:,sizePieceHoriz-R+1:sizePieceHoriz+R,:) = outImage(:,sizePieceHoriz-R+1:sizePieceHoriz+R,:) + rectVert(:,1:end/2,:);
            outImage(:,2*sizePieceHoriz-R+1:2*sizePieceHoriz+R,:) = outImage(:,2*sizePieceHoriz-R+1:2*sizePieceHoriz+R,:) + rectVert(:,end/2+1:end,:);
            outImage(sizePieceVert-R+1:sizePieceVert+R,:,:) = outImage(sizePieceVert-R+1:sizePieceVert+R,:,:) + rectHoriz(1:end/2,:,:);
            outImage(2*sizePieceVert-R+1:2*sizePieceVert+R,:,:) = outImage(2*sizePieceVert-R+1:2*sizePieceVert+R,:,:) + rectHoriz(end/2+1:end,:,:);
            %figure; imshow(outImage)

            switch ndims(Image)

                case 2
                    mask = outImage == 0;
                    outImage = regionfill(outImage,mask);

                case 3
                    % Filter the result
                    [r,g,b] = imsplit(outImage);
                    maskR = outImage(:,:,1) == 0;
                    maskG = outImage(:,:,2) == 0;
                    maskB = outImage(:,:,3) == 0;
                    % Fill holes in each channel individually.
                    r = regionfill(r, maskR);
                    g = regionfill(g, maskG);
                    b = regionfill(b, maskB);
                    outImage = cat(3, r, g, b);
                    %figure; imshow(outImage)             

            end

        case 16
            % Collect vertical area between pieces
            rectVert = [rectVert  outImage(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:)]; %figure; imshow(rectVert(:,1:end,:))
            rectVert = [rectVert  outImage(:,2*R+2*sizePieceHoriz+1:4*R+2*sizePieceHoriz,:)]; %figure; imshow(rectVert(:,end/2+1:end,:))
            rectVert = [rectVert  outImage(:,4*R+3*sizePieceHoriz+1:6*R+3*sizePieceHoriz,:)]; %figure; imshow(rectVert(:,2*end/3+1:end,:))

            % Collect horizontal area between pieces
            rectHoriz = [rectHoriz ; outImage(sizePieceVert+1:2*R+sizePieceVert,:,:)]; %figure; imshow(rectHoriz(1:end,:,:))
            rectHoriz = [rectHoriz  ; outImage(2*R+2*sizePieceVert+1:4*R+2*sizePieceVert,:,:)]; %figure; imshow(rectHoriz(end/2+1:end,:,:))
            rectHoriz = [rectHoriz  ; outImage(4*R+3*sizePieceVert+1:6*R+3*sizePieceVert,:,:)]; %figure; imshow(rectHoriz(2*end/3+1:end,:,:))

            % Remove useless part from original image
            outImage(sizePieceVert+1:2*R+sizePieceVert,:,:) = []; %figure; imshow(outImage)
            rectVert(sizePieceVert+1:2*R+sizePieceVert,:,:) = []; %figure; imshow(rectVert(:,1:end/3,:));
            outImage(2*sizePieceVert+1:2*R+2*sizePieceVert,:,:) = []; %figure; imshow(outImage)
            rectVert(2*sizePieceVert+1:2*R+2*sizePieceVert,:,:) = []; %figure; imshow(rectVert(:,end/3+1:2*end/3,:))
            outImage(3*sizePieceVert+1:2*R+3*sizePieceVert,:,:) = []; %figure; imshow(outImage)
            rectVert(3*sizePieceVert+1:2*R+3*sizePieceVert,:,:) = []; %figure; imshow(rectVert(:,2*end/3+1:end,:))

            outImage(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:) = []; %figure; imshow(outImage)
            rectHoriz(:,sizePieceHoriz+1:2*R+sizePieceHoriz,:) = []; %figure; imshow(rectHoriz(1:end/3,:,:));
            outImage(:,2*sizePieceHoriz+1:2*R+2*sizePieceHoriz,:) = []; %figure; imshow(outImage)
            rectHoriz(:,2*sizePieceHoriz+1:2*R+2*sizePieceHoriz,:) = []; %figure; imshow(rectHoriz(end/3+1:2*end/3+1,:,:))
            outImage(:,3*sizePieceHoriz+1:2*R+3*sizePieceHoriz,:) = []; %figure; imshow(outImage)
            rectHoriz(:,3*sizePieceHoriz+1:2*R+3*sizePieceHoriz,:) = []; %figure; imshow(rectHoriz(2*end/3+1:end,:,:))
            analyze = outImage(:,:,1);
            %figure; imshow(outImage)

            % Circular shift              
            rectVert = [rectVert(:,end/6+1:2*end/6,:) rectVert(:,1:end/6,:) rectVert(:,3*end/6+1:4*end/6,:) rectVert(:,2*end/6+1:3*end/6,:) rectVert(:,5*end/6+1:end,:) rectVert(:,4*end/6+1:5*end/6,:)]; %figure; imshow(rectVert(:,1:end/3,:)); figure; imshow(rectVert(:,end/3+1:2*end/3,:)); figure; imshow(rectVert(:,2*end/3+1:end,:))
            rectHoriz = [rectHoriz(end/6+1:2*end/6,:,:) ; rectHoriz(1:end/6,:,:) ; rectHoriz(3*end/6+1:4*end/6,:,:) ; rectHoriz(2*end/6+1:3*end/6,:,:) ; rectHoriz(5*end/6+1:end,:,:,:) ; rectHoriz(4*end/6+1:5*end/6,:,:,:)]; %figure; imshow(rectHoriz(1:end/3,:,:)); figure; imshow(rectHoriz(end/3+1:2*end/3,:,:)); figure; imshow(rectHoriz(2*end/3+1:end,:,:))
    
            % Reassemble the puzzle
            outImage(:,sizePieceHoriz-R+1:sizePieceHoriz+R,:) = outImage(:,sizePieceHoriz-R+1:sizePieceHoriz+R,:) + rectVert(:,1:end/3,:);
            outImage(:,2*sizePieceHoriz-R+1:2*sizePieceHoriz+R,:) = outImage(:,2*sizePieceHoriz-R+1:2*sizePieceHoriz+R,:) + rectVert(:,end/3+1:2*end/3,:);
            outImage(:,3*sizePieceHoriz-R+1:3*sizePieceHoriz+R,:) = outImage(:,3*sizePieceHoriz-R+1:3*sizePieceHoriz+R,:) + rectVert(:,2*end/3+1:end,:);
            outImage(sizePieceVert-R+1:sizePieceVert+R,:,:) = outImage(sizePieceVert-R+1:sizePieceVert+R,:,:) + rectHoriz(1:end/3,:,:);
            outImage(2*sizePieceVert-R+1:2*sizePieceVert+R,:,:) = outImage(2*sizePieceVert-R+1:2*sizePieceVert+R,:,:) + rectHoriz(end/3+1:2*end/3,:,:);
            outImage(3*sizePieceVert-R+1:3*sizePieceVert+R,:,:) = outImage(3*sizePieceVert-R+1:3*sizePieceVert+R,:,:) + rectHoriz(2*end/3+1:end,:,:);
            
            %figure; imshow(outImage)

            switch ndims(Image)

                case 2
                    mask = outImage == 0;
                    outImage = regionfill(outImage,mask);

                case 3
                    % Filter the result
                    [r,g,b] = imsplit(outImage);
                    maskR = outImage(:,:,1) == 0;
                    maskG = outImage(:,:,2) == 0;
                    maskB = outImage(:,:,3) == 0;
                    % Fill holes in each channel individually.
                    r = regionfill(r, maskR);
                    g = regionfill(g, maskG);
                    b = regionfill(b, maskB);
                    outImage = cat(3, r, g, b);
                    %figure; imshow(outImage)             

            end

    end

end