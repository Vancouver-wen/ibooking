from .models import *
from .utils import *

from apscheduler.schedulers.background import BackgroundScheduler # 使用它可以使你的定时任务在后台运行
from django_apscheduler.jobstores import DjangoJobStore, register_events, register_job # 要求django-apscheduler-0.2.10，否则缺少register_job
# 关于bug： django_apscheduler.models.DjangoJob.DoesNotExist: DjangoJob matching query does not exist.
# bug的解决：https://stackoverflow.com/questions/51168474/django-apscheduler-models-doesnotexist-djangojob-matching-query-does-not-exist
# this issues is a bug on django-apscheduler version=0.2.11 which resolved on version=0.2.12
import datetime

from .sendemail import sendemail
'''
date：在您希望在某个特定时间仅运行一次作业时使用
interval：当您要以固定的时间间隔运行作业时使用
cron：以crontab的方式运行定时任务
minutes：设置以分钟为单位的定时器
seconds：设置以秒为单位的定时器
'''
scheduler=None
def initScheduler():
    try:
        global scheduler
        # 实例化调度器
        scheduler = BackgroundScheduler(timezone='Asia/Shanghai') # 添加上海时区解决bug： PytzUsageWarning: The localize method is no longer necessary, as this time zone supports the fold attribute (PEP 495).
        # 开启定时工作
        # 调度器使用DjangoJobStore()
        scheduler.add_jobstore(DjangoJobStore(), "default")
        if not scheduler.running:
            scheduler.start()
        print("=> scheduler被实例化并开启工作")
        return scheduler
    except:
        print("=> 定时任务无法初始化 .. ")
        return None
def seatinit():
    seats=SeatInfo.objects.all()
    for seat in seats:
        seat.Used="000000000000000000000000"
        seat.save()
def seatInit():
    try:
        # register_events(scheduler)    最新的django_apscheduler已经不需要这一步
        scheduler.add_job(
            seatinit, 
            "interval", 
            days=1,
            start_date='2023-01-01 03:30:00',end_date='2025-01-01 03:30:00', 
            args=[],
            id='seat_init', 
            replace_existing=True
        ) 
        if not scheduler.running:
            scheduler.start()
        print("=> 添加凌晨自动清理占用计划")
    except Exception as e:
        print('=> seatinit定时任务异常：%s' % str(e))
def getRemindTime(start):
    # remindTime='2023-05-22 21:43:00' # 规定 remindTime的格式
    current=datetime.datetime.now()
    if current.hour<start and current.minute<45: # 正常预约
        current=current.replace(hour=start-1,minute=45) # 在预约时间之前15分钟会有推送
    else: # 抢座位
        print("=> 修改前current:",current)
        current=current.replace(minute=current.minute+1) # 在当前时间1分钟后进行推送
        print("=> 修改后current:",current)
    remindTime=current.strftime("%Y-%m-%d %H:%M:%S")
    print("=> RemindTime:",remindTime)
    return remindTime
def getDeadline(start):
    # deadline='2023-05-22 21:43:00' # 规定 deadline的格式
    current=datetime.datetime.now()
    if current.hour<start: # 正常预约
        current=current.replace(hour=start,minute=0,second=0)
        deadline=current.strftime("%Y-%m-%d %H:%M:%S")
    elif current.hour>=start: # 正在进行抢座位
        current=current.replace(minute=current.minute+5) # 5分钟之内签到
        if current.minute>=60: 
            current=current.replace(minute=59,second=59)
        deadline=current.strftime("%Y-%m-%d %H:%M:%S")
    return deadline

def remind(reservation,user,sign):
    '''
    1. 发送邮件提醒学生进行签到
    2. 在合适的时间检查该学生签到情况
    '''
    # 如果已经签到了，就不用 发邮件提醒 + 检查 了
    reservation=ReservationInfo.objects.get(id=reservation.id)
    if reservation.State==1:
        pass
    else:
        # 1. 发送邮件提醒学生进行签到
        sendemail(Context="您有一个预约即将到期，请到个人主页进行签到",ToAddress=user.Email)
        # 2. 在合适的时间检查该学生签到情况
        scheduler.add_job(
            checkSign, 
            'date', 
            run_date=getDeadline(sign.Deadline), 
            args=[reservation.id,user,sign],
            id='remind', 
            replace_existing=True
        )

def checkSign(reservationID,user,sign):
    # 到点检查是否签到
    # 从 ReservationInfo表 中检查签到情况，已经完成签到（1），如果未完成（0），则改为违约（-1）
    reservation=ReservationInfo.objects.get(id=reservationID)
    print("=> 违约检查！ reservationID:",reservation.id," .. state .. :",reservation.State)
    if reservation.State==0: # 表示没有签到
        sendemail("后台检测到您新产生一条违约记录，reservationID={}".format(reservationID),user.Email)
        reservation.State=-1;sign.delete() # 后台记录一次违约，并删除签到
        reservation.save()
        releaseSeat(reservation) # 释放被占用的座位
 
def releaseSeat(reservation):
    seat=reservation.SeatID
    Used=seat.Used
    Start=reservation.Start
    End=reservation.End
    for i in range(Start,End):
        Used=Used[:i]+'0'+Used[i+1:]
    seat.Used=Used
    seat.save()
def occupySeat(reservation):
    seat=reservation.SeatID
    Used=seat.Used
    Start=reservation.Start
    End=reservation.End
    for i in range(Start,End):
        Used=Used[:i]+'1'+Used[i+1:]
    print("=> Used:",Used)
    seat.Used=Used
    seat.save() # 修改后的字段需要更新到数据库中
    print("=> seat.Used:",seat.Used)
def reserveOperation(reservationID):
    '''功能：占用座位，并督促学生进行签到
    1. 占用座位，防止重复预约
    2. 在签到表中添加一项信息
    3. 发送邮件提醒学生预约成功
    4. 在合适时间提醒学生签到
    '''
    reservation=ReservationInfo.objects.get(id=int(reservationID))
    print("=> 查看预约表的用户ID： ",reservation.UserID)
    user=reservation.UserID
    # 1. 占用座位，防止重复预约
    occupySeat(reservation) 
    # 2. 在签到表中添加一项信息
    sign=SignInfo.objects.create(
        ReservationID=reservation,
        Deadline=reservation.Start,
        UserID=user,
    )
    # 3. 发送邮件提醒学生预约成功
    sendemail(Context="预约成功",ToAddress=str(user.Email))
    # 4. 在合适时间提醒学生签到
    global scheduler
    scheduler.add_job(
        remind, 
        'date', 
        run_date=getRemindTime(reservation.Start), 
        args=[reservation,user,sign],
        id='remind', 
        replace_existing=True
    )
    if not scheduler.running:
        scheduler.start()