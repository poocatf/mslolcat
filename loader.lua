local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

if not getgenv().MSLOLCAT_Loaded then
    getgenv().MSLOLCAT_Loaded = false
end

local supportedGames = {
    [6516141723] = {
        name = "Main Lobby",
        url = "https://raw.githubusercontent.com/poocatf/mslolcat/main/mslolcat.lua"
    },
    [6839171747] = {
        name = "Floor 1",
        url = "https://raw.githubusercontent.com/poocatf/mslolcat/main/maingame.lua"
    },
    [110258689672367] = {
        name = "PreHotel",
        url = "https://raw.githubusercontent.com/poocatf/mslolcat/main/prehotel.lua"
    },
}

local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 5})
end

local function fetchScript(url)
    local success, content = pcall(game.HttpGet, game, url)
    if not success then
        error(string.format("Failed to fetch script from URL: %s", content))
    end
    return content
end

local function main()
    if getgenv().MSLOLCAT_Loaded then
        notify("Already Loaded", "MSLOLCAT is already running!", 3)
        return false
    end

    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    local gameInfo = supportedGames[game.PlaceId]
    local success, error = pcall(function()
        if gameInfo then
            notify("Loading Script", string.format("Loading script for %s...", gameInfo.name), 3)
            local scriptContent = fetchScript(gameInfo.url)
            loadstring(scriptContent)()
            notify("Script Loaded", string.format("Successfully loaded %s script!", gameInfo.name), 3)
        else
            notify("Error", "Game not supported", 3)
        end
    end)
    
    if not success then
        warn("Script Loading Error:", error)
        notify("Script Error", "Failed to load script. Check console for details.")
        return false
    end
    
    getgenv().MSLOLCAT_Loaded = true
    return true
end

return main()
