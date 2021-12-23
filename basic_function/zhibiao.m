function  [PSNR,MPSNR,SSIM,MSSIM,MSAD] = zhibiao(Ori_H,Denoi_HSI)
%% 适用于灰度值为0-1

[M,N,B] = size(Ori_H);
T1 = reshape(Ori_H*255,M*N,B);
T2 = reshape(Denoi_HSI*255,M*N,B);


temp = reshape(sum((T1 -T2).^2),B,1)/(M*N);
PSNR = 20*log10(255)-10*log10(temp);
MPSNR = mean(PSNR);


for i=1:B
    [mssim, ssim_map]=ssim_index(Ori_H(:,:,i)*255, Denoi_HSI(:,:,i)*255);
    SSIM(i,1) = mssim;
end
MSSIM = mean(SSIM);


sumNO = 0.0;
for i = 1:M
    for j = 1:N
       T = Ori_H(i,j,:);
       T = T(:)';
       H = Denoi_HSI(i,j,:);
       H = H(:)';
       sumNO=sumNO+SAM(T,H);
    end
end
MSAD = sumNO / (M * N);
