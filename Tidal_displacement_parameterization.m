%% Generate the tidal displacement (Pang & Nikurashin., 2026)

% Read topography (m)
addpath ~/bin
file = './STRM30PLUS.nc';
lon = ncread(file,'x');
lat = ncread(file,'y');
topo = ncread(file,'z');

% Read TPXO tidal velocity (m/s)
filename = './u_tpxo9.v4a.nc';
lon_u  = ncread(filename,'lon_u');
lon_v  = ncread(filename,'lon_v');
lat_u  = ncread(filename,'lat_u');
lat_v  = ncread(filename,'lat_v');

ua1  =  ncread(filename,'ua'); 
va1  =  ncread(filename,'va');

% Define the calculation domain, here is the Indonesian Seas
ii = find(lon_u(1,:)>100 & lon_u(1,:)<=150); 
jj = find(lat_u(:,1)>-20 & lat_u(:,1)<=+15);

lon_u = lon_u(jj,ii);
lat_u = lat_u(jj,ii);
lon_v = lon_v(jj,ii);
lat_v = lat_v(jj,ii);

ua1 = ua1(jj,ii,:);
va1 = va1(jj,ii,:);

ua1(ua1==0) = NaN;
va1(va1==0) = NaN;

% Interpolate the TPXO tidal velocity
D = topo;D(D>0)=0;
hw = D; hw(D>0)=1; 

[nx,ny] = size(D);
ua = zeros(nx,ny,1);
va = zeros(nx,ny,1);

for n = 1:8
ua(:,:,n) = interp2(lat_u(:,1),lon_u(1,:),ua1(:,:,n)',lat,lon');
va(:,:,n) = interp2(lat_v(:,1),lon_v(1,:),va1(:,:,n)',lat,lon');
up(:,:,n) = interp2(lat_u(:,1),lon_u(1,:),up1(:,:,n)',lat,lon');
vp(:,:,n) = interp2(lat_v(:,1),lon_v(1,:),vp1(:,:,n)',lat,lon');
end

[yc,xc] = meshgrid(lat',lon);

ws = [0.1 0.1 10];

for n = 1:8
disp(n)
ua(:,:,n) = my_interpolation(lon_u',lat_u',0*lon_u',ua1(:,:,n)',xc,yc,0*xc,ua(:,:,n),hw,ws);
va(:,:,n) = my_interpolation(lon_v',lat_v',0*lon_v',va1(:,:,n)',xc,yc,0*xc,va(:,:,n),hw,ws);
up(:,:,n) = my_interpolation(lon_u',lat_u',0*lon_u',up1(:,:,n)',xc,yc,0*xc,up(:,:,n),hw,ws);
vp(:,:,n) = my_interpolation(lon_v',lat_v',0*lon_v',vp1(:,:,n)',xc,yc,0*xc,vp(:,:,n),hw,ws);
end

ua(D>-50) = 0; 
va(D>-50) = 0;

% Define the Delt x and Delt y
lat_rad = deg2rad(yc);
lon_rad = deg2rad(xc);

R = 6371000;

dlat = diff(lat_rad,1,2);
dlon = diff(lon_rad,1,1);

dx = R * cos(lat_rad(1:end-1,:)) .* dlon;
dy = R * dlat;

% Calculate the bathymetry gradient
hx = diff(D,1,1) ./ dx;
hy = diff(D,1,2) ./ dy;
hx = cat(1,hx,hx(1,:));
hy = cat(2,hy,hy(:,1));

w_bot = ua.^2.*hx.^2 + va.^2.*hy.^2;

% Here we focus on eight high-frequency tidal constituents (M2 S2 N2 K2 K1 O1 P1 Q1)
tidalPeriod  = [44714.16, 43200., 45569.88, 43081.92, 86164.2, 92949.48, 86637.24, 96726.24];

% Define the vertical layers of displacement. Here we use 100 vertical layers.
nz = 100; DD = repmat(D,1,1,nz); 
rc =  repmat(reshape(layer_depth, [1 1 nz]), [nx ny 1]); 
% "layer_depth" is the depth of each layer
dummy = abs(rc)./abs(DD);
dummy(dummy>1) = 0; 

for n = 1:8
disp(n)
w_bot = ua(:,:,n).^2.*hx.^2 + va(:,:,n).^2.*hy.^2;
w_bot = repmat(w_bot,1,1,nz);
w = w_bot.*dummy.^2;
displ = displ + w * (tidalPeriod(n)/2/pi).^2;
end

displ_RMS = sqrt(displ*0.5);

