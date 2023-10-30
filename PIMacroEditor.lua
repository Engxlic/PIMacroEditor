local _, class = UnitClass("player")
local YELLOW_FONT_COLOR_CODE = "|cffffff00"
local YELLOW_FONT_COLOR_CODE_CLOSE = "|r"
local piMacroWARNINGShown = false -- Add this variable to keep track of warning status for PI button
local piVeMacroWARNINGShown = false -- Add this variable to keep track of warning status for PI w/ VE button
local piNoPotMacroWARNINGShown = false -- Add this variable to keep track of warning status for PI w/o Pot button
local playerName = UnitName("player") or "Unknown" -- Get the player's name or use "Unknown" if it's not available
local function OnEvent(self, event, arg1)
    if event == "PLAYER_LOGIN" and class == "PRIEST" then
	-- Create a frame to display the target's name
local targetNameFrame = UIParent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
targetNameFrame:SetPoint("TOPLEFT", 25, -60) -- Adjust the position as needed
targetNameFrame:SetText("No Target")

local isButtonClickable = true

local function UpdateMacro(script, buttonText)
    local targetName = UnitName("target") or "player"
    local _, targetClass = UnitClass("target")
    if not InCombatLockdown() then
        EditMacro(GetMacroIndexByName('PI'), nil, nil, "")
        local updatedScript = string.format(script, targetName)
        EditMacro(GetMacroIndexByName('PI'), nil, nil, updatedScript)
        
if targetName == "player" then
    targetNameFrame:SetText("Target: " .. playerName .. " (" .. buttonText .. ")")
    print("|cffffffff" .. buttonText .. " updated to " .. playerName .. "|r") -- Print in chat in white color
else
    targetNameFrame:SetText("Target: " .. targetName .. " (" .. buttonText .. ")")
    local classColor = "|cffffffff" -- Default color (white) for non-specific targets
    
if targetClass == "DEATHKNIGHT" then
    classColor = "|cffC41E3A" -- Red
elseif targetClass == "DEMONHUNTER" then
    classColor = "|cffA330C9" -- Dark Magenta
elseif targetClass == "DRUID" then
    classColor = "|cffFF7C0A" -- Orange
elseif targetClass == "EVOKER" then
    classColor = "|cff33937F" -- Dark Emerald
elseif targetClass == "HUNTER" then
    classColor = "|cffAAD372" -- Pistachio
elseif targetClass == "MAGE" then
    classColor = "|cff3FC7EB" -- Light Blue
elseif targetClass == "MONK" then
    classColor = "|cff00FF98" -- Spring Green
elseif targetClass == "PALADIN" then
    classColor = "|cffF48CBA" -- Pink
elseif targetClass == "PRIEST" then
    classColor = "|cffFFFFFF" -- White
elseif targetClass == "ROGUE" then
    classColor = "|cffFFF468" -- Yellow
elseif targetClass == "SHAMAN" then
    classColor = "|cff0070DD" -- Blue
elseif targetClass == "WARLOCK" then
    classColor = "|cff8788EE" -- Purple
elseif targetClass == "WARRIOR" then
    classColor = "|cffC69B6D" -- Tan
else
    classColor = "|cffffffff" -- Default color (White) for unknown classes
end
    
    print("" .. buttonText .. " updated to " .. classColor .. targetName .. "|r") -- Print in chat with class-specific color
end

		
        isButtonClickable = false
        C_Timer.After(.1, function()  -- Set a cooldown of .1 seconds
            isButtonClickable = true
        end)
    end
end


-- First Button
local frame1 = CreateFrame("Button", "MyButton1", UIParent, "UIPanelButtonTemplate")
frame1:SetSize(70, 30)
frame1:SetPoint("TOPLEFT", 20, -20)
frame1:SetText("PI")
frame1:SetAlpha(0.25) -- Set initial transparency

frame1:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" and isButtonClickable then
        local macroIndex = GetMacroIndexByName('PI')
        if macroIndex == 0 then
            print("|cffffff00PI macro not found. Create a Macro Named \"PI\"|r") -- Print a yellow message in chat if the "PI" macro is not found
        else
            local _, _, body = GetMacroInfo(macroIndex)
            if body and body ~= "" then
                print("|cffffff00WARNING: PI Macro is not empty!|r") -- Print a yellow warning message if the "PI" macro is not empty
            else
                local script = "#showtooltip\n/cast [@mouseover,help,nodead][@%s] Power Infusion \n/cast Power Infusion\n/use 13\n/use Elemental Potion of Ultimate Power"
                UpdateMacro(script, "PI") -- Update the macro only if it exists and is empty
                piMacroWARNINGShown = true -- Set the warning status to true if the macro is not empty
            end
        end
    end
