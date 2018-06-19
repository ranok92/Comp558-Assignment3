function [ image ] = geometric_heatequation( origimg, image ,deltaT , timestep)
%UNTITLED3 Summary of this function goes here


%create the video writer
writerObjgrad = VideoWriter('mycurvatureflow.avi');
 writerObjgrad.FrameRate = 5;
[row, col] = size(image);
  secsPerImage = 1;
  open(writerObjgrad);
    figure(1);

contour(image,[1,0],'blue');
for i = 1:timestep
    if (mod(i,100)==0)
            %display the number of iterations covered
            i
            %show the image and the updated contour 
            imshow(origimg);
            hold on;
            [c h] = contour(image,[0,0],'red');
            h.LineWidth = 1;
            drawnow;
            framegrad = getframe(1);
            writeVideo(writerObjgrad,framegrad);

            hold off;
    end

    %[u_x ,u_y ] = gradient(image);
    %[u_xx, u_xy ] = gradient(u_x);
    %[u_xy, u_yy] = gradient(u_y);
    
    %calculate the gradient values using central differences
    u_x = centralDiffX(image);
    u_xx = centralDiffXX(image);
    u_y = centralDiffY(image);
    u_xy = centralDiffXY(image);
    u_yy = centralDiffYY(image);

    %calculate the value of kappa||div psi|| using the derivative terms calculated before 
    u_t = ((u_xx.*u_y.^2) - 2.*(u_x.*u_y.*u_xy)+(u_yy.*u_x.^2))./...
        ((u_x.^2)+(u_y.^2)+eps);

    %update the imgae
    image = (image+(u_t*deltaT));

    
end    
close(writerObjgrad);
    
end

