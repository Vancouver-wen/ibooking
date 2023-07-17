# python mydjangoDemo01/manage.py  test mydjangoDemo01 library

from django.test import TestCase

# Create your tests here.
def test_getInformationOption():
    # 检查context可用的键
    from .log2index import getInformationOption
    context=getInformationOption()
    keys=context.keys()
    print("=> login页面获取的信息:",keys)

def test_startend2mask():
    from .adminIndex import startend2mask
    start=9
    end=11
    mask="00000000011100000000000000"
    mask_lab=startend2mask(start,end)
    if mask_lab==mask:
        print("=> startend2mask函数通过测试")
    else:
        print("=> 请重新检查startend2mask函数")
def test_mask2startend():
    from .adminIndex import mask2startend
    start=9
    end=11
    mask="00000000011100000000000000"
    start_lab,end_lab=mask2startend(mask)
    if start_lab==start and end_lab==end:
        print("=> mask2startend函数通过测试")
    else:
        print("=> 请重新检查mask2startend函数")

def test_human_read_accessable():
    from .studentIndex import human_read_accessable
    accessable=['9','10','11','13','14','15','20']
    h_accessable=str([[9,11],[13,15],[20,20]])
    pre_accessable=human_read_accessable(accessable)
    if h_accessable==pre_accessable:
        print("=> test_human_read_accessable函数通过测试")
    else:
        print("=> 请重新检查test_human_read_accessable函数")

def test_seatAvailable():
    from .studentIndex import seatAvailable
    Mask="00000000011100000000000000"
    Used="00000000011100000000000000"
    Start=10
    End=15
    available=False
    pre_available=seatAvailable(Mask,Used,Start,End)
    if pre_available==available:
        print("=> seatAvailable函数通过测试")
    else:
        print("=> 请重新检查seatAvailable函数")

def main():
    test_getInformationOption()
    test_startend2mask()
    test_mask2startend()
    test_human_read_accessable()
    test_seatAvailable()


print("=> 开始测试 library app ..")
main()