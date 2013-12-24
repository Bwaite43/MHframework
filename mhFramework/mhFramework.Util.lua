local unk = "unk"
local unitTag = "PLAYER"

mhf.Print = function(m) d(m); end

mhf.Util.CountOf = function(T) local c = 0;for _ in pairs(T) do c = c + 1 end;return c; end
mhf.Util.NextOf = function(T) return mhf.Util.CountOf(T)+1; end

mhf.Util.CreateInline = function(obj)
	local T={}
	setmetatable(T,{__index = function(self,fun)
		if fun=="__END" then
			return obj
		end
		return function(self,...)
			assert(obj[fun],fun.." missing in object")
			obj[fun](obj,...)
			return self
		end
	end})
	return T
end

mhf.GetDateTimeString = function()
	local ts = GetTimeStamp()
	if not ts then return nil end
	local d = GetDateStringFromTimestamp(ts)
	if not d then return nil end
	local t = GetTimeString()
	if not t then return nil end
	return d.." "..t
end

mhf.RegisterSkillPointChange = function(data)
	local ii = mhf.Util.NextOf(mhf.SavedVariables.SkillPointChanges["data"])
	data["datetime"] = mhf.GetDateTimeString() or unk
	mhf.SavedVariables.SkillPointChanges["data"][ii] = data
end

mhf.RegisterSkyshard = function(data)
	local ii = mhf.Util.NextOf(mhf.SavedVariables.Skyshards["data"])
	data["datetime"] = mhf.GetDateTimeString() or unk
	mhf.SavedVariables.Skyshards["data"][ii] = data
end

mhf.RegisterLevel = function(data)
	local ii = mhf.Util.NextOf(mhf.SavedVariables.Levels["data"])
	data["datetime"] = mhf.GetDateTimeString() or unk
	mhf.SavedVariables.Levels["data"][ii] = data
end

mhf.RegisterSkill = function(key, data) 
	local dt = mhf.GetDateTimeString()
	mhf.SavedVariables.Skills["data"][key] = {}
	mhf.SavedVariables.Skills["data"][key][dt] = data 
end

mhf.RegisterWeaponSet = function(key, data) 
	local dt = mhf.GetDateTimeString()
	mhf.SavedVariables.WeaponSets["data"][key] = {}
	mhf.SavedVariables.WeaponSets["data"][key][dt] = data 
end

mhf.RegisterQuest = function(key, data) 
	local dt = mhf.GetDateTimeString()
	mhf.SavedVariables.Quests["data"][key] = {}
	mhf.SavedVariables.Quests["data"][key][dt] = data 
end

mhf.RegisterQuestDetailed = function(key, data) mhf.RegisterQuest(key, mhf.GetLocationDetails(mhf.GetProgressDetails(data))) end
mhf.RegisterQuestEnhanced = function(key, data) mhf.RegisterQuest(key, mhf.GetLocationDetails(mhf.GetPlayerDetails(data))) end

mhf.RegisterAbilityProgress = function(data)
	local ii = mhf.Util.NextOf(mhf.SavedVariables.AbilityProgress["data"])
	data["datetime"] = mhf.GetDateTimeString() or unk
	mhf.SavedVariables.AbilityProgress["data"][ii] = data
end

mhf.RegisterExperience = function(data)
	local ii = mhf.Util.NextOf(mhf.SavedVariables.Experience["data"])
	data["datetime"] = mhf.GetDateTimeString() or unk
	mhf.SavedVariables.Experience["data"][ii] = data
end

mhf.RegisterLevelUpdate = function(data) mhf.RegisterLevel(data) end

mhf.GetLocationDetails = function(tbl)
	if not tbl then tbl = {} end
	tbl["locationdetails"] = {}
	tbl["locationdetails"]["zone"] = GetUnitZone(unitTag) or unk
	tbl["locationdetails"]["zone_index"] = GetCurrentPlayerZoneIndex() or 0
	return tbl
end

mhf.GetPlayerDetails = function(tbl)
	if not tbl then tbl = {} end
	tbl["playerdetails"] = {}
	tbl["playerdetails"]["name"] = GetUnitName(unitTag) or unk
	tbl["playerdetails"]["raw_name"] = GetRawUnitName(unitTag) or unk
	tbl["playerdetails"]["race"] = GetUnitRace(unitTag) or unk
	tbl["playerdetails"]["class"] = GetUnitClass(unitTag) or unk
	tbl = mhf.GetProgressDetails(tbl)
	return tbl
end

