function [out_filter] = RGB_filter(image,choice)
% choice 0：中值滤波    1：邻域平均滤波
% 对三通道分离后分别滤波，可选择中值或者邻域平均滤波
% R通道
    R = image(:,:,1);
    %%G通道
    G = image(:,:,2);
    %%B通道
    B = image(:,:,3);

    if choice
        R=medfilt2(R,[3,3]);
        G=medfilt2(G,[3,3]);
        B=medfilt2(B,[3,3]);
        filt1=cat(3,R,G,B);  % 对彩色图像R,G，B三个通道分别进行3×3模板的中值滤波 cat函数用于连接两个矩阵或数组
        out_filter=filt1;    
    else
        R=filter2(fspecial('average',3),R)/255;
        G=filter2(fspecial('average',3),G)/255;
        B=filter2(fspecial('average',3),B)/255;
        filt2= cat(3,R,G,B);  %对彩色图像R,G，B三个通道分别进行3×3模板的均值滤波 并合并
        out_filter=filt2;
    end
end

