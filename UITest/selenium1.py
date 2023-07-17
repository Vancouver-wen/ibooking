from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
import time
from selenium.webdriver.support.wait import WebDriverWait
from random import randint

def test_eight_components():
    driver = webdriver.Chrome()

    driver.get("https://www.selenium.dev/selenium/web/web-form.html")

    title = driver.title
    assert title == "Web form"

    driver.implicitly_wait(0.5)

    text_box = driver.find_element(by=By.NAME, value="my-text")
    submit_button = driver.find_element(by=By.CSS_SELECTOR, value="button")

    text_box.send_keys("Selenium")
    submit_button.click()

    message = driver.find_element(by=By.ID, value="message")
    value = message.text
    assert value == "Received!"

    driver.quit()

def highlight(element):
    """Highlights (blinks) a Selenium Webdriver element"""
    driver = element._parent
    def apply_style(s):
        driver.execute_script("arguments[0].setAttribute('style', arguments[1]);",
                              element, s)
    original_style = element.get_attribute('style')
    apply_style("background: yellow; border: 2px solid red;")
    time.sleep(.3)
    apply_style(original_style)

def Admin_Login_Test():
    print("--管理员登录测试开始--")
    driver = webdriver.Chrome()

    driver.get("http://127.0.0.1:8000/")

    title = driver.title
    assert title == "自习室预约系统"

    useracc  = driver.find_element(by=By.NAME, value="userAcc").send_keys("admin")
    userpass = driver.find_element(by=By.NAME, value="userPass").send_keys("123456")

    i = len(driver.find_elements(by = By.CSS_SELECTOR, value="input[type='text']"))
    assert i == 1

    #time.sleep(3)

    submit = driver.find_element(by = By.CSS_SELECTOR, value="input[type='submit']")

    submit.click()
    driver.implicitly_wait(0.5)

    message = driver.find_elements(by=By.TAG_NAME,value='h2')[0].text

    print(message)

    assert message == "欢迎管理员admin登录!"
    driver.quit()
    print("--管理员登录测试通过--")


def User_register_test():
    print("--注册测试开始--")
    driver = webdriver.Chrome()

    driver.get("http://127.0.0.1:8000/page/register.html")

    userInfo = randint(100000000, 999999999)

    print(userInfo)

    userAcc = driver.find_element(by=By.NAME,value="userAcc").send_keys(userInfo)
    userpass = driver.find_element(by=By.NAME, value="userPass").send_keys("123456")
    userName = driver.find_element(by=By.NAME, value="userName").send_keys("test")
    genders = driver.find_elements(by=By.NAME, value="userGender")
    for gender in genders:
        if gender.text == "男":
            gender.click()
    userEmail = driver.find_element(by=By.NAME, value="userEmail").send_keys(str(userInfo) + "@qq.com")

    time.sleep(3)

    submit = driver.find_element(by=By.CSS_SELECTOR, value="input[type='submit']").click()

    #------------------------

    driver.implicitly_wait(2)



    title = driver.title
    assert title == "自习室预约系统"

    useracc  = driver.find_element(by=By.NAME, value="userAcc").send_keys(str(userInfo))
    userpass = driver.find_element(by=By.NAME, value="userPass").send_keys("123456")

    i = len(driver.find_elements(by = By.CSS_SELECTOR, value="input[type='text']"))
    assert i == 1


    submit = driver.find_element(by = By.CSS_SELECTOR, value="input[type='submit']")

    submit.click()
    driver.implicitly_wait(0.5)

    message = driver.find_elements(by=By.TAG_NAME,value='h2')[0].text

    print(message)

    assert message == "欢迎" + str(userInfo) + "登录!"
    driver.quit()
    print("--注册测试通过--")

def search_test():
    print("--管理员检索测试开始--")
    driver = webdriver.Chrome()

    driver.get("http://127.0.0.1:8000/")

    title = driver.title
    assert title == "自习室预约系统"

    useracc  = driver.find_element(by=By.NAME, value="userAcc").send_keys("admin")
    userpass = driver.find_element(by=By.NAME, value="userPass").send_keys("123456")

    i = len(driver.find_elements(by = By.CSS_SELECTOR, value="input[type='text']"))
    assert i == 1

    #time.sleep(3)

    submit = driver.find_element(by = By.CSS_SELECTOR, value="input[type='submit']")

    submit.click()
    driver.implicitly_wait(0.5)

    campus = Select(driver.find_element(by=By.NAME, value="Campus"))
    campus.select_by_value("江湾校区")
    #Campus
    submit = driver.find_elements(by=By.CSS_SELECTOR, value="input[type='submit']")[0].click()

    campus = Select(driver.find_element(by=By.NAME, value="Campus"))
    print(campus.first_selected_option.text)
    assert campus.first_selected_option.text == "江湾校区"

    print("--管理员检索测试完成--")
    driver.quit()

def student_book_test():
    print("--学生预约测试开始--")
    driver = webdriver.Chrome()

    driver.get("http://127.0.0.1:8000/")

    title = driver.title
    assert title == "自习室预约系统"

    useracc = driver.find_element(by=By.NAME, value="userAcc").send_keys("22210240181")
    userpass = driver.find_element(by=By.NAME, value="userPass").send_keys("123456")

    i = len(driver.find_elements(by=By.CSS_SELECTOR, value="input[type='text']"))
    assert i == 1

    # time.sleep(3)

    submit = driver.find_element(by=By.CSS_SELECTOR, value="input[type='submit']")

    submit.click()
    driver.implicitly_wait(0.5)

    Campus = Select(driver.find_element(by=By.NAME, value="Campus"))
    Campus.select_by_value("江湾校区")
    submit = driver.find_element(by=By.CSS_SELECTOR, value="input[type='submit']").click()

    starts = driver.find_elements(by=By.NAME, value="Start")
    start = starts[0]
    start.clear()
    start.send_keys(19)

    ends = driver.find_elements(by=By.NAME, value="End")
    end = ends[0]
    end.clear()
    end.send_keys(20)

    submits = driver.find_elements(by=By.CSS_SELECTOR, value="input[type='submit']")

    time.sleep(3)

    submit = submits[0].click()

    driver.implicitly_wait(2)

    table = driver.find_elements(by=By.TAG_NAME,value='table')[0]

    highlight(table)

    line = table.find_elements(by=By.TAG_NAME, value='tr')[-1]
    highlight(line)
    col = line.find_elements(by=By.TAG_NAME, value='td')[2]
    highlight(col)
    #values = col.find_element(by=By.TAG_NAME, value='value')
    print(col.accessible_name)
    #print(col.text)

    assert col.accessible_name == "江湾校区"


    #highlight(submit)
    time.sleep(3)

    print("--学生预约测试完成--")

    driver.quit()



if __name__ == '__main__':
    Admin_Login_Test()
    #search_test()
    #student_book_test()