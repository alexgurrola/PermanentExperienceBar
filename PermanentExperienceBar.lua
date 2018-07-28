--------------------------
-- Initialize Variables --
--------------------------

PermanentExperienceBar = {}
PermanentExperienceBar.name = "PermanentExperienceBar"
PermanentExperienceBar.configVersion = 1
PermanentExperienceBar.saveData = {}
PermanentExperienceBar.defaults = {}

---------------------
--  OnAddOnLoaded  --
---------------------

function OnAddOnLoaded(event, addonName)
    if addonName ~= PermanentExperienceBar.name then
        return
    end
    PermanentExperienceBar:Initialize(PermanentExperienceBar)
end

--------------------------
--  Initialize Function --
--------------------------

function PermanentExperienceBar:Initialize(self)
    -- Handle Save Data
    self.saveData = ZO_SavedVars:New(self.name .. "Data", self.configVersion, nil, self.defaults)
    self:RepairSaveData(self)

    -- Show Experience Bar
    self:Show(self)

    -- Listen for Changes
    --ZO_PreHookHandler(ZO_PlayerProgressBar, 'OnUpdate', PermanentExperienceBar.ExperienceBarOnUpdate)

    -- Add the experience bar to the two hud displays so it always shows up
	SCENE_MANAGER:GetScene("hud"):AddFragment(PLAYER_PROGRESS_BAR_FRAGMENT)
	SCENE_MANAGER:GetScene("hudui"):AddFragment(PLAYER_PROGRESS_BAR_FRAGMENT)
	SCENE_MANAGER:GetScene("hud"):AddFragment(PLAYER_PROGRESS_BAR_CURRENT_FRAGMENT)
	SCENE_MANAGER:GetScene("hudui"):AddFragment(PLAYER_PROGRESS_BAR_CURRENT_FRAGMENT)

    -- Add Interactive
    --SCENE_MANAGER:GetScene("interact"):AddFragment(PLAYER_PROGRESS_BAR_FRAGMENT)
	--SCENE_MANAGER:GetScene("interact"):AddFragment(PLAYER_PROGRESS_BAR_CURRENT_FRAGMENT)

    -- Dismiss Initializer
    EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_ADD_ON_LOADED)
end

--------------------
-- Internal Tools --
--------------------

-- allow debugging based on changes
PermanentExperienceBar.debugLog = {}
function PermanentExperienceBar:Debug(self, key, output)
    if output ~= self.debugLog[key] then
        self.debugLog[key] = output
        d(self.name .. "." .. key .. ":", output)
    end
end

function PermanentExperienceBar:RepairSaveData(self)
    for key, value in pairs(self.defaults) do
        if (self.saveData[key] == nil) then
            self.saveData[key] = value
        end
    end
    --[[
    for key, value in pairs(self.defaults.KillSpree) do
        if (self.saveData.KillSpree[key] == nil) then
            self.saveData.KillSpree[key] = value
        end
    end
    ]]
end

------------------------
-- Core Functionality --
------------------------

function PermanentExperienceBar:Show(self)
    ZO_PlayerProgressBar:SetAlpha(1)
end

function PermanentExperienceBar.ExperienceBarOnUpdate()
    PermanentExperienceBar:Show(PermanentExperienceBar)
end

----------------------
--  Register Events --
----------------------

EVENT_MANAGER:RegisterForEvent(PermanentExperienceBar.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)

------------------------
--  Register Commands --
------------------------

SLASH_COMMANDS["/exp"] = PermanentExperienceBar.ExperienceBarOnUpdate
