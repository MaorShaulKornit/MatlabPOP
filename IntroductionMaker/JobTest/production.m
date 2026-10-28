%% Production overlay registration
% Edit inputFolder when the production TIFF files are stored elsewhere.

clear;
close all;

inputFolder = pwd;
underbaseFileName = 'Underbase_20260603_162239.tif';
overlayFileName = 'PCBCJ5231F-04.tif';

underbasePath = fullfile(inputFolder, underbaseFileName);
overlayPath = fullfile(inputFolder, overlayFileName);

if ~isfile(underbasePath)
    error('production:MissingUnderbase', 'Underbase file was not found: %s', underbasePath);
end
if ~isfile(overlayPath)
    error('production:MissingOverlay', 'Overlay file was not found: %s', overlayPath);
end

underbase = imread(underbasePath);
overlay = imread(overlayPath);

overlay = rot90(overlay,2);
registration = InteractiveImageWarp(underbase, overlay, 127, 300);

% After positioning, the current four-corner result is available with:
% cornersInches = registration.getCorners();
% registration.exportImage('registered_overlay_rgba.tif');
