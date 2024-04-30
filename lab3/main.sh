#！/bin/bash

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
grep ">兼容性" file -A 30 | sed -n '7p' | grep -oP '<dd class="information-list__item__definition__item__definition">\K[^<]*' >> output
echo -n "年龄 " >> output
grep ">年龄" file -A 2 | sed "1,2d" | tr -d ' ' >> output
echo -n "价格 "  >> output
grep ">价格" file -A 2 | sed "1,1d" | sed "2,2d" | grep -o '<dd class="information-list__item__definition">[^<]*</dd>' | sed 's/<[^>]*>//g' >> output
echo -n "评分 " >> output
grep ">（满分 5 分）<" file | grep -o '<span class="we-customer-ratings__averages__display">[^<]*</span>' | sed 's/<[^>]*>//g' >> output
#At last we show the content stored in the output file
cat output
done < "$input" 


