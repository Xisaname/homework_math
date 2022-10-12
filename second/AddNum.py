def AddNum(a,b):
    return int(a)+int(b)
def AddString(a,b):
    return a+b
InputOne=input("请输入数字1：")
InputTwo=input("请输入数字2：")
print(type(InputOne))
print("AddNumber:"+AddNum(InputOne,InputTwo))
print("AddString:"+AddString(InputOne,InputTwo))