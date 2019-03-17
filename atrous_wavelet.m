clc
clear all

data = imread('C:\Users\hi\Desktop\1.jpg');


data = double(data);


filter=[1  4 6   4  1 ; 
      4 16 24 16  4 ;
      6 24 36 24  6 ;
      4 16 24 16  4 ;
      1  4 6   4  1 ]/256;

level = 2;
[ Residual,D ] = a_trous_dwt2( data,level,filter );

P1 = D(:,:,1);
P2 = D(:,:,2);

figure; imshow(P2);

filtered = medfilt2(P2);
figure; imshow(filtered);
uc=medfilt2(filtered);
dort=medfilt2(uc);
bes=medfilt2(dort);
figure; imshow(uc);
figure; imshow(bes);
figure; imshow(dort);
adres = 'C:\Users\hi\Desktop\1_'
filename1 = strcat(adres,'.jpg');
imwrite(P2, filename1);


