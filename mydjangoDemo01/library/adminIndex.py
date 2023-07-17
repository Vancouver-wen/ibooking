from django.shortcuts import render,redirect,HttpResponse
# djangp=2.1
from .models import *
from .utils import *


"""
Seat Information
"""
def startend2mask(start,end):
    mask=""
    for i in range(24):
        if i >=start and i <end:
            mask=mask+"1"
        else:
            mask=mask+"0"
    #print("=> 开放时间为：",mask," .. mask的长度为:",len(mask))
    return mask
def mask2startend(mask):
    start=0
    end=0
    start=mask.find("1")
    end=mask.rfind("1")
    if start==-1 or end==-1:
        start=0
        end=0
    return start,end

def addSeatPage(request):
    return render(request,"addseat.html")
def addSeat(request):
    #从前端表单中获取数据
    Campus=request.GET.get("campus",None)
    Classroom_1=request.GET.get("classroom_1",None)
    Classroom_2=request.GET.get("classroom_2",None)
    Classroom=str(Classroom_1)+str(Classroom_2)
    Index_1=request.GET.get("index_1",None)
    Index_2=request.GET.get("index_2",None)
    Index=str(Index_1).zfill(3)+str(Index_2).zfill(3)
    Electricity=(request.GET.get("electricity",None)=="Powered") #Powered->1  Unpowered->0
    Start=request.GET.get("start",None)
    End=request.GET.get("end",None)
    Maxtime=request.GET.get("maxtime",None)
    State=request.GET.get("state",None)
    if State=="不可用":
        State=-1
    elif State=="空闲":
        State=0
    elif State=="被占用":
        State=1
    else:
        State=None
    #在 SeatInfo 表中添加记录
    SeatInfo.objects.create(
        Campus=Campus,
        Classroom=Classroom,
        Index=Index,
        Electricity=Electricity,
        Mask=startend2mask(int(Start),int(End)),
        MaxTime=Maxtime,
    )
    #return redirect("/page/adminIndex.html")
    return render(request,"adminIndex.html")

def manageSeatPage(request):
    Campus=request.GET.get("Campus",None)
    Classroom=request.GET.get("Classroom",None)
    Index=request.GET.get("Index",None)
    Electricity=request.GET.get("Electricity",None)
    seats=SeatInfo.objects.all()
    # print("打印各个值：",Campus,Classroom,Index,Electricity)
    if "all" not in Campus:
        seats=seats.filter(Campus=Campus)
    if "all" not in Classroom:
        # print("发现异常")
        # print(type(Classroom),"###",Classroom,"###")
        seats=seats.filter(Classroom=Classroom)
    if "all" not in Index :
        seats=seats.filter(Index=Index)
    if "all" not in Electricity :
        seats=seats.filter(Electricity=Electricity)
    #seats是一个list类型的数据
    # print("=> seats:",seats)
    # print("seats.type:",type(seats))
    #print("=> seat.type:",type(seats[0]))
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
        temp["Mask"]=seat.Mask
        context["seats"].append(temp)
    return render(request,"manageSeat.html",context)
def modifySeat(request):
    #print("=> 测试url传参：",request.GET.get("SeatID",None)) #经测试，能够成功传参，使用get方式获取
    context=dict()
    context["Id"]=request.GET.get("SeatID",None)
    context["Campus"]=request.GET.get("Campus",None)
    context["Classroom"]=request.GET.get("Classroom",None)
    context["Index"]=request.GET.get("Index",None)
    context["Electricity"]= True if "True" in request.GET.get("Electricity",None) else False
    context["MaxTime"]=int(request.GET.get("MaxTime",None))
    context["Mask"]=request.GET.get("Mask",None)
    context["Start"],context["End"]=mask2startend(context["Mask"])
    '''
    # print(context)
    # print("=> 开始检查 各个属性的 类型 数值 ..")
    # print("*****",type(context["Id"]),"*****",context["Id"],"*****")
    # print("*****",type(context["Campus"]),"*****",context["Campus"],"*****")
    # print("*****",type(context["Classroom"]),"*****",context["Classroom"],"*****")
    # print("*****",type(context["Index"]),"*****",context["Index"],"*****")
    # print("*****",type(context["Electricity"]),"*****",context["Electricity"],"*****")
    # print("*****",type(context["MaxTime"]),"*****",context["MaxTime"],"*****")
    # print("*****",type(context["Mask"]),"*****",context["Mask"],"*****")
    # print("*****",type(context["Start"]),"*****",context["Start"],"*****")
    # print("*****",type(context["End"]),"*****",context["End"],"*****")
    '''
    seat=SeatInfo.objects.filter(id=int(context["Id"]))
    if context["Campus"]=="None":
        seat[0].delete()
    seat=SeatInfo.objects.filter(id=int(context["Id"])).update(
        Campus=context["Campus"],
        Classroom=context["Classroom"],
        Index=context["Index"],
        Electricity=context["Electricity"],
        Mask=startend2mask(start=context["Start"],end=context["End"]),
        MaxTime=context["MaxTime"],
    )
    return render(request,"adminIndex.html")

