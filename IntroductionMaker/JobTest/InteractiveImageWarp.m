classdef InteractiveImageWarp < handle
    %INTERACTIVEIMAGEWARP Display a DPI-aware underbase and movable RGBA overlay.

    properties (SetAccess = private)
        Underbase
        Overlay
        UnderbaseDpi = 127
        OverlayDpi = 300
        FigureHandle
        AxesHandle
        OverlayImageHandle
        CornerHandles
        SaveButtonHandle
        OverlayCorners
    end

    properties (Access = private)
        UnderbaseImageHandle
        ActiveCorner = 0
        DraggingOverlay = false
        DragOffset = [0 0]
        LastRenderTime = 0
        PreviewInterval = 0.05
        BaseWidthInches
        BaseHeightInches
        OverlayWidthInches
        OverlayHeightInches
    end

    methods
        function obj = InteractiveImageWarp(underbase, overlay, underbaseDpi, overlayDpi)
            if nargin < 3
                underbaseDpi = 127;
            end
            if nargin < 4
                overlayDpi = 300;
            end

            obj.Underbase = underbase;
            obj.Overlay = obj.ensureRgba(overlay);
            obj.UnderbaseDpi = underbaseDpi;
            obj.OverlayDpi = overlayDpi;

            baseSize = size(underbase);
            overlaySize = size(obj.Overlay);
            obj.BaseHeightInches = baseSize(1) / underbaseDpi;
            obj.BaseWidthInches = baseSize(2) / underbaseDpi;
            obj.OverlayHeightInches = overlaySize(1) / overlayDpi;
            obj.OverlayWidthInches = overlaySize(2) / overlayDpi;

            obj.createFigure();
            obj.setInitialCorners();
            obj.renderOverlay(true);
        end

        function setCorners(obj, corners)
            if ~isequal(size(corners), [4 2])
                error('InteractiveImageWarp:InvalidCorners', ...
                    'Corners must be a 4-by-2 matrix in [x y] inches.');
            end
            obj.OverlayCorners = corners;
            obj.renderOverlay(true);
        end

        function corners = getCorners(obj)
            corners = obj.OverlayCorners;
        end

        function exportImage(obj, fileName)
            if nargin < 2
                error('InteractiveImageWarp:MissingFileName', ...
                    'A TIFF filename is required.');
            end

            [rgb, alpha] = obj.warpOverlay();
            output = cat(3, rgb, alpha);
            imwrite(output, fileName, 'tif', 'Compression', 'none');
        end

        function saveResults(obj, outputFolder)
            if nargin < 2
                outputFolder = pwd;
            end
            if ~isfolder(outputFolder)
                error('InteractiveImageWarp:InvalidOutputFolder', ...
                    'Output folder was not found: %s', outputFolder);
            end

            [underbaseCrop, overlayResult] = obj.createResults();
