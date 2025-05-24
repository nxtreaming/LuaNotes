-- Basic Lua Program Example
-- This program demonstrates Lua's main syntax and features

print("=== Basic Lua Program Example ===")

-- 1. Basic output
print("Hello, Lua!")
print("Welcome to Lua World!")

-- 2. Variable definition and usage
local name = "John"
local age = 25
local height = 1.75
local isStudent = true

print("\n=== Variable Examples ===")
print("Name: " .. name)
print("Age: " .. age)
print("Height: " .. height .. " meters")
print("Is Student: " .. tostring(isStudent))

-- 3. Function definition
local function greet(person)
    return "Hello, " .. person .. "!"
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

print("\n=== Function Examples ===")
print(greet(name))
print("5 + 3 = " .. add(5, 3))
print("Factorial of 5 = " .. factorial(5))

-- 4. Conditional statements
print("\n=== Conditional Statement Examples ===")
if age >= 18 then
    print(name .. " is an adult")
else
    print(name .. " is a minor")
end

local score = 85
if score >= 90 then
    print("Grade: Excellent")
elseif score >= 80 then
    print("Grade: Good")
elseif score >= 70 then
    print("Grade: Average")
else
    print("Grade: Needs Improvement")
end

-- 5. Loop examples
print("\n=== Loop Examples ===")

-- for loop
print("Numbers 1 to 5:")
for i = 1, 5 do
    print("  " .. i)
end

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

print("x = " .. x .. ", y = " .. y)
print("Addition: " .. x .. " + " .. y .. " = " .. (x + y))
print("Subtraction: " .. x .. " - " .. y .. " = " .. (x - y))
print("Multiplication: " .. x .. " * " .. y .. " = " .. (x * y))
print("Division: " .. x .. " / " .. y .. " = " .. (x / y))
print("Modulo: " .. x .. " % " .. y .. " = " .. (x % y))
print("Exponentiation: " .. x .. " ^ " .. y .. " = " .. (x ^ y))

print("Square root: sqrt(" .. x .. ") = " .. math.sqrt(x))
print("Random number: " .. math.random(1, 100))

-- 9. Program end
print("\n=== Program End ===")
print("This is a basic Lua program example showing Lua's main syntax features.")
print("You can modify this program to learn and experiment with Lua programming!")
