function [rgbImage,time_m,psnr_val]= a_f(rgbImage)
    
     fontSize = 10;
    % Enlarge figure to full screen.
    set(gcf, 'Position', get(0,'Screensize')); 
    
    % Extract the individual red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    
    time_m = Inf;
    tStart=tic;
    
    % Average Filter the channels:
    redMF = avgfil(redChannel);
    greenMF = avgfil(greenChannel);
    blueMF = avgfil(blueChannel);
    
    tElapsed = toc(tStart);  
    time_m = min(tElapsed, time_m);
   
    %rgbFixed = cat(3, noiseFreeRed, noiseFreeGreen, noiseFreeBlue);
    rgbFixed = cat(3 ,redMF,greenMF,blueMF);
    O_image = double(imread('peppers.png'))/255;
    figure();
    imshow(rgbFixed);
    psnr_val = PSNR(O_image,rgbFixed);
    rgbImage = rgbFixed;
end