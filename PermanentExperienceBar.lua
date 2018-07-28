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
    self.saveData = ZO_SavedVars:New(self.name .. "Data", self.configVersion, nil, self.defaults)
    self:RepairSaveData(self)
    self:Show(self)
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

----------------------
--  Register Events --
----------------------

EVENT_MANAGER:RegisterForEvent(PermanentExperienceBar.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
