function [] = image_process(img,str)
   %调用人脸检测
    [img_orig,img_res,flag,num]=face_detection_func(img);
    if flag %人脸识别，检测图片中的人头，调用内置库，flag标记如果为0表示没有人
       for i = 1:num  
        fig=figure;

        [w,~]=size(img_res);

        if w<100
            img_res=imresize(img_res,4);
        end  
        subplot(121);imshow(img_orig);title('原图像');
        subplot(122);imshow(img_res);title(sprintf('结果图像flag=%d',flag));
        s=sprintf("./result/%s_face.jpg",str)
        imwrite((img_res),s);

        % choice 0：中值滤波    1：邻域平均滤波
        img_rf=RGB_filter(img_res,0);%三通道分离滤波后cat合并,第二个参数滤波方式
        figure;subplot(121);imshow(img_rf);title('RGB分别滤波后合并图片');
        % 形态学滤波
        im = imnoise(img_rf,'gaussian',0,1e-3); % RGB滤波图像 + 白噪声
        % 形态学滤波
        sca = 5;                           % 结构元素尺寸
        im_e = morphology_filter(im,sca);  % 形态学滤波
        subplot(122);imshow(im_e);title('形态学滤波图片');
        
        %肤色标定
        im_adj=imadjust(im_e,[0.3,0.8],[0,1]);%核心点，增加对比度
        [hsv_color,gray2,color_img]=skinColorRemove(im_adj);
        figure;
        subplot(221);imshow(hsv_color);title('肤色分离hsv图片');
        subplot(222);imshow(gray2);title('肤色分离二值图片');
        imwrite((gray2),sprintf("./result/%s_face_2value.jpg",str));
        subplot(223);imshow(color_img);title('肤色分离彩色图片');%得到大致肤色分离图片
        %口罩定位（口罩在头的下半部分）
        [rr,cc]=size(gray2);%遍历图片矩阵
        count=0;
        flag=1;
        threshold=((rr*cc)/2)*3/4;%如果击中的面积和>=3/4
        for c=1:cc
            for r=1:rr
                if r>=rr/3+30 %如果是下半部分
                    if(gray2(r,c)&&flag)%如果是白色边界，标记边界坐标
                        x=c;
                        y=r;
                        flag=0;
                    end
                    %累积击中白色数量即非人脸区域数量
                    count=count+gray2(r,c);
                end
            end
        end
        fig=figure;imshow(img_res);
        if count>=threshold%如果非人脸区域大于75%
           title("have mask");
           %标框rectangle('Position',[0 0 2 4],'Curvature',0.2)
           rectangle('Position',[x+15 y rr-30 cc/2], 'EdgeColor', 'g');
            imwrite(frame2im(getframe(fig)),sprintf("./result/%s_result.jpg",str));
        else
            title("No mask!!!");
            %标框rectangle('Position',[0 0 2 4],'Curvature',0.2)
            rectangle('Position',[x+10 y+5 rr-20 cc/2-10], 'EdgeColor', 'r');
            imwrite(frame2im(getframe(fig)),sprintf("./result/%s_result.jpg",str));
        end
       end
    else
        subplot(121);imshow(img_orig);title('原图像');
        subplot(122);imshow(img_res);title(sprintf('！！！未检测到人像，原图像flag=%d',flag));
    end    

end

