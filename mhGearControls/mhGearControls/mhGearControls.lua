--[[
  * Mostly Harmless's [ Gear Controls ]
  * Sponsored & Supported by: Mostly Harmless (mostly-harmless-guild.com)
  * Author: Wykkyd, aka Wykkyd Gaming (wykkyd.gaming@gmail.com)
  * Special Thanks To: Zenimax Online Studios & Bethesda for The Elder Scrolls Online
  *
  * {{ THIS ADDON REQUIRES mhFramework }}
  * 
  * This addon is designed to collect information for consumption by other addons, tools or parsers
]]--
gc = {}
gc.__index = gc
gc.AddonID = "mhGearControls"

if not fw then fw = {} end 					--[[ INSTANTIATE FRAMEWORK ]]--
if not fw.Addons then fw.Addons = {} end 	--[[ INITIALIZE ADDON REGISTRY ]]--

fw.Addons[gc.AddonID] = {}
fw.Addons[gc.AddonID].Ready = false
fw.Addons[gc.AddonID].AddonID = gc.AddonID
fw.Addons[gc.AddonID].AddonName = "[MH] Gear Controls"
fw.Addons[gc.AddonID].AddonAbbrev = "gc"
fw.Addons[gc.AddonID].AddonVersion = "1.14.1.16.1"
fw.Addons[gc.AddonID].StartUp = nil
fw.Addons[gc.AddonID].SavedVariables = nil

gc.Ready = function() return fw.Addons[gc.AddonID].Ready end
gc.AddonName = function() return fw.Addons[gc.AddonID].AddonName end
gc.AddonAbbrev = function() return fw.Addons[gc.AddonID].AddonAbbrev end
gc.AddonVersion = function() return fw.Addons[gc.AddonID].AddonVersion end
gc.AddonDescr = function() return fw.Addons[gc.AddonID].AddonName.." v"..fw.Addons[gc.AddonID].AddonVersion end