"""
Student Information
"""
def manageStudentPage(request):
    Name=request.GET.get("Name",None)
    UserID=request.GET.get("UserID",None)
    Email=request.GET.get("Email",None)
    students=UserInfo.objects.all()
    if "all" not in Name:
        students=students.filter(Name=Name)
    if "all" not in UserID:
        students=students.filter(UserID=UserID)
    if "all" not in Email:
        students=students.filter(Email=Email)
    context=dict()
    context["students"]=[]
    for student in students:
        temp=dict()
        temp["UserID"]=student.UserID
        temp["UserPassword"]=student.UserPassword
        temp["Name"]=student.Name
        temp["Gender"]="♂ 男" if student.Gender==True else "♀ 女"
        temp["Email"]=student.Email
        context["students"].append(temp)
    return render(request,"manageStudent.html",context)
def modifyStudent(request):
    context=dict()
    context["UserID"]=request.GET.get("UserID",None)
    context["UserPassword"]=request.GET.get("UserPassword",None)
    context["Name"]=request.GET.get("Name",None)
    context["Gender"]=True if "man" in  request.GET.get("Gender",None) else False
    context["Email"]=request.GET.get("Email",None)
    student=UserInfo.objects.filter(UserID=int(context["UserID"])).update(
        UserPassword=context["UserPassword"],
        Name=context["Name"],
        Gender=context["Gender"],
        Email=context["Email"],
    )
    return render(request,"adminIndex.html")

"""
Reservation Information
"""
def judgeReservation(reservation,Year,Month,Day,State,UserID,SeatID):
    matchYear=str(reservation.Date.year)==str(Year)
    matchMonth=str(reservation.Date.month)==str(Month)
    matchDay=str(reservation.Date.day)==str(Day)
    matchState=str(reservation.State)==str(State)
    matchUserID=str(reservation.UserID.UserID)==str(UserID)
    matchSeatID=str(reservation.SeatID.id)==str(SeatID)
    match=True
    if "all" not in Year:
        match=match and matchYear
    if "all" not in Month:
        match=match and matchMonth
    if "all" not in Day:
        match=match and matchDay
    if "all" not in State:
        match=match and matchState
    if "all" not in UserID:
        match=match and matchUserID
    if "all" not in SeatID:
        match=match and matchSeatID
    return match
def manageReservationPage(request):
    Year=request.GET.get("Year",None)
    Month=request.GET.get("Month",None)
    Day=request.GET.get("Day",None)
    State=request.GET.get("State",None)
    UserID=request.GET.get("UserID",None)
    SeatID=request.GET.get("SeatID",None)
    reservations=ReservationInfo.objects.all()
    matchReservations=[]
    for reservation in reservations:
        match=judgeReservation(reservation,Year,Month,Day,State,UserID,SeatID)
        if match==False:
            continue
        matchReservations.append(reservation)
    context=dict()
    context["reservations"]=[]
    print("=> matchReservations的长度：",len(matchReservations))
    for reservation in matchReservations:
        temp=dict()
        temp["UserID"]=reservation.UserID.UserID
        temp["SeatID"]=reservation.SeatID.id
        temp["SeatCampus"]=reservation.SeatID.Campus
        temp["SeatClassroom"]=reservation.SeatID.Classroom
        temp["SeatIndex"]=reservation.SeatID.Index
        temp["Date"]=reservation.Date.strftime("%Y-%m-%d %H:%M")
        temp["Start"]=reservation.Start
        temp["End"]=reservation.End
        temp["State"]=reservation.State
        context["reservations"].append(temp)
    return render(request,"manageReservation.html",context)

