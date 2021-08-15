function Conn = Conn_Filt(V)
% Conn_Filt takes a 3D binary image and imposes face connectivity to
% isolate the single largest connected body.
%
% Conn = Conn_Filt(V) returns the single largest connected component in
% the 3D binary image V.
%
% Conn is a 3D binary image the same size as V.
%CC = bwconncomp(V, 6);
CC = bwconncomp(V, 6);
numPixels = cellfun(@numel, CC.PixelIdxList); %find number of pixels in
 %connected component.
[~, idx] = max(numPixels); %index of largest connected component.
%Conn = zeros(size(V), 'logical');
Conn = V;
Conn(CC.PixelIdxList{idx}) = 1; %new image isolating largest connected body
end