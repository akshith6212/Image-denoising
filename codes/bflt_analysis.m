close all;
clear all;
% input image
img1 = double(imread('peppers.png'))/255;
figure()
imshow(img1);
title("Original Image");

img1 = imnoise(img1,"gaussian",0.1);
figure()
imshow(img1);
title("Original Image after adding Gaussian noise");
% Set bilateral filter parameters.
w = 3;    % bilateral filter half-width

% Apply bilateral filter to each image.

sigma_r = [1 10 100 1000]; %spatial
sigma_d = [1 5 10]; w       %range
t = 0;

[I_r1,t,psnr_val1] = bilateral(img1,w,sigma_d(1),sigma_r(1));
[I_r2,t,psnr_val2] = bilateral(img1,w,sigma_d(1),sigma_r(2));
[I_r3,t,psnr_val3] = bilateral(img1,w,sigma_d(1),sigma_r(3));
[I_r4,t,psnr_val4] = bilateral(img1,w,sigma_d(1),sigma_r(4));

[I_r5,t,psnr_val5] = bilateral(img1,w,sigma_d(2),sigma_r(1));
[I_r6,t,psnr_val6] = bilateral(img1,w,sigma_d(2),sigma_r(2));
[I_r7,t,psnr_val7] = bilateral(img1,w,sigma_d(2),sigma_r(3));
[I_r8,t,psnr_val8] = bilateral(img1,w,sigma_d(2),sigma_r(4));

[I_r9,t,psnr_val9] = bilateral(img1,w,sigma_d(3),sigma_r(1));
[I_r10,t,psnr_val10]= bilateral(img1,w,sigma_d(3),sigma_r(2));
[I_r11,t,psnr_val11]= bilateral(img1,w,sigma_d(3),sigma_r(3));
[I_r12,t,psnr_val12] = bilateral(img1,w,sigma_d(3),sigma_r(4));

I_bil = [I_r1; I_r2; I_r3; I_r4; I_r5; I_r6; I_r7; I_r8; I_r9; I_r10; I_r11; I_r12];

figure()
montage({I_r1,I_r2,I_r3,I_r4},"BackgroundColor",'w',"BorderSize",10);

figure()
montage({I_r5,I_r6,I_r7,I_r8},"BackgroundColor",'w',"BorderSize",10);

figure()
montage({I_r9,I_r10,I_r11,I_r12},"BackgroundColor",'w',"BorderSize",10);


val1 = [psnr_val1 psnr_val2 psnr_val3 psnr_val4];

val2 = [psnr_val5 psnr_val6 psnr_val7 psnr_val8];

val3 = [psnr_val9 psnr_val10 psnr_val11 psnr_val12];

figure()
P = [val1;val2;val3];
bar(P);
title("PSNR of Filters for various Noise");
ylabel("PSNR(dB)");
ylim([0,30]);
legend("\sigma_r =1 ","\sigma_r =10 ","\sigma_r =100 ","\sigma_r=1000 ");
xticklabels(["\sigma_d = 1","\sigma_d =5 ","\sigma_d =10 "]);

bf_iter = img1;
p_iter = zeros(1,4);
for i = 1:25
    bf_iter = bilateral(bf_iter,w,2,15);
    if(i==1)
        figure()
        imshow(bf_iter);
        title("Filtered image for \sigma_d=2, \sigma_r=15, iterations=1");
        p_iter(1) = PSNR(img1,bf_iter); 
        disp(psnr(img1,bf_iter));
    end
    if(i==10)
        figure()
        imshow(bf_iter);
        title("Filtered image for \sigma_d=2, \sigma_r=15, iterations=10");
        p_iter(2) = PSNR(img1,bf_iter); 
        disp(PSNR(img1,bf_iter));
    end
    if(i==20)
        figure()
        imshow(bf_iter);
        title("Filtered image for \sigma_d=2, \sigma_r=15, iterations=20");
        p_iter(3) = PSNR(img1,bf_iter); 
        disp(PSNR(img1,bf_iter));
    end
    if(i==25)
        figure()
        imshow(bf_iter);
        title("Filtered image for \sigma_d=2, \sigma_r=15, iterations=25");
        p_iter(4) = PSNR(img1,bf_iter); 
        disp(PSNR(img1,bf_iter));
    end
end

figure()
t = [1 10 20 25];
plot(t,p_iter);
hold on;
scatter(t,p_iter);
title("PSNR values Vs No. of iterations");
ylabel("PSNR value(dB)");
xlabel("No. of Iterations");

val1 = val1';
val2 = val2';
val3 = val3';
disp(table(val1,val2,val3));
