function [diffimg] = centralDiffX(input)
%UNTITLED4 Summary of this function goes here
%   calculates the partial derivative in the x direction
    padImg = input;
    diffimg = zeros(size(input));
    [ row col ] = size(input);
    for r = 1:row
        for c = 2:col-1
            diffimg(r,c) = (padImg(r,c+1)-(padImg(r,c-1)))/2; %uses the central difference formula
        end
    end
    diffimg(:,1) = diffimg(:,2);
    diffimg(:,col) = diffimg(:,col-1);
end

