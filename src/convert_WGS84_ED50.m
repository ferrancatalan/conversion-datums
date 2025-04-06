[19:22, 6/4/2025] ChatGPT: function [longitude_ED50, latitude_ED50, height_ED50] = convertir_WGS84aED50(longitude_WGS84, latitude_WGS84, height_WGS84)
% CONVERTIR_WGS84aED50
% Converts geodetic coordinates from WGS84 datum to ED50 using translation parameters.
%
% INPUTS:
% longitude_WGS84 : Longitude in degrees (WGS84)
% latitude_WGS84  : Latitude in degrees (WGS84)
% height_WGS84    : Height in meters (WGS84)
%
% OUTPUTS:
% longitude_ED50  : Longitude in degrees (ED50)
% latitude_ED50   : Latitude in degrees (ED50)
% height_ED50     : Height in meters (ED50)

% --- Ellipsoid parameters ---
% WGS84
aWGS84 = 6378137.0;
e2WGS84 = 0.00669437999014;

% ED50
aED50 = 6378388.0;
e2ED50 = 0.00672267002233;

% --- Convert degrees to radians ---
lat_rad = deg2rad(latitude_WGS84);
lon_rad = deg2rad(longitude_WGS84);

% --- Step 1: Geodetic to Cartesian (WGS84) ---
N = aWGS84 ./ sqrt(1 - e2WGS84 * sin(lat_rad).^2);

x = (N + height_WGS84) .* cos(lat_rad) .* cos(lon_rad);
y = (N + height_WGS84) .* cos(lat_rad) .* sin(lon_rad);
z = (N * (1 - e2WGS84) + height_WGS84) .* sin(lat_rad);

% --- Step 2: Apply datum shift (translation only) ---
dx = -84.0;
dy = -107.0;
dz = -120.0;

x = x + dx;
y = y + dy;
z = z + dz;

% --- Step 3: Cartesian to Geodetic (ED50) ---
% ED50 ellipsoid calculations
bED50 = aED50 * sqrt(1 - e2ED50);
ep2 = (aED50^2 - bED50^2) / bED50^2;

% Intermediate values
p = sqrt(x.^2 + y.^2);
theta = atan2(z * aED50, p * bED50);

lat_rad_ED50 = atan2(z + ep2 * bED50 * sin(theta).^3, ...
                     p - e2ED50 * aED50 * cos(theta).^3);
lon_rad_ED50 = atan2(y, x);

N_ED50 = aED50 ./ sqrt(1 - e2ED50 * sin(lat_rad_ED50).^2);
h_ED50 = p ./ cos(lat_rad_ED50) - N_ED50;

% --- Convert radians back to degrees ---
latitude_ED50 = rad2deg(lat_rad_ED50);
longitude_ED50 = rad2deg(lon_rad_ED50);
height_ED50 = h_ED50;

end