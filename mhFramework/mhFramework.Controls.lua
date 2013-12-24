mhf.Controls.TBL = {}
mhf.Controls.ARRAY = {}

mhf.Controls.ArrayCount = function() return mhf.Util.CountOf(mhf.Controls.ARRAY); end
mhf.Controls.NextArrayIndex = function() return mhf.Util.NextOf(mhf.Controls.ARRAY); end

mhf.Controls.CreateInline = function(Label,parent)
	Label = mhf.Labels.New(Label)
	local i = mhf.Controls.NextArrayIndex()
	mhf.Controls.ARRAY[i] = WINDOW_MANAGER:CreateControl(Label,parent,CT_LABEL);
	return mhf.Util.CreateInline(mhf.Controls.ARRAY[i]);
end