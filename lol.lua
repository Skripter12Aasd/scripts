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
            -- Attempt to get the function name if available
            local functionName = debug.getinfo(value, "n").name
            if functionName then
                debugPrint("Function accessed:", functionName)
            else
                debugPrint("Function accessed: (Unknown)")
            end
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
        local lib = _G[libName]
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
