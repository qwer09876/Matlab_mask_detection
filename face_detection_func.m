function [outimg1,outimg2,flag,num] = face_detection_func(img)
    %调用人脸检测模型
    FDetect = vision.CascadeObjectDetector;
    %获取图像存储原图像
    I_orig=img;
    %检测人脸
    face_dtect = step(FDetect,I_orig);
    %图片尺寸
    [Height,Width,K]=size(I_orig);
    %检测人数
    Num_face=size(face_dtect,1)

    %规整化尺寸
    normal_size=mod(300,227);
    %存储人脸
    I_mask=zeros(normal_size,normal_size*Num_face,K);

    %画图
    outimg1=(I_orig);

    % Num_face
    for i = 1:Num_face
        %矩形框
        rectangle('Position',face_dtect(i,:),'LineWidth',1,'LineStyle','-','EdgeColor','m');
        %行序号
        row_set=face_dtect(i,2)+1:min(Height,face_dtect(i,2)+face_dtect(i,4));
        %列序号
        cul_set=face_dtect(i,1)+1:min(Width,face_dtect(i,1)+face_dtect(i,3));
        %截取
        im=I_orig(row_set,cul_set,:);
        %尺寸调整
        im2=imresize(im,[normal_size,normal_size]);
        I_mask(:,(i-1)*normal_size+1:i*normal_size,:)=im2;

    end
    %识别图片内容 

    if Num_face>0
        outimg2=uint8(I_mask);
        flag=1;
    else
        outimg2=I_orig;%原图像
        flag=0;
    end
    num=Num_face
    
end

