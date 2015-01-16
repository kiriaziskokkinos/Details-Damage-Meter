local _detalhes = 		_G._detalhes
local Loc = LibStub ("AceLocale-3.0"):GetLocale ( "Details" )
local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0")

local g =	_detalhes.gump
local _
function _detalhes:OpenWelcomeWindow ()

	GameCooltip:Close()
	local window = _G.DetailsWelcomeWindow

	if (not window) then
	
		local index = 1
		local pages = {}
		
		local instance = _detalhes.tabela_instancias [1]
		
		window = CreateFrame ("frame", "DetailsWelcomeWindow", UIParent)
		window:SetPoint ("center", UIParent, "center", -200, 0)
		window:SetWidth (512)
		window:SetHeight (265)
		window:SetMovable (true)
		window:SetScript ("OnMouseDown", function() window:StartMoving() end)
		window:SetScript ("OnMouseUp", function() window:StopMovingOrSizing() end)
		window:SetScript ("OnHide", function()
			_detalhes.tabela_historico:resetar()
		end)
		
		local background = window:CreateTexture (nil, "background")
		background:SetPoint ("topleft", window, "topleft")
		background:SetPoint ("bottomright", window, "bottomright")
		background:SetTexture ([[Interface\AddOns\Details\images\welcome]])
		
		local rodape_bg = window:CreateTexture (nil, "artwork")
		rodape_bg:SetPoint ("bottomleft", window, "bottomleft", 11, 12)
		rodape_bg:SetPoint ("bottomright", window, "bottomright", -11, 12)
		rodape_bg:SetTexture ([[Interface\Tooltips\UI-Tooltip-Background]])
		rodape_bg:SetHeight (25)
		rodape_bg:SetVertexColor (0, 0, 0, 1)
		
		local logotipo = window:CreateTexture (nil, "overlay")
		logotipo:SetPoint ("topleft", window, "topleft", 16, -20)
		logotipo:SetTexture ([[Interface\Addons\Details\images\logotipo]])
		logotipo:SetTexCoord (0.07421875, 0.73828125, 0.51953125, 0.890625)
		logotipo:SetWidth (186)
		logotipo:SetHeight (50)
		
		local cancel = CreateFrame ("Button", nil, window)
		cancel:SetWidth (22)
		cancel:SetHeight (22)
		cancel:SetPoint ("bottomleft", window, "bottomleft", 12, 14)
		cancel:SetFrameLevel (window:GetFrameLevel()+1)
		cancel:SetPushedTexture ([[Interface\Buttons\UI-GroupLoot-Pass-Down]])
		cancel:SetHighlightTexture ([[Interface\Buttons\UI-GROUPLOOT-PASS-HIGHLIGHT]])
		cancel:SetNormalTexture ([[Interface\Buttons\UI-GroupLoot-Pass-Up]])
		cancel:SetScript ("OnClick", function() window:Hide() end)
		local cancelText = cancel:CreateFontString (nil, "overlay", "GameFontNormal")
		cancelText:SetTextColor (1, 1, 1)
		cancelText:SetPoint ("left", cancel, "right", 2, 0)
		cancelText:SetText (Loc ["STRING_WELCOME_69"])
		
		local forward = CreateFrame ("button", nil, window)
		forward:SetWidth (26)
		forward:SetHeight (26)
		forward:SetPoint ("bottomright", window, "bottomright", -14, 13)
		forward:SetFrameLevel (window:GetFrameLevel()+1)
		forward:SetPushedTexture ([[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]])
		forward:SetHighlightTexture ([[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]])
		forward:SetNormalTexture ([[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]])
		forward:SetDisabledTexture ([[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]])
		
		local backward = CreateFrame ("button", nil, window)
		backward:SetWidth (26)
		backward:SetHeight (26)
		backward:SetPoint ("bottomright", window, "bottomright", -38, 13)
		backward:SetPushedTexture ([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]])
		backward:SetHighlightTexture ([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]])
		backward:SetNormalTexture ([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]])
		backward:SetDisabledTexture ([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]])
		
		forward:SetScript ("OnClick", function()
			if (index < #pages) then
				for _, widget in ipairs (pages [index]) do 
					widget:Hide()
				end
				
				index = index + 1
				
				for _, widget in ipairs (pages [index]) do 
					widget:Show()
				end
				
				if (index == #pages) then
					forward:Disable()
				end
				backward:Enable()
			end
		end)
		
		backward:SetScript ("OnClick", function()
			if (index > 1) then
				for _, widget in ipairs (pages [index]) do 
					widget:Hide()
				end
				
				index = index - 1
				
				for _, widget in ipairs (pages [index]) do 
					widget:Show()
				end
				
				if (index == 1) then
					backward:Disable()
				end
				forward:Enable()
			end
		end)

		function _detalhes:WelcomeSetLoc()
			local instance = _detalhes.tabela_instancias [1]
			instance.baseframe:ClearAllPoints()
			instance.baseframe:SetPoint ("left", DetailsWelcomeWindow, "right", 10, 0)
		end
		_detalhes:ScheduleTimer ("WelcomeSetLoc", 12)

--/script local f=CreateFrame("frame");local g=false;f:SetScript("OnUpdate",function(s,e)if not g then local r=math.random for i=1,2500000 do local a=r(1,1000000);a=a+1 end g=true else print(string.format("cpu: %.3f",e));f:SetScript("OnUpdate",nil)end end)
	
	function _detalhes:CalcCpuPower()
		local f = CreateFrame ("frame")
		local got = false
		
		f:SetScript ("OnUpdate", function (self, elapsed)
			if (not got and not InCombatLockdown()) then
				local r = math.random
				for i = 1, 2500000 do 
					local a = r (1, 1000000)
					a = a + 1
				end
				got = true
				
			elseif (not InCombatLockdown()) then
				--print ("process time:", elapsed)
				
				if (elapsed < 0.295) then
					_detalhes.use_row_animations = true
					_detalhes.update_speed = 0.30
				
				elseif (elapsed < 0.375) then
					_detalhes.use_row_animations = true
					_detalhes.update_speed = 0.40
					
				elseif (elapsed < 0.475) then
					_detalhes.use_row_animations = true
					_detalhes.update_speed = 0.5
					
				elseif (elapsed < 0.525) then
					_detalhes.update_speed = 0.5
					
				end
			
				DetailsWelcomeWindowSliderUpdateSpeed.MyObject:SetValue (_detalhes.update_speed)
				DetailsWelcomeWindowAnimateSlider.MyObject:SetValue (_detalhes.use_row_animations)

				f:SetScript ("OnUpdate", nil)
			end
		end)
	end
	
	_detalhes:ScheduleTimer ("CalcCpuPower", 10)

	--detect ElvUI
	local ElvUI = _G.ElvUI
	if (ElvUI) then
		--active elvui skin
		local instance = _detalhes.tabela_instancias [1]
		if (instance and instance.ativa) then
			if (instance.skin ~= "ElvUI Frame Style") then
				instance:ChangeSkin ("ElvUI Frame Style")
				_detalhes:SetTooltipBackdrop ("Blizzard Tooltip", 16, {1, 1, 1, 0})
			end
		end

		--save standard
		local savedObject = {}
		for key, value in pairs (instance) do
			if (_detalhes.instance_defaults [key] ~= nil) then	
				if (type (value) == "table") then
					savedObject [key] = table_deepcopy (value)
				else
					savedObject [key] = value
				end
			end
		end
		_detalhes.standard_skin = savedObject
	end
	
-- frame alert
	
	local frame_alert = CreateFrame ("frame", nil, window)
	frame_alert:SetPoint ("topright", window)
	function _detalhes:StopPlayStretchAlert()
		frame_alert.alert.animIn:Stop()
		frame_alert.alert.animOut:Play()
		_detalhes.stopwelcomealert = nil
	end
	frame_alert.alert = CreateFrame ("frame", "DetailsWelcomeWindowAlert", UIParent, "ActionBarButtonSpellActivationAlert")
	frame_alert.alert:SetFrameStrata ("FULLSCREEN")
	frame_alert.alert:Hide()	
	
local window_openned_at = time()

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 1
		
		--> introduction
		
		local angel = window:CreateTexture (nil, "border")
		angel:SetPoint ("bottomright", window, "bottomright")
		angel:SetTexture ([[Interface\TUTORIALFRAME\UI-TUTORIALFRAME-SPIRITREZ]])
		angel:SetTexCoord (0.162109375, 0.591796875, 0, 1)
		angel:SetWidth (442)
		angel:SetHeight (256)
		angel:SetAlpha (.2)
		
		local texto1 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto1:SetPoint ("topleft", window, "topleft", 13, -150)
		texto1:SetText (Loc ["STRING_WELCOME_1"])
		texto1:SetJustifyH ("left")
		
		pages [#pages+1] = {texto1, angel}
		

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> Avatar and Nickname Page

		local bg555 = window:CreateTexture (nil, "overlay")
		bg555:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg555:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg555:SetHeight (125*3)--125
		bg555:SetWidth (89*3)--82
		bg555:SetAlpha (.05)
		bg555:SetTexCoord (1, 0, 0, 1)

		local avatar_image = window:CreateTexture (nil, "overlay")
		avatar_image:SetTexture ([[Interface\EncounterJournal\UI-EJ-BOSS-Default]])
		avatar_image:SetPoint ("topright", window, "topright", -5, -21)
		avatar_image:SetWidth (128*1.2)
		avatar_image:SetHeight (64*1.2)
		
		local avatar_bg = g:NewImage (window, nil, 275, 60, nil, nil, "avatarPreview2", "$parentAvatarPreviewTexture2")
		avatar_bg:SetTexture ([[Interface\PetBattles\Weather-StaticField]])
		avatar_bg:SetPoint ("topright", window, "topright", -5, -36)
		avatar_bg:SetTexCoord (0, 1, 1, 0)
		avatar_bg:SetSize (360, 60)
		avatar_bg:SetVertexColor (.5, .5, .5, .5)
		
		local nickname = g:NewLabel (window, _, "$parentAvatarNicknameLabel", "avatarNickname", UnitName ("player"), "GameFontHighlightSmall")
		nickname:SetPoint ("center", avatar_bg, "center", 0, -15)
		_detalhes:SetFontSize (nickname.widget, 18)
		
		avatar_bg:SetDrawLayer ("overlay", 2)
		avatar_image:SetDrawLayer ("overlay", 3)
		nickname:SetDrawLayer ("overlay", 3)

		local onPressEnter = function (_, _, text)
			local accepted, errortext = _detalhes:SetNickname (text)
			if (not accepted) then
				_detalhes:Msg (errortext)
			end
			--> we call again here, because if not accepted the box return the previous value and if successful accepted, update the value for formated string.
			local nick = _detalhes:GetNickname (UnitGUID ("player"), UnitName ("player"), true)
			window.nicknameEntry.text = nick
			nickname:SetText (nick)
			nickname:SetPoint ("center", avatar_bg, "center", 0, -15)
		end
		
		local nicknamelabel = g:NewLabel (window, nil, "$parentNickNameLabel", "nicknameLabel", Loc ["STRING_OPTIONS_NICKNAME"] .. ":", "GameFontNormal")
		local nicknamebox = g:NewTextEntry (window, nil, "$parentNicknameEntry", "nicknameEntry", 140, 20, onPressEnter)
		nicknamebox:HighlightText()
		
		nicknamebox:SetPoint ("left", nicknamelabel, "right", 2, 0)
		nicknamelabel:SetPoint ("topleft", window, "topleft", 30, -160)
		
		function _detalhes:UpdateNicknameOnWelcomeWindow()
			nicknamebox:SetText (select (1, UnitName ("player")))
		end
		_detalhes:ScheduleTimer ("UpdateNicknameOnWelcomeWindow", 2)
		
		--
		
		local avatarcallback = function (textureAvatar, textureAvatarTexCoord, textureBackground, textureBackgroundTexCoord, textureBackgroundColor)
			_detalhes:SetNicknameBackground (textureBackground, textureBackgroundTexCoord, textureBackgroundColor, true)
			_detalhes:SetNicknameAvatar (textureAvatar, textureAvatarTexCoord)

			avatar_image:SetTexture (textureAvatar)
			avatar_image:SetTexCoord (1, 0, 0, 1)
			
			avatar_bg.texture = textureBackground
			local r, l, t, b = unpack (textureBackgroundTexCoord)
			avatar_bg:SetTexCoord (l, r, t, b)
			local r, g, b = unpack (textureBackgroundColor)
			avatar_bg:SetVertexColor (r, g, b, 1)
			
			_G.AvatarPickFrame.callback = nil
		end
		
		local openAtavarPickFrame = function()
			_G.AvatarPickFrame.callback = avatarcallback
			_G.AvatarPickFrame:Show()
		end
		
		local avatarbutton = g:NewButton (window, _, "$parentAvatarFrame", "chooseAvatarButton", 160, 18, openAtavarPickFrame, nil, nil, nil, "Pick Avatar", 1)
		avatarbutton:InstallCustomTexture()
		avatarbutton:SetPoint ("left", nicknamebox, "right", 10, 0)
		--

		local bg_avatar = window:CreateTexture (nil, "overlay")
		bg_avatar:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg_avatar:SetHeight (125*3)--125
		bg_avatar:SetWidth (89*3)--82
		bg_avatar:SetAlpha (.1)
		bg_avatar:SetTexCoord (1, 0, 0, 1)
		
		local texto_avatar1 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_avatar1:SetPoint ("topleft", window, "topleft", 20, -80)
		texto_avatar1:SetText (Loc ["STRING_WELCOME_60"])
		
		local texto_avatar2 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_avatar2:SetPoint ("topleft", window, "topleft", 30, -190)
		texto_avatar2:SetText (Loc ["STRING_WELCOME_61"])
		texto_avatar2:SetTextColor (1, 1, 1, 1)
		
		local changemind = g:NewLabel (window, _, "$parentChangeMindAvatarLabel", "ChangeMindAvatarLabel", Loc ["STRING_WELCOME_2"], "GameFontNormal", 9, "orange")
		changemind:SetPoint ("center", window, "center")
		changemind:SetPoint ("bottom", window, "bottom", 0, 19)
		changemind.align = "|"
		
		local texto_avatar3 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_avatar3:SetPoint ("topleft", window, "topleft", 30, -110)
		texto_avatar3:SetText (Loc ["STRING_WELCOME_62"])
		texto_avatar3:SetWidth (460)
		texto_avatar3:SetHeight (100)
		texto_avatar3:SetJustifyH ("left")
		texto_avatar3:SetJustifyV ("top")
		texto_avatar3:SetTextColor (1, 1, 1, 1)

		local pleasewait = window:CreateFontString (nil, "overlay", "GameFontHighlightSmall")
		pleasewait:SetPoint ("bottomright", forward, "topright")
		
		local free_frame3 = CreateFrame ("frame", nil, window)
		function _detalhes:FreeTutorialFrame3()
			if (window_openned_at+10 > time()) then
				pleasewait:Show()
				forward:Disable()
				pleasewait:SetText ("wait... " .. window_openned_at + 10 - time())
			else
				pleasewait:Hide()
				pleasewait:SetText ("")
				forward:Enable()
				_detalhes:CancelTimer (window.free_frame3_schedule)
				window.free_frame3_schedule = nil
			end
		end
		free_frame3:SetScript ("OnShow", function()
			if (window_openned_at+10 > time()) then
				forward:Disable()
				if (window.free_frame3_schedule) then
					_detalhes:CancelTimer (window.free_frame3_schedule)
					window.free_frame3_schedule = nil
				end
				window.free_frame3_schedule = _detalhes:ScheduleRepeatingTimer ("FreeTutorialFrame3", 1)
			end
		end)
		free_frame3:SetScript ("OnHide", function()
			if (window.free_frame3_schedule) then
				_detalhes:CancelTimer (window.free_frame3_schedule)
				window.free_frame3_schedule = nil
				pleasewait:SetText ("")
				pleasewait:Hide()
			end
		end)

		pages [#pages+1] = {pleasewait, free_frame3, bg555, bg_avatar, texto_avatar1, texto_avatar2, texto_avatar3, changemind, avatar_image, avatar_bg, nickname, nicknamelabel, nicknamebox, avatarbutton}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> Skins Page

	--SKINS

		local bg55 = window:CreateTexture (nil, "overlay")
		bg55:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg55:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg55:SetHeight (125*3)--125
		bg55:SetWidth (89*3)--82
		bg55:SetAlpha (.05)
		bg55:SetTexCoord (1, 0, 0, 1)

		local texto55 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto55:SetPoint ("topleft", window, "topleft", 20, -80)
		texto55:SetText (Loc ["STRING_WELCOME_42"])

		local texto555 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		--texto555:SetPoint ("topleft", window, "topleft", 30, -190)
		texto555:SetText (Loc ["STRING_WELCOME_45"])
		texto555:SetTextColor (1, 1, 1, 1)
		
		local changemind = g:NewLabel (window, _, "$parentChangeMind55Label", "changemind55Label", Loc ["STRING_WELCOME_2"], "GameFontNormal", 9, "orange")
		window.changemind55Label:SetPoint ("center", window, "center")
		window.changemind55Label:SetPoint ("bottom", window, "bottom", 0, 19)
		window.changemind55Label.align = "|"
		
		local texto_appearance = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_appearance:SetPoint ("topleft", window, "topleft", 30, -110)
		texto_appearance:SetText (Loc ["STRING_WELCOME_43"])
		texto_appearance:SetWidth (460)
		texto_appearance:SetHeight (100)
		texto_appearance:SetJustifyH ("left")
		texto_appearance:SetJustifyV ("top")
		texto_appearance:SetTextColor (1, 1, 1, 1)
		
		local skins_image = window:CreateTexture (nil, "overlay")
		skins_image:SetTexture ([[Interface\Addons\Details\images\icons2]])
		skins_image:SetPoint ("topright", window, "topright", -30, -24)
		skins_image:SetWidth (214)
		skins_image:SetHeight (133)
		skins_image:SetTexCoord (0, 0.41796875, 0, 0.259765625) --0, 0, 214 133
		
		--import settings
		local import_label = g:NewLabel (window, _, "$parentImportSettingsLabel", "ImportLabel", Loc ["STRING_WELCOME_46"] .. ":", "GameFontNormal")
		import_label:SetPoint ("topleft", window, "topleft", 30, -160)

		local convert_table = {
			["bartexture"] = "row_info-texture",
			["barfont"] = "row_info-font_face",
			["barfontsize"] = "row_info-font_size",
			["barspacing"] = "row_info-space-between",
			["barheight"] = "row_info-height",
			["barbgcolor"] = "row_info-fixed_texture_background_color",
			["reversegrowth"] = "bars_grow_direction",
			["barcolor"] = "row_info-fixed_texture_color",
			["title"] = "attribute_text",
			["background"] = "null"
		}
		
		local onSelectImport = function (_, _, keyname)
			--window.ImportDropdown:Select (false)
			local addon1_profile = _G.Skada.db.profile.windows [1]
			local value = addon1_profile [keyname]
			local dvalue = convert_table [keyname]
			
			if (dvalue) then
			
				local instance1 = _detalhes:GetInstance (1)
			
				if (keyname == "barbgcolor") then
					instance1.row_info.fixed_texture_background_color[1] = value.r
					instance1.row_info.fixed_texture_background_color[2] = value.g
					instance1.row_info.fixed_texture_background_color[3] = value.b
					instance1.row_info.fixed_texture_background_color[4] = value.a
					value = instance1.row_info.fixed_texture_background_color
					
				elseif (keyname == "title") then
					local v = instance1.attribute_text
					v.enabled = true
					v.text_face = value.font
					v.anchor = {-17, 4}
					v.text_size = value.fontsize
					instance1.color[1], instance1.color[2], instance1.color[3], instance1.color[4] = value.color.r, value.color.g, value.color.b, value.color.a
					value = v
					
				elseif (keyname == "background") then
					instance1.bg_alpha = value.color.a
					instance1.bg_r = value.color.r
					instance1.bg_g = value.color.g
					instance1.bg_b = value.color.b
					instance1.backdrop_texture = value.texture
					
					instance1:ChangeSkin()
					return
				end
			
				local key1, key2, key3 = strsplit ("-", dvalue)
				if (key3) then
					instance1 [key1] [key2] [key3] = value
				elseif (key2) then
					instance1 [key1] [key2] = value
				elseif (key1) then
					instance1 [key1] = value
				end
				
				instance1:ChangeSkin()
			end
			
		end

		local ImportMenu = function()
			local options = {}
			if (_G.Skada) then
				tinsert (options, {value = "bartexture", label = Loc ["STRING_WELCOME_47"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "barfont", label = Loc ["STRING_WELCOME_48"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "barfontsize", label = Loc ["STRING_WELCOME_49"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "barspacing", label = Loc ["STRING_WELCOME_50"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "barheight", label = Loc ["STRING_WELCOME_51"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "barbgcolor", label = Loc ["STRING_WELCOME_52"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "reversegrowth", label = Loc ["STRING_WELCOME_53"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "barcolor", label = Loc ["STRING_WELCOME_54"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "title", label = Loc ["STRING_WELCOME_55"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				tinsert (options, {value = "background", label = Loc ["STRING_WELCOME_56"] .. "Skada)", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
				--tinsert (options, {value = "", label = "", onclick = onSelectImport, icon = [[Interface\FriendsFrame\StatusIcon-Online]]})
			end
			return options
		end
		
		local import_dropdown = g:NewDropDown (window, _, "$parentImportDropdown", "ImportDropdown", 140, 20, ImportMenu, false)
		import_dropdown:SetPoint ("left", import_label, "right", 2, 0)
		import_dropdown.tooltip = Loc ["STRING_WELCOME_57"]
		
		--wallpapaer and skin
		local wallpaper_label_switch = g:NewLabel (window, _, "$parentBackgroundLabel", "enablewallpaperLabel", Loc ["STRING_WELCOME_44"] .. ":", "GameFontNormal")
		wallpaper_label_switch:SetPoint ("topleft", window, "topleft", 30, -200)
		
		--skin
			local onSelectSkin = function (_, _, skin_name)
				local instance1 = _detalhes:GetInstance (1)
				instance1:ChangeSkin (skin_name)
			end

			local buildSkinMenu = function()
				local skinOptions = {}
				for skin_name, skin_table in pairs (_detalhes.skins) do
					skinOptions [#skinOptions+1] = {value = skin_name, label = skin_name, onclick = onSelectSkin, icon = "Interface\\GossipFrame\\TabardGossipIcon", desc = skin_table.desc}
				end
				return skinOptions
			end
			
			local instance1 = _detalhes:GetInstance (1)
			local skin_dropdown = g:NewDropDown (window, _, "$parentSkinDropdown", "skinDropdown", 140, 20, buildSkinMenu, instance1.skin)
			skin_dropdown.tooltip = Loc ["STRING_WELCOME_58"]
			
			local skin_label = g:NewLabel (window, _, "$parentSkinLabel", "skinLabel", Loc ["STRING_OPTIONS_INSTANCE_SKIN"] .. ":", "GameFontNormal")
			skin_dropdown:SetPoint ("left", skin_label, "right", 2)
			skin_label:SetPoint ("topleft", window, "topleft", 30, -140)
			
			--skin_dropdown:Select ("WoW Interface")
		
		--> icon type
			local OnSelectIconFile = function (_, _, iconpath)
				instance1:SetBarSettings (nil, nil, nil, nil, nil, nil, nil, nil, iconpath)
				if (instance1.row_info.use_spec_icons) then
					instance1:SetBarSpecIconSettings (false)
				end
			end
			local OnSelectIconFileSpec = function (_, _, iconpath)
				instance1:SetBarSpecIconSettings (true, iconpath, true)
			end

			local iconsize = {16, 16}
			local icontexture = [[Interface\WorldStateFrame\ICONS-CLASSES]]
			local iconcoords = {0.25, 0.50, 0, 0.25}
			local list = {
				{value = [[]], label = Loc ["STRING_OPTIONS_BAR_ICONFILE1"], onclick = OnSelectIconFile, icon = icontexture, texcoord = iconcoords, iconsize = iconsize, iconcolor = {1, 1, 1, .3}},
				{value = [[Interface\AddOns\Details\images\classes_small]], label = Loc ["STRING_OPTIONS_BAR_ICONFILE2"], onclick = OnSelectIconFile, icon = icontexture, texcoord = iconcoords, iconsize = iconsize},
				{value = [[Interface\AddOns\Details\images\spec_icons_normal]], label = "Specialization", onclick = OnSelectIconFileSpec, icon = [[Interface\AddOns\Details\images\icons]], texcoord = {2/512, 32/512, 480/512, 510/512}, iconsize = iconsize},
				{value = [[Interface\AddOns\Details\images\spec_icons_normal_alpha]], label = "Specialization Alpha", onclick = OnSelectIconFileSpec, icon = [[Interface\AddOns\Details\images\icons]], texcoord = {2/512, 32/512, 480/512, 510/512}, iconsize = iconsize},
				{value = [[Interface\AddOns\Details\images\classes_small_bw]], label = Loc ["STRING_OPTIONS_BAR_ICONFILE3"], onclick = OnSelectIconFile, icon = icontexture, texcoord = iconcoords, iconsize = iconsize},
				{value = [[Interface\AddOns\Details\images\classes_small_alpha]], label = Loc ["STRING_OPTIONS_BAR_ICONFILE4"], onclick = OnSelectIconFile, icon = icontexture, texcoord = iconcoords, iconsize = iconsize},
				{value = [[Interface\AddOns\Details\images\classes_small_alpha_bw]], label = Loc ["STRING_OPTIONS_BAR_ICONFILE6"], onclick = OnSelectIconFile, icon = icontexture, texcoord = iconcoords, iconsize = iconsize},
				{value = [[Interface\AddOns\Details\images\classes]], label = Loc ["STRING_OPTIONS_BAR_ICONFILE5"], onclick = OnSelectIconFile, icon = icontexture, texcoord = iconcoords, iconsize = iconsize},
			}
			local BuiltIconList = function() 
				return list
			end
			
			local default
			if (instance1.row_info.use_spec_icons) then
				default = instance1.row_info.spec_file
			else
				default = instance1.row_info.icon_file
			end
			
			local d = g:NewDropDown (window, _, "$parentIconSelectDropdown", "IconSelectDropdown", 140, 20, BuiltIconList, default)
			
			g:NewLabel (window, _, "$parentIconsAnchor", "rowIconsLabel", Loc ["STRING_OPTIONS_TEXT_ROWICONS_ANCHOR"], "GameFontNormal")
			
			d:SetPoint ("left", window.rowIconsLabel, "right", 2)
			window.rowIconsLabel:SetPoint ("topleft", window, "topleft", 30, -180)
		
		--wallpapper
			--> agora cria os 2 dropdown da categoria e wallpaper
			
			local onSelectSecTexture = function (_, _, texturePath) 
				if (texturePath:find ("TALENTFRAME")) then
					instance1:InstanceWallpaper (texturePath, nil, nil, {0, 1, 0, 0.703125}, nil, nil, {1, 1, 1, 1})
				elseif (texturePath:find ("EncounterJournal")) then
					instance1:InstanceWallpaper (texturePath, nil, nil, {0.06, 0.68, 0.1, 0.57}, nil, nil, {1, 1, 1, 1})
				else
					instance1:InstanceWallpaper (texturePath, nil, nil, {0, 1, 0, 1}, nil, nil, {1, 1, 1, 1})
				end
			end
		
			local subMenu = {
				
				["ARCHEOLOGY"] = {
					{value = [[Interface\ARCHEOLOGY\Arch-BookCompletedLeft]], label = "Book Wallpaper", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-BookCompletedLeft]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-BookItemLeft]], label = "Book Wallpaper 2", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-BookItemLeft]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-DraeneiBIG]], label = "Draenei", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-DraeneiBIG]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-DwarfBIG]], label = "Dwarf", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-DwarfBIG]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-NightElfBIG]], label = "Night Elf", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-NightElfBIG]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-OrcBIG]], label = "Orc", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-OrcBIG]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-PandarenBIG]], label = "Pandaren", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-PandarenBIG]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-TrollBIG]], label = "Troll", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-TrollBIG]], texcoord = nil},

					{value = [[Interface\ARCHEOLOGY\ArchRare-AncientShamanHeaddress]], label = "Ancient Shaman", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-AncientShamanHeaddress]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-BabyPterrodax]], label = "Baby Pterrodax", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-BabyPterrodax]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-ChaliceMountainKings]], label = "Chalice Mountain Kings", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-ChaliceMountainKings]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-ClockworkGnome]], label = "Clockwork Gnomes", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-ClockworkGnome]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-QueenAzsharaGown]], label = "Queen Azshara Gown", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-QueenAzsharaGown]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-QuilinStatue]], label = "Quilin Statue", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-QuilinStatue]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-TempRareSketch]], label = "Rare Sketch", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-TempRareSketch]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-ScepterofAzAqir]], label = "Scepter of Az Aqir", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-ScepterofAzAqir]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-ShriveledMonkeyPaw]], label = "Shriveled Monkey Paw", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-ShriveledMonkeyPaw]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-StaffofAmmunrae]], label = "Staff of Ammunrae", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-StaffofAmmunrae]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-TinyDinosaurSkeleton]], label = "Tiny Dinosaur", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-TinyDinosaurSkeleton]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-TyrandesFavoriteDoll]], label = "Tyrandes Favorite Doll", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-TyrandesFavoriteDoll]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ArchRare-ZinRokhDestroyer]], label = "ZinRokh Destroyer", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ArchRare-ZinRokhDestroyer]], texcoord = nil},
				},
				
				["RAIDS"] = {
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-BlackrockCaverns]], label = "Blackrock Caverns", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-BlackrockCaverns]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-BlackrockSpire]], label = "Blackrock Spire", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-BlackrockSpire]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-DragonSoul]], label = "Dragon Soul", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-DragonSoul]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-EndTime]], label = "End Time", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-EndTime]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-Firelands1]], label = "Firelands", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-Firelands1]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-HallsofReflection]], label = "Halls of Reflection", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-HallsofReflection]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-HellfireCitadel]], label = "Hellfire Citadel", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-HellfireCitadel]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-Pandaria]], label = "Pandaria", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-Pandaria]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-RagefireChasm]], label = "Ragefire Chasm", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-RagefireChasm]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-SiegeofOrgrimmar]], label = "Siege of Orgrimmar", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-SiegeofOrgrimmar]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-TheNexus]], label = "The Nexus", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-TheNexus]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-TheOculus]], label = "The Oculus", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-TheOculus]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-TheStonecore]], label = "The Stonecore", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-TheStonecore]], texcoord = nil},
					{value = [[Interface\EncounterJournal\UI-EJ-LOREBG-ThunderKingRaid]], label = "Throne of Thunder", onclick = onSelectSecTexture, icon = [[Interface\EncounterJournal\UI-EJ-LOREBG-ThunderKingRaid]], texcoord = nil},
				},
			
				["LOGOS"] = {
					{value = [[Interface\Timer\Alliance-Logo]], label = "For the Alliance", onclick = onSelectSecTexture, icon = [[Interface\Timer\Alliance-Logo]], texcoord = nil},
					{value = [[Interface\Timer\Horde-Logo]], label = "For the Horde", onclick = onSelectSecTexture, icon = [[Interface\Timer\Horde-Logo]], texcoord = nil},
					{value = [[Interface\Destiny\EndscreenImage]], label = "Pandaria Logo", onclick = onSelectSecTexture, icon = [[Interface\Destiny\EndscreenImage]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ARCH-RACE-ORC]], label = "Orc Crest", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ARCH-RACE-ORC]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ARCH-RACE-DWARF]], label = "Dwarf Crest", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ARCH-RACE-DWARF]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ARCH-RACE-NIGHTELF]], label = "Night Elf Crest", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ARCH-RACE-NIGHTELF]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\Arch-Race-Pandaren]], label = "Padaren Crest", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\Arch-Race-Pandaren]], texcoord = nil},
					{value = [[Interface\ARCHEOLOGY\ARCH-RACE-TROLL]], label = "Troll Crest", onclick = onSelectSecTexture, icon = [[Interface\ARCHEOLOGY\ARCH-RACE-TROLL]], texcoord = nil},
					{value = [[Interface\FlavorImages\BloodElfLogo-small]], label = "Blood Elf Crest", onclick = onSelectSecTexture, icon = [[Interface\FlavorImages\BloodElfLogo-small]], texcoord = nil},
					{value = [[Interface\Glues\COMMON\Glues-Logo]], label = "Wow Logo", onclick = onSelectSecTexture, icon = [[Interface\Glues\COMMON\Glues-Logo]], texcoord = nil},
					{value = [[Interface\Glues\COMMON\GLUES-WOW-BCLOGO]], label = "Burning Cruzade Logo", onclick = onSelectSecTexture, icon = [[Interface\Glues\COMMON\GLUES-WOW-BCLOGO]], texcoord = nil},
					{value = [[Interface\Glues\COMMON\GLUES-WOW-CCLOGO]], label = "Cataclysm Logo", onclick = onSelectSecTexture, icon = [[Interface\Glues\COMMON\GLUES-WOW-CCLOGO]], texcoord = nil},
					{value = [[Interface\Glues\COMMON\Glues-WOW-WoltkLogo]], label = "WotLK Logo", onclick = onSelectSecTexture, icon = [[Interface\Glues\COMMON\Glues-WOW-WoltkLogo]], texcoord = nil},
				},				
			
				["CREDITS"] = {
					{value = [[Interface\Glues\CREDITS\Arakkoa2]], label = "Arakkoa", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Arakkoa2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Arcane_Golem2]], label = "Arcane Golem", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Arcane_Golem2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Badlands3]], label = "Badlands", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Badlands3]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\BD6]], label = "Draenei", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\BD6]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Draenei_Character1]], label = "Draenei 2", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Draenei_Character1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Draenei_Character2]], label = "Draenei 3", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Draenei_Character2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Draenei_Crest2]], label = "Draenei Crest", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Draenei_Crest2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Draenei_Female2]], label = "Draenei 4", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Draenei_Female2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Draenei2]], label = "Draenei 5", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Draenei2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Blood_Elf_One1]], label = "Kael'thas", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Blood_Elf_One1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\BD2]], label = "Blood Elf", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\BD2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\BloodElf_Priestess_Master2]], label = "Blood elf 2", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\BloodElf_Priestess_Master2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Female_BloodElf2]], label = "Blood Elf 3", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Female_BloodElf2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\CinSnow01TGA3]], label = "Cin Snow", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\CinSnow01TGA3]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\DalaranDomeTGA3]], label = "Dalaran", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\DalaranDomeTGA3]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Darnasis5]], label = "Darnasus", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Darnasis5]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Draenei_CityInt5]], label = "Exodar", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Draenei_CityInt5]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Shattrath6]], label = "Shattrath", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Shattrath6]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Demon_Chamber2]], label = "Demon Chamber", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Demon_Chamber2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Demon_Chamber6]], label = "Demon Chamber 2", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Demon_Chamber6]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Dwarfhunter1]], label = "Dwarf Hunter", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Dwarfhunter1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Fellwood5]], label = "Fellwood", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Fellwood5]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\HordeBanner1]], label = "Horde Banner", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\HordeBanner1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Illidan_Concept1]], label = "Illidan", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Illidan_Concept1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Illidan1]], label = "Illidan 2", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Illidan1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Naaru_CrashSite2]], label = "Naaru Crash", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Naaru_CrashSite2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\NightElves1]], label = "Night Elves", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\NightElves1]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Ocean2]], label = "Mountain", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Ocean2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Tempest_Keep2]], label = "Tempest Keep", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Tempest_Keep2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Tempest_Keep6]], label = "Tempest Keep 2", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Tempest_Keep6]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Terrokkar6]], label = "Terrokkar", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Terrokkar6]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\ThousandNeedles2]], label = "Thousand Needles", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\ThousandNeedles2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\Troll2]], label = "Troll", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\Troll2]], texcoord = nil},
					{value = [[Interface\Glues\CREDITS\LESSERELEMENTAL_FIRE_03B1]], label = "Fire Elemental", onclick = onSelectSecTexture, icon = [[Interface\Glues\CREDITS\LESSERELEMENTAL_FIRE_03B1]], texcoord = nil},
				},
			
				["DEATHKNIGHT"] = {
					{value = [[Interface\TALENTFRAME\bg-deathknight-blood]], label = "Blood", onclick = onSelectSecTexture, icon = [[Interface\ICONS\Spell_Deathknight_BloodPresence]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-deathknight-frost]], label = "Frost", onclick = onSelectSecTexture, icon = [[Interface\ICONS\Spell_Deathknight_FrostPresence]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-deathknight-unholy]], label = "Unholy", onclick = onSelectSecTexture, icon = [[Interface\ICONS\Spell_Deathknight_UnholyPresence]], texcoord = nil}
				},
				
				["DRESSUP"] = {
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-BloodElf1]], label = "Blood Elf", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.5, 0.625, 0.75, 1}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-DeathKnight1]], label = "Death Knight", onclick = onSelectSecTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["DEATHKNIGHT"]},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Draenei1]], label = "Draenei", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.5, 0.625, 0.5, 0.75}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Dwarf1]], label = "Dwarf", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.125, 0.25, 0, 0.25}},
					{value = [[Interface\DRESSUPFRAME\DRESSUPBACKGROUND-GNOME1]], label = "Gnome", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.25, 0.375, 0, 0.25}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Goblin1]], label = "Goblin", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.625, 0.75, 0.75, 1}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Human1]], label = "Human", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0, 0.125, 0.5, 0.75}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-NightElf1]], label = "Night Elf", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.375, 0.5, 0, 0.25}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Orc1]], label = "Orc", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.375, 0.5, 0.25, 0.5}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Pandaren1]], label = "Pandaren", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.75, 0.875, 0.5, 0.75}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Tauren1]], label = "Tauren", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0, 0.125, 0.25, 0.5}},
					{value = [[Interface\DRESSUPFRAME\DRESSUPBACKGROUND-TROLL1]], label = "Troll", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.25, 0.375, 0.75, 1}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Scourge1]], label = "Undead", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.125, 0.25, 0.75, 1}},
					{value = [[Interface\DRESSUPFRAME\DressUpBackground-Worgen1]], label = "Worgen", onclick = onSelectSecTexture, icon = [[Interface\Glues\CHARACTERCREATE\UI-CHARACTERCREATE-RACES]], texcoord = {0.625, 0.75, 0, 0.25}},
				},
				
				["DRUID"] = {
					{value = [[Interface\TALENTFRAME\bg-druid-bear]], label = "Guardian", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_racial_bearform]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-druid-restoration]], label = "Restoration", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_nature_healingtouch]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-druid-cat]], label = "Feral", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_shadow_vampiricaura]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-druid-balance]], label = "Balance", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_nature_starfall]], texcoord = nil}
				},
				
				["HUNTER"] = {
					{value = [[Interface\TALENTFRAME\bg-hunter-beastmaster]], label = "Beast Mastery", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_hunter_bestialdiscipline]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-hunter-marksman]], label = "Marksmanship", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_hunter_focusedaim]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-hunter-survival]], label = "Survival", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_hunter_camouflage]], texcoord = nil}
				},
				
				["MAGE"] = {
					{value = [[Interface\TALENTFRAME\bg-mage-arcane]], label = "Arcane", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_holy_magicalsentry]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-mage-fire]], label = "Fire", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_fire_firebolt02]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-mage-frost]], label = "Frost", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_frost_frostbolt02]], texcoord = nil}
				},

				["MONK"] = {
					{value = [[Interface\TALENTFRAME\bg-monk-brewmaster]], label = "Brewmaster", onclick = onSelectSecTexture, icon = [[Interface\ICONS\monk_stance_drunkenox]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-monk-mistweaver]], label = "Mistweaver", onclick = onSelectSecTexture, icon = [[Interface\ICONS\monk_stance_wiseserpent]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-monk-battledancer]], label = "Windwalker", onclick = onSelectSecTexture, icon = [[Interface\ICONS\monk_stance_whitetiger]], texcoord = nil}
				},

				["PALADIN"] = {
					{value = [[Interface\TALENTFRAME\bg-paladin-holy]], label = "Holy", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_holy_holybolt]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-paladin-protection]], label = "Protection", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_paladin_shieldofthetemplar]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-paladin-retribution]], label = "Retribution", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_holy_auraoflight]], texcoord = nil}
				},
				
				["PRIEST"] = {
					{value = [[Interface\TALENTFRAME\bg-priest-discipline]], label = "Discipline", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_holy_powerwordshield]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-priest-holy]], label = "Holy", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_holy_guardianspirit]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-priest-shadow]], label = "Shadow", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_shadow_shadowwordpain]], texcoord = nil}
				},

				["ROGUE"] = {
					{value = [[Interface\TALENTFRAME\bg-rogue-assassination]], label = "Assassination", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_rogue_eviscerate]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-rogue-combat]], label = "Combat", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_backstab]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-rogue-subtlety]], label = "Subtlety", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_stealth]], texcoord = nil}
				},

				["SHAMAN"] = {
					{value = [[Interface\TALENTFRAME\bg-shaman-elemental]], label = "Elemental", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_nature_lightning]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-shaman-enhancement]], label = "Enhancement", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_nature_lightningshield]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-shaman-restoration]], label = "Restoration", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_nature_magicimmunity]], texcoord = nil}	
				},
				
				["WARLOCK"] = {
					{value = [[Interface\TALENTFRAME\bg-warlock-affliction]], label = "Affliction", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_shadow_deathcoil]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-warlock-demonology]], label = "Demonology", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_shadow_metamorphosis]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-warlock-destruction]], label = "Destruction", onclick = onSelectSecTexture, icon = [[Interface\ICONS\spell_shadow_rainoffire]], texcoord = nil}
				},
				["WARRIOR"] = {
					{value = [[Interface\TALENTFRAME\bg-warrior-arms]], label = "Arms", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_warrior_savageblow]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-warrior-fury]], label = "Fury", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_warrior_innerrage]], texcoord = nil},
					{value = [[Interface\TALENTFRAME\bg-warrior-protection]], label = "Protection", onclick = onSelectSecTexture, icon = [[Interface\ICONS\ability_warrior_defensivestance]], texcoord = nil}
				},
			}
		
			local buildBackgroundMenu2 = function() 
				return  subMenu [window.backgroundDropdown.value] or {label = "-- -- --", value = 0}
			end
		
			local onSelectMainTexture = function (_, _, choose)
				window.backgroundDropdown2:Select (choose)
			end
		
			local backgroundTable = {
				{value = "ARCHEOLOGY", label = "Archeology", onclick = onSelectMainTexture, icon = [[Interface\ARCHEOLOGY\Arch-Icon-Marker]]},
				{value = "CREDITS", label = "Burning Crusade", onclick = onSelectMainTexture, icon = [[Interface\ICONS\TEMP]]},
				{value = "LOGOS", label = "Logos", onclick = onSelectMainTexture, icon = [[Interface\WorldStateFrame\ColumnIcon-FlagCapture0]]},
				{value = "DRESSUP", label = "Race Background", onclick = onSelectMainTexture, icon = [[Interface\ICONS\INV_Chest_Cloth_17]]},
				{value = "RAIDS", label = "Dungeons & Raids", onclick = onSelectMainTexture, icon = [[Interface\COMMON\friendship-FistHuman]]},
				{value = "DEATHKNIGHT", label = "Death Knight", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["DEATHKNIGHT"]},
				{value = "DRUID", label = "Druid", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["DRUID"]},
				{value = "HUNTER", label = "Hunter", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["HUNTER"]},
				{value = "MAGE", label = "Mage", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["MAGE"]},
				{value = "MONK", label = "Monk", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["MONK"]},
				{value = "PALADIN", label = "Paladin", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["PALADIN"]},
				{value = "PRIEST", label = "Priest", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["PRIEST"]},
				{value = "ROGUE", label = "Rogue", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["ROGUE"]},
				{value = "SHAMAN", label = "Shaman", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["SHAMAN"]},
				{value = "WARLOCK", label = "Warlock", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["WARLOCK"]},
				{value = "WARRIOR", label = "Warrior", onclick = onSelectMainTexture, icon = _detalhes.class_icons_small, texcoord = _detalhes.class_coords ["WARRIOR"]},
			}
			local buildBackgroundMenu = function() return backgroundTable end		
			
			local wallpaper_switch = g:NewSwitch (window, _, "$parentUseBackgroundSlider", "useBackgroundSlider", 60, 20, _, _, instance.wallpaper.enabled)
			wallpaper_switch.tooltip = Loc ["STRING_WELCOME_59"]
			local wallpaper_dropdown1 = g:NewDropDown (window, _, "$parentBackgroundDropdown", "backgroundDropdown", 150, 20, buildBackgroundMenu, nil)
			local wallpaper_dropdown2 = g:NewDropDown (window, _, "$parentBackgroundDropdown2", "backgroundDropdown2", 150, 20, buildBackgroundMenu2, nil)

			wallpaper_switch:SetPoint ("left", wallpaper_label_switch, "right", 2)
			wallpaper_dropdown1:SetPoint ("left", wallpaper_switch, "right", 2)
			wallpaper_dropdown2:SetPoint ("left", wallpaper_dropdown1, "right", 2)
			
			function _detalhes:WelcomeWallpaperRefresh()
				local spec = GetSpecialization()
				if (spec) then
					local id, name, description, icon, _background, role = GetSpecializationInfo (spec)
					if (_background) then
						local _, class = UnitClass ("player")
						
						local titlecase = function (first, rest)
							return first:upper()..rest:lower()
						end
						class = class:gsub ("(%a)([%w_']*)", titlecase)
						
						local bg = "Interface\\TALENTFRAME\\" .. _background
						
						wallpaper_dropdown1:Select (class)
						wallpaper_dropdown2:Select (1, true)
						
						instance.wallpaper.texture = bg
						instance.wallpaper.texcoord = {0, 1, 0, 0.703125}
						
					end
				end
			end
			
			_detalhes:ScheduleTimer ("WelcomeWallpaperRefresh", 5)
			
			wallpaper_switch.OnSwitch = function (_, _, value)
				instance.wallpaper.enabled = value
				if (value) then
					--> primeira vez que roda:
					if (not instance.wallpaper.texture) then
						local spec = GetSpecialization()
						if (spec) then
							local id, name, description, icon, _background, role = GetSpecializationInfo (spec)
							if (_background) then
								instance.wallpaper.texture = "Interface\\TALENTFRAME\\".._background
							end
						end
						instance.wallpaper.texcoord = {0, 1, 0, 0.703125}
					end
					
					instance.wallpaper.alpha = 0.35

					instance:InstanceWallpaper (true)
				else
					instance:InstanceWallpaper (false)
				end
			end
			
		local created_test_bars = 0
		local skins_frame_alert = CreateFrame ("frame", nil, window)
		skins_frame_alert:SetScript ("OnShow", function()
			if (created_test_bars < 2) then
				_detalhes:CreateTestBars()
				created_test_bars = created_test_bars + 1
			end
		end)

		pages [#pages+1] = {import_label, import_dropdown, skins_frame_alert, bg55, texto55, texto555, skins_image, changemind, texto_appearance, skin_dropdown, skin_label, wallpaper_label_switch, wallpaper_switch, wallpaper_dropdown1, wallpaper_dropdown2, window.rowIconsLabel, window.IconSelectDropdown}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 2
		
	-- DPS effective or active
		
		local ampulheta = window:CreateTexture (nil, "overlay")
		ampulheta:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		ampulheta:SetPoint ("bottomright", window, "bottomright", -10, 10)
		ampulheta:SetHeight (125*3)--125
		ampulheta:SetWidth (89*3)--82
		ampulheta:SetAlpha (.05)
		ampulheta:SetTexCoord (1, 0, 0, 1)		
		
		g:NewLabel (window, _, "$parentChangeMind2Label", "changemind2Label", Loc ["STRING_WELCOME_2"], "GameFontNormal", 9, "orange")
		window.changemind2Label:SetPoint ("center", window, "center")
		window.changemind2Label:SetPoint ("bottom", window, "bottom", 0, 19)
		window.changemind2Label.align = "|"

		local texto2 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto2:SetPoint ("topleft", window, "topleft", 20, -80)
		texto2:SetText (Loc ["STRING_WELCOME_3"])
		
		local chronometer = CreateFrame ("CheckButton", "WelcomeWindowChronometer", window, "ChatConfigCheckButtonTemplate")
		chronometer:SetPoint ("topleft", window, "topleft", 40, -110)
		local continuous = CreateFrame ("CheckButton", "WelcomeWindowContinuous", window, "ChatConfigCheckButtonTemplate")
		continuous:SetPoint ("topleft", window, "topleft", 40, -160)
		
		_G ["WelcomeWindowChronometerText"]:SetText (Loc ["STRING_WELCOME_4"])
		_G ["WelcomeWindowContinuousText"]:SetText (Loc ["STRING_WELCOME_5"])
		
		local sword_icon = window:CreateTexture (nil, "overlay")
		sword_icon:SetTexture ([[Interface\TUTORIALFRAME\UI-TutorialFrame-AttackCursor]])
		sword_icon:SetPoint ("topright", window, "topright", -15, -30)
		sword_icon:SetWidth (64*1.4)
		sword_icon:SetHeight (64*1.4)
		sword_icon:SetTexCoord (1, 0, 0, 1)
		sword_icon:SetDrawLayer ("overlay", 2)
		local thedude = window:CreateTexture (nil, "overlay")
		thedude:SetTexture ([[Interface\TUTORIALFRAME\UI-TutorialFrame-TheDude]])
		thedude:SetPoint ("bottomright", sword_icon, "bottomleft", 70, 19)
		thedude:SetWidth (128*1.0)
		thedude:SetHeight (128*1.0)
		thedude:SetTexCoord (0, 1, 0, 1)
		thedude:SetDrawLayer ("overlay", 3)
		
		local chronometer_text = window:CreateFontString (nil, "overlay", "GameFontNormal")
		chronometer_text:SetText (Loc ["STRING_WELCOME_6"])
		chronometer_text:SetWidth (360)
		chronometer_text:SetHeight (40)
		chronometer_text:SetJustifyH ("left")
		chronometer_text:SetJustifyV ("top")
		chronometer_text:SetTextColor (.8, .8, .8, 1)
		chronometer_text:SetPoint ("topleft", _G ["WelcomeWindowChronometerText"], "topright", 0, 0)
		
		local continuous_text = window:CreateFontString (nil, "overlay", "GameFontNormal")
		continuous_text:SetText (Loc ["STRING_WELCOME_7"])
		continuous_text:SetWidth (340)
		continuous_text:SetHeight (40)
		continuous_text:SetJustifyH ("left")
		continuous_text:SetJustifyV ("top")
		continuous_text:SetTextColor (.8, .8, .8, 1)
		continuous_text:SetPoint ("topleft", _G ["WelcomeWindowContinuousText"], "topright", 0, 0)
		
		chronometer:SetHitRectInsets (0, -70, 0, 0)
		continuous:SetHitRectInsets (0, -70, 0, 0)
		
		if (_detalhes.time_type == 1) then --> chronometer
			chronometer:SetChecked (true)
			continuous:SetChecked (false)
		elseif (_detalhes.time_type == 2) then --> continuous
			chronometer:SetChecked (false)
			continuous:SetChecked (true)
		end
		
		chronometer:SetScript ("OnClick", function() continuous:SetChecked (false); _detalhes.time_type = 1 end)
		continuous:SetScript ("OnClick", function() chronometer:SetChecked (false); _detalhes.time_type = 2 end)
		
		pages [#pages+1] = {thedude, sword_icon, ampulheta, texto2, chronometer, continuous, chronometer_text, continuous_text, window.changemind2Label}
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 4

	-- UPDATE SPEED
		
		local bg = window:CreateTexture (nil, "overlay")
		bg:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg:SetHeight (125*3)--125
		bg:SetWidth (89*3)--82
		bg:SetAlpha (.05)
		bg:SetTexCoord (1, 0, 0, 1)
		
		g:NewLabel (window, _, "$parentChangeMind4Label", "changemind4Label", Loc ["STRING_WELCOME_11"], "GameFontNormal", 9, "orange")
		window.changemind4Label:SetPoint ("center", window, "center")
		window.changemind4Label:SetPoint ("bottom", window, "bottom", 0, 19)
		window.changemind4Label.align = "|"
		
		local texto4 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto4:SetPoint ("topleft", window, "topleft", 20, -80)
		texto4:SetText (Loc ["STRING_WELCOME_41"])
		
		local interval_text = window:CreateFontString (nil, "overlay", "GameFontNormal")
		interval_text:SetText (Loc ["STRING_WELCOME_12"])
		interval_text:SetWidth (460)
		interval_text:SetHeight (40)
		interval_text:SetJustifyH ("left")
		interval_text:SetJustifyV ("top")
		interval_text:SetTextColor (1, 1, 1, .9)
		interval_text:SetPoint ("topleft", window, "topleft", 30, -110)
		
		local dance_text = window:CreateFontString (nil, "overlay", "GameFontNormal")
		dance_text:SetText (Loc ["STRING_WELCOME_13"])
		dance_text:SetWidth (460)
		dance_text:SetHeight (40)
		dance_text:SetJustifyH ("left")
		dance_text:SetJustifyV ("top")
		dance_text:SetTextColor (1, 1, 1, 1)
		dance_text:SetPoint ("topleft", window, "topleft", 30, -175)
		
	--------------- Update Speed
		g:NewLabel (window, _, "$parentUpdateSpeedLabel", "updatespeedLabel", Loc ["STRING_WELCOME_14"] .. ":", "GameFontNormal")
		window.updatespeedLabel:SetPoint (31, -150)
		--
		
		g:NewSlider (window, _, "$parentSliderUpdateSpeed", "updatespeedSlider", 160, 20, 0.050, 3, 0.050, _detalhes.update_speed, true) --parent, container, name, member, w, h, min, max, step, defaultv
		window.updatespeedSlider:SetPoint ("left", window.updatespeedLabel, "right", 2, 0)
		window.updatespeedSlider:SetThumbSize (50)
		window.updatespeedSlider.useDecimals = true
		local updateColor = function (slider, value)
			if (value < 1) then
				slider.amt:SetTextColor (1, value, 0)
			elseif (value > 1) then
				slider.amt:SetTextColor (-(value-3), 1, 0)
			else
				slider.amt:SetTextColor (1, 1, 0)
			end
		end
		window.updatespeedSlider:SetHook ("OnValueChange", function (self, _, amount) 
			_detalhes:CancelTimer (_detalhes.atualizador)
			_detalhes.update_speed = amount
			_detalhes.atualizador = _detalhes:ScheduleRepeatingTimer ("AtualizaGumpPrincipal", _detalhes.update_speed, -1)
			updateColor (self, amount)
		end)
		updateColor (window.updatespeedSlider, _detalhes.update_speed)
		
		window.updatespeedSlider:SetHook ("OnEnter", function()
			_detalhes:CooltipPreset (1)
			GameCooltip:AddLine (Loc ["STRING_WELCOME_15"])
			GameCooltip:ShowCooltip (window.updatespeedSlider, "tooltip")
			return true
		end)
		
		window.updatespeedSlider.tooltip = Loc ["STRING_WELCOME_15"]
		
	--------------- Animate Rows
		g:NewLabel (window, _, "$parentAnimateLabel", "animateLabel", Loc ["STRING_WELCOME_16"] .. ":", "GameFontNormal")
		window.animateLabel:SetPoint (31, -170)
		--
		g:NewSwitch (window, _, "$parentAnimateSlider", "animateSlider", 60, 20, _, _, _detalhes.use_row_animations) -- ltext, rtext, defaultv
		window.animateSlider:SetPoint ("left",window.animateLabel, "right", 2, 0)
		window.animateSlider.OnSwitch = function (self, _, value) --> slider, fixedValue, sliderValue (false, true)
			_detalhes:SetUseAnimations (value)
		end	
		window.animateSlider.tooltip = Loc ["STRING_WELCOME_17"]
		
	--------------- Fast Hps/Dps Updates
	--[
		g:NewLabel (window, _, "$parentDpsHpsLabel", "DpsHpsLabel", Loc ["STRING_WELCOME_63"] .. ":", "GameFontNormal")
		window.DpsHpsLabel:SetPoint (31, -190)
		--
		g:NewSwitch (window, _, "$parentDpsHpsSlider", "DpsHpsSlider", 60, 20, _, _, _detalhes:GetInstance(1).row_info.fast_ps_update) -- ltext, rtext, defaultv
		window.DpsHpsSlider:SetPoint ("left",window.DpsHpsLabel, "right", 2, 0)
		window.DpsHpsSlider.OnSwitch = function (self, _, value) --> slider, fixedValue, sliderValue (false, true)
			_detalhes:GetInstance(1):FastPSUpdate (value)
		end	
		window.DpsHpsSlider.tooltip = Loc ["STRING_WELCOME_64"]
	--]]
	--------------- Max Segments
		g:NewLabel (window, _, "$parentSliderLabel", "segmentsLabel", Loc ["STRING_WELCOME_21"] .. ":", "GameFontNormal")
		window.segmentsLabel:SetPoint (31, -210)
		--
		g:NewSlider (window, _, "$parentSlider", "segmentsSlider", 120, 20, 1, 25, 1, _detalhes.segments_amount) -- min, max, step, defaultv
		window.segmentsSlider:SetPoint ("left", window.segmentsLabel, "right", 2, 0)
		window.segmentsSlider:SetHook ("OnValueChange", function (self, _, amount) --> slider, fixedValue, sliderValue
			_detalhes.segments_amount = math.floor (amount)
		end)
		window.segmentsSlider.tooltip = Loc ["STRING_WELCOME_22"]
		
	--------------
		local mech_icon = window:CreateTexture (nil, "overlay")
		mech_icon:SetTexture ([[Interface\Vehicles\UI-Vehicles-Endcap-Alliance]])
		mech_icon:SetPoint ("topright", window, "topright", -15, -15)
		mech_icon:SetWidth (128*0.9)
		mech_icon:SetHeight (128*0.9)
		mech_icon:SetAlpha (0.8)
		
		local mech_icon2 = window:CreateTexture (nil, "overlay")
		mech_icon2:SetTexture ([[Interface\Vehicles\UI-Vehicles-Trim-Alliance]])
		mech_icon2:SetPoint ("topright", window, "topright", -10, -151)
		mech_icon2:SetWidth (128*1.0)
		mech_icon2:SetHeight (128*0.6)
		mech_icon2:SetAlpha (0.6)
		mech_icon2:SetTexCoord (0, 1, 40/128, 1)
		mech_icon2:SetDrawLayer ("overlay", 2)

		local update_frame_alert = CreateFrame ("frame", nil, window)
		update_frame_alert:SetScript ("OnShow", function()
		
			_detalhes.tabela_historico:resetar()
			created_test_bars = 0
			
			_detalhes.zone_type = "pvp"
			
			_detalhes:EntrarEmCombate()
			
			_detalhes:StartTestBarUpdate()
			
			if (created_test_bars < 2) then
				_detalhes:CreateTestBars()
				created_test_bars = created_test_bars + 1
			end
			
			local instance = _detalhes:GetInstance (1)
			instance:SetMode (3)
		end)
		
		update_frame_alert:SetScript ("OnHide", function()
			_detalhes:StopTestBarUpdate()
			
			_detalhes.parser_functions:ZONE_CHANGED_NEW_AREA()
			_detalhes:SairDoCombate()
			
			instance:SetMode (2)
		end)
	
	----------------
		
		pages [#pages+1] = {update_frame_alert, mech_icon2, mech_icon, window.segmentsLabel, window.segmentsSlider, bg, texto4, interval_text, dance_text, window.updatespeedLabel, window.updatespeedSlider, window.animateLabel, window.animateSlider, window.changemind4Label, window.DpsHpsLabel, window.DpsHpsSlider}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 6
-- stretcher

		local bg6 = window:CreateTexture (nil, "overlay")
		bg6:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg6:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg6:SetHeight (125*3)--125
		bg6:SetWidth (89*3)--82
		bg6:SetAlpha (.1)
		bg6:SetTexCoord (1, 0, 0, 1)

		local texto5 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto5:SetPoint ("topleft", window, "topleft", 20, -80)
		texto5:SetText (Loc ["STRING_WELCOME_26"])
		
		local texto_stretch = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_stretch:SetPoint ("topleft", window, "topleft", 181, -105)
		texto_stretch:SetText (Loc ["STRING_WELCOME_27"])
		texto_stretch:SetWidth (310)
		texto_stretch:SetHeight (100)
		texto_stretch:SetJustifyH ("left")
		texto_stretch:SetJustifyV ("top")
		texto_stretch:SetTextColor (1, 1, 1, 1)
		
		local stretch_image = window:CreateTexture (nil, "overlay")
		stretch_image:SetTexture ([[Interface\Addons\Details\images\icons]])
		stretch_image:SetPoint ("right", texto_stretch, "left", -12, 0)
		stretch_image:SetWidth (144)
		stretch_image:SetHeight (61)
		stretch_image:SetTexCoord (0.716796875, 1, 0.876953125, 1)
		
		local stretch_frame_alert = CreateFrame ("frame", nil, window)
		stretch_frame_alert:SetScript ("OnHide", function()
			_detalhes:StopPlayStretchAlert()
		end)
		stretch_frame_alert:SetScript ("OnShow", function()
			local instance = _detalhes:GetInstance (1)
			_detalhes.OnEnterMainWindow (instance)
			instance.baseframe.button_stretch:SetAlpha (1)
			frame_alert.alert:SetPoint ("topleft", instance.baseframe.button_stretch, "topleft", -20, 6)
			frame_alert.alert:SetPoint ("bottomright", instance.baseframe.button_stretch, "bottomright", 20, -14)
			
			frame_alert.alert.animOut:Stop()
			frame_alert.alert.animIn:Play()
			if (_detalhes.stopwelcomealert) then
				_detalhes:CancelTimer (_detalhes.stopwelcomealert)
			end
			_detalhes.stopwelcomealert = _detalhes:ScheduleTimer ("StopPlayStretchAlert", 30)
		end)

		
		pages [#pages+1] = {bg6, texto5, stretch_image, texto_stretch, stretch_frame_alert}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 7
-- window button

		local bg6 = window:CreateTexture (nil, "overlay")
		bg6:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg6:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg6:SetHeight (125*3)--125
		bg6:SetWidth (89*3)--82
		bg6:SetAlpha (.1)
		bg6:SetTexCoord (1, 0, 0, 1)

		local texto6 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto6:SetPoint ("topleft", window, "topleft", 20, -80)
		texto6:SetText (Loc ["STRING_WELCOME_28"])
		
		local texto_instance_button = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_instance_button:SetPoint ("topleft", window, "topleft", 25, -105)
		texto_instance_button:SetText (Loc ["STRING_WELCOME_29"])
		texto_instance_button:SetWidth (270)
		texto_instance_button:SetHeight (100)
		texto_instance_button:SetJustifyH ("left")
		texto_instance_button:SetJustifyV ("top")
		texto_instance_button:SetTextColor (1, 1, 1, 1)
		
		local instance_button_image = window:CreateTexture (nil, "overlay")
		instance_button_image:SetTexture ([[Interface\Addons\Details\images\icons]])
		instance_button_image:SetPoint ("topright", window, "topright", -16, -70)
		instance_button_image:SetWidth (198)
		instance_button_image:SetHeight (141)
		instance_button_image:SetTexCoord (0.328125, 0.71484375, 0.724609375, 1)
		
		local instance_frame_alert = CreateFrame ("frame", nil, window)
		instance_frame_alert:SetScript ("OnHide", function()
			_detalhes:StopPlayStretchAlert()
		end)
		instance_frame_alert:SetScript ("OnShow", function()
			local instance = _detalhes:GetInstance (1)

			frame_alert.alert:SetPoint ("topleft", instance.baseframe.cabecalho.modo_selecao.widget, "topleft", -8, 6)
			frame_alert.alert:SetPoint ("bottomright", instance.baseframe.cabecalho.modo_selecao.widget, "bottomright", 8, -6)
			
			frame_alert.alert.animOut:Stop()
			frame_alert.alert.animIn:Play()
			if (_detalhes.stopwelcomealert) then
				_detalhes:CancelTimer (_detalhes.stopwelcomealert)
			end
			_detalhes.stopwelcomealert = _detalhes:ScheduleTimer ("StopPlayStretchAlert", 30)
		end)
		
		pages [#pages+1] = {bg6, texto6, instance_button_image, texto_instance_button, instance_frame_alert}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 8
-- bookmark

		local bg7 = window:CreateTexture (nil, "overlay")
		bg7:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg7:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg7:SetHeight (125*3)--125
		bg7:SetWidth (89*3)--82
		bg7:SetAlpha (.1)
		bg7:SetTexCoord (1, 0, 0, 1)

		local texto7 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto7:SetPoint ("topleft", window, "topleft", 20, -80)
		texto7:SetText (Loc ["STRING_WELCOME_30"])
		
		local texto_shortcut = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_shortcut:SetPoint ("topleft", window, "topleft", 25, -110)
		texto_shortcut:SetText (Loc ["STRING_WELCOME_31"])
		texto_shortcut:SetWidth (290)
		texto_shortcut:SetHeight (90)
		texto_shortcut:SetJustifyH ("left")
		texto_shortcut:SetJustifyV ("top")
		texto_shortcut:SetTextColor (1, 1, 1, 1)
		
		local shortcut_image2 = window:CreateTexture (nil, "overlay")
		shortcut_image2:SetTexture ([[Interface\Addons\Details\images\icons]])
		shortcut_image2:SetPoint ("topright", window, "topright", -22, -87)
		shortcut_image2:SetWidth (165)
		shortcut_image2:SetHeight (119)
		shortcut_image2:SetTexCoord (2/512, 167/512, 306/512, 425/512)

		
		local instance1 = _detalhes:GetInstance (1)
		
		local bookmark_frame = CreateFrame ("frame", "WelcomeBookmarkFrame", window)
		bookmark_frame:SetPoint ("topleft", instance1.baseframe, "topleft")
		bookmark_frame:SetPoint ("bottomright", instance1.baseframe, "bottomright")
		bookmark_frame:SetBackdrop ({bgFile = [[Interface\AddOns\Details\images\background]], tile = true, tileSize = 64})
		bookmark_frame:SetBackdropColor (0, 0, 0, 0.8)

		local desc_anchor_topleft = _detalhes.gump:NewImage (bookmark_frame, [[Interface\AddOns\Details\images\options_window]], 75, 106, "artwork", {0.19921875, 0.2724609375, 0.6796875, 0.783203125}, "descAnchorBottomLeftImage", "$parentDescAnchorBottomLeftImage") --204 696 279 802
		desc_anchor_topleft:SetPoint ("topleft", bookmark_frame, "topleft", -5, 5)
		
		local desc_anchor_bottomleft = _detalhes.gump:NewImage (bookmark_frame, [[Interface\AddOns\Details\images\options_window]], 75, 106, "artwork", {0.2724609375, 0.19921875, 0.783203125, 0.6796875}, "descAnchorTopLeftImage", "$parentDescAnchorTopLeftImage") --204 696 279 802
		desc_anchor_bottomleft:SetPoint ("bottomright", bookmark_frame, "bottomright", 5, -5)
		
		local bmf_string = bookmark_frame:CreateFontString ("overlay", nil, "GameFontNormal")
		bmf_string:SetPoint ("center", bookmark_frame, "center")
		bmf_string:SetText (Loc ["STRING_WELCOME_65"])
		
		local bg_string = _detalhes.gump:NewImage (bookmark_frame, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-RecentHeader]], 256, 32, "border", {0, 1, 0, 23/32})
		bg_string:SetPoint ("left", bookmark_frame, "left", 0, 0)
		bg_string:SetPoint ("right", bookmark_frame, "right", 0, 0)
		bg_string:SetPoint ("center", bmf_string, "center", 0, 0)
		
		bookmark_frame:SetScript ("OnMouseDown", function (self, button)
			if (button == "RightButton") then
				_detalhes.switch:ShowMe (instance1)
				self:Hide()
			end
		end)
		
		pages [#pages+1] = {bg7, texto7, shortcut_image2, texto_shortcut, bookmark_frame}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 9
-- group windows

		local bg77 = window:CreateTexture (nil, "overlay")
		bg77:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg77:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg77:SetHeight (125*3)--125
		bg77:SetWidth (89*3)--82
		bg77:SetAlpha (.1)
		bg77:SetTexCoord (1, 0, 0, 1)

		local texto77 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto77:SetPoint ("topleft", window, "topleft", 20, -80)
		texto77:SetText (Loc ["STRING_WELCOME_32"])
		
		local texto_snap = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_snap:SetPoint ("topleft", window, "topleft", 25, -101)
		texto_snap:SetText (Loc ["STRING_WELCOME_66"])
		texto_snap:SetWidth (160)
		texto_snap:SetHeight (110)
		texto_snap:SetJustifyH ("left")
		texto_snap:SetJustifyV ("top")
		texto_snap:SetTextColor (1, 1, 1, 1)
		local fonte, _, flags = texto_snap:GetFont()
		texto_snap:SetFont (fonte, 11, flags)
		
		local snap_image1 = window:CreateTexture (nil, "overlay")
		snap_image1:SetTexture ([[Interface\Addons\Details\images\icons]])
		snap_image1:SetPoint ("topright", window, "topright", -12, -95)
		snap_image1:SetWidth (310)
		snap_image1:SetHeight (102) 
		snap_image1:SetTexCoord (0, 0.60546875, 191/512, 293/512)

		local group_frame_alert = CreateFrame ("frame", nil, window)
		group_frame_alert:SetScript ("OnShow", function()
			_detalhes.tabela_historico:resetar()
			created_test_bars = 0
		end)
		
		pages [#pages+1] = {bg77, texto77, snap_image1, texto_snap, group_frame_alert}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 10
-- tooltip shift alt ctrl

		local bg88 = window:CreateTexture (nil, "overlay")
		bg88:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg88:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg88:SetHeight (125*3)--125
		bg88:SetWidth (89*3)--82
		bg88:SetAlpha (.1)
		bg88:SetTexCoord (1, 0, 0, 1)

		local texto88 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto88:SetPoint ("topleft", window, "topleft", 20, -80)
		texto88:SetText (Loc ["STRING_WELCOME_34"])

		local texto_micro_display = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_micro_display:SetPoint ("topleft", window, "topleft", 25, -101)
		texto_micro_display:SetText (Loc ["STRING_WELCOME_67"])
		texto_micro_display:SetWidth (300)
		texto_micro_display:SetHeight (110)
		texto_micro_display:SetJustifyH ("left")
		texto_micro_display:SetJustifyV ("top")
		texto_micro_display:SetTextColor (1, 1, 1, 1)
		
		local micro_image1 = window:CreateTexture (nil, "overlay")
		micro_image1:SetTexture ([[Interface\Addons\Details\images\icons]])
		micro_image1:SetPoint ("topright", window, "topright", -15, -70)
		micro_image1:SetWidth (186)
		micro_image1:SetHeight (100)
		micro_image1:SetTexCoord (326/512, 1, 85/512, 185/512)
		
		local tooltip_frame = CreateFrame ("frame", nil, window)
		tooltip_frame:SetScript ("OnShow", function (self)
		
			_detalhes.tabela_historico:resetar()
			created_test_bars = 0
			
			local current_combat = _detalhes:GetCombat ("current")
			local actors_classes = CLASS_SORT_ORDER
			local total_damage = 0
			local total_heal = 0
			
			local joe = current_combat[1]:PegarCombatente (0x0000000000000, "Joe", 0x114, true)
			joe.grupo = true
			joe.classe = actors_classes [math.random (1, #actors_classes)]
			joe.total = 7500000
			joe.total_without_pet = 7500000
			joe.damage_taken = math.random (100000, 600000)
			joe.friendlyfire_total = math.random (100000, 600000)
			
			total_damage = total_damage + joe.total

			--local joe_death = current_combat[4]:PegarCombatente (0x0000000000000, joe.nome, 0x114, true)
			--joe_death.grupo = true
			--joe_death.classe = joe.classe
			--local esta_morte = {{true, 96648, 100000, time(), 0, "Lady Holenna"}, {true, 96648, 100000, time()-52, 100000, "Lady Holenna"}, {true, 96648, 100000, time()-86, 200000, "Lady Holenna"}, {true, 96648, 100000, time()-101, 300000, "Lady Holenna"}, {false, 55296, 400000, time()-54, 400000, "King Djoffrey"}, {true, 14185, 0, time()-59, 400000, "Lady Holenna"}, {false, 87351, 400000, time()-154, 400000, "King Djoffrey"}, {false, 56236, 400000, time()-158, 400000, "King Djoffrey"} } 
			--local t = {esta_morte, time(), joe.nome, joe.classe, 400000, "52m 12s",  ["dead"] = true}
			--table.insert (current_combat.last_events_tables, #current_combat.last_events_tables+1, t)
			
			rawset (_detalhes.spellcache, 300000, {"A Gun in Your Hand", 300000, [[Interface\ICONS\INV_Legendary_Gun]]})
			rawset (_detalhes.spellcache, 300001, {"Shot", 300001, [[Interface\ICONS\INV_Archaeology_Ogres_HarGunn_Eye]]})
			rawset (_detalhes.spellcache, 300002, {"Mexico Travel", 300002, [[Interface\ICONS\Achievement_Dungeon_Gundrak_Normal]]})
			rawset (_detalhes.spellcache, 300003, {"Rope", 300003, [[Interface\ICONS\Creatureportrait_RopeLadder01]]})
			
			joe.targets ["My Old Lady"] = 3500000
			joe.targets ["My Self"] = 2000000
			joe.targets ["Another Man"] = 1000001
			joe.targets ["Another Random Guy"] = 1000001
			
			joe.spells:PegaHabilidade (300000, true, "SPELL_DAMAGE"); joe.spells._ActorTable [300000].total = 3500000
			joe.spells:PegaHabilidade (300001, true, "SPELL_DAMAGE"); joe.spells._ActorTable [300001].total = 1000001
			joe.spells:PegaHabilidade (300002, true, "SPELL_DAMAGE"); joe.spells._ActorTable [300002].total = 1000001
			joe.spells:PegaHabilidade (300003, true, "SPELL_DAMAGE"); joe.spells._ActorTable [300003].total = 2000000
		
			--current_combat.start_time = time()-360
			current_combat.start_time = GetTime() - 360
			--current_combat.end_time = time()
			current_combat.end_time = GetTime()
			
			current_combat.totals_grupo [1] = total_damage
			current_combat.totals [1] = total_damage
			
			for _, instance in ipairs (_detalhes.tabela_instancias) do 
				if (instance:IsEnabled()) then
					instance:InstanceReset()
				end
			end
			
			_detalhes:GetInstance(1):SetDisplay (0, 1, 1)
			
			local bar1 = _detalhes:GetInstance(1):GetRow(1)
			
			frame_alert.alert:SetPoint ("topleft", bar1, "topleft", -60, 8)
			frame_alert.alert:SetPoint ("bottomright", bar1, "bottomright", 60, -10)
			
			frame_alert.alert.animOut:Stop()
			frame_alert.alert.animIn:Play()
			if (_detalhes.stopwelcomealert) then
				_detalhes:CancelTimer (_detalhes.stopwelcomealert)
			end
			_detalhes.stopwelcomealert = _detalhes:ScheduleTimer ("StopPlayStretchAlert", 2)
			
		end)
		
		tooltip_frame:SetScript ("OnHide", function()
			_detalhes:StopPlayStretchAlert()
		end)
		
		pages [#pages+1] = {bg88, texto88, micro_image1, texto_micro_display, tooltip_frame}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 11

		local bg11 = window:CreateTexture (nil, "overlay")
		bg11:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg11:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg11:SetHeight (125*3)--125
		bg11:SetWidth (89*3)--82
		bg11:SetAlpha (.1)
		bg11:SetTexCoord (1, 0, 0, 1)

		local texto11 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto11:SetPoint ("topleft", window, "topleft", 20, -80)
		texto11:SetText (Loc ["STRING_WELCOME_36"])

		local texto_plugins = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto_plugins:SetPoint ("topleft", window, "topleft", 25, -101)
		texto_plugins:SetText (Loc ["STRING_WELCOME_68"])
		texto_plugins:SetWidth (220)
		texto_plugins:SetHeight (110)
		texto_plugins:SetJustifyH ("left")
		texto_plugins:SetJustifyV ("top")
		texto_plugins:SetTextColor (1, 1, 1, 1)
		--local fonte, _, flags = texto_plugins:GetFont()
		--texto_plugins:SetFont (fonte, 11, flags)
		
		local plugins_image1 = window:CreateTexture (nil, "overlay")
		plugins_image1:SetTexture ([[Interface\Addons\Details\images\icons2]])
		plugins_image1:SetPoint ("topright", window, "topright", -12, -90)
		plugins_image1:SetWidth (281)
		plugins_image1:SetHeight (81)
		plugins_image1:SetTexCoord (216/512, 497/512, 6/512, 95/512)
		
		pages [#pages+1] = {bg11, texto11, plugins_image1, texto_plugins}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end		
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> page 12

		local bg8 = window:CreateTexture (nil, "overlay")
		bg8:SetTexture ([[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]])
		bg8:SetPoint ("bottomright", window, "bottomright", -10, 10)
		bg8:SetHeight (125*3)--125
		bg8:SetWidth (89*3)--82
		bg8:SetAlpha (.1)
		bg8:SetTexCoord (1, 0, 0, 1)

		local texto8 = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto8:SetPoint ("topleft", window, "topleft", 20, -80)
		texto8:SetText (Loc ["STRING_WELCOME_38"])
		
		local texto = window:CreateFontString (nil, "overlay", "GameFontNormal")
		texto:SetPoint ("topleft", window, "topleft", 25, -110)
		texto:SetText (Loc ["STRING_WELCOME_39"])
		texto:SetWidth (410)
		texto:SetHeight (90)
		texto:SetJustifyH ("left")
		texto:SetJustifyV ("top")
		texto:SetTextColor (1, 1, 1, 1)

		pages [#pages+1] = {bg8, texto8, texto, report_image1}
		
		for _, widget in ipairs (pages[#pages]) do 
			widget:Hide()
		end
		
------------------------------------------------------------------------------------------------------------------------------		
		
		--[[
		forward:Click() 
		forward:Click()
		forward:Click()
		forward:Click()
		forward:Click()
		forward:Click()
		forward:Click()
		--forward:Click()
		--forward:Click()
		--forward:Click()
		--]]

	end
	
end