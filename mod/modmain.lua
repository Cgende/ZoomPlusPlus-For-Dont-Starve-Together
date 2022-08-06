-- Welcome to my Zoom++ mod. I imagine you're here because this mod broke, or your trying to make a mod of your own.
-- In either case, good luck. I've tried to heavily comment this code to make it easier to understand. If you have any questions
-- or suggestions feel free to contact me on steam.

-- -------------------------------------------------- Zoom -------------------------------------------------------------
-- This function is applied 'post construct' to Klei's code for the camera located at
-- "Don't Starve Together\data\databundles\scripts.zip\scripts\cameras\followcamera.lua"
--
-- This sets the max and min distances, to increase zoom range, and the max and min pitches (Camera angles).
local function updateZoom(inst)
    -- Grab the SetDefault method from Klei's FollowCamera class
    inst.SetDefaultOriginal = inst.SetDefault
    -- Overwrite the SetDefault method with our new function
    inst.SetDefault = function(self, inst)
        -- Call the original SetDefault method from Klei's FollowCamera class
        self:SetDefaultOriginal(inst)
        -- Then, apply are changes from the configuration menu to these values
        self.mindist = GetModConfigData("minCameraDistance")
        self.maxdist = GetModConfigData("maxCameraDistance")

        self.mindistpitch = GetModConfigData("minDistancePitch")
        self.maxdistpitch = GetModConfigData("maxDistancePitch")

        self.zoomstep = GetModConfigData("zoomStep")
        self.fov = GetModConfigData("fov")
    end
end
-- Applies our updateZoom function to Klei's FollowCamera class
AddGlobalClassPostConstruct("cameras/followcamera", "FollowCamera", updateZoom)
-- ------------------------------------------------- Clouds ------------------------------------------------------------
-- This function is applied 'post construct' to Klei's code for the hud clouds located at
-- "Don't Starve Together\data\databundles\scripts.zip\scripts\screens\playerhud.lua"
--
-- This disables the clouds and the 'push down' effect they have on the camera by deleting the UpdateClouds method of
-- Klei's PlayerHud class
local function removeClouds(inst)
    -- Set klei's UpdateClouds method to an empty function that does nothing
    inst.UpdateClouds = function()
    end
end
-- If disabled is chosen in mod configuration
if GetModConfigData("clouds") == "Disabled" then
    -- Applies our removeClouds function to Klei's PlayerHud class
    AddGlobalClassPostConstruct("screens/playerhud", "PlayerHud", removeClouds)
end

-- -------------------------------------------- Knobbly Tree Leaves ----------------------------------------------------
-- This function is applied 'post construct' to Klei's code for the knobbly tree leaf Canopy located at
-- "Don't Starve Together\data\databundles\scripts.zip\scripts\widgets\leaafcanopy.lua"
--
-- This solves the issue of the leaves coming too far down the screen when the max zoom distance is increased.
-- Before the code for applying the y position of the leaves on the screen is ran, we set the camera distance to
-- a much smaller value. Then, we set it back so the player doesn't notice.
local function fixLeaves(inst)
    -- Grab the OnUpdate method from Klei's Leafcanopy class
    inst.OnUpdateOriginal = inst.OnUpdate
    -- Overwrite the OnUpdate method with our new function
    inst.OnUpdate = function(self, inst)
        -- Store the current camera distance
        local realDistance = GLOBAL.TheCamera.distance
        -- Cap the camera distance at 35 to trick the game to drawing the leaves higher on the screen
        GLOBAL.TheCamera.distance = math.min(35, GLOBAL.TheCamera.distance)
        -- Call the original OnUpdate method from Klei's Leafcanopy class
        self:OnUpdateOriginal(inst)
        -- Set the camera distance back to our stored value, so the player doesn't see any change to the zoom
        GLOBAL.TheCamera.distance = realDistance
    end
end
-- Applies our fixLeaves function to Klei's leafcanopy class
AddGlobalClassPostConstruct("widgets/leafcanopy", "Leafcanopy", fixLeaves)

-- This function is applied 'post construct' to Klei's code for the knobbly tree leaf Canopy located at
-- "Don't Starve Together\data\databundles\scripts.zip\scripts\widgets\leaafcanopy.lua"
--
-- This disables the leaves.
-- Before the code for applying the y position of the leaves on the screen is ran, we set the camera distance to
-- a much smaller value. Then, we set it back so the player doesn't notice.
--
-- This doesn't exactly fit the theme of the mod, but I had to mess around with the leaves to fix issue described above
-- anyways, so i figured why not.
local function removeLeaves(inst)
    -- Overwrite the OnUpdate method with our new function
    inst.OnUpdate = function(self, inst)
        -- Store the current camera distance
        local realDistance = GLOBAL.TheCamera.distance
        -- Set the camera distance to -5 to trick the game to drawing the leaves so high they are off the screen
        GLOBAL.TheCamera.distance = -5
        -- Call the original OnUpdate method from Klei's Leafcanopy class
        self:OnUpdateOriginal(inst)
        -- Set the camera distance back to our stored value, so the player doesn't see any change to the zoom
        GLOBAL.TheCamera.distance = realDistance
    end
