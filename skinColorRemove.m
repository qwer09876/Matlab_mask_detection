function [hsv_color,segment_img,res_img] = skinColorRemove(image)
%RGB转HSV找出肤色特征置0，其他特征可能是口罩，设置为1或者显示乘法运算
    I=double(image);
    %I2=I;
    I2=rgb2hsv(I); % RGB转HSV
    hsv_color=I2;
    R=I(:,:,1);%三通道分离，根据RGB->hsv对应运算法则运算
    G=I(:,:,2);
    B=I(:,:,3);
    y=16+0.258*R+0.505*G+0.090*B;
    cb=128-0.148*R+0.291*G+0.439*B;
    cr=128+0.439*R-0.368*G-0.071*B;
    [w, h]=size(I(:,:,1));
    hue=I2(:,:,1);
    saturation=I2(:,:,2);
    value=I2(:,:,3);
    for i=1:w
      for j=1:h
        if 115<=cr(i,j) && cr(i,j)<=175 && 110<=cb(i,j) && cb(i,j)<=175 && hue(i,j)<=0.1 && 0.01<=hue(i,j) && 0<=y(i,j) && y(i,j)<=255
            segment(i,j)=0;%不需要皮肤区域，置0
         else
            segment(i,j)=1;
         end
      end
    end
    im(:,:,1)=I(:,:,1).*segment;
    im(:,:,2)=I(:,:,2).*segment;
    im(:,:,3)=I(:,:,3).*segment;
    figure;subplot(121);imshow(segment);title("000000");

    %用3*3模板对二值图像进行膨胀操作
    se = strel('diamond', 2);
    segment = imdilate(segment, se);
    subplot(122);imshow(segment);title("1111111");
        
    segment_img=segment;
    res_img=I.*segment;%原图像乘以二值图，显示二值图为1的内容

end

