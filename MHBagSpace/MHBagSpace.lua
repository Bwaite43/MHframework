local AddonID = "mhBagSpace"
local addonReady = false

local StartUp = function(eventCode, addOnName)
	if addOnName == AddonID then
		addonReady = true
	end
end

local Ready = function() return (addonReady and mhf.Ready); end


function BagSpace()
local iconTrash, totalBagSpace = GetBagInfo(BAG_BACKPACK)
local usedBagSpace = 0

 for i = totalBagSpace, 0, -1 do
	usedBagSpace = i
	if CheckInventorySpaceSilently(usedBagSpace) then break end
 end
 
--Get number of items that are normal or trash
local iconTrash, itemStack, sellPrice, failedEduipRequirement, locked, equipType, itemStyle, itemQuality
local itemHighQuality = 0

for i = totalBagSpace, 0, -1 do
	iconTrash, itemStack, sellPrice, failedEduipRequirement, locked, equipType, itemStyle, itemQuality = GetItemInfo(BAG_BACKPACK,i)
	if (itemQuality == ITEM_QUALITY_MAGIC or itemQuality == ITEM_QUALITY_LEGENDARY or itemQuality == ITEM_QUALITY_ARTIFACT or itemQuality == ITEM_QUALITY_ARCANE)  then 
		itemHighQuality = itemHighQuality + 1
	end
end



local freeBagSpace = totalBagSpace - usedBagSpace
 
 
 --fps
 local fps = GetFramerate()
 
mhBagSpaceLabel:SetText(string.format("%d / %d", freeBagSpace, totalBagSpace))
mhBagSpaceLabel:SetAnchor(BOTTOMLEFT,TopLevelWindow,BOTTOMLEFT,25,-10)
mhBagSpaceLabel:SetColor(0,255,0,20)
mhBagSpaceHQ:SetAnchor(BOTTOMLEFT,TopLevelWindow,BOTTOMLEFT,100,-10)
mhBagSpaceHQ:SetText(string.format("HQ:%d", itemHighQuality))

--Add FPS for Holicori
mhBagSpaceFPS:SetText(string.format("FPS:%d", fps))
mhBagSpaceFPS:SetAnchor(BOTTOMLEFT,TopLevelWindow,BOTTOMLEFT,175,-10)

end