mhf.GetProgressDetails = function(tbl)
	if not tbl then tbl = {} end
	tbl["progressdetails"] = {}
	tbl["progressdetails"]["level"] = GetUnitLevel(unitTag) or 0
	tbl["progressdetails"]["xp"] = GetUnitXP(unitTag) or 0
	tbl["progressdetails"]["xpmax"] = GetUnitXPMax(unitTag) or 0
	tbl["progressdetails"]["xpdebt"] = GetUnitXPDebt(unitTag) or 0
	tbl["progressdetails"]["secondsplayed"] = GetSecondsPlayed() or 0
	return tbl
end

mhf.DumpWindowsToChat = function(win,num)
	if not win and not num then
		mhf.DumpWindowsToChat(GuiRoot)
		return
	end
	if not win then return end
	local nn = num or 0
	local xx = nn + 1
	DumpWindowName(win,nn)
	local x = win:GetNumChildren()
	if x > 0 then	
		for ii = 1, x do
			mhf.DumpWindowsToChat(win:GetChild(ii),xx)
		end
	end
end

local DumpWindowName = function(win,num)
	if win then mhf.Print(Indentation(num)..win:GetName()); end
end

local Indentation = function(num)
	local r = ""
	for xx = 0,num do
		r = r..">"
	end
	return r.." "
end

mhf.DumpCommandsToChat = function() table.foreach(_G,d); end

local showMap = function() ZO_WorldMap:SetHidden(false); end
local hideMap = function() ZO_WorldMap:SetHidden(true); end

local getMapElement = function(tbl, key1, key2)
	if not tbl then tbl = {} end
	if not tbl[key1] then tbl[key1] = {} end
	local val = unk
	--if key2 == "mapindex" then val = GetCurrentMapIndex() end
	--if key2 == "mapname" then val = GetCurrentMapName() end
	--if key2 == "maptype" then val = GetCurrentMapType() end
	--if key2 == "maplocation" then val = GetMapLocation(GetCurrentMapIndex()) end
	--if key2 == "mapplayerposition" then val = GetCurrentMapPlayerPosition(unitTag) end
	tbl[key1][key2] = val
	return tbl
end

local nilMapElement = function(tbl, key1, key2)
	if not tbl then tbl = {} end
	if not tbl[key1] then tbl[key1] = {} end
	tbl[key1][key2] = nil
	return tbl
end

mhf.GetMapDetails = function(tbl)
	if not tbl then tbl = {} end
	local mapKey = "mapdetails"
	tbl[mapKey] = {}
	if not pcall(getMapElement(tbl, mapKey, "mapindex")) then nilMapElement(tbl, mapKey, "mapindex") end
	if not pcall(getMapElement(tbl, mapKey, "mapname")) then nilMapElement(tbl, mapKey, "mapindex") end
	if not pcall(getMapElement(tbl, mapKey, "maptype")) then nilMapElement(tbl, mapKey, "mapindex") end
	if not pcall(getMapElement(tbl, mapKey, "maplocation")) then nilMapElement(tbl, mapKey, "mapindex") end
	if not pcall(getMapElement(tbl, mapKey, "mapplayerposition")) then nilMapElement(tbl, mapKey, "mapindex") end
	return tbl
end

mhf.GetQuestDetails = function(idx, tbl)
	if not tbl then tbl = {} end 
	if not idx then return tbl; end
	local key = "QuestDetails"
	tbl[key] = {}
	tbl[key]["JournalQuestName"] = GetJournalQuestName(idx)
	tbl[key]["JournalQuestType"] = GetJournalQuestType(idx)
	tbl[key]["JournalQuestLevel"] = GetJournalQuestLevel(idx)
	tbl[key]["JournalQuestRepeatType"] = GetJournalQuestRepeatType(idx)
	tbl[key]["JournalQuestInfo"] = GetJournalQuestInfo(idx)
	tbl[key]["JournalQuestIsComplete"] = GetJournalQuestIsComplete(idx)
	tbl[key]["JournalQuestIsPushed"] = GetJournalQuestIsPushed(idx)
	tbl[key]["IsQuestSharable"] = GetIsQuestSharable(idx)
	tbl[key]["JournalQuestNumSteps"] = GetJournalQuestNumSteps(idx)
	tbl[key]["JournalQuestTimerInfo"] = GetJournalQuestTimerInfo(idx)
	tbl[key]["JournalQuestTimerCaption"] = GetJournalQuestTimerCaption(idx)
	tbl[key]["QuestToolCount"] = GetQuestToolCount(idx)
	return tbl
end

