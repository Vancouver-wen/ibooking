from django.shortcuts import render,redirect,HttpResponse

from .models import *
from .utils import *

import datetime
from copy import deepcopy

from .adminIndex import mask2startend
from .apscheduler import reserveOperation
from .log2index import getSelfInformation
from .sendemail import sendemail

def human_read_accessable(accessable):
    intervals=[]
    interval=[int,int]
    have_start=False
    for step,i in enumerate(accessable):
        i=int(i)
        if have_start==False:
            interval=[i,i]
            have_start=True
        elif step==len(accessable)-1:
            interval[1]=i
            intervals.append(str(interval[0])+'-'+str(interval[1]))
        elif i-1==interval[1]:
            interval[1]=i
        else: # i-1 != interval[0]
            intervals.append(str(interval[0])+'-'+str(interval[1]))
            interval=[i,i]
    # accessable=str(accessable)
    accessable=str(intervals)
    return accessable
def reservationPage(request):
    # 主体从 manageSeatPage 函数中拷贝
    Campus=request.GET.get("Campus",None)
    Classroom=request.GET.get("Classroom",None)
    Index=request.GET.get("Index",None)
    Electricity=request.GET.get("Electricity",None)
    seats=SeatInfo.objects.all()
    if "all" not in Campus:
        seats=seats.filter(Campus=Campus)
    if "all" not in Classroom:
        seats=seats.filter(Classroom=Classroom)
    if "all" not in Index :
        seats=seats.filter(Index=Index)
    if "all" not in Electricity :
        seats=seats.filter(Electricity=Electricity)
    context=dict()
    context["seats"]=[]
    for seat in seats:
        temp=dict()
        temp["Id"]=seat.id
        temp["Campus"]=seat.Campus
        temp["Classroom"]=seat.Classroom
        temp["Index"]=seat.Index
        temp["Electricity"]=seat.Electricity
        temp["MaxTime"]=seat.MaxTime
        temp["Start"],temp["End"]=mask2startend(seat.Mask)
        accessable=[]
        for i in range(24):
            if seat.Mask[i]=='1' and seat.Used[i]=='0':
                accessable.append(i)
        temp["accessable"]=human_read_accessable(accessable)
        context["seats"].append(temp)
    return render(request,"reservation.html",context)
def seatAvailable(Mask,Used,Start,End):
    available=True
    for i in range(Start,End):
        if Mask[i]=='0' or Used[i]=='1':
            available=False
    return available
def reservation(request):
    '''
    1. 从前端获取用户预约数据
    2. 判断预约是否合法
    3. 新建一个预约放RreservationInfo表中
    4. 占用座位，并督促学生进行签到
    '''
    # 1. 从前端获取用户预约数据
    UserID=request.session['userAccount']# ;print("=> UserID_Type:",type(UserID)," UserID:",UserID)
    SeatID=request.GET.get("SeatID",None)# ;print("=> SeatID_Type:",type(SeatID)," SeatID:",SeatID)
    MaxTime=int(request.GET.get("MaxTime",None))
    AvailableStart=int(request.GET.get("AvailableStart",None))
    AvailableEnd=int(request.GET.get("AvailableEnd",None))
    Start=int(request.GET.get("Start",None))
    End=int(request.GET.get("End",None))
    # 2. 判断预约是否合法
    current=datetime.datetime.now()
    if Start>End :
        return HttpResponse("结束时间不能早于开始时间！")
    if End<current.hour:
        return HttpResponse("预约已经过期！")
    if Start -End > MaxTime:
        return HttpResponse("拒绝内卷！学习时长不得大于{}小时".format(MaxTime))
    if Start<AvailableStart:
        return HttpResponse("哟，这么早就卷起来啦。教室最早的开放时间为{}点".format(AvailableStart))
    if End>AvailableEnd:
        return HttpResponse("让我看看是谁还没下班。教室最晚开放到{}点".format(AvailableEnd))
    seat=SeatInfo.objects.get(id=int(SeatID))
    # 3. 新建一个预约放RreservationInfo表中
    if seatAvailable(seat.Mask,seat.Used,Start,End):
        reservation=ReservationInfo.objects.create(
            UserID=UserInfo.objects.get(UserID=int(UserID)),
            SeatID=SeatInfo.objects.get(id=int(SeatID)),
            Start=Start,
            End=End,
            State=0,
        )
    # 4. 占用座位，并督促学生进行签到
        reserveOperation(reservation.id) 
    else:
        return HttpResponse("您预约的座位已经被占用了！")
    # 更新 studentIndex.html页面信息
    request.session["context"]=getSelfInformation(
        context=request.session["context"],
        student=UserInfo.objects.get(UserID=int(request.session['userAccount']))
    )
    return render(request,"studentIndex.html")
def inCampus(request):
    isIn=True
    # TODO 根据前端获取的位置信息，判断签到地点是否在校园内
    return isIn
def sign(request):
    '''
    1. 删除签到表的信息 
    2. 将预约表中的state标志为1 
    3. 发送签到成功的邮件
    '''
    if inCampus(request)==False:
        return HttpResponse("您的地理位置异常，请尽快前往自习室签到！")
    SignID=request.GET.get("SignID",None)
    sign=SignInfo.objects.get(id=SignID)
    reservation=sign.ReservationID
    user=reservation.UserID
    # 2. 将预约表中的state标志为1 
    reservation.State=1
    reservation.save()
    print("=> 被签到的sign对应的reservation的ID为：",reservation.id)
    # 1. 删除签到表的信息 
    sign.delete()
    # 3. 发送签到成功的邮件
    sendemail(Context="签到成功！",ToAddress=str(user.Email))
    request.session["context"]=getSelfInformation(
        context=request.session["context"],
        student=UserInfo.objects.get(UserID=int(request.session['userAccount']))
    )
    return render(request,"studentIndex.html")