close all;
clear all;

% Original Image
I = double(imread('peppers.png'))/255; 
figure()
imshow(I);
title("Original Image");

% Original Image with gaussian noise 
I1 = imnoise(I,'gaussian', 0.1);
figure()
imshow(I1);
title("Original Image with gaussian noise ");
% Original Image with salt & pepper noise
I2 = imnoise(I,'salt & pepper', 0.1);
figure()
imshow(I2);
title("Original Image with salt & pepper noise");

% Original Image with Mixed noise
I3 = imnoise(I1,'salt & pepper', 0.1);
figure()
imshow(I3);
title("Original Image with Mixed noise");

% Median fliter
time_mid = zeros(1,3);
psnr_mid = zeros(1,3);
[I4,time_mid(1),psnr_mid(1)] = m_f(I1);
title("Restored Image for Gaussian Noise(median)")

[I5,time_mid(2),psnr_mid(2)] = m_f(I2);
title("Restored Image for Salt & Pepper Noise(median)")

[I6,time_mid(3),psnr_mid(3)] = m_f(I3);
title("Restored Image for Mixed Noise(median)");
fprintf('Time taken for median filtering: %f',sum(time_mid));

% avgerage fliter
time_avg = zeros(1,3);
psnr_avg = zeros(1,3);
[I7,time_avg(1),psnr_avg(1)] = a_f(I1);
title("Restored Image for Gaussian Noise(Avg)")

[I8,time_avg(2),psnr_avg(2)] = a_f(I2);
title("Restored Image for Salt & Pepper Noise(Avg)")

[I9,time_avg(3),psnr_avg(3)] = a_f(I3);
title("Restored Image for Mixed Noise(Avg)")
fprintf('Time taken for average filtering: %f',sum(time_avg));


% bilateral fliter
w     = 3;      % bilateral filter half-width
sigma = [2 100]; % bilateral filter standard deviation

time_bf = zeros(1,3);
psnr_bf = zeros(1,3);
[I10,time_bf(1),psnr_bf(1)] = bilateral(I1,w,sigma(1),sigma(2));
title("Restored Image for Gaussian Noise(bilateral)")

[I11,time_bf(2),psnr_bf(2)] = bilateral(I2,w,sigma(1),sigma(2));
title("Restored Image for Salt & Pepper Noise(bilateral)")

[I12,time_bf(3),psnr_bf(3)] = bilateral(I3,w,sigma(1),sigma(2));
title("Restored Image for Mixed Noise(bilateral)")
fprintf('Time taken for bilateral filtering: %f',sum(time_bf));

% Time complexity analysis
% Total time
figure()
T = [sum(time_mid); sum(time_avg); sum(time_bf)];
bar(T);
title("Total Time compexity for computing all noises");
xticklabels(["median","average","bilateral"]);
ylabel("Time(sec)");

% Comparision of time various filters 
figure()
T = [[time_mid(1),time_avg(1), time_bf(1)];[time_mid(2),time_avg(2), time_bf(2)];[time_mid(3),time_avg(3), time_bf(3)]];
bar(T);
title("Time compexity of Filters for various Noise");
ylabel("Time(sec)");
legend("med","avg","bil");
xticklabels(["Gaussian","Salt nd Pepper","Mixed"]);

p_g = PSNR(I,I1);
p_s = PSNR(I,I2);
p_m = PSNR(I,I3);
figure()
P = [[psnr_mid(1),psnr_avg(1), psnr_bf(1)];[psnr_mid(2),psnr_avg(2), psnr_bf(2)];[psnr_mid(3),psnr_avg(3), psnr_bf(3)]];
bar(P);
title("PSNR of Filters for various Noise");
ylabel("PSNR(dB)");
legend("med","avg","bil");
xticklabels(["Gaussian","Salt nd Pepper","Mixed"]);

p1 = psnr_mid';
p2 = psnr_avg';
p3 = psnr_bf';
p0 = [p_g p_s p_m]';
disp(table(p0,p1,p2,p3));


