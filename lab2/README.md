# We Love Tiktok —— 计算机系统工具与操作课程第二次作业

本文档详细说明了制作分离的视频、音频和字幕文件的方法。我采取的是录制视频 -> 分离音频与视频 -> 使用Python + VOSK程序生成字幕文件的方案。

## 1.录制视频
网络上有许多好用的视频录制软件，如OBS、Bandicam、Capture、必剪录制工具等。我这里使用激活后的bandicam进行录制。Bandicam操作流程十分简单。先在“常规”栏中设置保存地址，再将录制模式设置为全屏模式（或者矩形窗口模式），之后直接点击红色的REC按钮进行录制，按下自己设置的暂停热键（默认为ctrl + alt + T）即可暂停 / 停止录制.

## 2.进行剪辑
主要是剪辑自己录制时的口误与失误，提高观众看视频的体验。我直接使用了必剪这一软件，如果对剪辑需求较大可以考虑Adobe公司的Pr软件。

## 3.分离视频与音频文件
我直接使用必剪的分离音频功能，再设置格式导出。或者使用“格式工厂”这一软件，对视频进行音频分离。

## 生成字幕文件
我采取Python + VOSK程序自动生成，教程如下： https://www.zhihu.com/question/397207300/answer/2806069443
VOSK下载网站： https://alphacephei.com/vosk/models
大致流程为：
1.python里使用pip安装ffmpeg和VOSK
2.下载对应版本的VOSK模型
3.将视频文件、VOSK文件和Python文件放到同一文件夹中，使用教程中的python代码
4.运行python test_test_cn.py Target.mp4
因为是自动识别，所以可能不尽准确，我再用一些在线网站对字幕进行调整，比如这个网站：https://jianwai.youdao.com/index/0

最终，我便得到了所需的所有文件。