end
-- If disabled is chosen in mod configuration
if GetModConfigData("knobblyTreeLeaves") == "Disabled" then
    -- Applies our removeLeaves function to Klei's leafcanopy class
    AddGlobalClassPostConstruct("widgets/leafcanopy", "Leafcanopy", removeLeaves)
end


-- -------------------------------------------- FOV/PITCH Hotkeys ------------------------------------------------------
-- Target Fov and pitch that get changed when the hotkeys are pressed
local fovTarget = GetModConfigData("fov")
local pitchTarget = 30

-- Functions to increase/decrease Fov/pitch targets. Called by the button handlers
local function increaseFov()
    fovTarget = math.min(179, fovTarget + (1))
    GLOBAL.ThePlayer.components.talker:Say("FOV: "..tostring(fovTarget))
end

local function decreaseFov()
    fovTarget = math.max(1, fovTarget - (1))
    GLOBAL.ThePlayer.components.talker:Say("FOV: "..tostring(fovTarget))
end
local function increasePitch()
    pitchTarget = math.min(180, pitchTarget + (1))
    GLOBAL.ThePlayer.components.talker:Say("PITCH: "..tostring(pitchTarget))
end

local function decreaseDecrease()
    pitchTarget = math.max(0, pitchTarget - (1))
    GLOBAL.ThePlayer.components.talker:Say("PITCH: "..tostring(pitchTarget))
end

-- linear interpolation function for smooth transition of fov and pitch
local function lerp(lower, upper, t)
    return t > 1 and upper
            or (t < 0 and lower
            or lower * (1 - t) + upper * t)
end

-- Only enable pitch adjustment if a key is bound
local pitchAdjustmentEnabled = (GetModConfigData("- Pitch Keybind") ~= 'Disabled')
pitchAdjustmentEnabled = pitchAdjustmentEnabled or (GetModConfigData("+ Pitch Keybind") ~= 'Disabled')
-- After the Update function is run, set fov and pitch smoothly based on fov target
local function updateFovAndPitch(inst)
    local lastPitch = 30
    inst.UpdateOriginal = inst.Update
    inst.Update = function(self, dt, dontupdatepos)
        self:UpdateOriginal(dt, dontupdatepos)

        self.fov = math.abs(self.fov - fovTarget) > .01 and
                lerp(self.fov, fovTarget, dt) or
                fovTarget

        if pitchAdjustmentEnabled then
            self.pitch = math.abs(lastPitch - pitchTarget) > .01 and
                    lerp(lastPitch, pitchTarget, dt) or
                    pitchTarget
            lastPitch = self.pitch

            -- Calling these might cause some lag, could just copy the whole .Update function here instead and only call once
            self:onupdatefn(dt)
            self:Apply()
            self:UpdateListeners(dt)
        end
    end
end

AddGlobalClassPostConstruct("cameras/followcamera", "FollowCamera", updateFovAndPitch)

-- hotkey handlers
local function getKeyFromConfig(config)
    if config == 'KEY_F1' then
        return GLOBAL.KEY_F1
    end
    if config == 'KEY_F2' then
        return GLOBAL.KEY_F2
    end
    if config == 'KEY_F3' then
        return GLOBAL.KEY_F3
    end
    if config == 'KEY_F4' then
        return GLOBAL.KEY_F4
    end
    if config == 'KEY_F5' then
        return GLOBAL.KEY_F5
    end
    if config == 'KEY_F6' then
        return GLOBAL.KEY_F6
    end
    if config == 'KEY_F7' then
        return GLOBAL.KEY_F7
    end
    if config == 'KEY_F8' then
        return GLOBAL.KEY_F8
    end
    if config == 'KEY_F9' then
        return GLOBAL.KEY_F9
    end
    if config == 'KEY_F10' then
        return GLOBAL.KEY_F10
    end
    if config == 'KEY_F11' then
        return GLOBAL.KEY_F11
    end
    if config == 'KEY_F12' then
        return GLOBAL.KEY_F12
    end
end

if GetModConfigData("+ FOV Keybind") ~= 'Disabled' then
    GLOBAL.TheInput:AddKeyDownHandler(getKeyFromConfig(GetModConfigData("+ FOV Keybind")), increaseFov)
end

if GetModConfigData("- FOV Keybind") ~= 'Disabled' then
    GLOBAL.TheInput:AddKeyDownHandler(getKeyFromConfig(GetModConfigData("- FOV Keybind")), decreaseFov)
end

if GetModConfigData("+ Pitch Keybind") ~= 'Disabled' then
    GLOBAL.TheInput:AddKeyDownHandler(getKeyFromConfig(GetModConfigData("+ Pitch Keybind")), increasePitch)
end

if GetModConfigData("- Pitch Keybind") ~= 'Disabled' then
    GLOBAL.TheInput:AddKeyDownHandler(getKeyFromConfig(GetModConfigData("- Pitch Keybind")), decreaseDecrease)
end








