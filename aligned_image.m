function [image_rotate,rotation] = aligned_image(image,affichage)
%aligned_image : pick a image, find the principal line and return the image
% rotate to have this line horizontal or vertical
%   - image : original image, a binary/black and white matrix, like an
%   occupancy map of the image
%   /!\ not sure that the program works on a colored image (with multiple
%   canal)
%   - affichage : boolean indicating if the user want to see steps of the process
%--------------------------------------------------------------------------
%   - image_rotate : original image rotate fulfilling the task
%   - rotation : angle of rotation applied



% Extract border of the image
BW = edge(image,'canny');
% Applied hough transform 
[H,T,R] = hough(BW);
% Find peaks (corner) of the border
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
if affichage
    figure();
    subplot(2,2,1);
    imshow(image);
    title("Rotated image"); 
    subplot(2,2,2);
    imshow(H,[],'XData',T,'YData',R,...
                'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;    
    x = T(P(:,2)); y = R(P(:,1));
    plot(x,y,'s','color','white');
end
% Find straight lines of the image's borders
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
if affichage
    subplot(2,2,3); imshow(image); hold on;
end
% Variable to extract theta rotation from the straight lines
angles = [];
for k = 1:length(lines)
   if affichage
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   end

   angle = lines(k).theta;
   if angle<0  
       % If angle is inferior to 0, it is perpendicular of the other ones
       % so applied a +90° to make it parallel
       angle = 90 + angle;
   end;
   % Take the result to memorized it
   angles = [angles angle];
end
if affichage
    hold off;
    title("Edge dectetion with hough transform");
end
% The rotation is deduced from the most frequent theta to make it 0 after
% transform
rotation = mode(angles);
% Applied the rotation
image_rotate = imrotate(image,rotation,'crop');
if affichage
    subplot(2,2,4);
    imshow(image_rotate)
    title("Putted right image")
end
end