gc.SaveCommands = function(idx)
	local gear = gc.ParseGear()
	gc.GearSets[idx] = gear
end

gc.LoadCommands = function(idx)
	if not idx then return end
	if not gc.GearSets[idx] then return end
	
	local worn = gc.ParseGear()
	for a,w in pairs(worn) do
		local found = false
		for b,g in pairs(gc.GearSets[idx]) do
			if gc.SameItem(w,g) then 
				found = true
				if w["slot"] ~= g["slot"] then
					d("[MHG] Item "..w["name"].." is out of order, attempting to remove" )
					UnequipItem(gc.EquipSlot[w["slot"]])
				end
			end
		end
		if not found and w["name"] ~= nil and w["name"] ~= "" then
			d("[MHG] Item "..w["name"].." is not in set, attempting to remove" )
			UnequipItem(gc.EquipSlot[w["slot"]])
		end
	end
	
	local bagged = gc.ParseBags()
	for a,g in pairs(gc.GearSets[idx]) do
		local found = false
		for c,b in pairs(bagged) do
			if gc.SameItem(b, g) then
				d("[MHG] Attempting to equip set item " .. b["name"] )
				EquipItem(b["bag"], b["slot"], g["slot"])
			end
		end
	end
end

gc.ClearCommands = function(idx)
	if gc.GearSets[idx] then
		table.remove(gc.GearSets, idx)
	end
end

gc.ParseGear = function()
	local gearFound = {}
	local bag = 0
	for slot = 0, 23, 1 do
		local id, detail = gc.GetBagSlotDetails( bag, slot)
		if id then gearFound[id] = detail end
	end
	return gearFound
end

gc.ParseBags = function()
	local gearFound = {}
	local maxBags = GetMaxBags()
	local bag = 1
	local img, slots = GetBagInfo(bag)
	local usedSlots = 0
	for i = slots, 0, -1 do
		usedSlots = i
		if CheckInventorySpaceSilently(usedSlots) then break end
	end
	for slot = 1, usedSlots, 1 do
		local id, detail = gc.GetBagSlotDetails( bag, slot)
		if id then gearFound[id] = detail end
	end
	return gearFound
end

gc.SameItem = function( a, b )
	if a then
		if b then
			if a["name"] == b["name"] 
			and a["icon"] == b["icon"] 
			and a["equipType"] == b["equipType"] 
			and a["itemStyle"] == b["itemStyle"] 
			and a["quality"] == b["quality"] 
			and a["equipable"] == b["equipable"] 
			and a["name"] ~= "" and b["name"] ~= ""
			and a["name"] ~= nil and b["name"] ~= nil then
				return true
			end
		end
	end
	return false
end

gc.GetBagSlotDetails = function( bag, slot )
	local gearFound = {}
	gearFound["bag"] = bag
	gearFound["slot"] = slot
	gearFound["name"] = GetItemName( bag, slot )
	local equipable, resultErrorCodeIfFailed = IsEquipable(bag, slot)
	gearFound["equipable"] = equipable
	gearFound["equipableErrorCode"] = resultErrorCodeIfFailed
	local icon, stack, sellPrice, failedEquipRequirement, locked, equipType, itemStyle, quality = GetItemInfo(bag, slot)
	gearFound["icon"] = icon
	gearFound["stack"] = stack
	gearFound["sellPrice"] = sellPrice
	gearFound["failedEquipRequirement"] = failedEquipRequirement
	gearFound["locked"] = locked
	gearFound["equipType"] = equipType
	gearFound["itemStyle"] = itemStyle
	gearFound["quality"] = quality
	return bag.."."..slot, gearFound
	
end