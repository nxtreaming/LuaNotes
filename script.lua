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

-- Call C functions
print("\nCalling C functions from script.lua:")
if c_add then  -- Check if the function exists
    local result = c_add(50, 60)
    print("Result of c_add(50, 60) =", result)
end

if c_hello then
    c_hello("Script user")
end

if mylib then
    print("\nUsing C module from script.lua:")
    local result = mylib.add(70, 80)
    print("Result of mylib.add(70, 80) =", result)
    mylib.hello("Script module user")
end

-- return a value to C program
return "Script executed successfully"
