local parent, ns = ...
local oUF = oUF
local WidgetBar = assert(LibStub("LibScriptableWidgetBar-1.0"), "oUF_ScriptableBar requires LibScriptableWidgetBar-1.0")

oUF.ALIGN_LEFT, oUF.ALIGN_CENTER, oUF.ALIGN_RIGHT, oUF.ALIGN_MARQUEE, oUF.ALIGN_AUTOMATIC, oUF.ALIGN_PINGPONG = 1, 2, 3, 4, 5, 6
oUF.SCROLL_RIGHT, oUF.SCROLL_LEFT = 1, 2

local frames = {}
local tinsert = table.insert

local Update = function(self)
	local widget = self
	local bar = widget.bar
	if bar and bar:GetObjectType() == "StatusBar" then

		bar:SetMinMaxValues(widget.min, widget.max)
		bar:SetStatusBarTexture(widget.texture)
		bar:SetValue(widget.val1 * widget.max)
		bar:SetHeight(widget.height)
		bar:SetWidth(widget.length)
		bar:Show()

		local r, g, b, a = 1, 1, 1, 1
		
		if widget.color1 then
			r, g, b, a = widget.color1.ret1, widget.color1.ret2, widget.color1.ret3, widget.color1.ret4
		end


		if type(r) == "number" then
			bar:SetStatusBarColor(r, g, b, a)
		end
	end
end

local MyUpdate = function(self, event, unit)
	if unit ~= self.unit or not self.ScriptableBar then return end
	local widget = self.ScriptableBar.widget
	widget:Update()
end

local Enable = function(self, unit)
	local bar = self.ScriptableBar
	if bar and bar:GetObjectType() == "StatusBar" then
		assert(self.core)
		local col, row, layer = 0, 0, 0
		local errorLevel = 2
		local name = bar.name or ("ScriptableBar" .. random())

		local widget = bar.widget or WidgetBar:New(self.core, name, bar, row, col, layer, errorLevel, Update)
		widget:Start(unit)
		widget.bar = bar
		bar.widget = widget
	end
	return true
end

local Disable = function(self)
	if not self.ScriptableBar then return end
	self.ScriptableBar.widget:Stop()
	return true
end

oUF:AddElement('ScriptableBar', MyUpdate, Enable, Disable)