end)

frame1:SetScript("OnEnter", function(self)
    self:SetAlpha(1.0) -- Set fully visible when hovered
end)

frame1:SetScript("OnLeave", function(self)
    self:SetAlpha(0.25) -- Set back to 25% transparency when not hovered
end)

-- Second Button
local frame2 = CreateFrame("Button", "MyButton2", UIParent, "UIPanelButtonTemplate")
frame2:SetSize(70, 30)
frame2:SetPoint("TOPLEFT", 90, -20) -- Adjust the position as needed
frame2:SetText("PI w/ VE")
frame2:SetAlpha(0.25) -- Set initial transparency

frame2:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" and isButtonClickable then
        local macroIndex = GetMacroIndexByName('PI')
        if macroIndex == 0 then
            print("|cffffff00PI macro not found. Create a Macro Named \"PI\"|r") -- Print a yellow message in chat if the "PI" macro is not found
        else
            local _, _, body = GetMacroInfo(macroIndex)
            if body and body ~= "" then
                print("|cffffff00WARNING: PI Macro is not empty!|r") -- Print a yellow warning message if the "PI" macro is not empty
            else
                local script = "#showtooltip\n/cast [@mouseover,help,nodead][@%s] Power Infusion \n/cast Power Infusion\n/use 13\n/use Elemental Potion of Ultimate Power\n/cast Vampiric Embrace"
                UpdateMacro(script, "PI w/ VE") -- Update the macro only if it exists and is empty
                piVeMacroWARNINGShown = true -- Set the warning status to true if the macro is not empty
            end
        end
    end
end)


frame2:SetScript("OnEnter", function(self)
    self:SetAlpha(1.0) -- Set fully visible when hovered
end)

frame2:SetScript("OnLeave", function(self)
    self:SetAlpha(0.25) -- Set back to 25% transparency when not hovered
end)

-- Create a button for running a specific macro script
local macroButton = CreateFrame("Button", "MyMacroButton", UIParent, "UIPanelButtonTemplate")
macroButton:SetSize(70, 30)
macroButton:SetPoint("TOPLEFT", 160, -20) -- Adjust the position as needed
macroButton:SetText("Clear")
macroButton:SetAlpha(0.25)

macroButton:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
        local macroIndex = GetMacroIndexByName('PI')
        if macroIndex == 0 then
            print("|cffffff00PI macro not found. Create a Macro Named \"PI\"|r") -- Print a yellow message in chat if the "PI" macro is not found
        else
            local _, _, body = GetMacroInfo(macroIndex)
            if body and body ~= "" then
                -- Clear the macro script directly
                local macroScript = "EditMacro(GetMacroIndexByName('PI'), nil, nil, '')"
                RunScript(macroScript)
                print("|cffffff00Cleared current PI target.|r")
                targetNameFrame:SetText("No Target") -- Update targetNameFrame to "No Target"
                -- Put cooldown logic here if needed
            else
                print("|cffffff00PI macro is already empty.|r") -- Print a message if the "PI" macro is already empty
            end
        end
    end
end)
macroButton:SetScript("OnEnter", function(self)
    self:SetAlpha(1.0) -- Set fully visible when hovered
end)

macroButton:SetScript("OnLeave", function(self)
    self:SetAlpha(0.25) -- Set back to 25% transparency when not hovered
end)

-- Modify the OnEnter and OnLeave scripts for the buttons to handle visibility on hover

local function SetButtonStateAndTransparency(button, enabled, alpha)
    button:SetEnabled(enabled)
    button:SetAlpha(alpha)
end

local function SetButtonVisibility(button, visible)
    if visible then
        button:SetAlpha(1.0) -- Set fully visible when hovered
    else
        button:SetAlpha(0.25) -- Set back to 25% transparency when not hovered
    end
end

frame1:SetScript("OnUpdate", function(self, elapsed)
    if InCombatLockdown() then
        SetButtonStateAndTransparency(frame1, false, 0) -- Disable and make transparent during combat
    else
        SetButtonStateAndTransparency(frame1, true, 0.25) -- Enable and set transparency when out of combat
        SetButtonVisibility(frame1, self:IsMouseOver()) -- Handle visibility based on hover state
    end
end)

frame1:SetScript("OnEnter", function(self)
    SetButtonVisibility(frame1, true) -- Set fully visible when hovered
end)

frame1:SetScript("OnLeave", function(self)
    SetButtonVisibility(frame1, false) -- Set back to 25% transparency when not hovered
end)

