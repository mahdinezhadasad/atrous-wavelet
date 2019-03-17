function [ A,D ] = a_trous_dwt2( I,N,filter )
%A_TROUS_DWT Summary of this function goes here
%   Detailed explanation goes here

 A = double(I);
for level = 1:N
    
    approx(:,:,level) =  convn(A,filter,'same');
    D(:,:,level) = A - approx(:,:,level);
    A = approx(:,:,level);
end

