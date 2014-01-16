fw.Addons[gc.AddonID].StartUp = function()
	fw.Commands.Add(gc.AddonAbbrev(), gc.CommandLine)
	fw.Commands.Add("saveset", gc.CommandLine)
	fw.Commands.Add("loadset", gc.LoadCommands)
	fw.Commands.Add("clearset", gc.ClearCommands)
	
	fw.Commands.Add(gc.AddonAbbrev().."parsebags", gc.DumpParseBags)
	fw.Commands.Add(gc.AddonAbbrev().."parsegear", gc.DumpParseGear)
	
	fw.Events.Register(EVENT_INVENTORY_SINGLE_SLOT_UPDATE, gc.QueueHandler, gc.AddonID)
end

gc.DumpParseBags = function() d(gc.ParseBags()) end
gc.DumpParseGear = function() d(gc.ParseGear()) end