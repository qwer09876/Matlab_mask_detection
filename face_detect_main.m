clc,clear,close all  % 清理命令区、清理工作区、关闭显示图形
warning off       % 消除警告
feature jit off      % 加速代码运行
tic
[filename ,pathname]=...
    uigetfile({'*.*';'*.jpg';'*.png';},'选择图片'); %选择图片路径
str=[pathname filename]; % 合成路径+文件名
if str %如果取消选择，启动视频
    img = imread(str);        % 读图
    image_process(img,'picture');
else
    cam=webcam(1);%读取图片
    img=snapshot(cam);
    preview(cam)
    img = snapshot(cam);    % Get a single frame
    figure,image(img);      % Display the frame in a figure window.
    num_frame=3;
    % 获取num_frame个帧
    for idx = 1:num_frame
        figure;
        img = snapshot(cam);%获取每一帧图片
        image_process(img,"video");
        pause(3)%每隔五秒处理一次
    end
    clear cam
end