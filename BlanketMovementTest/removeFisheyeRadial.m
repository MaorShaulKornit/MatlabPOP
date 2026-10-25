function Iout = removeFisheyeRadial(Iin, k, zoom)
    % Iin: uint8/uint16/double image (RGB or grayscale)
    % k:   radial coefficient (positive to undo fisheye/barrel)
    % zoom: scale factor to crop away empty borders after correction

    I = im2double(Iin);
    [h, w, c] = size(I);
    % Use the larger half-dimension to normalize to [-1,1] with AR preserved
    R = max(h, w) / 2;
%     R = 2/min(w-1,h-1);
    
    cx = (w+1)/2;  % center x
    cy = (h+1)/2;  % center y

    % Create output grid
    [X, Y] = meshgrid(1:w, 1:h);

    % Normalize to [-1,1]
    xn = (X - cx) / R;
    yn = (Y - cy) / R;

    r2 = xn.^2 + yn.^2;

    % Radial model: x_src = x * (1 + k*r^2), y_src = y * (1 + k*r^2)
    % Positive k applies pincushion warp to counter barrel/fisheye.
    scale = (1 + k * r2);

    % Apply inverse mapping (backward warping): for each OUTPUT pixel,
    % sample from INPUT at these source coordinates.
    xs = xn .* scale / zoom;
    ys = yn .* scale / zoom;

    % Back to pixel coordinates
    Xs = xs * R + cx;
    Ys = ys * R + cy;

    % Sample with bilinear interpolation
    Iout = zeros(h, w, c);
    for ch = 1:c
        V = I(:,:,ch);
        % interp2 assumes 1..w (X) and 1..h (Y) default grid
        Ic = interp2(V, Xs, Ys, 'linear', 0); % fill out-of-bounds with 0 (black)
        Iout(:,:,ch) = Ic;
    end

    % Convert back to original class
    Iout = im2uint8(Iout);
end
