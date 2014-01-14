local AddonID = "mhExpLog"

--Register events
function mhExpLog_OnInitialized()
--	EVENT_MANAGER:RegisterForEvent(EVENT_EXPERIENCE_GAIN, OnExperienceGain)
	EVENT_MANAGER:RegisterForEvent("mhExpLog", EVENT_EXPERIENCE_GAIN, OnExperienceGain)
end



local function OnExperienceGain(value, reason)
--log the XP value received to chat

	FindReason(reason)
		
	d("XP Gained for ",reasonText,":", value)
	mhExpLogLabel:SetText(string.format("EXP: %d", value))
	mhExpLogLabel:SetAnchor(TOPLEFT,TopLevelWindow,TOPLEFT,75,10)
	mhExpLogLabel:SetColor(0,255,0,20)
end

function OnExperienceUpdate(unitTag, currentExp, maxExp, reason)
	FindReason(reason)
	d("XP Gained for (update) ",reasonText,":", maxExp)
end

function FindReason(reason)
	if reason == XP_REASON_ACTION then
		reasonText = "Action"
	elseif reason == XP_REASON_BATTLEGROUND then
		reasonText = "Battleground"
	elseif reason == XP_REASON_COLLECT_BOOK then
		reasonText = "Collected Book"
	elseif reason == XP_REASON_COMMAND then
		reasonText = "Command"
	elseif reason == XP_REASON_COMPLETE_POI then
		reasonText = "Point of Interest Completed"
	elseif reason == XP_REASON_DISCOVER_POI then
		reasonText = "Point of Interest Discovered"
	elseif reason == XP_REASON_FINESSE  then
		reasonText = "Finesse"
	elseif reason == XP_REASON_KEEP_REWARD  then
		reasonText = "Keep Reward"
	elseif reason == XP_REASON_KILL then
		reasonText = "Kill Reward"
	elseif reason == XP_REASON_LOCK_PICK then
		reasonText = "Lock Pick"
	elseif reason == XP_REASON_MEDAL then
		reasonText = "Medal"
	elseif reason == XP_REASON_NONE then
		reasonText = ""
	elseif reason == XP_REASON_QUEST then
		reasonText = "Quest"
	elseif reason == XP_REASON_QUEST then
		reasonText = ""
	elseif reason == XP_SCRIPTED_EVENT then
		reasonText = "Event"
	elseif reason == XP_REASON_SKILL_AVA then
		reasonText = "AvA Skill"
	elseif reason == XP_REASON_SKILL_BOOK then
		reasonText = "Skill Book"
	elseif reason == XP_REASON_SKILL_GUILD_REP then
		reasonText = "Guild Rep"
	else 
		reasonText = ""
	end
end






