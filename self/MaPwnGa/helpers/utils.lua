function ValidTarget(target, visibleOnly, allowedDistance)
    if !target:IsValid() then return false end
    if target == LocalPlayer() then return false end
    if target:IsPlayer() then
        if target:Team() == TEAM_SPECTATOR then return false end
        if !target:Alive() then return false end
    elseif !target:IsNPC() then return false end
    if visibleOnly and !LocalPlayer():IsLineOfSightClear(target) then return false end
    if allowedDistance != 0 and (LocalPlayer():GetShootPos():Distance(target:GetPos()) > allowedDistance) then return false end
    return true
end

function ValidEntity(target, visibleOnly, allowedDistance)
    if !target:IsValid() then return false end
    if target == LocalPlayer() then return false end
    if visibleOnly and !LocalPlayer():IsLineOfSightClear(target) then return false end
    if allowedDistance != 0 and (LocalPlayer():GetShootPos():Distance(target:GetPos()) > allowedDistance) then return false end
    return true
end

function ForceKey(cmd, KeyCode)
    cmd:SetButtons(bit.bor(cmd:GetButtons(), KeyCode))
end

function IsTTT()
    return (GAMEMODE and GAMEMODE.Name and string.find(GAMEMODE.Name, "Terror") and true)
end

local observerModes = { "None", "Deathcam", "Freezecam", "Fixed", "Firstperson", "Thirdperson", "Freeroam" }
function GetObserverModeString(mode)
    return observerModes[i+1] --+1 cuz enum starts at 0 (not like fuckin lua)
end

icons = { smileIcon = Material("icon16/emoticon_smile.png"),
unhappyIcon    = Material("icon16/emoticon_unhappy.png"),
magnifierIcon  = Material("icon16/magnifier.png"),
bombIcon       = Material("icon16/bomb.png"),
wrongIcon      = Material("icon16/cross.png"),
rightIcon      = Material("icon16/tick.png"),
shieldIcon     = Material("icon16/shield.png"),
starIcon       = Material("icon16/star.png"),
appIcon        = Material("icon16/application.png"),
creditIcon     = Material("icon16/coins.png"),
wrenchIcon     = Material("icon16/wrench.png"),
userIcon       = Material("icon16/user.png"),
warningIcon    = Material("icon16/exclamation.png"),
clockIcon      = Material("icon16/time.png"),
gunIcon        = Material("icon16/gun.png"),
heartIcon      = Material("icon16/heart.png"),
connectIcon    = Material("icon16/connect.png"),
disconnectIcon = Material("icon16/disconnect.png"),
skullIcon      = Material("icon16/user_delete.png"),
eyeIcon        = Material("icon16/lighting.png"),
lightningIcon  = Material("icon16/lightning.png"),
colorIcon      = Material("icon16/color_wheel.png")}

concommand.Add("exp_test_logicons", function()
    for k,v in pairs(icons) do
        table.insert(Events, {icon = v, details = k})
    end
    BuildLogListView()
end)

function Log(text, logIcon)
    local timeStamp = os.date("[%H:%M:%S]", os.time())
    local lIcon = logIcon --Can be nil then we just have a empty field
    local toLog = timeStamp .. " Log: " .. text
    
    --Insert into Event Table & update the log (not too happy about calling the update function here... maybe add a callback to table insert?)
    local event = {time = timeStamp, icon = lIcon, details = text}
    table.insert(Events, event)
    BuildLogListView()

    print(toLog)
    chat.AddText(toLog)
end

function IsEnemy(entity)
    return entity:Team() != LocalPlayer():Team() or (IsTTT() and entity.role and LocalPlayer().role and entity.role != LocalPlayer().role)
end

function RainbowColor()
    return HSVToColor(RealTime() * 120 % 360, 1, 1)
end

function GetRandomString(seed, length)
    if !seed then
        seed = math.random(0, os.time())
    end
    local seeed = seed

    local l = length
    if !length then
        l = 5
    end

    math.randomseed(seeed)
    local ret = ""
    for i=0, l do
        ret = ret .. string.char(math.random(65, 122))
    end

    return ret
end