function(states, event, unitId, _, spellId)
    if unitId == nil then return end
    if spellId == nil then return end
    if (not(UnitIsPlayer(unitId))) then return end
    if (not(UnitIsEnemy("player",unitId))) then return end
    
    local _, _, classId = UnitClass(unitId) 
    
    
    
    if event == "NAME_PLATE_UNIT_REMOVED" then
        states[unitId] = 
        {
            show = false,
            changed = true
        }
        
        return true
    end
    
    local _, gcdMS = GetSpellBaseCooldown(spellId)
    
    if (gcdMS == 0) then return end
    
    local _, _, icon, castTime = GetSpellInfo(spellId)
    
    if castTime > 0 then return end
    
    if classId == 4 then -- Rogues have 1s gcd.
        castTime = 1000
    else
        castTime = 1500
    end
    
    local duration, expiration;
    
    duration = castTime / 1000
    expiration = GetTime() + (castTime / 1000)
    
    states[unitId] =
    {
        show = true,
        changed = true,
        progressType = "timed",
        value = 0,
        total = 0,
        duration = duration,
        expirationTime = expiration,
        autoHide = true,
        icon = icon,
        unit = unitId
    }
    
    return true
end
