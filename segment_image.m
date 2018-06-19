function [ input ] = segment_image( input ,iterations ,deltaT)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %calculate the value of phi
    n = 3;
    inp = input;
    inp = imgaussfilt(input,2.5);
    %calculate the central differences
    I_x = centralDiffX(double(inp));
    I_y = centralDiffY(double(inp));
    grad_mod = (I_x.^2+I_y.^2).^.5;
    den = 1+grad_mod.^n;
    %calculate the value of phi
    phi = 1./den;
   
    %create the curve for segmentation
    boundary = 0.*input;
    m = 10;
    boundary(1:m,:)=255;
    boundary(end-m:end,:)=255;
    boundary(:,1:m)=255;
    boundary(:,end-m:end)=255;
    
    contour_psi = create_psi(boundary);
    
    surf(contour_psi);
    
    image = contour_psi;
    [row, col] = size(image);
    %create the videowriter
 writerObjgrad = VideoWriter('mySegmentationtest.avi');
 writerObjgrad.FrameRate = 5;
  secsPerImage = 1;
  open(writerObjgrad);
    figure(1);



contour(image,[1,0],'blue');
u_t = zeros(size(image));
for i = 1:iterations
    if (mod(i-1,100)==0)
         
            %show the current no. of iteration
            %plots the image
            i
            imshow(input);
            hold on;
            [c,h]=contour(image,[0,0],'red');set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
            %sum(sum(u_t(4,4)))
            %pause;
            h.LineWidth = 1;
            drawnow;
            %uses the frame to create the video
            framegrad = getframe(1);
            writeVideo(writerObjgrad,framegrad);

            hold off;
    end
    %imagesep = image;
    %calculation of the kappa, taking the derivatives of psi (image
    %variable)
    u_x = centralDiffX(double(image));
    u_xx = centralDiffXX(double(image));
    u_y = centralDiffY(double(image));
    u_xy = centralDiffXY(double(image));
    u_yy = centralDiffYY(double(image));
    %calculating the upwinding scheme
    image_rpad = [ image zeros(row,1) ] ; 
    image_lpad = [ zeros(row,1) image ] ; 
    d_px = image_rpad(:,2:end) - image; 
    d_mx = image - image_lpad(:,1:end-1);    
    image_bpad = [ image ; zeros(1,col) ] ; 
    image_tpad = [ zeros(1,col); image ] ; 
    d_py = image_bpad(2:end,:) - image; 
    d_my = image - image_tpad(1:end-1,:);
    
    delta_p = (max(d_mx,0).^2+min(d_px,0).^2 + max(d_my,0).^2 + min(d_py,0).^2).^.5;
    
    delta_m = (max(d_px,0).^2+min(d_mx,0).^2 + max(d_py,0).^2 + min(d_my,0).^2).^.5;
    
    f = .7;
    beta_0 = -(max(f,0).*delta_p+min(f,0).*delta_m);
    
    %combining everything to get the final term
    beta_1 = .7;
    
    %calculate the kappa using the terms obtained before
    curv_term = beta_1.*(((u_xx.*u_y.^2) - 2.*(u_x.*u_y.*u_xy)+(u_yy.*u_x.^2))./...
        ((u_x.^2)+(u_y.^2)+eps));

    u_t_curve =  phi.*curv_term;
    u_t_upwind = phi.*beta_0;

    u_t = u_t_curve + u_t_upwind;

    image = (image+(u_t.*deltaT));

end
close(writerObjgrad);

end

