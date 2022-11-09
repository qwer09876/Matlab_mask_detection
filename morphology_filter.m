function Iobrcbr = morphology_filter(im,sca)
% 形态学滤波器
%函数输入: 
%         im:   输入的二维图像矩阵
%         sca : 结构元素尺寸代销
%函数输出: 
%         Iobrcbr: 形态学滤波图像
% 形态学滤波
se=strel('diamond',(sca-1)/2); % 形态学结构元素

Io=imopen(im,se);              % 开操作，内部细小连接去除
Ioc=imclose(Io,se);            % 闭操作，内部小凹陷去除
Iobr=imreconstruct(Io,Ioc);    % 结构重建

Iobrd = imdilate(Iobr,se);   % 膨胀

Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr)); % 结构重建
Iobrcbr = imcomplement(Iobrcbr);   