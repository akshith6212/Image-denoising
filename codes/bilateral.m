function [img,time_bil,psnr_val] = bilateral(img1,w,sigma_d,sigma_r)
    input_imag = double(imread('peppers.png'))/255;
    time_bil = Inf;
    tStart=tic;
    img1 = applycform(img1,makecform('srgb2lab'));
    [X,Y] = meshgrid(-w:w,-w:w);
    % spatial or domain filter
    G = exp(-((X.^2+Y.^2)/(2*sigma_d^2)));
    dim = size(img1);
    img = zeros(dim);
    for i = 1:dim(1)
       for j = 1:dim(2)
          
             % for local region.
             iMin = max(i-w,1);
             iMax = min(i+w,dim(1));
             jMin = max(j-w,1);
             jMax = min(j+w,dim(2));
             I = img1(iMin:iMax,jMin:jMax,:);%neighbourhoood
         
             u = I(:,:,1)-img1(i,j,1);
             v = I(:,:,2)-img1(i,j,2);
             z = I(:,:,3)-img1(i,j,3);
             % range or photometric filter
             H = exp(-(u.^2+v.^2+z.^2)/(2*sigma_r^2));
             
             % For filter response.
             F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
             s = sum(F(:));
             img(i,j,1) = sum(sum(F.*I(:,:,1)))/s;
             img(i,j,2) = sum(sum(F.*I(:,:,2)))/s;
             img(i,j,3) = sum(sum(F.*I(:,:,3)))/s;
                    
       end 
    end
       img = applycform(img,makecform('lab2srgb'));
       figure();
       imshow(img);
       psnr_val = PSNR(input_imag,img);
       tElapsed = toc(tStart);  
       time_bil = min(tElapsed, time_bil);
end