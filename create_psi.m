function [ final_psi ] = create_psi( input )
    %if rgb convert to grayscale
    if size(input,3)>1
        input = rgb2gray(input);
    end
   %
   
    i = imbinarize(input);
    %i = padarray(i,[20,20],1);
    dist1 = bwdist(i);
    %reverse the image and then take the bwdist
    i = -i;
    i = i+1;
    dist2 = bwdist(i);
    final_psi = dist1-dist2;
    %smooth the final surface
    final_psi = imgaussfilt(final_psi,2);
    surf(final_psi);

end

