function Image = drawHalfCircle(x,y,x0,y0,R,Image,orientation,choice)

    switch choice

        case 'add'

            switch orientation
                case 'bottom'
                    Image(y >= y0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 1;
                case 'up'
                    Image(y <= y0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 1;
                case 'left'
                    Image(x <= x0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 1;
                case 'right'
                    Image(x >= x0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 1;
            end

        case 'remove'

            switch orientation
                case 'bottom'
                    Image(y >= y0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 0;
                case 'up'
                    Image(y <= y0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 0;
                case 'left'
                    Image(x <= x0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 0;
                case 'right'
                    Image(x >= x0 & (x-x0).^2 + (y-y0).^2 <= R^2) = 0;
            end

    end

end
