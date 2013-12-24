mhf.Windows.TBL = {}
mhf.Windows.ARRAY = {}

mhf.Windows.ArrayCount = function() return mhf.Util.CountOf(mhf.Windows.ARRAY); end
mhf.Windows.NextArrayIndex = function() return mhf.Util.NextOf(mhf.Windows.ARRAY); end

mhf.Windows.Create = function(Label,Parent)
	Label = mhf.Labels.Register(Label)
	Parent = Parent or nil
	if not Parent then
		-- create top level window
		mhf.Windows.TBL[Label] = WINDOW_MANAGER:CreateTopLevelWindow(Label)
	end
	-- non-top level window NYI
end

mhf.Windows.CreateInline = function(Label)
	Label = mhf.Labels.Register(Label)
	local i = mhf.Windows.NextArrayIndex()
	mhf.Windows.ARRAY[i] = WINDOW_MANAGER:CreateTopLevelWindow(Label);
	return mhf.Util.CreateInline(mhf.Windows.ARRAY[i]);
end