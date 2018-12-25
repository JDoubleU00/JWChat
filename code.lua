-- This file is loaded from "JWChat.toc"

ChatFrameChannelButton:Hide()   --Self-explanatory

local n = QuickJoinToastButton  --Social Button
n:UnregisterAllEvents()
n:SetScript("OnShow", n.Hide)
n:Hide()

ChatFrameMenuButton:Hide( )     -- menu button

BNToastFrame:SetClampedToScreen(true)
BNToastFrame:SetClampRectInsets(-15,15,15,-15)

function FloatingChatFrame_OnMouseScroll(self, delta)
	if delta > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else	
			self:ScrollUp()
		end
	elseif delta < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			self:ScrollDown()
		end
	end	
end

--AddMessage
local function AddMessage(self, text, ...)
  --channel replace (Trade and such)
  text = text:gsub('|h%[(%d+)%. .-%]|h', '|h%1.|h')
  --url search
  text = text:gsub('([wWhH][wWtT][wWtT][%.pP]%S+[^%p%s])', '|cffffffff|Hurl:%1|h[%1]|h|r')
  return self.DefaultAddMessage(self, text, ...)
end

-- Table to keep track of frames you already saw:
local frames = {}

-- Function to handle customzing a chat frame:
local function ProcessFrame(frame)
	if frames[frame] then return end

	frame:SetClampRectInsets(0, 0, 0, 0)
	frame:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
	frame:SetMinResize(250, 100)

	local name = frame:GetName()
	_G[name .. "ButtonFrame"]:Hide()
	_G[name .. "EditBoxLeft"]:Hide()
	_G[name .. "EditBoxMid"]:Hide()
	_G[name .. "EditBoxRight"]:Hide()

	local editbox = _G[name .. "EditBox"]
	editbox:ClearAllPoints()
	editbox:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', -7, 25)
	editbox:SetPoint('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT', 10, 25) 
	editbox:SetAltArrowKeyMode(false)

	frames[frame] = true
end

-- Get all of the permanent chat windows and customize them:
for i = 1, NUM_CHAT_WINDOWS do
	ProcessFrame(_G["ChatFrame" .. i])
	if (i ~= 2) then
    _G["ChatFrame" .. i].DefaultAddMessage = _G["ChatFrame" .. i].AddMessage
    _G["ChatFrame" .. i].AddMessage = AddMessage
  end
end

--EditBox
--[[r i = 1, NUM_CHAT_WINDOWS do
	local editBoxleft = _G[format("%s%d%s", "ChatFrame", i, "EditBoxLeft")]
    local editBoxright = _G[format("%s%d%s", "ChatFrame", i, "EditBoxRight")]
	local editBoxmid = _G[format("%s%d%s", "ChatFrame", i, "EditBoxMid")]
	editBoxleft:SetAlpha(0)
	editBoxright:SetAlpha(0)
	editBoxmid:SetAlpha(0)
end
--]]
--Classic mode hides the editbox when not in use, IM mode fades it out
--since we move the editbox above the chat tabs, we don't want it always showing
SetCVar("chatStyle", "classic")

--for i = 1, 10 do
		--local eb =  _G[format("%s%d%s", "ChatFrame", i, "EditBox")]
		--local cfs = _G[format("%s%d", "ChatFrame", i)]
		--local cfsbf = _G[format("%s%d%s", "ChatFrame", i, "ButtonFrame")]
	    
		--Allow resizing chatframes to whatever size you wish!
		--cfs:SetMinResize(100,10)
		--cfs:SetMaxResize(0,0)
	    --Allow the chat frame to move to the end of the screen
        --cfs:SetClampRectInsets(0,0,0,0)
		--Hides the ChatFrameButtonFrame for each chat window
		--cfsbf:Hide()
		
		--eb:SetAltArrowKeyMode(false)
		--eb:ClearAllPoints()
		--eb:SetPoint("BOTTOMLEFT",  cfs, "TOPLEFT",  -5, 0)
		--eb:SetPoint("BOTTOMRIGHT", cfs, "TOPRIGHT", 5, 0)
		--eb:Hide() --call this incase we're just changing to classic mode for the first time
--end


--[[-----------------------------------------------------------------------------
Sticky Channels, 0 off, 1 on.
-------------------------------------------------------------------------------]]
local StickyTypeChannels = {
  SAY = 1,
  YELL = 0,
  EMOTE = 0,
  PARTY = 1, 
  RAID = 1,
  GUILD = 1,
  OFFICER = 1,
  WHISPER = 1,
  CHANNEL = 1,
};

for k, v in pairs(StickyTypeChannels) do
    ChatTypeInfo[k].sticky = v;
end

--Turn profanity filter off
SetCVar("profanityFilter", 0)


