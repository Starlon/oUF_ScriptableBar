local parent, ns = ...
local oUF = oUF
local WidgetBar = assert(LibStub("LibScriptableWidgetBar-1.0"), "oUF_ScriptableBar requires LibScriptableWidgetBar-1.0")

oUF.ALIGN_LEFT, oUF.ALIGN_CENTER, oUF.ALIGN_RIGHT, oUF.ALIGN_MARQUEE, oUF.ALIGN_AUTOMATIC, oUF.ALIGN_PINGPONG = 1, 2, 3, 4, 5, 6
oUF.SCROLL_RIGHT, oUF.SCROLL_LEFT = 1, 2

local Update = function(self)
	local widget = self.widget
	if widget and widget:GetObjectType() == "StatusBar" then
		widget:SetValue(widget.val1 * 100)
		local r, g, b, a = 1, 1, 1, 1
		
		if widget.color1 and widget.widget1 then
			r, g, b, a, = widget.color1.ret1, widget.color1.ret2, widget.color1.ret3, widget.color1.ret4
		elseif widget.color2 and widget.widget2 then
			r, g, b, a, = widget.color2.ret1, widget.color2.ret2, widget.color2.ret3, widget.color2.ret4
		end
		if type(r) == "number" then
			widget:SetStatusBarColor(r, g, b, a)
		end
	end
end

local Enable = function(self, unit)
	local bar = self.ScriptableBar
	if bar and text:GetObjectType() == "StatusBar" then
		assert(self.core)
		local col, row, layer = 0, 0, 0
		local errorLevel = 2
		local name = bar.name or "ScriptableBar"

		local widget = bar.widget or WidgetBar:New(self.core, name, text, row, col, layer, errorLevel, Update)
		if widget.configModified then widget:Init() end

		widget.environment.unit = unit
		bar.widget = widget
		bar.widget:Start()
		bar.widget.bar = text
	end
	return true
end

local Disable = function(self)
	self.widget:Stop()
	return true
end

oUF:AddElement('ScriptableBar', nil, Enable, Disable)
