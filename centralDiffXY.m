function [ diffimg ] = centralDiffXY( input )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    padImg = double(input);
        diffimg = zeros(size(input));

    [ row col ] = size(input);
    for r = 2:row-1
        for c = 2:col-1
            diffimg(r,c) = (padImg(r+1,c+1)-padImg(r+1,c-1) - padImg(r-1,c+1)+(padImg(r-1,c-1)))/4; %uses the central difference formula
        end
    end
    diffimg(1,:) = diffimg(2,:);
    diffimg(row,:) = diffimg(row-1,:);
    diffimg(:,1) = diffimg(:,2);
    diffimg(:,col) = diffimg(:,col-1);
end

