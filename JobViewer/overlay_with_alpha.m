function overlay_with_alpha(img1, img2)
% img1 - base image (HxWx3)
% img2 - overlay image (HxWx4) where 4th channel is alpha

    % Convert to double for proper blending
    img1 = im2double(img1);
    img2 = im2double(img2);

    % Split overlay into RGB and alpha
    rgb2 = img2(:,:,1:3);
    alpha = img2(:,:,4);

    % If alpha is single channel, replicate to 3 channels
    alpha = repmat(alpha, [1 1 3]);
    

    % Alpha blending
    result = rgb2 .* alpha.*0.5 + img1 .* (1 - alpha) + img1 .* alpha .*0.5;

    % Display result
    imshow(result);
    PImage.SaveAsPNG(result,'R',127)
end