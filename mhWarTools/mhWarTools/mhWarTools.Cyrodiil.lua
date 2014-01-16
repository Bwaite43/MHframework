mhw.Cyrodiil = nil

mhw.CyrodiilObjectiveEvent = function()
	local Objectives = {}
	local campaignId = GetCurrentCampaignId()
	for avaIndex = 1, GetNumAvAObjectives(), 1 do
		local keepId, objectiveId, battlegroundContext = GetAvAObjectiveKeysByIndex(avaIndex)
		local objectiveName, objectiveType, objectiveState, allianceParam1, allianceParam2 = GetAvAObjectiveInfo(keepId, objectiveId, battlegroundContext)
		if objectiveType ~= 10 and not string.find(objectiveName, " Nave") and not string.find(objectiveName, " Courtyard") then
			local displayName = objectiveName:gsub(" Flag", ""):gsub(" Apse", ""):gsub(" Tower", "")
			local pinType, currentNormalizedX, currentNormalizedY, continuousUpdate = GetAvAObjectivePinInfo(keepId, objectiveId, battlegroundContext)
			
			local base = ""
			local key = ""
			local subKey = ""
			local baseFaction = 0
			if objectiveType == 4 then
				base = "objectives"
				key = displayName
				if string.find(displayName, " Farm") then
					key = key:gsub(" Farm","")
					if string.find(displayName, " Farm") then subKey = "Farm" end
				end
				if string.find(displayName, " Mine") then
					key = key:gsub(" Mine","")
					if string.find(displayName, " Mine") then subKey = "Mine" end
				end
				if string.find(displayName, " Lumbermill") then
					key = key:gsub(" Lumbermill","")
					if string.find(displayName, " Lumbermill") then subKey = "Lumbermill" end
				end
				if string.find(displayName, " Keep") then
					key = key:gsub(" Keep","")
					baseFaction = 2
				end
				if string.find(displayName, "Fort ") then
					key = key:gsub("Fort ","")
					baseFaction = 3
				end
				if string.find(displayName, "Castle ") then
					key = key:gsub("Castle ","")
					baseFaction = 1
				end
				if string.find(displayName, " Outpost") then
					key = key:gsub(" Outpost","")
					if string.find(displayName, "Bleaker's") then baseFaction = 3 end
					if string.find(displayName, "Sejanus") then baseFaction = 2 end
					if string.find(displayName, "Nikel") then baseFaction = 1 end
				end
			else
				base = "scrolls"
			end
			if not Objectives[base] then Objectives[base] = {} end
			if key ~= "" then if not Objectives[base][key] then Objectives[base][key] = {} end end
			if subKey ~= "" then if not Objectives[base][key][subKey] then Objectives[base][key][subKey] = {} end end
			
			local data = {}
			data["avaIndex"] = avaIndex
			data["displayName"] = displayName
			data["keepId"] = keepId
			data["objectiveId"] = objectiveId
			data["battlegroundContext"] = battlegroundContext
			data["objectiveName"] = objectiveName
			data["objectiveType"] = objectiveType
			data["objectiveState"] = objectiveState
			data["allianceParam1"] = allianceParam1
			data["allianceParam2"] = allianceParam2
			data["pinType"] = pinType
			data["pinName"] = mhw.Lists.PinTypes[pinType]
			data["currentNormalizedX"] = currentNormalizedX
			data["currentNormalizedY"] = currentNormalizedY
			data["continuousUpdate"] = continuousUpdate
			
			if subKey ~= "" then
				Objectives[base][key][subKey] = data
				Objectives[base][key][subKey]["heldBy"] = mhw.Lists.Alliances[allianceParam1]
				Objectives[base][key][subKey]["siegedBy"] = mhw.Lists.Alliances[allianceParam2]
			else
				if key ~= "" then
					Objectives[base][key] = data
					Objectives[base][key]["baseFaction"] = baseFaction
					Objectives[base][key]["belongsTo"] = mhw.Lists.Alliances[baseFaction]
					Objectives[base][key]["heldBy"] = mhw.Lists.Alliances[allianceParam1]
					Objectives[base][key]["siegedBy"] = mhw.Lists.Alliances[allianceParam2]
				else
					Objectives[base][displayName] = data
					Objectives[base][displayName]["belongsTo"] = mhw.Lists.Alliances[allianceParam1]
					Objectives[base][displayName]["heldBy"] = mhw.Lists.Alliances[allianceParam2]
				end
			end
		end
	end

	mhw.Cyrodiil = Objectives
end