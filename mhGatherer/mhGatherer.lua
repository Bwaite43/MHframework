local AddonID = "mhGatherer"
local addonReady = false

local StartUp = function(eventCode, addOnName)
	if addOnName == AddonID then
		addonReady = true
		--SkillPointsChanged(666,999,true)
	end
end

local Ready = function() return (addonReady and mhf.Ready); end

function SkillPointsChanged(eventCode, pointsBefore, pointsNow, isSkyShard)
	if not Ready() then return end
	if s then SkyshardGathered(eventCode, pointsBefore, pointsNow) end
	SkillPointsUpdated(eventCode, pointsBefore, pointsNow, isSkyShard)
end

function SkillPointsUpdated(eventCode, pointsBefore, pointsNow, isSkyShard)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_SKILL_POINTS_CHANGED"
	tbl["pointsBefore"] = pointsBefore
	tbl["pointsNow"] = pointsNow
	if isSkyShard then tbl["isSkyShard"] = "true"
	else tbl["isSkyShard"] = "false"
	end
	mhf.RegisterSkillPointChange(mhf.GetPlayerDetails(tbl))
end

function SkyshardGathered(eventCode, pointsBefore, pointsNow)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_SKILL_POINTS_CHANGED"
	tbl["pointsBefore"] = pointsBefore
	tbl["pointsNow"] = pointsNow
	tbl["isSkyShard"] = "true"
	mhf.RegisterSkyshard(mhf.GetLocationDetails(mhf.GetMapDetails(tbl)))
end

function AbilityXPUpdate(eventCode, progressionIndex, lastRankXP, nextRankXP, currentXP, atMorph)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_ABILITY_PROGRESSION_XP_UPDATE"
	tbl["progressionIndex"] = progressionIndex
	tbl["lastRankXP"] = lastRankXP
	tbl["nextRankXP"] = nextRankXP
	tbl["currentXP"] = currentXP
	tbl["atMorph"] = atMorph
	mhf.AbilityProgress(mhf.GetProgressDetails(tbl))
end

function AbilityRankUpdate(eventCode, progressionIndex, rank, maxRank, morph)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_ABILITY_PROGRESSION_RANK_UPDATE"
	tbl["progressionIndex"] = progressionIndex
	tbl["rank"] = rank
	tbl["maxRank"] = maxRank
	tbl["morph"] = morph
	mhf.AbilityProgress(mhf.GetProgressDetails(tbl))
end

function ExperienceGain(eventCode, value, reason)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_EXPERIENCE_GAIN"
	tbl["value"] = value
	tbl["reason"] = reason
	mhf.RegisterExperience(mhf.GetProgressDetails(tbl))
end

function ExperienceGainDiscovery(eventCode, areaName, value)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_EXPERIENCE_GAIN_DISCOVERY"
	tbl["areaName"] = areaName
	tbl["value"] = value
	mhf.RegisterExperience(mhf.GetProgressDetails(tbl))
end

function ExperienceUpdate(eventCode, unitTag, currentExp, maxExp, reason)
	if not unitTag then unitTag = "PLAYER" end
	if unitTag ~= "PLAYER" then return; end
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_EXPERIENCE_UPDATE"
	tbl["unitTag"] = unitTag
	tbl["currentExp"] = currentExp
	tbl["maxExp"] = maxExp
	tbl["reason"] = reason
	mhf.RegisterExperience(mhf.GetProgressDetails(tbl))
end

function LevelUpdate(eventCode, unitTag, level)
	if not unitTag then unitTag = "PLAYER" end
	if unitTag ~= "PLAYER" then return; end
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_LEVEL_UPDATE"
	tbl["unitTag"] = unitTag
	tbl["level"] = level
	mhf.RegisterLevelUpdate(mhf.GetProgressDetails(tbl))
end

