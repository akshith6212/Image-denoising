
function [rgbImage,time_a,psnr_val] = m_f(rgbImage)

    fontSize = 10;
   
    % Enlarge figure to full screen.
    set(gcf, 'Position', get(0,'Screensize')); 
    
    % Extract the individual red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    time_a = Inf;
    tStart=tic;
    % Median Filter the channels:
    redMF = median_fil(redChannel);
    greenMF = median_fil(greenChannel);
    blueMF = median_fil(blueChannel);
    
    tElapsed = toc(tStart);  
    time_a = min(tElapsed, time_a);
    
    % Reconstruct the noise free RGB image
    %rgbFixed = cat(3, noiseFreeRed, noiseFreeGreen, noiseFreeBlue);
    rgbFixed = cat(3 ,redMF,greenMF,blueMF);
    
    O_image = double(imread('peppers.png'))/255;
    figure();
    imshow(rgbFixed);
    psnr_val = PSNR(O_image,rgbFixed);
    rgbImage = rgbFixed;
end