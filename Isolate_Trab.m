%Isolate_Trab:
% This script takes a connected volume of a bone and applies image opening
% functions to isolate the trabecular structure.
E = V_conn; %Connected volume
se = strel('cube',5); % 5x5x5 cubic structural element.
E_open = imopen(E,se);
%E_open = imclose(E,se);
E_open_conn = Conn_Filt(E_open); %Isolated cortical shell.
G = E-E_open_conn; %subtract cortical shell from original image to isolate
 % trabecular structure.
Trab = Conn_Filt(G); %apply connectivity filter again to ensure single
 % body for use in FEA.
%-------------------------------------------------------------------------
%display for pubilcation:
%config

figure
%E_ = volshow(E,config);
E_ = volshow(E);

figure
%E_open_ = volshow(E_open,config);
E_open_ = volshow(E_open);

figure
%E_open_conn_ = volshow(E_open_conn,config);
E_open_conn_ = volshow(E_open_conn);

figure
%G_ = volshow(G,config);
G_ = volshow(G);

figure
Trab_ = volshow(Trab); 
%Trab_ = volshow(Trab,config);