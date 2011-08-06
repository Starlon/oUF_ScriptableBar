local parent, ns = ...
local oUF = oUF
local WidgetBar = assert(LibStub("LibScriptableWidgetBar-1.0"), "oUF_ScriptableBar requires LibScriptableWidgetBar-1.0")

oUF.ALIGN_LEFT, oUF.ALIGN_CENTER, oUF.ALIGN_RIGHT, oUF.ALIGN_MARQUEE, oUF.ALIGN_AUTOMATIC, oUF.ALIGN_PINGPONG = 1, 2, 3, 4, 5, 6
oUF.SCROLL_RIGHT, oUF.SCROLL_LEFT = 1, 2

local Update = function(self)
	local widget = self
	local bar = widget.bar
	if bar and bar:GetObjectType() == "StatusBar" then
		bar:SetMinMaxValues(widget.min, widget.max)
		bar:SetStatusBarTexture(widget.texture)
		bar:SetValue(widget.val1 * widget.max)
		bar:SetHeight(widget.height)
		bar:SetWidth(widget.length)
		local r, g, b, a = 1, 1, 1, 1
		
		if widget.color1 and widget.widget1 then
			r, g, b, a = widget.color1.ret1, widget.color1.ret2, widget.color1.ret3, widget.color1.ret4
		elseif widget.color2 and widget.widget2 then
			r, g, b, a = widget.color2.ret1, widget.color2.ret2, widget.color2.ret3, widget.color2.ret4
		end
		if type(r) == "number" then
			bar:SetStatusBarColor(r, g, b, a)
		end
	end
print("hmmm")
end

local Enable = function(self, unit)
	local bar = self.ScriptableBar
	if bar and bar:GetObjectType() == "StatusBar" then
		assert(self.core)
		local col, row, layer = 0, 0, 0
		local errorLevel = 2
		local name = bar.name or "ScriptableBar"

		local widget = bar.widget or WidgetBar:New(self.core, name, bar, row, col, layer, errorLevel, Update)
		widget.environment.unit = unit
		widget:Start()
		widget.bar = bar
		bar.widget = widget
	end
	return true
end

local Disable = function(self)
	self.widget:Stop()
	return true
end

oUF:AddElement('ScriptableBar', nil, Enable, Disable)
