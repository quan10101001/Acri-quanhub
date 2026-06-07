if Quan then
    return 
end
getgenv().Quan = {}

local GameList = {
  [2440500124] = "Doors"
}

local BaseUrl = "https://raw.githubusercontent.com/quan10101001-ux/ACRI-QUAN-HUB/refs/heads/main/"
getgenv().Quan = {
    Environment = loadstring(game:HttpGet(BaseUrl .. "Components/Environment.luau"))(),
    ESPLibrary = loadstring(game:HttpGet(BaseUrl .. "Components/ESP.luau"))(),
    GmodeFix = loadstring(game:HttpGet(BaseUrl .. "Components/gmodefix.luau"))(),
}

local function CloneReference(Object)
    if Quan and Quan.Environment.cloneref then
        return Quan.Environment.cloneref(Object)
    else
        return Object
    end
end

local Services = setmetatable({}, {
    __index = function(self, Name)
        return CloneReference(game:GetService(Name))
    end
})

if Quan.Environment.writefile and Quan.Environment.readfile then
    if not Quan.Environment.isfile("Quan/UserData.json") then
        local Data = {
            TotalExecutions = 0,
            UILibrary = "Obsidian"
        }
        Quan.Environment.writefile("Quan/UserData.json", Services.HttpService:JSONEncode(Data))
    end

    local UserData = Quan.Environment.readfile("Quan/UserData.json")
    local Decoded = Services.HttpService:JSONDecode(UserData)
    if not Decoded.TotalExecutions then
        Decoded.TotalExecutions = 0    
    end

    Decoded.TotalExecutions = Decoded.TotalExecutions + 1

    if not Decoded.UILibrary then
        Decoded.UILibrary = "Obsidian"
    end

    Quan.TotalExecutions = Decoded.TotalExecutions
    Quan.UILibrary = Decoded.UILibrary

    Quan.Environment.writefile("Quan/UserData.json", Services.HttpService:JSONEncode(Decoded))
end

Quan.Interface = loadstring(game:HttpGet(BaseUrl .. "Components/Interface.luau"))()

local CurrentGame = GameList[game.GameId]
if CurrentGame then
    loadstring(game:HttpGet(BaseUrl .. "Games/" .. CurrentGame .. "/Loader.luau"))()
else
    loadstring(game:HttpGet(BaseUrl .. "Games/Universal/Loader.luau"))()
end
