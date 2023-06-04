function y = correlation(I, nb_piece)

    [maxeur indingg] = min(I,[],2);
    [maxing indexeur] = mink(maxeur,nb_piece);
    indexelem =[];
    for i = 1 :nb_piece
       indexelem(i) = indingg(indexeur(i));
    end
    position = struct; 
 
    for i = 1 : size(indexelem,2)
        if (indexelem(i) == 1)
            position(i).pos = 'TT';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 2)
            position(i).pos = 'TR';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 3)
            position(i).pos = 'TB';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 4)
            position(i).pos = 'TL';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 5)
            position(i).pos = 'RT';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 6)
            position(i).pos = 'RR';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 7)
            position(i).pos = 'RB';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 8)
            position(i).pos = 'RL';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 9)
            position(i).pos = 'BT';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 10)
            position(i).pos = 'BR';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 11)
            position(i).pos = 'BB';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 12)
            position(i).pos = 'BL';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 13)
            position(i).pos = 'LT';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 14)
            position(i).pos = 'LR';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 15)
            position(i).pos = 'LB';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        elseif (indexelem(i) == 16)
            position(i).pos = 'LL';
            position(i).piece = indexeur(i);
            position(i).valeur = maxing(i);
            continue;
        end
    end
    y = position;
    