mhf.LoadSavedVariables = function(eventCode, addOnName)
	if addOnName == mhf.AddonID then
		d(mhf.AddonDescr.." loaded")
		SLASH_COMMANDS["/mhf"] = mhf.SlashCommands
		SLASH_COMMANDS["/mhframework"] = mhf.SlashCommands
		mhf.Ready = true
		mhf.SavedVariables.MHF = ZO_SavedVars:New("mhFrameworkData", 1, "MF", {}, "CORE") or {}
		mhf.SavedVariables.External = ZO_SavedVars:New("mhFrameworkData", 1, "External", {}, "EXT") or {}
		mhf.SavedVariables.Skyshards = ZO_SavedVars:New("mhFrameworkData", 1, "Skyshards", {}, "GATHERER") or {}
		mhf.SavedVariables.SkillPointChanges = ZO_SavedVars:New("mhFrameworkData", 1, "SkillPointChanges", {}, "GATHERER") or {}
		mhf.SavedVariables.AbilityProgress = ZO_SavedVars:New("mhFrameworkData", 1, "AbilityProgress", {}, "GATHERER") or {}
		mhf.SavedVariables.Experience = ZO_SavedVars:New("mhFrameworkData", 1, "Experience", {}, "GATHERER") or {}
		mhf.SavedVariables.WeaponSets = ZO_SavedVars:New("mhFrameworkData", 1, "WeaponSets", {}, "GATHERER") or {}
		mhf.SavedVariables.Skills = ZO_SavedVars:New("mhFrameworkData", 1, "Skills", {}, "GATHERER") or {}
		mhf.SavedVariables.Quests = ZO_SavedVars:New("mhFrameworkData", 1, "Quests", {}, "GATHERER") or {}
		mhf.SavedVariables.Levels = ZO_SavedVars:New("mhFrameworkData", 1, "Levels", {}, "GATHERER") or {}
		if not mhf.SavedVariables.Skyshards["data"] then mhf.SavedVariables.Skyshards["data"] = {} end
		if not mhf.SavedVariables.SkillPointChanges["data"] then mhf.SavedVariables.SkillPointChanges["data"] = {} end
		if not mhf.SavedVariables.AbilityProgress["data"] then mhf.SavedVariables.AbilityProgress["data"] = {} end
		if not mhf.SavedVariables.Experience["data"] then mhf.SavedVariables.Experience["data"] = {} end
		if not mhf.SavedVariables.WeaponSets["data"] then mhf.SavedVariables.WeaponSets["data"] = {} end
		if not mhf.SavedVariables.Skills["data"] then mhf.SavedVariables.Skills["data"] = {} end
		if not mhf.SavedVariables.Quests["data"] then mhf.SavedVariables.Quests["data"] = {} end
		if not mhf.SavedVariables.Levels["data"] then mhf.SavedVariables.Levels["data"] = {} end
		d(mhf.AddonDescr.." loaded")
		d("... For help type: /mhf help")
	end
end

EVENT_MANAGER:RegisterForEvent(mhf.AddonID, EVENT_ADD_ON_LOADED, mhf.LoadSavedVariables)

mhf.SlashCommands = function(text)
	d("test")
	if not text or text == "" or text == "help" then
		d("Mostly Harmless Framework's accepted commands:")
		d("> /mhf or /mhframework behave the same")
		d("> /mhf")
		d("> /mhf help")
		d("> /mhf parseglobal")   -- mhf.DumpCommandsToChat()
		d("> /mhf parsewin") -- mhf.DumpWindowsToChat()
		return
	end

	if text == "parseglobal" then
		mhf.DumpCommandsToChat()
		return
	end

	if text == "parsewin" then
		mhf.DumpWindowsToChat()
		return
	end
end