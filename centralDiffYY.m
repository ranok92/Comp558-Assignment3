function [ diffimg ] = centralDiffYY( input )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    padImg = double(input);
    diffimg = zeros(size(input));
    %    diffimg = input;
    [ row col ] = size(input);
    for r = 2:row-1
        for c = 1:col
            diffimg(r,c) = padImg(r+1,c)-2*padImg(r,c)+padImg(r-1,c);%uses the central difference formula
        end
    end
    %diffimg(1,:) = diffimg(2,:);
    %diffimg(row,:) = diffimg(row-1,:);
end



