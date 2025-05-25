print("=== Basic Lua Program Example (Best Practices) ===")

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

-- 2. metatable example
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