-- Modify the OnEnter and OnLeave scripts for frame2 and macroButton to handle visibility on hover

frame2:SetScript("OnUpdate", function(self, elapsed)
    if InCombatLockdown() then
        SetButtonStateAndTransparency(frame2, false, 0) -- Disable and make transparent during combat
    else
        SetButtonStateAndTransparency(frame2, true, 0.25) -- Enable and set transparency when out of combat
        SetButtonVisibility(frame2, self:IsMouseOver()) -- Handle visibility based on hover state
    end
end)

frame2:SetScript("OnEnter", function(self)
    SetButtonVisibility(frame2, true) -- Set fully visible when hovered
end)

frame2:SetScript("OnLeave", function(self)
    SetButtonVisibility(frame2, false) -- Set back to 25% transparency when not hovered
end)

-- Fourth Button (without Elemental Potion)
local frame3 = CreateFrame("Button", "MyButton3", UIParent, "UIPanelButtonTemplate")
frame3:SetSize(70, 30)
frame3:SetPoint("TOPLEFT", 230, -20) -- Adjust the position as needed
frame3:SetText("PI w/o Pot")
frame3:SetAlpha(0.25) -- Set initial transparency


frame3:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" and isButtonClickable then
        local macroIndex = GetMacroIndexByName('PI')
		--local currentMacroBody = select(3, GetMacroInfo(macroIndex))
        if macroIndex == 0 then
            print("|cffffff00PI macro not found. Create a Macro Named \"PI\"|r") -- Print a yellow message in chat if the "PI" macro is not found
        else
            local _, _, body = GetMacroInfo(macroIndex)
            if body and body ~= "" then
                print("|cffffff00WARNING: PI Macro is not empty!|r") -- Print a yellow warning message if the "PI" macro is not empty
            else
                local script = "#showtooltip\n/cast [@mouseover,help,nodead][@%s] Power Infusion \n/cast Power Infusion\n/use 13\n/cast Vampiric Embrace"
                UpdateMacro(script, "PI w/o Pot") -- Update the macro only if it exists and is empty
                piVeMacroWARNINGShown = true -- Set the warning status to true if the macro is not empty
            end
        end
    end
end)


frame3:SetScript("OnEnter", function(self)
    self:SetAlpha(1.0) -- Set fully visible when hovered
end)

frame3:SetScript("OnLeave", function(self)
    self:SetAlpha(0.25) -- Set back to 25% transparency when not hovered
end)

frame3:SetScript("OnUpdate", function(self, elapsed)
    if InCombatLockdown() then
        SetButtonStateAndTransparency(frame3, false, 0) -- Disable and make transparent during combat
    else
        SetButtonStateAndTransparency(frame3, true, 0.25) -- Enable and set transparency when out of combat
        SetButtonVisibility(frame3, self:IsMouseOver()) -- Handle visibility based on hover state
    end
end)

frame3:SetScript("OnEnter", function(self)
    SetButtonVisibility(frame3, true) -- Set fully visible when hovered
end)

frame3:SetScript("OnLeave", function(self)
    SetButtonVisibility(frame3, false) -- Set back to 25% transparency when not hovered
end)

macroButton:SetScript("OnUpdate", function(self, elapsed)
    if InCombatLockdown() then
        SetButtonStateAndTransparency(macroButton, false, 0) -- Disable and make transparent during combat
    else
        SetButtonStateAndTransparency(macroButton, true, 0.25) -- Enable and set transparency when out of combat
        SetButtonVisibility(macroButton, self:IsMouseOver()) -- Handle visibility based on hover state
    end
end)
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", OnEvent)

macroButton:SetScript("OnEnter", function(self)
    SetButtonVisibility(macroButton, true) -- Set fully visible when hovered
end)

macroButton:SetScript("OnLeave", function(self)
    SetButtonVisibility(macroButton, false) -- Set back to 25% transparency when not hovered
end)

-- Adjust the font size for targetNameFrame
targetNameFrame:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE") -- Set the font, font size (18 in this case), and outline style

-- Adjust the font size for button texts
frame1:SetText("PI")
frame1:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE") -- Set the font, font size (14 in this case), and outline style for frame1

frame2:SetText("PI w/ VE")
frame2:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE") -- Set the font, font size (14 in this case), and outline style for frame2

macroButton:SetText("Run Macro")
macroButton:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE") -- Set the font, font size (14 in this case), and outline style for macroButton

frame3:SetText("PI w/o Pot")
frame3:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE") -- Set the font, font size (14 in this case), and outline style for frame3




