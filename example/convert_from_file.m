% =========================================================================
% Script: convert_from_file.m
% Description: Loads WGS84 geodetic coordinates from a file,
%              converts them to ED50, and saves the result to a new file.
% =========================================================================

% Add source folder to the path (assumes this script is run from /examples)
addpath('../src');

% Load input data from file
inputFilePath = '../data/data.txt';  % Path to input file
disp(['Loading data from: ', inputFilePath]);
data = load(inputFilePath);

% Extract WGS84 coordinates
longitude_WGS84 = data(:,1);   % Longitude in degrees
latitude_WGS84  = data(:,2);   % Latitude in degrees
height_WGS84    = data(:,3);   % Height in meters

% Run the coordinate conversion
[longitude_ED50, latitude_ED50, height_ED50] = convertir_WGS84aED50( ...
    longitude_WGS84, latitude_WGS84, height_WGS84);

% Prepare output file
outputFilePath = '../data/dataOutput.txt';
fileID = fopen(outputFilePath, 'wt');

% Save the converted coordinates
for i = 1:length(longitude_ED50)
    fprintf(fileID, '%.10f, %.10f, %.10f\n', ...
        longitude_ED50(i), latitude_ED50(i), height_ED50(i));
end

fclose(fileID);
disp(['Conversion complete! Output saved to: ', outputFilePath]);