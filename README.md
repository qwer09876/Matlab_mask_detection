

# Matlab口罩检测

#### 介绍
使用Matlab 采用人脸定位，肤色检测相结合的方法进行判别有无戴口罩的目的。
#####  Matlab_mask_detection
没有使用GUI，按照思路弄出来的，口罩定位的方法以及人脸识别后的处理有待改进
传统检测口罩的方法，基本使用基于颜色的方法，即口罩基本有浅蓝色，黑色和白色为主的几种，
通过RGB三原色转换为HSV等容易聚集颜色的色彩空间，得到对应颜色的像素点的方法来定位口罩。
但是该种方法容易受到外部环境的干扰，如人们自身穿戴的衣服，周边环境颜色等。
因为本文不以考虑该种算法。而是采用人脸定位，肤色检测相结合的方法进行口罩的识别。
首先可以利用人脸定位器将目标人脸区域与复杂背景进行初步分离(目前使用的是matlab自带的人脸识别函数，效果并不是很好)，
然后在该人脸区域内，利用肤色定位原理对人脸的区域进行遍历像素， 这样就可以准确地定位出属于肤色位置像素值和位置，
并将其置黑色。如果该人穿戴了口罩，那么口罩部分不属于人脸肤色，自然不会被检测为人脸肤色像素，
因此该块口罩区域块呈现白色，最后通过形态学知识滤除掉白色面积块小于一定值的区域，
留下面积一定的白色面积块，该面积块即为口罩区域。

#### 流程思路

![image](https://user-images.githubusercontent.com/59789921/200734005-d427288e-3690-4b5a-81fe-2c80daf88bb7.png)

#### 安装教程

1.  需要安装matlab,最好是较高版本
2.  matlab App 摄像头 可参考[https://blog.csdn.net/weixin_44505194/article/details/111172488]![IL}20{4~FLW$KM~HF_9Z3)X](https://user-images.githubusercontent.com/59789921/200735375-6dbdccb0-09d8-44b4-8f94-d0b3b6152184.png)


#### 使用说明

1.  ./face_detect_main.m直接运行即可
2.  运行主文件之后，选择图片可以对图片口罩判别，取消选择可以调用摄像头对人脸进行判别
3.  后面的.m文件都是函数功能，可根据文件名理解大致功能，在流程思路中也有提出

####  函数解析（没有封装，纯源码）
face_detect_main.m为主函数，处理输入选择图片还是视频后，调用image_process
image_process为调用其他函数的综合
face_detecion_func.m为调用matlab内置人脸识别模块分割人脸
RGB_filter为RGB通道分离后滤波再合并
morphology_filter为形态学滤波，开运算，闭运算后膨胀
skinColorRemove为肤色去除，用RGB转HSV形式设定阈值分离出皮肤，将皮肤置零，其他可能是口罩的部分保留
#### 结果显示

![YU{UH R6C}`%_9IFG ZN(9Y](https://user-images.githubusercontent.com/59789921/200734957-00cf34c4-a741-4dfb-a888-7f9390faca41.png)
![N 6UR1CI)FXA2L4BA4_CO2S](https://user-images.githubusercontent.com/59789921/200734991-6495ec11-476a-4f7b-9c53-27c987725de1.png)
![BEV 99`3JYEEG{DZIN~AO{N](https://user-images.githubusercontent.com/59789921/200735081-53ec4c7d-42bd-4556-acd9-ab7cf5f5162c.png)
![}D 1`)TEBSMO%}IWB3$51A](https://user-images.githubusercontent.com/59789921/200735088-6351a8b5-d17b-4e12-aa14-1aecb7f250ba.png)
![DWXTR5LOY4 @$DY}$DEOPIE](https://user-images.githubusercontent.com/59789921/200735096-18ddbc79-6b75-4b82-91b5-f8fca1d8befb.png)

![IL}20{4~FLW$KM~HF_9Z3)X](https://user-images.githubusercontent.com/59789921/200735403-582ad673-3635-43e3-b8c4-0a3b62831987.png)

####  有待改进
1、可以在对人脸检测分割后图像做背景差分，减少对口罩处理的影响
2、对图像增强，可以增加一定对比度，让肤色和口罩或者其他内容增加差异
3、可以融合进传统口罩识别方法，对口罩颜色进行一定的判别。
4、还有很多需要改进的。。。


