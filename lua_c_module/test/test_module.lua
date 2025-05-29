-- Test script for myluamodule

-- Try to load the module
local status, mymodule = pcall(require, "myluamodule")

if not status then
    print("Failed to load module: " .. mymodule)
    print("Make sure the module is in the Lua package.path or package.cpath")
    print("Current package.cpath: " .. package.cpath)
    os.exit(1)
end

print("Module loaded successfully!")

-- Test version function
print("Module version: " .. mymodule.version())

-- Test add function
local sum = mymodule.add(10, 20)
print("10 + 20 = " .. sum)

-- Test multiply function
local product = mymodule.multiply(10, 20)
print("10 * 20 = " .. product)

-- Test hello function
local greeting = mymodule.hello("Lua User")
print(greeting)

print("All tests completed successfully!")