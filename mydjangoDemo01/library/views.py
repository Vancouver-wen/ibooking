from django.shortcuts import render,redirect,HttpResponse

from .models import *
from .utils import *

from apscheduler.schedulers.background import BackgroundScheduler 
from django_apscheduler.jobstores import DjangoJobStore, register_events, register_job 
import datetime


# Create your views here.
from .apscheduler import initScheduler,seatInit
initScheduler()
seatInit()

# jump Page
from .log2index import topage,index,userRegister,register,distinguishIdentity

# Admin Index 
from .adminIndex import addSeat,addSeatPage,manageSeatPage,modifySeat
from .adminIndex import manageStudentPage,modifyStudent
from .adminIndex import manageReservationPage

# Student Index 
from .studentIndex import reservationPage,reservation,sign
