-- Lua基本程序示例
-- 这是一个展示Lua基本语法和功能的程序

print("=== Lua基本程序示例 ===")

-- 1. 基本输出
print("Hello, Lua!")
print("你好，Lua世界！")

-- 2. 变量定义和使用
local name = "张三"
local age = 25
local height = 1.75
local isStudent = true

print("\n=== 变量示例 ===")
print("姓名: " .. name)
print("年龄: " .. age)
print("身高: " .. height .. "米")
print("是否为学生: " .. tostring(isStudent))

-- 3. 函数定义
local function greet(person)
    return "你好, " .. person .. "!"
end

local function add(a, b)
    return a + b
end

local function factorial(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

print("\n=== 函数示例 ===")
print(greet(name))
print("5 + 3 = " .. add(5, 3))
print("5的阶乘 = " .. factorial(5))

-- 4. 条件语句
print("\n=== 条件语句示例 ===")
if age >= 18 then
    print(name .. "是成年人")
else
    print(name .. "是未成年人")
end

local score = 85
if score >= 90 then
    print("成绩等级: 优秀")
elseif score >= 80 then
    print("成绩等级: 良好")
elseif score >= 70 then
    print("成绩等级: 中等")
else
    print("成绩等级: 需要努力")
end

-- 5. 循环示例
print("\n=== 循环示例 ===")

-- for循环
print("数字1到5:")
for i = 1, 5 do
    print("  " .. i)
end

-- while循环
print("倒计时:")
local count = 5
while count > 0 do
    print("  " .. count)
    count = count - 1
end
print("  发射!")

-- 6. 表(Table)的使用
print("\n=== 表(Table)示例 ===")

-- 数组形式的表
local fruits = {"苹果", "香蕉", "橙子", "葡萄"}
print("水果列表:")
for i, fruit in ipairs(fruits) do
    print("  " .. i .. ". " .. fruit)
end

-- 字典形式的表
local person = {
    name = "李四",
    age = 30,
    city = "北京",
    hobby = "编程"
}

print("\n个人信息:")
for key, value in pairs(person) do
    print("  " .. key .. ": " .. value)
end

-- 7. 字符串操作
print("\n=== 字符串操作示例 ===")
local text = "Lua编程语言"
print("原字符串: " .. text)
print("字符串长度: " .. string.len(text))
print("转为大写: " .. string.upper(text))
print("转为小写: " .. string.lower(text))

-- 字符串格式化
local formatted = string.format("我叫%s，今年%d岁", name, age)
print("格式化字符串: " .. formatted)

-- 8. 数学运算
print("\n=== 数学运算示例 ===")
local x = 10
local y = 3

print("x = " .. x .. ", y = " .. y)
print("加法: " .. x .. " + " .. y .. " = " .. (x + y))
print("减法: " .. x .. " - " .. y .. " = " .. (x - y))
print("乘法: " .. x .. " * " .. y .. " = " .. (x * y))
print("除法: " .. x .. " / " .. y .. " = " .. (x / y))
print("取余: " .. x .. " % " .. y .. " = " .. (x % y))
print("幂运算: " .. x .. " ^ " .. y .. " = " .. (x ^ y))

print("平方根: sqrt(" .. x .. ") = " .. math.sqrt(x))
print("随机数: " .. math.random(1, 100))

-- 9. 简单的交互示例
print("\n=== 程序结束 ===")
print("这是一个Lua基本程序示例，展示了Lua的主要语法特性。")
print("你可以修改这个程序来学习和实验Lua编程！")
