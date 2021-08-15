% CT_To_Volume:
%
% This script reads a series of grayscale images and stacks them, binarizes
% the volume, and applies a connectivity filter to isolate a single
% connected body.
%
% Output V_conn is a 3D binary image.
%-------------------------------------------------------------------------
% User Input Parameters:
% Specify folder of images:
Folder_Path = '/home/raihan/Documents/bones/selected/';
Image_Leader = 'single'; %Leading characters in file from CT export
First_Image = 181;
Last_Image = 406;
% Cropping dimensions: specify extents of cropping - these can be
% identified by probing values in the image viewer or using imshow().
xlow = 1; %161;
xhigh = 100; %513;
ylow = 16; %569;
yhigh = 80; %846;
%-------------------------------------------------------------------------
% Crop and Stack Images:
filepath = append(Folder_Path,Image_Leader);
count = 0;
Image_Number = First_Image;
Layer = 1;
A = zeros(yhigh-ylow,xhigh-xlow+1,'uint16');
[m,n] = size(A);
V = zeros(m,n,(Last_Image-First_Image+1),'uint16');
for i = First_Image:Last_Image
    %change filename to open each image
    %filename = append(filepath,num2str(Image_Number, '%3.4i'));
    filename = append(filepath,num2str(Image_Number));
    Z = imread(filename,'tiff');
     %select only the desire pixels:
        for j = 1:(yhigh - ylow)
        A(j,:) = Z(ylow + (j-1), xlow:xhigh);
        end
    %stack each cropped image into a 3D volume:
    %V(:,:,Layer) = A;
    V(:,:,Layer) = imbinarize(A);
    Image_Number = Image_Number + 1;
    Layer = Layer + 1;
end
%-------------------------------------------------------------------------
% Binarization:
%V_seg = imbinarize(V); % Otsu's Method
%-------------------------------------------------------------------------
% Keep only the largest section of connected voxels
%V_conn = Conn_Filt(V_seg);
V_conn = Conn_Filt(V);
volshow(V_conn);