# 守望者——计算机系统工具与操作课程第三次作业

本次作业需要我们从网页中爬取数据，需要用到爬虫的知识。我首先学习了shell编程的基础内容，参考书籍为《Linux Command Line and Shell Script Bible》.

我在后文直接将我写的shell脚本粘贴过来，在此做逐行解析：（虽然我也用英文写了不少注释，写英文是因为在命令行切换输入法很麻烦）

首先我会告诉用户，把网址一行一行存在一个websites文本文件里，然后我告诉用户输出会在output文件里。

接着我以websites为输入，创建file 和 output两个文件，如果它们已经存在，我就把它们清空。

然后我检查input是否存在，如果不存在就报错。接着我循环遍历websites的每一行，每次把这一行赋给line， 然后输出到终端告诉用户目前这个app的网址是多少。 接着我开始做文本解析。这个过程非常耗时，需要多次尝试。比如，以抓取版本为例，如果只grep "版本" file，则抓出来的东西非常多，根本没法用。可以利用版本号的数字特征这样抓： grep "版本 [0-9].[0-9].[0-9]" file， 抓完再送到另一个grep进行过滤。我大致的思路就是，先用grep粗抓，抓到的东西尽量行数比较少且包含我需要的信息，然后我用sed删去没用的行，再拿sed或者grep进行精筛，拿到我需要的信息。这里值得注意的是，有可能最后拿到的信息包含空格。我可以用tr -d " "来删去最终信息中的空格。如果有缺少的提示信息，我再用echo人为补充。

为了让用户看到每次抓取结果，我设计的脚本不但会将结果输出到output文本文件中，还会在终端也输出一份。结果截图如下：

![](https://notes.sjtu.edu.cn/uploads/upload_b544ee094b66f5537d3d962b2418229a.png)


对于定时自动化，这个由用户自行来设定自己想要的时间间隔。比如用户可以这么做： crontab -e
再加入0 1 * * * script

通过本次作业，我学到了超级多关于shell脚本和命令行的知识，感觉这些知识以后会经常用，非常具有实用性，比理论计算机接地气多了。

脚本主体如下：（省略了#!bin/bash）


```#！/bin/bash

echo "Please store all the website line by line in the file named websites"
echo "The output is stored in the file named output"

input="websites"
#create these two files if they don't exist
touch file
touch output
#clear these two files
> file
> output

# check if the input file exists
if [ ! -f "$input" ]; then
    echo "文件 $input 不存在"
    exit 1
fi

#read the input line by line and pass it to wget
while IFS= read -r line; do
#Tell the user the website of the app
echo -n "This website of this app is:" >> output
echo "$line" >> output
#quiet mode wget and store information into file
wget -O file "$line" 
#firstly grep roughly and then grep delicately and filter the information with sed.At last use tr -d ' ' to get rid of all the blank characters
grep "版本 [0-9].[0-9].[0-9]" file | grep '<p class="l-column small-6 medium-12 whats-new__latest__version">.*</p>' | sed -e 's/<[^>]*>//g' | tr -d ' ' >> output
echo -n "供应商 " >> output
#Notice right here we have to use -A n to get more lines for our sed and grep
grep ">供应商" file -A 2 | sed "1, 2d" | tr -d ' ' >> output
echo -n "大小 " >> output
grep ">大小*" file -A 2 | grep 'information-list__item__definition' | sed -e 's/.*aria-label="//' -e 's/">.*//' >> output
#grep ">兼容性" file -A 30 | grep -A 1 '<dt class="information-list__item__term medium-valign-top">兼容性</dt>' | grep -oP '设备需装有*或 更高版本'
echo -n "语言 " >> output
grep ">语言" file -A 4 | sed "1,2d" | grep -oP '<p data-test-bidi>\K[^<]*' >> output
echo -n "兼容性 " >> output
grep ">兼容性" file -A 30 | sed -n '7p' | grep -oP '<dd class="information-list__item__definition__item__definition">\K[^<]*' >> output```
echo -n "年龄 " >> output
grep ">年龄" file -A 2 | sed "1,2d" | tr -d ' ' >> output
echo -n "价格 "  >> output
grep ">价格" file -A 2 | sed "1,1d" | sed "2,2d" | grep -o '<dd class="information-list__item__definition">[^<]*</dd>' | sed 's/<[^>]*>//g' >> output
echo -n "评分 " >> output
grep ">（满分 5 分）<" file | grep -o '<span class="we-customer-ratings__averages__display">[^<]*</span>' | sed 's/<[^>]*>//g' >> output
#At last we show the content stored in the output file
cat output
done < "$input" 

