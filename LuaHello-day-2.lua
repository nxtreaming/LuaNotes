print("=== Basic Lua Program Example ===")

print("\n=== Day 2 of 3 days of Lua ===")

-- 1. Closure
local function createCounter()
    local count = 0
    return function()
        count = count + 1
        return count
    end
end

local function createCounter2(start_value)
    local count = start_value
    return function(step)
        count = count + step
        return count
    end
end

print("\n=== Closure Example ===")
local counter = createCounter()
local counter2 = createCounter()

print(counter())  -- Output: 1
print(counter())  -- Output: 2

print(counter2())  -- Output: 1

local counter3 = createCounter2(10)
print(counter3(3))  -- Output: 13
print(counter3(5))  -- Output: 18

local function map(a, func)
    local result = {}
    for i, v in ipairs(a) do
        result[i] = func(v)
    end
    return result
end

print("\n=== Map Example ===")
local numbers = {1, 2, 3, 4, 5}
local squaredNumbers = map(numbers, function(x) return x * x end)
for i, v in ipairs(squaredNumbers) do
    print(v)
end

-- 2. Metatable example
local function createPoint(x, y)
    local point = {x = x, y = y}

    local mt = {
        __add = function(p1, p2)
            return createPoint(p1.x + p2.x, p1.y + p2.y)
        end,
        __tostring = function(p)
            return "(" .. p.x .. ", " .. p.y .. ")"
        end,
        __mul = function(p1, p2)
            return createPoint(p1.x * p2.x, p1.y * p2.y)
        end,
        distance = function(p1, p2)
            return math.sqrt((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2)
        end
    }

    function point:distance(other)
        -- return mt.distance(self, other)
        return math.sqrt((self.x - other.x) ^ 2 + (self.y - other.y) ^ 2)
    end

    setmetatable(point, mt)
    return point
end

print("\n=== Metatable Example ===")
local p1 = createPoint(1, 2)
local p2 = createPoint(3, 4)
local p3 = p1 + p2
print(p3)  -- Output: (4, 6)

local mt = getmetatable(p1)
print("Distance p1 to p2: " .. mt.distance(p1, p2))
print("Distance p2 to p1: " .. mt.distance(p2, p1))
print("Distance p1 to p2: " .. p1:distance(p2))

local function createPoint2(x, y)
    local point = {x = x, y = y}

    local mt = {}
    function mt.__add(p1, p2)
        return createPoint2(p1.x + p2.x, p1.y + p2.y)
    end
    function mt.__tostring(p)
        return "(" .. p.x .. ", " .. p.y .. ")"
    end
    function mt.__mul(p1, p2)
        return createPoint2(p1.x * p2.x, p1.y * p2.y)
    end

    setmetatable(point, mt)

    return point
end

local point2_1 = createPoint2(3, 4)
local point2_2 = createPoint2(5, 6)
local point2_3 = point2_1 + point2_2
print(point2_3)  -- Output: (8, 10)

-- Inherits of tables
local Animal = { sound = "..." }
function Animal:speak() 
    print(self.sound)
end

local Dog = {sound = "Woof!"}
setmetatable(Dog, {__index = Animal})

print("\n=== Inheritance Example ===")
local dog = Dog
dog:speak()  -- Output: Woof!

-- Module example
print("\n=== Module Example ===")
local m = require("MyModule")
print(m.add(1, 2))
print(m.subtract(1, 2))
m.sayHello()

-- Print and setup the package.path
print("\n=== package.path ===")
print(package.path)

-- OOP example
local Person  = { }
Person.__index = Person

function Person:new(name, age)
    local person = setmetatable({}, self)
    -- local person = {}
    person.name = name
    person.age = age
    return person
end

function Person:sayHello()
    print("Hello, my name is " .. self.name .. " and I am " .. self.age .. " years old.")
end

print("\n=== OOP Example ===")
local person = Person:new("John", 25)
person:sayHello()

local Student = {}
Student.__index = Student
setmetatable(Student, {__index = Person})

function Student:new(name, age, school)
    local s = Person.new(self, name, age)
    -- the following code is not needed
    -- setmetatable(s, self)
    s.school = school
    return s
end

-- function Student.sayHello(self)
function Student:sayHello()
        print("Hello, my name is " .. self.name .. " and I am " .. self.age .. " years old. I study in " .. self.school .. ".")
end

print("\n=== OOP Inheritance Example-2 ===")
local student = Student:new("John", 25, "MIT")
student:sayHello()

-- tryout-1 : implement complex number, and support addition and tostring

local Complex = {}
Complex.__index = Complex

function Complex:new(real, imag)
    local c = setmetatable({}, self)
    c.real = real
    c.imag = imag
    return c
end

function Complex:__add(other)
    return Complex:new(self.real + other.real, self.imag + other.imag)
end

function Complex:__tostring()
    return self.real .. " + " .. self.imag .. "i"
end 

print("\n=== Complex Number Example ===")
local c1 = Complex:new(1, 2)
local c2 = Complex:new(3, 4)
local c3 = c1 + c2
print(c3)

-- implement an Animal class and Dog, Cat classes, and verify the polymorphism
local NewAnimal = {type = "Generic animal", sound = "..."}
NewAnimal.__index = NewAnimal

function NewAnimal:new(type, sound)
    local animal = setmetatable({}, self)
    animal.type = type
    animal.sound = sound
    return animal
end

function NewAnimal:speak()
    print("I am a " .. self.type .. " and I say " .. self.sound)
end

local Dog = {type = "Dog", sound = "Woof!"}
Dog.__index = Dog
setmetatable(Dog, {__index = NewAnimal})

function Dog:speak2()
    print("I am a " .. self.type .. " and I say " .. self.sound .. " " .. self.sound)
end

local Cat = {type = "Cat", sound = "Meow!"}
Cat.__index = Cat
setmetatable(Cat, {__index = NewAnimal})

print("\n=== Animal Example ===")
local dog = Dog:new("Dog", "Woof!")
local cat = Cat:new("Cat", "Meow!")
dog:speak()
dog:speak2()
cat:speak()
