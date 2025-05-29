-- Simple debugging test script
local function factorial(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

print("Calculate factorial")
local result = factorial(5)
print("5! =", result)

local cwd = io.popen("cd"):read("*l")
print("Current directory:", cwd)
print("package.cpath:", package.cpath)

local module_path = cwd .. "\\lua_c_module\\build\\Debug\\?.dll"
package.cpath = package.cpath .. ";" .. module_path

-- Test our C module
local status, mymodule = pcall(require, "myluamodule")
if status then
    print("Module loaded successfully")
    print("Version:", mymodule.version())
    print("2 + 3 =", mymodule.add(2, 3))
    print(mymodule.hello("Debugger"))
else
    print("Module load failed:", mymodule)
end

print("Debugging test completed")