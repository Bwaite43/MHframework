local AddonID = "mhClock"
local addonReady = false

local StartUp = function(eventCode, addOnName)
	if addOnName == AddonID then
		addonReady = true
	end
end

local Ready = function() return (addonReady and mhf.Ready); end


function Clock()
local Time = GetTimeString()

mhClockLabel:SetText(string.format(Time))
mhClockLabel:SetAnchor(TOPLEFT,TopLevelWindow,TOPLEFT,25,10)
mhClockLabel:SetColor(0,255,0,20)


end

