# 网络家园——计算机系统工具与操作课程作业四

本次作业需要搭建一个个人网站，我最初采用的是hexo + github.io的方法，但是加完主题之后hexo出了点小问题暂时没解决好，所以现在hexo只能本地浏览不能公网浏览。为了能产生公开IP，我又尝试了typecho并成功搭建了第二个个人主页。我最终提交的是typecho搭建的个人主页。

hexo本地预览截图如下：（其实我非常喜欢这个主题，不过不小心把github.io配置弄崩了，正在修复中）

![](https://notes.sjtu.edu.cn/uploads/upload_62612ce9e0451a80b481c23c600d192c.png)
![](https://notes.sjtu.edu.cn/uploads/upload_c61c8d6b5d508fd87a5d6d22bf03dc2b.png)


hexo的配置过程大致就是：安装Node.js，用 npm下载hexo，配置github,创建并连接ssh密钥，创建github仓库，名字取为用户名.github.io, hexo这边用hexo g hexo s生成页面，用npm安装hexo-deployer-git，修改hexo的_config.yml文件，然后hexo d， push到github, git clone喜欢的主题， 修改config文件。这里好像我把config文件改错了，所以github.io炸了...

我之后更换了路线，采用了typecho进行搭建。大致过程就是：使用腾讯云服务器，登录服务器，输入一堆指令（直接复制教程里的）搭建主页，然后git clone下载主题，这时候注意一个指令: sudo chmod -R 777 /usr/local/lighthouse/softwares/typecho/usr/themes
这个指令非常关键，需要在上传主题文件夹之前输入一遍进行授权，否则可能上传失败，上传成功后，需要再输入一遍该指令，进行授权配置。

之后我进入我的私人配置页面，用markdown语法写文章和页面，再上传即可。我可以去公用IP页面查看外部浏览效果，最终效果截图如下：（亟待进一步优化和配置，这次作业时间有点紧所以很多地方没优化好）

![](https://notes.sjtu.edu.cn/uploads/upload_4e0e6319d53bbd47d47a8741972a13f3.png)
![](https://notes.sjtu.edu.cn/uploads/upload_ddd6a44be45c72e4e86af1b5b5e03cec.png)
![](https://notes.sjtu.edu.cn/uploads/upload_7631aa7b4dbca9d3c808077bf33e03f1.png)

通过做本次作业，我学到了网页搭建的很多知识，我感觉我有必要从现在开始每周写点博客文章了，主要想写一些每周学到的新知识，用讲给读者的方法来检验自己的学习成果。