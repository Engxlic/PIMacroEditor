-- Create a frame to display the target's name
local targetNameFrame = UIParent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
targetNameFrame:SetPoint("TOPLEFT", 25, -60) -- Adjust the position as needed
targetNameFrame:SetText("No Target")

local isButtonClickable = true

local function UpdateMacro(script, buttonText)
    local targetName = UnitName("target") or "player"
    if not InCombatLockdown() then
        EditMacro(GetMacroIndexByName('PI'), nil, nil, "")
        local updatedScript = string.format(script, targetName)
        EditMacro(GetMacroIndexByName('PI'), nil, nil, updatedScript)
        
        -- Set the target name to "Angx" if the target is "player"
        if targetName == "player" then
            targetNameFrame:SetText("Target: Angx (" .. buttonText .. ")")
            print(buttonText .. " updated to Angx") -- Print in chat when the target is "player"
        else
            targetNameFrame:SetText("Target: " .. targetName .. " (" .. buttonText .. ")")
            print(buttonText .. " updated to " .. targetName) -- Print in chat when the target is not "player"
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
        -- The script with a placeholder for target's name
        local script = "#showtooltip\n/cast [@mouseover,help,nodead][@%s] Power Infusion \n/cast Power Infusion\n/use 13\n/use Elemental Potion of Ultimate Power"
        UpdateMacro(script, "PI")
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
        -- The script for casting Vampiric Embrace
        local script = "#showtooltip\n/cast [@mouseover,help,nodead][@%s] Power Infusion \n/cast Power Infusion\n/use 13\n/use Elemental Potion of Ultimate Power\n/cast Vampiric Embrace"
        UpdateMacro(script, "PI w/ VE")
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
macroButton:SetText("Run Macro")
macroButton:SetAlpha(0.25)

macroButton:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" and isButtonClickable then
        -- Your macro script here (without the /run)
        local macroScript = "EditMacro(GetMacroIndexByName('PI'), nil, nil, '')"
        -- Execute the macro script using RunScript function
        RunScript(macroScript)
        print("Cleared Current PI Target")
        targetNameFrame:SetText("No Target") -- Update targetNameFrame to "No Target"
        -- Put cooldown logic here if needed
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
        -- The script without the Elemental Potion line
        local script = "#showtooltip\n/cast [@mouseover,help,nodead][@%s] Power Infusion \n/cast Power Infusion\n/use 13\n/cast Vampiric Embrace"
        UpdateMacro(script, "PI w/o Pot")
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




