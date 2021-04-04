# Image-denoising
<p>Image denoising using Bilateral filtering and cartooning the image.<p>

Image denoising is one of the fundamental challenges in the field of image processing and computer vision, where the underlying goal is to estimate the original image by suppressing noise from a noise-contaminated version of the image.The image noise may be caused by different intrinsic(i.e.,sensor) and extrinsic(i.e.,environment) conditions which are often not possible to avoid in practical situations.Therefore, image denoising plays an important role in a wide range of applications such as image restoration, visual tracking, image registration, image segmentation, and image classification, where obtaining the original image content is crucial for strong performance.

### Bilateral Filter
A bilateral filter is a non-linear, edge preserving and noise reduction smoothing filter for images. It replaces the intensity of each pixel with a weighted average of intensity values from nearby pixels. This weight can be based on a Gaussian distribution. Crucially, the weights depend not only on Euclidean distance of pixels, but also on the radiometric differences (e.g., range differences, such as colon intensity, depth distance, etc.). This preserves sharp edges. 
The bilateral filtering is a combination of domain and range filtering. The domain filter averages the nearby pixel values and acts thereby as a low pass filter. The range filter plays an important part in edge preserving and allows averaging of similar pixel values only, regardless of their position in the filter window. The pixel is skipped, if the value of a pixel in the filter window diverges from the value of the pixel being filtered by a certain amount.

![alt text](https://github.com/akshith6212/Image-denoising/blob/main/equations.jpg)

The above equations are used to change the pixel weights and develop the final filtered edge preserved smoothing image and this technique is known as bilateral filtering.

### Peak-Signal-To-Noise-Ratio(PSNR)
This is the ratio used to measure the quality measurement between the original and a denoised image.The higher the PSNR value,the better the quality of the denoised or reconstructed image. It is measured in decibles(dB). And the equation when the image is scaled is given as:

![alt text](https://github.com/akshith6212/Image-denoising/blob/main/psnr.jpg)

where MSE is defined as the mean square error of the given image.

##### Note
> For Image denoising using Bilateral Filterring and Image cartooning run [bflt_analysis.m](https://github.com/akshith6212/Image-denoising/blob/main/codes/bilateral.m).<br>
//> For Comparision of performance metrics with other filters run [gim.m](https://github.com/sairamkiran9/Image-denoising/blob/main/codes/gim.m)
