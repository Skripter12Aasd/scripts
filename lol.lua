local function debugPrint(...)
    print("[Debug]", ...)
end

local function WrapNumber(Value, Name)
    local WrappedNumber = {
        __value = Value
    }
    setmetatable(WrappedNumber, {
        __add = function(self, num)
            local CurrentValue = rawget(self, "__value")
            local Result = CurrentValue + num
            debugPrint(`[{Name}] Added {CurrentValue} + {num} = {Result}`)
            rawset(WrappedNumber, "__value", Result)
            return self
        end,
        __tonumber = function(self)
            return tonumber(rawget(self, "__value")) or 0
        end,
        __tostring = function(self)
            return tostring(rawget(self, "__value"))
        end
    })
    return WrappedNumber
end

local originalEnv = getfenv(debug.info(0, "f"))
local env = {}
local function GetMT(Parent)
    local MT
    MT = {
        __index = function(t, k)
            local value = Parent[k]
            local Type = typeof(value)
            if Type == "function" then
                debugPrint("Function accessed:", k)
                return function(...)
                    debugPrint(k, "was called with:", ...)
                    local Returned = {value(...)}
                    for k, v in next, Returned do
                        if type(v) == "number" then
                            Returned[k] = WrapNumber(v, k)
                        end
                    end
                    return unpack(Returned)
                end
            elseif Type == "table" then
                return setmetatable({}, GetMT(value))
            else
                debugPrint("Constant accessed:", k, "=", value)
            end
            return value
        end
    }
    return MT
end
setmetatable(env, GetMT(originalEnv))

setfenv(debug.info(1, "f"), env)


print(math.random())
