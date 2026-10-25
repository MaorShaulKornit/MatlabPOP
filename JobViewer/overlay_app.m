function overlay_app
% Simple internal MATLAB UI for overlaying two same-size images,
% where the second image may contain an alpha channel.

    mxdif = 8;

    %---------------------- UI ----------------------%
    fig = uifigure( ...
        'Name', 'Image Overlay Tool', ...
        'Position', [100 100 1000 650]);

    gl = uigridlayout(fig, [4 3]);
    gl.RowHeight = {40, 40, '1x', 40};
    gl.ColumnWidth = {220, 220, '1x'};

    btnLoadBase = uibutton(gl, ...
        'Text', 'Load Base Image', ...
        'ButtonPushedFcn', @onLoadBase);

    btnLoadOverlay = uibutton(gl, ...
        'Text', 'Load Overlay Image', ...
        'ButtonPushedFcn', @onLoadOverlay);

    btnProcess = uibutton(gl, ...
        'Text', 'Preview Overlay', ...
        'Enable', 'off', ...
        'ButtonPushedFcn', @onProcess);

    lblBase = uilabel(gl, 'Text', 'Base: not loaded');
    lblOverlay = uilabel(gl, 'Text', 'Overlay: not loaded');
    lblStatus = uilabel(gl, 'Text', 'Status: waiting');

    ax = uiaxes(gl);
    ax.Layout.Row = 3;
    ax.Layout.Column = [1 3];
    title(ax, 'Preview');

    btnSave = uibutton(gl, ...
        'Text', 'Save Result', ...
        'Enable', 'off', ...
        'ButtonPushedFcn', @onSave);

    chkAutoResize = uicheckbox(gl, ...
        'Text', sprintf('Auto resize if size difference < %d px', mxdif), ...
        'Value', true);

    lblInfo = uilabel(gl, ...
        'Text', 'Load base image first, then overlay image');

    %---------------------- State ----------------------%
    app.basePath = '';
    app.overlayPath = '';
    app.baseImg = [];
    app.overlayRGB = [];
    app.overlayAlpha = [];
    app.result = [];
    app.mxdif = mxdif;

    %---------------------- Callbacks ----------------------%
    function onLoadBase(~, ~)
        [f, p] = uigetfile( ...
            {'*.tif;*.tiff;*.png;*.jpg;*.jpeg;*.bmp', 'Image Files'}, ...
            'Select Base Image');

        if isequal(f, 0)
            return;
        end

        fullpath = fullfile(p, f);
        img = imread(fullpath);

        % If base image is grayscale, expand to RGB
        if ndims(img) == 2
            img = repmat(img, [1 1 3]);
        elseif size(img, 3) > 3
            img = img(:, :, 1:3);
        end

        app.basePath = fullpath;
        app.baseImg = img;

        lblBase.Text = ['Base: ' f];
        lblStatus.Text = 'Status: base image loaded';

        imshow(app.baseImg, 'Parent', ax);
        updateProcessState();
    end

    function onLoadOverlay(~, ~)
        [f, p] = uigetfile( ...
            {'*.tif;*.tiff;*.png;*.jpg;*.jpeg;*.bmp', 'Image Files'}, ...
            'Select Overlay Image');

        if isequal(f, 0)
            return;
        end

        fullpath = fullfile(p, f);
        [rgb, alpha] = readImageWithAlpha(fullpath);

        app.overlayPath = fullpath;
        app.overlayRGB = rgb;
        app.overlayAlpha = alpha;

        lblOverlay.Text = ['Overlay: ' f];

        if isempty(alpha)
            lblStatus.Text = 'Status: overlay loaded (no alpha found, using opaque)';
        else
            lblStatus.Text = 'Status: overlay loaded with alpha';
        end

        imshow(app.overlayRGB, 'Parent', ax);
        updateProcessState();
    end

    function onProcess(~, ~)
        try
            base = app.baseImg;
            overlay = app.overlayRGB;
            alpha = app.overlayAlpha;

            if isempty(base) || isempty(overlay)
                uialert(fig, 'Please load both images first.', 'Missing Images');
                return;
            end

            if isempty(alpha)
                alpha = ones(size(overlay,1), size(overlay,2), 'double');
            end

            baseSize = size(base, 1:2);
            overlaySize = size(overlay, 1:2);
            dsz = sum(abs(baseSize - overlaySize));

            if dsz > 0
                if chkAutoResize.Value && dsz < app.mxdif
                    overlay = imresize(overlay, baseSize);
                    alpha = imresize(alpha, baseSize);
                else
                    msg = sprintf(['Images are not the same size.\n' ...
                                   'Base: %d x %d\nOverlay: %d x %d'], ...
                                   baseSize(1), baseSize(2), overlaySize(1), overlaySize(2));
                    uialert(fig, msg, 'Size Mismatch');
                    return;
                end
            end

            result = blendImages(base, overlay, alpha);
            app.result = result;

            imshow(result, 'Parent', ax);
            lblStatus.Text = 'Status: preview generated';
            btnSave.Enable = 'on';

        catch ME
            uialert(fig, ME.message, 'Processing Error');
            lblStatus.Text = 'Status: error';
        end
    end

    function onSave(~, ~)
        if isempty(app.result)
            uialert(fig, 'No result to save yet.', 'Nothing to Save');
            return;
        end

        [f, p] = uiputfile({'*.png'; '*.tif'; '*.jpg'}, 'Save Result As');
        if isequal(f, 0)
            return;
        end

        outPath = fullfile(p, f);
        imwrite(app.result, outPath);
        lblStatus.Text = ['Status: saved to ' f];
    end

    function updateProcessState()
        if ~isempty(app.baseImg) && ~isempty(app.overlayRGB)
            btnProcess.Enable = 'on';
        else
            btnProcess.Enable = 'off';
        end
    end
end

%==========================================================
function [rgb, alpha] = readImageWithAlpha(filename)
% Read image and alpha channel if it exists.

    [img, ~, rawAlpha] = imread(filename);

    alpha = [];

    if ndims(img) == 2
        rgb = repmat(img, [1 1 3]);
    elseif size(img, 3) == 4
        % Some formats may return RGBA directly
        rgb = img(:, :, 1:3);
        alpha = img(:, :, 4);
    else
        rgb = img(:, :, 1:min(3, size(img,3)));
        if size(rgb,3) == 1
            rgb = repmat(rgb, [1 1 3]);
        end
    end

    if ~isempty(rawAlpha)
        alpha = rawAlpha;
    end
end

%==========================================================
function result = blendImages(base, overlay, alpha)
% Alpha blend overlay onto base.

    base = im2double(base);
    overlay = im2double(overlay);
    alpha = im2double(alpha);

    if ndims(alpha) == 2
        alpha = repmat(alpha, [1 1 3]);
    end

    result = overlay .* alpha + base .* (1 - alpha);
end