function QuestAdded(eventCode, journalIndex, questName, objectiveName)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_ADDED"
	tbl["journalIndex"] = journalIndex
	tbl["questName"] = questName
	tbl["objectiveName"] = objectiveName
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestAdvanced(eventCode, journalIndex, questName, isPushed, isComplete, mainStepChanged)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_ADVANCED"
	tbl["journalIndex"] = journalIndex
	tbl["questName"] = questName
	tbl["isPushed"] = isPushed
	tbl["isComplete"] = isComplete
	tbl["mainStepChanged"] = mainStepChanged
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestCompleteDialog(eventCode, journalIndex)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_COMPLETE_DIALOG"
	tbl["journalIndex"] = journalIndex
	mhf.RegisterQuestDetailed("questName", mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestCompleteExperience(eventCode, questName, xpGained)
	local dt = mhf.GetDateTimeString()
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_COMPLETE_EXPERIENCE"
	tbl["questName"] = questName
	tbl["xpGained"] = xpGained
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestConditionCounterChanged(eventCode, journalIndex, questName, conditionText, conditionType, currConditionVal, newConditionVal, conditionMax, isFailCondition, stepOverrideText, isPushed, isComplete, isConditionComplete, isStepHidden)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_CONDITION_COUNTER_CHANGED"
	tbl["journalIndex"] = journalIndex
	tbl["questName"] = questName
	tbl["conditionText"] = conditionText
	tbl["conditionType"] = conditionType
	tbl["currConditionVal"] = currConditionVal
	tbl["newConditionVal"] = newConditionVal
	tbl["conditionMax"] = conditionMax
	tbl["isFailCondition"] = isFailCondition
	tbl["stepOverrideText"] = stepOverrideText
	tbl["isPushed"] = isPushed
	tbl["isComplete"] = isComplete
	tbl["isConditionComplete"] = isConditionComplete
	tbl["isStepHidden"] = isStepHidden
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestInteractDialog(eventCode, journalIndex)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_INTERACT_DIALOG"
	tbl["journalIndex"] = journalIndex
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestRemoved(eventCode, isCompleted, journalIndex, questName, zoneIndex, poiIndex)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_REMOVED"
	tbl["journalIndex"] = journalIndex
	tbl["questName"] = questName
	tbl["isCompleted"] = isCompleted
	tbl["zoneIndex"] = zoneIndex
	tbl["poiIndex"] = poiIndex
	mhf.RegisterQuestDetailed(questName, tbl)
end

function QuestTimerPaused(eventCode, journalIndex, isPaused)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_TIMER_PAUSED"
	tbl["journalIndex"] = journalIndex
	tbl["isPaused"] = isPaused
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function QuestToolUpdated(eventCode, journalIndex, questName)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_QUEST_TOOL_UPDATED"
	tbl["journalIndex"] = journalIndex
	tbl["questName"] = questName
	mhf.RegisterQuestDetailed(questName, mhf.GetQuestDetails(journalIndex, tbl))
end

function SkillLineAdded(eventCode, skillType, skillIndex)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_SKILL_LINE_ADDED"
	tbl["skillIndex"] = skillIndex
	tbl["skillType"] = skillType
	mhf.RegisterSkill(skillIndex, mhf.GetProgressDetails(tbl))
end

function SkillRankUpdate(eventCode, skillType, skillIndex, rank)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_SKILL_RANK_UPDATE"
	tbl["skillIndex"] = skillIndex
	tbl["skillType"] = skillType
	tbl["rank"] = rank
	mhf.RegisterSkill(skillIndex, mhf.GetProgressDetails(tbl))
end

function SkillXPUpdate(eventCode, skillType, skillIndex, lastRankXP, nextRankXP, currentXP)
	local tbl = {}
	tbl[skillIndex] = {}
	tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_SKILL_XP_UPDATE"
	tbl["skillIndex"] = skillIndex
	tbl["skillType"] = skillType
	tbl["lastRankXP"] = lastRankXP
	tbl["nextRankXP"] = nextRankXP
	tbl["currentXP"] = currentXP
	mhf.RegisterSkill(skillIndex, mhf.GetProgressDetails(tbl))
end

function WeaponSetRankUpdate(eventCode, weaponSetIndex, rank, maxRank)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_WEAPON_SET_RANK_UPDATE"
	tbl["weaponSetIndex"] = weaponSetIndex
	tbl["rank"] = rank
	tbl["maxRank"] = maxRank
	mhf.RegisterWeaponSet(weaponSetIndex, mhf.GetProgressDetails(tbl))
end

function WeaponSetXPUpdate(eventCode, weaponSetIndex, lastRankXP, nextRankXP, currentXP)
	local tbl = {}
	tbl["event"] = {}
	tbl["event"]["code"] = eventCode
	tbl["event"]["desc"] = "EVENT_WEAPON_SET_XP_UPDATE"
	tbl["weaponSetIndex"] = weaponSetIndex
	tbl["lastRankXP"] = lastRankXP
	tbl["skillType"] = lastRankXP
	tbl["nextRankXP"] = nextRankXP
	tbl["currentXP"] = currentXP
	mhf.RegisterWeaponSet(weaponSetIndex, mhf.GetProgressDetails(tbl))
end

EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_ADD_ON_LOADED, StartUp)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_SKILL_POINTS_CHANGED, SkillPointsChanged)

--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_ABILITY_PROGRESSION_XP_UPDATE, AbilityXPUpdate)
--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_ABILITY_PROGRESSION_RANK_UPDATE, AbilityRankUpdate)

--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_EXPERIENCE_GAIN, ExperienceGain)
--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_EXPERIENCE_GAIN_DISCOVERY, ExperienceGainDiscovery)
--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_EXPERIENCE_UPDATE, ExperienceUpdate)

--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_LEVEL_UPDATE, LevelUpdate)

EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_ADDED, QuestAdded)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_ADVANCED, QuestAdvanced)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_COMPLETE_DIALOG, QuestCompleteDialog)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_COMPLETE_EXPERIENCE, QuestCompleteExperience)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_CONDITION_COUNTER_CHANGED, QuestConditionCounterChanged)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_INTERACT_DIALOG, QuestInteractDialog)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_REMOVED, QuestRemoved)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_TIMER_PAUSED, QuestTimerPaused)
EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_QUEST_TOOL_UPDATED, QuestToolUpdated)

--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_SKILL_LINE_ADDED, SkillLineAdded)
--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_SKILL_RANK_UPDATE, SkillRankUpdate)
--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_SKILL_XP_UPDATE, SkillXPUpdate)

--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_WEAPON_SET_RANK_UPDATE, WeaponSetRankUpdate)
--EVENT_MANAGER:RegisterForEvent(AddonID, EVENT_WEAPON_SET_XP_UPDATE, WeaponSetXPUpdate)


