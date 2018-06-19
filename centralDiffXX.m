function [ diffimg ] = centralDiffXX( input )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    padImg = double(input);
    diffimg = zeros(size(input));
        
    [ row col ] = size(input);
    for r = 1:row
        for c = 2:col-1
            diffimg(r,c) = (padImg(r,c+1)-(2*padImg(r,c))+(padImg(r,c-1))); %uses the central difference formula
        end
    end
end

