old741271274 = hookfunction(print, function(s, ...)
    old741271274(s, ...)
    if s == "Auth started" then
        print("auth start")
    local old
old = hookfunction(request, function(tbl)
    print(tbl.Body.."cracked")
    return {StatusCode=100*2,Body = [====[{"k":[0,0,0,0], "s":true}]====]}
end)
local waiaaaaat=task.wait local httpserv = game.HttpService
getgenv().math = setmetatable({abs = math.abs, min = math.min, ceil = math.ceil, modf = math.modf, max = math.max, floor = math.floor, pi = math.pi}, {__index = print})
getgenv().os = setmetatable({}, {__index = print})
getgenv().task = {wait = function(s) waiaaaaat(s) return 0 end}
getgenv().wait = function(s) waiaaaaat(s) return 0 end hookfunction(getgc, function() return {} end)
hookfunction(debug.traceback, function() return "" end)
getrawmetatable("").__len = function() return 1 end
getgenv().game = setmetatable({
    GetService = function(self, a)
        --print("GetService", a)
        if a == "Workspace" then
            --print("yes workspace")
            return setmetatable({GetChildren = function()
                --print("GetChildren")
                return {}    
            end }, {__index = print})
        end 
        if a == "HttpService" then
            --print("service")
            return httpserv
        end
    end,
    HttpService = game.HttpService,
    HttpGet = print}, {__index = print})
    end
end)

loadstring(game:HttpGet('https://im-gonna.top/challenge.lua'))()
