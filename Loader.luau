if Abysall then
    return 
end
getgenv().Abysall = {}

local GameList = {
  [2440500124] = "Doors"
}

local BaseUrl = "https://raw.githubusercontent.com/bocaj111004/Abysall/refs/heads/main/"
getgenv().Abysall = {
    Environment = loadstring(game:HttpGet(BaseUrl .. "Components/Environment.luau"))(),
    ESPLibrary = loadstring(game:HttpGet(BaseUrl .. "Components/ESP.luau"))(),
    Interface = loadstring(game:HttpGet(BaseUrl .. "Components/Interface.luau"))(),
}

local function CloneReference(Object)
    if Abysall and Abysall.Environment.cloneref then
        return Abysall.Environment.cloneref(Object)
    else
        return Object
    end
end

local Services = setmetatable({}, {
    __index = function(self, Name)
        return CloneReference(game:GetService(Name))
    end
})

if Abysall.Environment.writefile and Abysall.Environment.readfile then
    if not Abysall.Environment.isfile("Abysall/UserData.json") then
        local Data = {
            TotalExecutions = 0
        }
        Abysall.Environment.writefile("Abysall/UserData.json", Services.HttpService:JSONEncode(Data))
    end

    local UserData = Abysall.Environment.readfile("Abysall/UserData.json")
    local Decoded = Services.HttpService:JSONDecode(UserData)
    Decoded.TotalExecutions = Decoded.TotalExecutions + 1
    Abysall.TotalExecutions = Decoded.TotalExecutions

    Abysall.Environment.writefile("Abysall/UserData.json", Services.HttpService:JSONEncode(Decoded))
end

loadstring(game:HttpGet(BaseUrl .. "Components/Analytics.luau"))()
local Success, Result = pcall(function()
    local Game = GameList[game.GameId]
    if Game then
        loadstring(game:HttpGet(BaseUrl .. "Games/" .. Game .. "/Loader.luau"))()
    end
end)
