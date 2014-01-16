gc.QueueHandler = function(eventCode, bagId, slotId, isNewItem, itemSoundCategory)
-- and not in combat
	if gc.HasQueue then
		local num = count(gc.Queue)
		if num == 0 then gc.HasQueue = false; return; end
		
		local last = nil
		for mode, t in pairs(gc.Queue) do
			if not last then
				if mode == "remove" then gc.RemoveItem(t) end
				if mode == "equip" then gc.EquipItem(t) end
				last = mode
			end
		end
		
		if num == 1 then gc.Queue = {}; gc.HasQueue = false; return; end
		table.remove(gc.Queue, last)
	end
end

local function count(tbl)
	local i = 0
	for _,t in pairs(gc.Queue) do i=i+1 end
	return i
end