-- This is a simple Lua script that will be loaded by the C program
print("\n=== Day 3 of 3 days of Lua ===")

-- 1. Error handling
local ok, err = pcall(function()
    error("something wrong")
end)
if not ok then
    print("Error:", err)
end

-- 2. Define a table
local person = {
    name = "John",
    age = 30,
    greeting = function(self)
        print("Hello, my name is " .. self.name .. " and I am " .. self.age .. " years old.")
    end
}

-- Call method
person:greeting()

-- Return a value to C program
return "Script executed successfully"