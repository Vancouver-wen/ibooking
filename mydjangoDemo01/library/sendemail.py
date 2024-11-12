def sendemail(Head="自习室管理系统自动邮箱",Context="test Context",ToAddress="your own email address"):
    import smtplib
    from email.mime.text import MIMEText
    from email.header import Header
    # 创建 SMTP 对象
    smtp = smtplib.SMTP()
    # 连接（connect）指定服务器
    smtp.connect("smtp.qq.com", port=587)
    # 构造MIMEText对象，参数为：正文，MIME的subtype，编码方式
    message = MIMEText(Context, 'plain', 'utf-8')
    message['From'] = Header("From Admin <your own email address>")  # 发件人的昵称
    message['To'] = Header("zhwen", 'utf-8')  # 收件人的昵称
    message['Subject'] = Header(Head, 'utf-8')  # 定义主题内容
    print(message)
    # 登录，需要：登录邮箱和授权码
    smtp.login(user="your own email address", password="your own password")
    smtp.sendmail(
        from_addr="your own email address", 
        to_addrs=ToAddress,  
        # to_addrs实际上应当是个list，意味着你可以同时给多个账户发送，
        # 如果是字符串则默认为长度为1的list
        msg=message.as_string()
        )
    smtp.quit()

if __name__== "__main__" :
    Head="自习室管理系统自动邮箱"
    Context="test Context"
    sendemail(Head,Context,ToAddress="your own email address")
