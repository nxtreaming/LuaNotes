-- Basic Lua Program Example (Best Practices Version)
-- This program demonstrates Lua's main syntax and features with proper coding practices

print("=== Basic Lua Program Example ===")

print("\n=== Day 1 of 3 days of Lua ===")

-- 1. Basic output
print("Hello, Lua!")
print("Welcome to Lua World!")

-- 2. Variable definition and usage
local name = "John"
local age = 25
local height = 1.75
local isStudent = true
local x = nil

print("\n=== Variable Examples ===")
print("Name: " .. name)
print("Age: " .. age)
print("Height: " .. height .. " meters")
print("Is Student: " .. tostring(isStudent))
if x == nil then
    print("x is nil")
end

-- 3. Function definition (BEST PRACTICE: Use 'local' for functions)
-- This avoids the "Global variable in lowercase initial" warning
local function greet(person)
    return "Hello, " .. person .. "!"
end

local function add(a, b)
    return a + b
end

local function divide(a, b)
    if b == 0 then
        return nil, "Error: Division by zero"
    else
        return a / b, nil
    end
end

-- For recursive functions, declare first, then define
local factorial
factorial = function(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

-- Alternative syntax for local recursive function:
local function factorial2(n)
     if n <= 1 then
         return 1
     else
         return n * factorial2(n - 1)
     end
 end

 local function minmax(a, b)
    if a < b then
        return a, b
    else
        return b, a
    end
end

print("\n=== Function Examples ===")
print(greet(name))
print("5 + 3 = " .. add(5, 3))
print("Factorial of 5 = " .. factorial(5))
print("Factorial of 6 = " .. factorial2(6))

print("\n=== Multi-return example: divide(a, b) ===")
local result, err = divide(10, 2)
if err then
    print(err)
else
    print("10 / 2 = " .. result)
end

result, err = divide(10, 0)
if err then
    print("10 / 0 = " .. err)
else
    print("10 / 0 = " .. result)
end

-- 4. Conditional statements
print("\n=== Conditional Statement Examples ===")
if age >= 18 then
    print(name .. " is an adult")
else
    print(name .. " is a minor")
end

local score = 85
if (score >= 85) then
    print("Score: " .. score .. " - Excellent")
end

-- local grade = "A"
-- type mismatch error: "attempt to compare number with string"
-- if grade >= 90 then
--    print("Grade: A - Excellent")
-- end

if score >= 90 then
    print("Grade: Excellent")
elseif score >= 80 then
    print("Grade: Good")
elseif score >= 70 then
    print("Grade: Average")
else
    print("Grade: Needs Improvement")
end

local min, max = minmax(10, 20)
print("\nMin: " .. min .. ", Max: " .. max)

-- 5. Loop examples
print("\n=== Loop Examples ===")

-- for loop
print("Numbers 1 to 5:")
for i = 1, 5 do
    print("  " .. i)
end

local sum = 0;
for i = 1, 100 do
    if i % 2 == 0 then
        sum = sum + i
    end
end
print("\nSum of even numbers from 1 to 100: " .. sum)

-- repeat-until loop
local k = 10
print("Countdown from 10 to 1:")
repeat
    print(" " .. k)
    k = k - 1
until k < 1

-- while loop
print("Countdown:")
local count = 5
while count > 0 do
    print("  " .. count)
    count = count - 1
end
print("  Launch!")

-- 6. Table usage
print("\n=== Table Examples ===")

-- Array-style table
local fruits = {"Apple", "Banana", "Orange", "Grape"}
print("Fruit list:")
for i, fruit in ipairs(fruits) do
    print("  " .. i .. ". " .. fruit)
end

-- the start index is from 1, not 0
local fruits_count = #fruits
print("\nNumber of fruits: " .. fruits_count)
for i = 1, fruits_count do
    print("  " .. i .. ". " .. fruits[i])
end
if fruits[0] == nil then
    print("The element at index of 0 is nil")
else
    print("The element at index of 0 is: " .. fruits[0])
end

-- Dictionary-style table
local person = {
    name = "Alice",
    age = 30,
    city = "New York",
    hobby = "Programming"
}

print("\nPerson information:")
for key, value in pairs(person) do
    print("  " .. key .. ": " .. value)
end

local keys = {}
for key, _ in pairs(person) do
    table.insert(keys, key)
end
table.sort(keys)

print("\nPerson information after sorting:")
for i = 1, #keys do
    print("  " .. keys[i] .. ": " .. person[keys[i]])
end

-- 7. String operations
print("\n=== String Operation Examples ===")
local text = "Lua Programming Language"
print("Original string: " .. text)
print("String length: " .. string.len(text))
print("Uppercase: " .. string.upper(text))
print("Lowercase: " .. string.lower(text))

-- String formatting
local formatted = string.format("My name is %s, I am %d years old", name, age)
print("Formatted string: " .. formatted)

-- 8. Mathematical operations
print("\n=== Mathematical Operation Examples ===")
local x = 10
local y = 3

if x ~= y then
    print("x is not equal to y")
end

-- true
print(5 > 3 and true or false)

print("x = " .. x .. ", y = " .. y)
print("Addition: " .. x .. " + " .. y .. " = " .. (x + y))
print("Subtraction: " .. x .. " - " .. y .. " = " .. (x - y))
print("Multiplication: " .. x .. " * " .. y .. " = " .. (x * y))
print("Division: " .. x .. " / " .. y .. " = " .. (x / y))
print("Modulo: " .. x .. " % " .. y .. " = " .. (x % y))
print("Exponentiation: " .. x .. " ^ " .. y .. " = " .. (x ^ y))

print("Square root: sqrt(" .. x .. ") = " .. math.sqrt(x))
print("Random number: " .. math.random(1, 100))

local random_arr = {}
for i = 1, 10 do
    random_arr[i] = math.random(1, 100)
end
print("Random array: " .. table.concat(random_arr, ", "))

-- table is reference type
local random_arr2 = random_arr
random_arr2[1] = -1

print("Random array 2: " .. table.concat(random_arr2, ", "))
print("Random array: " .. table.concat(random_arr, ", "))

-- z is nil
print(z)

-- 9. Best practices explanation
print("\n=== Lua Best Practices Demonstrated ===")
print("1. Use 'local' for variables and functions")
print("2. Avoid global variables unless necessary")
print("3. Use meaningful variable names")
print("4. Proper indentation and comments")
print("5. Handle edge cases in functions")

-- 10. Program end
print("\n=== Program End ===")
print("This is a Lua program following best practices.")
print("All functions are declared as 'local' to avoid global namespace pollution.")
print("This eliminates the 'lowercase-global' warning from Lua Language Server.")
