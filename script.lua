-- This is a simple Lua script that will be loaded by the C program
print("This message is from script.lua")

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