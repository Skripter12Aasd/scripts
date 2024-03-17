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
            debugPrint("Function accessed:", env.funcNames[tostring(value)])
        end
        return value
    end
})

setfenv(1, env)

-- Define a table to hold function names
env.funcNames = {
    ["function: 0x8aad42d4fed4942e"] = "math.random",
    -- Add other function names as needed
}

-- Define your libraries
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
