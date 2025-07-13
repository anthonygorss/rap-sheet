-- Define SavedVariables (declared in .toc)
local defaultOptions = {
    showRespecs = true,
    showLevel = true,
    showHK = true,
    showBosses = true,
    showScore = true,
    includeOption1 = true,
    showBgs = true,
    showCounts = true,
    showInCombat = false
}

-- Initialize settings if missing
RapSheetOptions = RapSheetOptions or {}
for k, v in pairs(defaultOptions) do
    if RapSheetOptions[k] == nil then RapSheetOptions[k] = v end
end


local function CreateCheckbox(parent, label, variable, yOffset)
    local check = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    check:SetPoint("TOPLEFT", 16, yOffset)
    check.Text:SetText(label)
    check:SetChecked(RapSheetOptions[variable])
    check:SetScript("OnClick", function(self)
        RapSheetOptions[variable] = self:GetChecked()
    end)
    return check
end

local function CreateSectionLabel(parent, label, yOffset)
    local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, yOffset)
    title:SetText(label)
end

-- Main Panel
local panel = CreateFrame("Frame", "RapSheetOptionsPanel", UIParent)
panel.name = "Rap Sheet"

panel:SetScript("OnShow", function(self)
    -- Clear existing children for refresh
    for i = 1, select("#", self:GetChildren()) do
        local child = select(i, self:GetChildren())
        if child and child:IsObjectType("CheckButton") then
            child:Hide()
        end
    end

    local y = -10

    CreateSectionLabel(self, "Mouseover View (Option 1)", y)
    y = y - 30
    y = y - 30; CreateCheckbox(self, "Show Respecs", "showRespecs", y)
    y = y - 30; CreateCheckbox(self, "Show Level", "showLevel", y)
    y = y - 30; CreateCheckbox(self, "Show Honor Kills", "showHK", y)
    y = y - 30; CreateCheckbox(self, "Show Boss Kills", "showBosses", y)

    y = y - 40
    CreateSectionLabel(self, "Ctrl + Mouseover (Option 2)", y)
    y = y - 30
    y = y - 30; CreateCheckbox(self, "Show Arena Info", "showScore", y)
    y = y - 30; CreateCheckbox(self, "Include Option 1 Stats", "includeOption1", y)
    y = y - 30; CreateCheckbox(self, "Show Battleground Info", "showBgs", y)
    y = y - 30; CreateCheckbox(self, "Show Kill Counts", "showCounts", y)

    y = y - 40
    CreateSectionLabel(self, "Global Settings", y)
    y = y - 30
    CreateCheckbox(self, "Show While In Combat", "showInCombat", y)
end)

local purgeButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
purgeButton:SetSize(160, 24)
purgeButton:SetText("Purge Cache")
purgeButton:SetPoint("BOTTOMLEFT", 16, 16)
purgeButton:SetScript("OnClick", function()
    RapSheetCache = {}
    print("|cFF00FF00[Rap Sheet]|r Cache purged.")
end)


InterfaceOptions_AddCategory(panel)

-- Slash support

SlashCmdList["RAPSHEET"] = function(msg)
    local key, val = msg:match("^(%S+)%s*(%S*)$")

    if not key or key == "" or key == "open" then
        InterfaceOptionsFrame_OpenToCategory(RapSheetOptionsPanel)
        InterfaceOptionsFrame_OpenToCategory(RapSheetOptionsPanel)
        print("|cFF00FF00[Rap Sheet]|r Options panel opened.")
        return
    end

    if key == "help" then
        printHelp()
        return
    end

    if key == "reset" then
        for k, v in pairs(defaultOptions) do
            RapSheetOptions[k] = v
        end
        print("|cFF00FF00[Rap Sheet]|r All settings reset to default.")
        return
    end

    key = key:lower()

    if RapSheetOptions[key] == nil then
        print("|cffff0000Invalid option:|r '" .. key .. "'")
        print("Type |cffffff00/rapsheet help|r for a list of valid options.")
        return
    end

    if val == "" then
        print(string.format("|cFF00FF00[Rap Sheet]|r %s is currently: %s", key, tostring(RapSheetOptions[key])))
        print("Use |cffffff00/rapsheet " .. key .. " true|r or |cffffff00false|r to update it.")
        return
    end

    local value
    if val == "true" then
        value = true
    elseif val == "false" then
        value = false
    else
        print("|cffff0000Invalid value:|r " .. val .. " (use true/false)")
        return
    end

    RapSheetOptions[key] = value
    print(string.format("|cFF00FF00[Rap Sheet]|r %s set to: %s", key, tostring(value)))
end
