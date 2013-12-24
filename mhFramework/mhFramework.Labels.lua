mhf.Labels.TBL = {}

mhf.Labels.Count = function() return mhf.Util.CountOf(mhf.Labels.TBL); end
mhf.Labels.NextIndex = function() return mhf.Util.NextOf(mhf.Labels.TBL); end

mhf.Labels.New = function(Label)
	Label = Label or mhf.Globals.Constants.DEFAULT_LABEL;
	local L = Label..mhf.Labels.NextIndex();
	mhf.Labels.TBL[mhf.Labels.NextIndex()] = L;
	return L;
end

mhf.Labels.AddNew = function(Label) mhf.Labels.New(Label) end
mhf.Labels.GetNew = function(Label) mhf.Labels.New(Label) end
mhf.Labels.Register = function(Label) mhf.Labels.New(Label) end

