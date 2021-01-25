function dB = PSNR(A,B)
% PURPOSE: To find the PSNR (peak signal-to-noise ratio) between two
%          intensity images A and B, each having values in the interval
%          [0,1]. The answer is in decibels (dB).

if A == B
   error('Images are identical: PSNR has infinite value')
end
error_diff = A - B;
decibels = 20*log10(1/(sqrt(mean(mean(error_diff.^2)))));
dB = sum(decibels)/3;
%disp(decibels)
%fprintf('PSNR = +%5.2f dB\n',decibels)