%             PImage.SaveAsPNG(underbaseCrop,'underbase',obj.UnderbaseDpi,outputFolder);
%             PImage.SaveAsPNG(overlayResult,'overlay',obj.OverlayDpi,outputFolder);
            imwrite(underbaseCrop, fullfile(outputFolder, 'underbase.tif'), ...
                'tif', 'Compression', 'none', 'Resolution', [obj.UnderbaseDpi obj.UnderbaseDpi]);
            imwrite(overlayResult, fullfile(outputFolder, 'overlay.tif'), ...
                'tif', 'Compression', 'none', 'Resolution', [obj.OverlayDpi obj.OverlayDpi]);
        end
    end

    methods (Access = private)
        function createFigure(obj)
            obj.FigureHandle = figure('Name', 'Underbase / Overlay Registration', ...
                'NumberTitle', 'off', 'Color', [0.15 0.15 0.15]);
            obj.AxesHandle = axes('Parent', obj.FigureHandle, ...
                'Units', 'normalized', 'Position', [0.03 0.08 0.94 0.88]);
            hold(obj.AxesHandle, 'on');

            obj.UnderbaseImageHandle = image(obj.AxesHandle, ...
                'CData', obj.Underbase, ...
                'XData', [0 obj.BaseWidthInches], ...
                'YData', [0 obj.BaseHeightInches]);
            set(obj.AxesHandle, 'YDir', 'reverse', 'DataAspectRatio', [1 1 1], ...
                'XLim', [0 obj.BaseWidthInches], 'YLim', [0 obj.BaseHeightInches]);
            xlabel(obj.AxesHandle, 'Width (inches)');
            ylabel(obj.AxesHandle, 'Height (inches)');
            title(obj.AxesHandle, 'Drag corners to warp the transparent overlay');

            obj.SaveButtonHandle = uicontrol(obj.FigureHandle, ...
                'Style', 'pushbutton', 'String', 'Save Results', ...
                'Units', 'normalized', 'Position', [0.03 0.015 0.15 0.045], ...
                'Callback', @(~, ~) obj.onSaveResults());

            obj.OverlayImageHandle = image(obj.AxesHandle, ...
                'XData', [0 obj.BaseWidthInches], ...
                'YData', [0 obj.BaseHeightInches], ...
                'AlphaData', zeros(size(obj.Underbase, 1), size(obj.Underbase, 2)), ...
                'ButtonDownFcn', @(~, ~) obj.onOverlayMouseDown());

            set(obj.FigureHandle, 'WindowButtonMotionFcn', @(~, ~) obj.onMouseMove());
            set(obj.FigureHandle, 'WindowButtonUpFcn', @(~, ~) obj.onMouseUp());
        end

        function setInitialCorners(obj)
            marginX = max(0, (obj.BaseWidthInches - obj.OverlayWidthInches) / 2);
            marginY = max(0, (obj.BaseHeightInches - obj.OverlayHeightInches) / 2);
            obj.OverlayCorners = [marginX marginY; ...
                marginX + obj.OverlayWidthInches marginY; ...
                marginX + obj.OverlayWidthInches marginY + obj.OverlayHeightInches; ...
                marginX marginY + obj.OverlayHeightInches];

            obj.CornerHandles = gobjects(4, 1);
            for k = 1:4
                obj.CornerHandles(k) = plot(obj.AxesHandle, ...
                    obj.OverlayCorners(k, 1), obj.OverlayCorners(k, 2), ...
                    'o', 'MarkerSize', 8, 'LineWidth', 1.5, ...
                    'Color', [0 0.8 1], 'MarkerFaceColor', [0 0.4 0.8], ...
                    'ButtonDownFcn', @(~, ~) obj.onMouseDown(k));
            end
        end

        function onMouseDown(obj, cornerIndex)
            point = get(obj.AxesHandle, 'CurrentPoint');
            obj.ActiveCorner = cornerIndex;
            obj.DraggingOverlay = false;
            obj.DragOffset = obj.OverlayCorners(cornerIndex, :) - point(1, 1:2);
        end

        function onOverlayMouseDown(obj)
            point = get(obj.AxesHandle, 'CurrentPoint');
            obj.ActiveCorner = 0;
            obj.DraggingOverlay = true;
            obj.DragOffset = point(1, 1:2);
        end

        function onMouseMove(obj)
            if (~obj.DraggingOverlay && obj.ActiveCorner == 0) || ~isvalid(obj.FigureHandle)
                return;
            end
            point = get(obj.AxesHandle, 'CurrentPoint');
            currentPoint = point(1, 1:2);
            if obj.DraggingOverlay
                delta = currentPoint - obj.DragOffset;
                obj.OverlayCorners = obj.OverlayCorners + delta;
                obj.DragOffset = currentPoint;
            else
                obj.OverlayCorners(obj.ActiveCorner, :) = currentPoint + obj.DragOffset;
            end
            obj.renderOverlay(false);
        end

        function onMouseUp(obj)
            obj.ActiveCorner = 0;
            obj.DraggingOverlay = false;
            obj.renderOverlay(true);
        end

        function onSaveResults(obj)
            obj.saveResults(pwd);
            msgbox('Saved underbase.tif and overlay.tif.', 'Registration saved');
        end

        function renderOverlay(obj, forceRender)
            if nargin < 2
                forceRender = false;
            end
            currentTime = tic;
            if ~forceRender && obj.LastRenderTime > 0
                elapsedTime = toc(obj.LastRenderTime);
                if elapsedTime < obj.PreviewInterval
                    return;
                end
            end
            obj.LastRenderTime = currentTime;
            [rgb, alpha] = obj.warpOverlay();
            set(obj.OverlayImageHandle, 'CData', rgb, 'AlphaData', alpha);
            for k = 1:4
                set(obj.CornerHandles(k), 'XData', obj.OverlayCorners(k, 1), ...
                    'YData', obj.OverlayCorners(k, 2));
            end
            drawnow limitrate;
        end

        function [rgb, alpha] = warpOverlay(obj)
            baseSize = size(obj.Underbase);
            outputReference = imref2d(baseSize);
            sourceCorners = [1 1; size(obj.Overlay, 2) 1; ...
                size(obj.Overlay, 2) size(obj.Overlay, 1); 1 size(obj.Overlay, 1)];
            targetCorners = [obj.OverlayCorners(:, 1) * obj.UnderbaseDpi + 1, ...
                obj.OverlayCorners(:, 2) * obj.UnderbaseDpi + 1];
            transform = fitgeotrans(sourceCorners, targetCorners, 'projective');

            warpedOverlay = imwarp(obj.Overlay, transform, 'OutputView', outputReference);
            rgb = warpedOverlay(:, :, 1:3);
            alpha = warpedOverlay(:, :, 4);
            if ~isa(warpedOverlay, 'uint8')
                rgb = im2uint8(rgb);
                alpha = im2uint8(alpha);
            end
        end

        function [underbaseCrop, overlayResult] = createResults(obj)
            cornersInBasePixels = obj.OverlayCorners * obj.UnderbaseDpi;
            minX = max(1, floor(min(cornersInBasePixels(:, 1))) + 1);
            maxX = min(size(obj.Underbase, 2), ceil(max(cornersInBasePixels(:, 1))) + 1);
            minY = max(1, floor(min(cornersInBasePixels(:, 2))) + 1);
            maxY = min(size(obj.Underbase, 1), ceil(max(cornersInBasePixels(:, 2))) + 1);
            underbaseCrop = obj.Underbase(minY:maxY, minX:maxX, :);

            overlayCornersIn300Dpi = obj.OverlayCorners * obj.OverlayDpi;
            minOverlayX = floor(min(overlayCornersIn300Dpi(:, 1)));
            minOverlayY = floor(min(overlayCornersIn300Dpi(:, 2)));
            maxOverlayX = ceil(max(overlayCornersIn300Dpi(:, 1)));
            maxOverlayY = ceil(max(overlayCornersIn300Dpi(:, 2)));
            outputWidth = max(1, maxOverlayX - minOverlayX + 1);
            outputHeight = max(1, maxOverlayY - minOverlayY + 1);

            sourceCorners = [1 1; size(obj.Overlay, 2) 1; ...
                size(obj.Overlay, 2) size(obj.Overlay, 1); 1 size(obj.Overlay, 1)];
            targetCorners = overlayCornersIn300Dpi - [minOverlayX minOverlayY] + 1;
            transform = fitgeotrans(sourceCorners, targetCorners, 'projective');
            outputReference = imref2d([outputHeight outputWidth]);
            overlayResult = imwarp(obj.Overlay, transform, 'OutputView', outputReference);
        end

        function rgba = ensureRgba(~, imageData)
            if size(imageData, 3) == 4
                rgba = imageData;
                return;
            end
            if size(imageData, 3) ~= 3
                error('InteractiveImageWarp:InvalidOverlay', ...
                    'The overlay must be an RGB or RGBA image.');
            end
            alpha = ones(size(imageData, 1), size(imageData, 2), 'like', imageData);
            rgba = cat(3, imageData, alpha);
        end
    end
end
