function [SSIM, FSIM, PSNR] = performance_evaluation(P, S)


SSIM = ssim(S,P);
FSIM = FeatureSIM(P,S);
PSNR = psnr(S,P);


end