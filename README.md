# ibooking

## 在华为云上进行编译构建
```python3.6
python -m pip install --upgrade pip
pip install -r requirements.txt
# 检查 ./mydjangoDemo01/settings.py 中的 DATASET列表
# 如果使用 sqlite数据库
python ./mydjangoDemo01/manage.py makemigrations
pythoon ./mydjangoDemo01/manage.py migrate
python ./mydjangoDemo01/manage.py test
# 如果使用 本地mysql数据库
python ./mydjangoDemo01/manage.py  test 
```

## Django 运行代码
```python
进入 django的python环境后,
python manage.py runserver
```

## Django 同步数据库
```python
python manage.py makemigrations
python manage.py migrate
```


## 容器编排

1. 编写Dockerfile
2. 编写docker-compose.yml,集成django与mysql
3. 编译并运行容器  

```
mkdir ./mysql/data
docker-compose up  mysql
docker exec -it mysql /bin/bash
mysql -h 127.0.0.1 -u root -p
use mysql;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
FLUSH PRIVILEGES;
```
```
docker build . -t ubuntu:web
docker-compose up web
docker exec -it web /bin/bash
python3 manage.py migrate
删除django 容器 重新执行docker-compose up -d web
```

4. 数据库迁移   
`导出:mysqldump -u root -p library > ./mysql/library.sql`     
 `导入:mysql -u root -h 127.0.0.1 -p library< /home/mysql/library.sql`

[docker搭建django+mysql](https://www.cnblogs.com/7dao/p/17107939.html)   
[docker 安装mysql8详细说明](https://blog.csdn.net/qq_36252295/article/details/122620663)