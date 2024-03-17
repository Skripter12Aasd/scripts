local function debugPrint(...)
    print("[Debug]", ...)
end

local originalEnv = getfenv(0)
local env = {}
setmetatable(env, {
    __index = function(t, k)
        local value = originalEnv[k]
        if type(value) ~= "function" then
            debugPrint("Constant accessed:", k, "=", value)
        else
            debugPrint("Function accessed:", k)
        end
        return value
    end
})

setfenv(1, env)
local function libs()
    local libslua = {
        "math",
        "string",
        "table",
        "coroutine",
        "os",
        "debug",
        "io",
        "utf8"
    }

    for _, libName in ipairs(libslua) do
        local lib = originalEnv[libName]
        if lib then
            for funcName, func in pairs(lib) do
                if type(func) == "function" then
                    debugPrint("Function accessed:", libName .. "." .. funcName)
                end
            end
        end
    end
end

-- Test
libs()
print(math.random)
