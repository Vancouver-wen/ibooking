from django.db import models

# Create your models here.

'''定义模型对象（其实就是数据库中的“表的模板”）'''
'''django\db\models\fields\__init__.py中有所有的类型'''
class UserInfo(models.Model):
    # 定义属性 也就是  表中列的定义
    UserID=models.BigIntegerField(primary_key=True)  #在mysql中，只有int类型数据能够作为主键，但学号很长，所以使用大整数
    UserPassword=models.CharField(max_length=100,null=True)
    Name=models.CharField(max_length=50,null=True)
    Gender=models.BooleanField(null=True)
    Email=models.EmailField(unique=True,null=True) #学生与邮箱必须一一对应

class SeatInfo(models.Model):
    Campus=models.CharField(max_length=50,null=True)
    Classroom=models.CharField(max_length=50,null=True)
    Index=models.CharField(max_length=50,null=True)
    Electricity=models.BooleanField(null=True)
    Mask=models.CharField(max_length=25,default="000000000111111111111000") #共24个数字，代表每个时间段的 availale
    Used=models.CharField(max_length=25,default="000000000000000000000000") #共24个数字，代表每个时间段的 accessable
    MaxTime=models.SmallIntegerField(null=True,default=4)

class ReservationInfo(models.Model):
    UserID=models.ForeignKey(to=UserInfo,on_delete=models.CASCADE) #设置外键
    SeatID=models.ForeignKey(to=SeatInfo,on_delete=models.CASCADE)
    Date=models.DateTimeField(auto_now=True,null=True)
    Start=models.SmallIntegerField(null=True)
    End=models.SmallIntegerField(null=True)
    State=models.SmallIntegerField(null=True)

class SignInfo(models.Model):
    UserID=models.ForeignKey(to=UserInfo,on_delete=models.CASCADE,null=True)
    ReservationID=models.ForeignKey(to=ReservationInfo,on_delete=models.CASCADE)
    Deadline=models.SmallIntegerField(null=True)

'''
在创建一对多的关系的,需要在ForeignKey的第二参数中加入
on_delete=models.CASCADE 主外关系键中，级联删除，
也就是当删除主表的数据的时候从表中的数据也随着一起删除。
'''

