fw.Addons[gc.AddonID].SavedVariables = function()	gc.GearSets = ZO_SavedVars:New(gc.AddonID, 1, "Sets", {}, string.upper(gc.AddonAbbrev()))	if not gc.GearSets then gc.GearSets = {} endend