gc.CommandLine = function(text)
	if not gc.Ready then return; end
	if not text or text == "" or text == "help" then
		d(gc.AddonName().." accepted commands:")
		d("[QC] /"..gc.AddonAbbrev().."  << shows help")
		d("[QC] /"..gc.AddonAbbrev().." help << shows help")
		d("[QC] /saveset ##, /loadset ##, /clearset ##")
		d("[QC] saveset to save, loadset to load, etc")
		d("[QC] ## = your index/label, (no spaces)")
		d("[QC] EXAMPLE 1: /saveset 1")
		d("[QC] EXAMPLE 2: /saveset pvp")
		return
	end
	
	local parms = {}
	for tt in text:gmatch("%w+") do table.insert(parms, tt) end
	
	if parms[1] and parms[2] then
		if parms[1] == "save" then gc.SaveCommands(parms[2]); return; end
		if parms[1] == "load" then gc.LoadCommands(parms[2]); return; end
		if parms[1] == "clear" then gc.ClearCommands(parms[2]); return; end
	end
end
