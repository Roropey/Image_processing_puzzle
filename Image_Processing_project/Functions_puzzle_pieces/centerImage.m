function piece = centerImage(mask, M, N, R, nppr, position)

    switch ndims(mask)

        case 2

            piece = zeros(((1/nppr)*M)+2*R, ((1/nppr)*N)+2*R);

            switch nppr
        
                case 2                                        

                    switch position
                        case 1
                            piece(R+1:R+((1/nppr)*M), R+1:end) = mask(1:((1/nppr)*M), 1:((1/nppr)*N)+R);
                            
                            
                        case 2
                            piece(R+1:end, R+1:((1/nppr)*N)+R) = mask(1:((1/nppr)*M)+R, ((1/nppr)*N)+1:end);
                            
                            
                        case 3
                            piece(1:((1/nppr)*M)+R, R+1:((1/nppr)*N)+R) = mask(((1/nppr)*M)-R+1:end, 1:((1/nppr)*N));
                            
                            
                        case 4
                            piece(R+1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R) = mask(((1/nppr)*M)+1:end, ((1/nppr)*N)-R+1:end);
                            
                            
                    end
        
                case 3

                    switch position
                        
                        case 1
                            piece(R+1:R+((1/nppr)*M), R+1:end) = mask(1:((1/nppr)*M), 1:((1/nppr)*N)+R);
                            
                            
                        case 2
                            piece(R+1:R+((1/nppr)*M), R+1:end) = mask(1:((1/nppr)*M), ((1/nppr)*N)+1:2*((1/nppr)*N)+R);
                            
                            
                        case 3
                            piece(R+1:end, R+1:((1/nppr)*N)+R) = mask(1:((1/nppr)*M)+R, 2*((1/nppr)*N)+1:end);
                            
                            
                        case 4
                            piece(1:((1/nppr)*M)+R, R+1:end) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M), 1:((1/nppr)*N)+R);
                            
                            
                        case 5
                            piece(:, R+1:((1/nppr)*N)+R) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M)+R, ((1/nppr)*N)+1:2*((1/nppr)*N));
                            
                            
                        case 6
                            piece(R+1:end, 1:((1/nppr)*N)+R) = mask(((1/nppr)*M)+1:2*((1/nppr)*M)+R, 2*((1/nppr)*N)-R+1:end);
                            
                            
                        case 7
                            piece(1:((1/nppr)*M)+R, R+1:((1/nppr)*N)+R) = mask(2*((1/nppr)*M)-R+1:end, 1:((1/nppr)*N));
                            
                            
                        case 8 
                            piece(R+1:R+((1/nppr)*M), 1:((1/nppr)*N)+R) = mask(2*((1/nppr)*M)+1:end, ((1/nppr)*N)-R+1:2*((1/nppr)*N));
                            
                            
                        case 9
                            piece(R+1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R) = mask(2*((1/nppr)*M)+1:end, 2*((1/nppr)*N)-R+1:end);
                            
                            
                    end

                case 4
                    
                    switch position
                        
                        case 1
                            piece(R+1:R+((1/nppr)*M), R+1:end) = mask(1:((1/nppr)*M), 1:((1/nppr)*N)+R);
                            
                            
                        case 2
                            piece(R+1:R+((1/nppr)*M), R+1:end) = mask(1:((1/nppr)*M), ((1/nppr)*N)+1:2*((1/nppr)*N)+R);
                            
                            
                        case 3
                            piece(R+1:R+((1/nppr)*M), R+1:end) = mask(1:((1/nppr)*M), 2*(1/nppr)*N+1:3*((1/nppr)*N)+R);
                            
                            
                        case 4
                            piece(R+1:end, R+1:((1/nppr)*N)+R) = mask(1:((1/nppr)*M)+R, 3*((1/nppr)*N)+1:end);
                            
                            
                        case 5
                            piece(1:((1/nppr)*M)+R, R+1:end) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M), 1:((1/nppr)*N)+R);
                            
                            
                        case 6
                            piece(:, R+1:((1/nppr)*N)+R) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M)+R, ((1/nppr)*N)+1:2*((1/nppr)*N));
                            
                            
                        case 7
                            piece(:, 1:((1/nppr)*N)+R) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M)+R, 2*((1/nppr)*N)-R+1:3*((1/nppr)*N));
                            
                            
                        case 8 
                            piece(R+1:end, 1:((1/nppr)*N)+R) = mask(((1/nppr)*M)+1:2*((1/nppr)*M)+R, 3*((1/nppr)*N)-R+1:end);
                            
                            
                        case 9
                            piece(1:((1/nppr)*M)+R, R+1:end) = mask(2*((1/nppr)*M)-R+1:3*((1/nppr)*M), 1:((1/nppr)*N)+R);
                            
                            
                        case 10
                            piece(:, R+1:((1/nppr)*N)+R) = mask(2*((1/nppr)*M)-R+1:3*((1/nppr)*M)+R, ((1/nppr)*N)+1:2*((1/nppr)*N));
                            
                            
                        case 11
                            piece(:, 1:((1/nppr)*N)+R) = mask(2*((1/nppr)*M)-R+1:3*((1/nppr)*M)+R, 2*((1/nppr)*N)-R+1:3*((1/nppr)*N));
                            
                            
                        case 12
                            piece(R+1:end, 1:((1/nppr)*N)+R) = mask(2*((1/nppr)*M)+1:3*((1/nppr)*M)+R, 3*((1/nppr)*N)-R+1:end);
                            
                            
                        case 13
                            piece(1:((1/nppr)*M)+R, R+1:((1/nppr)*N)+R) = mask(3*((1/nppr)*M)-R+1:end, 1:((1/nppr)*N));
                            
                            
                        case 14
                            piece(1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R) = mask(3*((1/nppr)*M)-R+1:end, ((1/nppr)*N)-R+1:2*((1/nppr)*N));
                            
                            
                        case 15
                            piece(1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R) = mask(3*((1/nppr)*M)-R+1:end, (2*(1/nppr)*N)-R+1:3*((1/nppr)*N));
                            
                            
                        case 16
                            piece(R+1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R) = mask(3*((1/nppr)*M)+1:end, 3*((1/nppr)*N)-R+1:end);
                            
                            
                    end
            end

        case 3

            piece = zeros(((1/nppr)*M)+2*R, ((1/nppr)*N)+2*R, 3);

            switch nppr
        
                case 2
                    
                    switch position
                        
                        case 1
                            piece(R+1:R+((1/nppr)*M), R+1:end, :) = mask(1:((1/nppr)*M), 1:((1/nppr)*N)+R, :);
                            
                            
                        case 2
                            piece(R+1:end, R+1:((1/nppr)*N)+R, :) = mask(1:((1/nppr)*M)+R, ((1/nppr)*N)+1:end, :);
                            
                            
                        case 3
                            piece(1:((1/nppr)*M)+R, R+1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)-R+1:end, 1:((1/nppr)*N), :);
                            
                            
                        case 4
                            piece(R+1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)+1:end, ((1/nppr)*N)-R+1:end, :);
                            
                            
                    end
        
                case 3

                    switch position
                        
                        case 1
                            piece(R+1:R+((1/nppr)*M), R+1:end, :) = mask(1:((1/nppr)*M), 1:((1/nppr)*N)+R, :);
                            
                            
                        case 2
                            piece(R+1:R+((1/nppr)*M), R+1:end, :) = mask(1:((1/nppr)*M), ((1/nppr)*N)+1:2*((1/nppr)*N)+R, :);
                            
                            
                        case 3
                            piece(R+1:end, R+1:((1/nppr)*N)+R, :) = mask(1:((1/nppr)*M)+R, 2*((1/nppr)*N)+1:end, :);
                            
                            
                        case 4
                            piece(1:((1/nppr)*M)+R, R+1:end, :) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M), 1:((1/nppr)*N)+R, :);
                            
                            
                        case 5
                            piece(:, R+1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M)+R, ((1/nppr)*N)+1:2*((1/nppr)*N), :);
                            
                            
                        case 6
                            piece(R+1:end, 1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)+1:2*((1/nppr)*M)+R, 2*((1/nppr)*N)-R+1:end, :);
                            
                            
                        case 7
                            piece(1:((1/nppr)*M)+R, R+1:((1/nppr)*N)+R, :) = mask(2*((1/nppr)*M)-R+1:end, 1:((1/nppr)*N), :);
                            
                            
                        case 8 
                            piece(R+1:R+((1/nppr)*M), 1:((1/nppr)*N)+R, :) = mask(2*((1/nppr)*M)+1:end, ((1/nppr)*N)-R+1:2*((1/nppr)*N), :);
                            
                            
                        case 9
                            piece(R+1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R, :) = mask(2*((1/nppr)*M)+1:end, 2*((1/nppr)*N)-R+1:end, :);
                            
                            
                    end

                case 4
                    
                    switch position
                        
                        case 1
                            piece(R+1:R+((1/nppr)*M), R+1:end, :) = mask(1:((1/nppr)*M), 1:((1/nppr)*N)+R, :);
                            
                            
                        case 2
                            piece(R+1:R+((1/nppr)*M), R+1:end, :) = mask(1:((1/nppr)*M), ((1/nppr)*N)+1:2*((1/nppr)*N)+R, :);
                            
                            
                        case 3
                            piece(R+1:R+((1/nppr)*M), R+1:end, :) = mask(1:((1/nppr)*M), 2*(1/nppr)*N+1:3*((1/nppr)*N)+R, :);
                            
                            
                        case 4
                            piece(R+1:end, R+1:((1/nppr)*N)+R, :) = mask(1:((1/nppr)*M)+R, 3*((1/nppr)*N)+1:end, :);
                            
                            
                        case 5
                            piece(1:((1/nppr)*M)+R, R+1:end, :) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M), 1:((1/nppr)*N)+R, :);
                            
                            
                        case 6
                            piece(:, R+1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M)+R, ((1/nppr)*N)+1:2*((1/nppr)*N), :);
                            
                            
                        case 7
                            piece(:, 1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)-R+1:2*((1/nppr)*M)+R, 2*((1/nppr)*N)-R+1:3*((1/nppr)*N), :);
                            
                            
                        case 8 
                            piece(R+1:end, 1:((1/nppr)*N)+R, :) = mask(((1/nppr)*M)+1:2*((1/nppr)*M)+R, 3*((1/nppr)*N)-R+1:end, :);
                            
                            
                        case 9
                            piece(1:((1/nppr)*M)+R, R+1:end, :) = mask(2*((1/nppr)*M)-R+1:3*((1/nppr)*M), 1:((1/nppr)*N)+R, :);
                            
                            
                        case 10
                            piece(:, R+1:((1/nppr)*N)+R, :) = mask(2*((1/nppr)*M)-R+1:3*((1/nppr)*M)+R, ((1/nppr)*N)+1:2*((1/nppr)*N), :);
                            
                            
                        case 11
                            piece(:, 1:((1/nppr)*N)+R, :) = mask(2*((1/nppr)*M)-R+1:3*((1/nppr)*M)+R, 2*((1/nppr)*N)-R+1:3*((1/nppr)*N), :);
                            
                            
                        case 12
                            piece(R+1:end, 1:((1/nppr)*N)+R, :) = mask(2*((1/nppr)*M)+1:3*((1/nppr)*M)+R, 3*((1/nppr)*N)-R+1:end, :);
                            
                            
                        case 13
                            piece(1:((1/nppr)*M)+R, R+1:((1/nppr)*N)+R, :) = mask(3*((1/nppr)*M)-R+1:end, 1:((1/nppr)*N), :);
                            
                            
                        case 14
                            piece(1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R, :) = mask(3*((1/nppr)*M)-R+1:end, ((1/nppr)*N)-R+1:2*((1/nppr)*N), :);
                            
                            
                        case 15
                            piece(1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R, :) = mask(3*((1/nppr)*M)-R+1:end, (2*(1/nppr)*N)-R+1:3*((1/nppr)*N), :);
                            
                            
                        case 16
                            piece(R+1:((1/nppr)*M)+R, 1:((1/nppr)*N)+R, :) = mask(3*((1/nppr)*M)+1:end, 3*((1/nppr)*N)-R+1:end, :);
                            
                            
                    end
            end
    end
end