-- This is a simple Lua script that will be loaded by the C program
print("\n=== Day 3 of 3 days of Lua ===")

-- define a table
local person = {
    name = "John",
    age = 30,
    greeting = function(self)
        print("Hello, my name is " .. self.name .. " and I am " .. self.age .. " years old.")
    end
}

-- call method
person:greeting()

-- return a value to C program
return "Script executed successfully"