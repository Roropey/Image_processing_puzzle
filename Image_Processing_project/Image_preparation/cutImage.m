function truncatedImage = cutImage(Image, nbrPieces)

    [M,N,~] = size(Image);

    truncatedImage = Image;

    while mod(M,nbrPieces) ~= 0 

        M = M-1;
        truncatedImage = Image(1:M,:,:);

    end

    while mod(N,nbrPieces) ~= 0 

        N = N-1;
        truncatedImage = truncatedImage(:,1:N,:);

    end

end