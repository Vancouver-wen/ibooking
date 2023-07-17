from django.shortcuts import render,redirect,HttpResponse

from .models import *
from .utils import *

def topage(request,pageName):
    #但是统一的页面跳转函数不能完成任务
    return render(request=request,template_name=pageName)

def index(request):
    return redirect("/page/login.html")
def userRegister(request):
    #从前端表单中获取信息
    userAccount=request.GET.get("userAcc",None)
    userPassword=request.GET.get("userPass",None)
    userName=request.GET.get("userName",None)
    userGender=(request.GET.get("userGender",None)=="man") #男->1 女->0
    userEmail=request.GET.get("userEmail",None)
    #在 UserInfo 表中添加记录
    UserInfo.objects.create(
        UserID=userAccount,
        UserPassword=userPassword,
        Name=userName,
        Gender=userGender,
        Email=userEmail,
    ) 
    return redirect("/page/login.html")
def register(request):
    return redirect("/page/register.html")

def getInformationOption():
    """contest字典可用 “键”
    seats: "availableCampus","availableClassroom","availableIndex","availableElectricity",
    students: "availableName","availableUserID","availableEmail",
    reservations: "reservedDate","reservedState","reservedUserID","reservedSeatID",
    """
    # Seat Information 获取所有可能的 Campus Classroom Index Electricity
    seats=SeatInfo.objects.all()
    context=dict()
    context["availableCampus"]=set()
    context["availableClassroom"]=set()
    context["availableIndex"]=set()
    context["availableElectricity"]=set()
    for seat in seats:
        context["availableCampus"].add(seat.Campus)
        context["availableClassroom"].add(seat.Classroom)
        context["availableIndex"].add(seat.Index)
        context["availableElectricity"].add(seat.Electricity)
    context["availableCampus"]=list(context["availableCampus"])
    context["availableClassroom"]=list(context["availableClassroom"])
    context["availableIndex"]=list(context["availableIndex"])
    context["availableElectricity"]=list(context["availableElectricity"])
    # Student Information 获取所有可能的 Name UserID Email
    students=UserInfo.objects.all()
    context["availableName"]=set()
    context["availableUserID"]=set()
    context["availableEmail"]=set()
    for student in students:
        context["availableName"].add(student.Name)
        context["availableUserID"].add(student.UserID)
        context["availableEmail"].add(student.Email)
    context["availableName"]=list(context["availableName"])
    context["availableUserID"]=list(context["availableUserID"])
    context["availableEmail"]=list(context["availableEmail"])
    # Reservation Information 获取所有可能的 Date State UserID SeatID
    reservations=ReservationInfo.objects.all()
    context["reservedDate"]=set()
    context["reservedDateYear"]=set()
    context["reservedDateMonth"]=set()
    context["reservedDateDay"]=set()
    context["reservedState"]=set()
    context["reservedUserID"]=set()
    context["reservedSeatID"]=set()
    for reservation in reservations:
        # print("外键的type：",type(reservation.UserID)) #外键的type： <class 'library.models.UserInfo'>
        # print("reservation.UserID.UserID的类型：",type(reservation.UserID.UserID))
        context["reservedUserID"].add(reservation.UserID.UserID)
        context["reservedSeatID"].add(reservation.SeatID.id)
        context["reservedDate"].add(str(reservation.Date))
        context["reservedDateYear"].add(str(reservation.Date.year))
        context["reservedDateMonth"].add(str(reservation.Date.month))
        context["reservedDateDay"].add(str(reservation.Date.day))
        #print("=> 查看context[reservedDate]:",context["reservedDate"])
        context["reservedState"].add(reservation.State)
    context["reservedDate"]=list(context["reservedDate"])
    context["reservedDateYear"]=list(context["reservedDateYear"])
    context["reservedDateMonth"]=list(context["reservedDateMonth"])
    context["reservedDateDay"]=list(context["reservedDateDay"])
    context["reservedState"]=list(context["reservedState"])
    context["reservedUserID"]=list(context["reservedUserID"])
    context["reservedSeatID"]=list(context["reservedSeatID"])
    return context

def getSelfInformation(context,student):
    """contest字典增加的 “键”
    signs: "SignID","Deadline","Campus","Classroom","row","colume",
    breaks/historys: "ReservationID","Date","Start","End","Campus","Classroom","Index",
    """
    signs=SignInfo.objects.filter(UserID=student)
    context["signs"]=[]
    for sign in signs:
        # print("=> sign:",sign)
        temp=dict()
        temp["SignID"]=sign.id
        temp["Deadline"]=sign.Deadline
        temp["Campus"]=sign.ReservationID.SeatID.Campus
        temp["Classroom"]=sign.ReservationID.SeatID.Classroom
        temp["row"]=sign.ReservationID.SeatID.Index[:3]
        temp["colume"]=sign.ReservationID.SeatID.Index[3:]
        context["signs"].append(temp)
    reservations=ReservationInfo.objects.filter(UserID=student)
    context["breaks"]=[]
    context["historys"]=[]
    for reservation in reservations:
        temp=dict()
        temp["ReservationID"]=int(reservation.id )
        temp["Date"]=reservation.Date.strftime("%Y-%m-%d")
        temp["Start"]=reservation.Start
        temp["End"]=reservation.End
        temp["Campus"]=reservation.SeatID.Campus
        temp["Classroom"]=reservation.SeatID.Classroom
        temp["Index"]=reservation.SeatID.Index
        if reservation.State==-1:
            context["breaks"].append(temp)
        elif reservation.State==1:
            # 这里包含了 reservation.State==0 or 1 的情况
            context["historys"].append(temp)
        
    # 对 违约记录 和 历史记录 从新到旧进行排序
    context["breaks"].sort(key=lambda x:x["ReservationID"],reverse=True)
    context["historys"].sort(key=lambda x:x["ReservationID"],reverse=True)
    # 只选取最新的7次历史记录
    context["historys"]=context["historys"][:7]
    return context
def distinguishIdentity(request):
    userAcc=request.GET.get("userAcc",None)
    userPass=request.GET.get("userPass",None)
    '''使用session，session是字典类型。session的数据能够在所有前端和后端之间共享'''
    request.session['userAccount']=userAcc
    # context=dict()
    # context["userPassword"]=userPass
    #print("=> 正在区分用户身份 .. ")
    context=getInformationOption()
    if userAcc=="admin" and userPass=="123456":
        # Seat Information获取所有可能的 Campus Classroom Index
        request.session["context"]=context
        return render(request,"adminIndex.html")
    else:
        try:
            student=UserInfo.objects.get(UserID=int(userAcc))
        except:
            return HttpResponse("系统中没有该用户："+userAcc)
        if student.UserPassword==userPass:
            request.session["context"]=getSelfInformation(context,student)
            return render(request,"studentIndex.html")
        else:
            return redirect("/page/login.html")