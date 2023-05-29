% It looks in the Data_Progect folder, and for every .tif file in the
% folder assigns at the NaN pixel value the 0 value, and then with the
% green band and the nir band compute the NDWI index and saves it in the folder Index_resoults. 


clear all
close all
clc

% -------- load data ------

folder_path = "Data_Progect\";
Images = dir(erase(join([folder_path, "*.tif"])," "));

for i = 1:size(Images,1)

Image_name = string(Images(i).name);

[img,geo] = readgeoraster(erase(join([folder_path,Image_name])," "));

img = img(:,:,[1,2,3,8]);  %Working only with B,G,R,Nir bands

% -------- clearing Nan Data ------

for k = 1:size(img,3)
    L = isnan(img(:,:,k)); 
    A = img(:,:,k);
    A(L) = 0;
    img(:,:,k) = A;
end
clear A

% -------- water index calculation (Band_1 = Green ; Band_2 = Nir) ------

Band_1 = img(:,:,2);
Band_2 = img(:,:,4);

index = (Band_1 - Band_2)./(Band_1 + Band_2);

% -------- saving resoults ------

Saving_folder = "Index_resoults\";
Image_name = erase(Image_name, ".tif");
index_img_name = erase(join([Saving_folder Image_name "_NDWI_index.tif"])," ");

geotiffwrite (index_img_name,index,geo);

end
