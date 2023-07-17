"""mydjangoDemo01 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path
import library.views
# 用于 代码测试 和 回忆语法
# import userAdmin.views
# import userStudent.views

urlpatterns = [
    path('admin/', admin.site.urls),
    #和views中的统一页面跳转函数相对应, page/<str:pageName>是restfulURL，<str:pageName>代表地址栏传递的参数
    #比如： http://127.0.0.1:8000/page/test.html
    #这个 pageName 要与 views中的函数参数名称相同

    # jump Page
    path('page/<str:pageName>',library.views.topage),
    path('',library.views.index),
    path('library/distinguishIdentity',library.views.distinguishIdentity),
    path('library/register',library.views.register),
    path("library/userRegister",library.views.userRegister),

    # Admin Index
    path("library/addseatpage",library.views.addSeatPage),
    path("library/addseat",library.views.addSeat),
    path("library/manageSeatPage",library.views.manageSeatPage),
    path("library/modifySeat",library.views.modifySeat),

    path("library/manageStudentPage",library.views.manageStudentPage),
    path("library/modifyStudent",library.views.modifyStudent),

    path("library/manageReservationPage",library.views.manageReservationPage),
    
    ##### Student Index #####
    path("library/reservationPage",library.views.reservationPage),
    path("library/reservation",library.views.reservation),
    path("library/sign",library.views.sign),

    # 用于 代码测试 与 回忆语法
    # path('admin/index',userAdmin.views.register),
    # path('student/index',userStudent.views.testRedirect),
    # path('user/testRender',userStudent.views.testRender),
    # path('user/testTemplate',userStudent.views.testTemplate),
]
