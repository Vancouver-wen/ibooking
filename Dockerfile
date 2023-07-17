FROM ubuntu

# 复制文件到容器
ADD requirements.txt /home

# 跳转到指定目录
WORKDIR /home

# 安装vim、python3、pip3以及Django用的包
RUN apt-get update && apt-get install vim -y \
    && apt-get install python3 -y \
    && apt-get install python3-pip -y \
    && pip3 install -r requirements.txt -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com

# 复制项目
ADD ./mydjangoDemo01 /home/mydjangoDemo01

# 进入到项目目录
WORKDIR /home/mydjangoDemo01

# 对外暴露端口
EXPOSE 8000

# 运行项目
CMD ["python3","manage.py","runserver", "0.0.0.0:8000"]

