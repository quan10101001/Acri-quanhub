local Library = (Quan.UILibrary == "Linoria" and "LinoriaLib" or "Obsidian")
local BaseUrl = "https://raw.githubusercontent.com/mstudio45/" .. Library .. "/refs/heads/main/"
local QuanUrl = "https://raw.githubusercontent.com/quan10101001-ux/ACRI-QUAN-HUB/refs/heads/main/"

return {
  Library = loadstring(game:HttpGet(BaseUrl .. "Library.lua"))(),
  SaveManager = loadstring(game:HttpGet(BaseUrl .. "addons/SaveManager.lua"))(),
  ThemeManager = loadstring(game:HttpGet(BaseUrl .. "addons/ThemeManager.lua"))(),

  ApplyInfoTab = loadstring(game:HttpGet(QuanUrl .. "Components/InfoTab.luau"))(),
  ApplySettingsTab = loadstring(game:HttpGet(QuanUrl .. "Components/SettingsTab.luau"))()
}
