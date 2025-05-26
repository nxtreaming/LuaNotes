local MyModule = {}

function MyModule.add(a, b)
    return a + b
end

function MyModule.subtract(a, b)
    return a - b
end

function MyModule.sayHello()
    print("Hello, World--from MyModule!")
end

return MyModule