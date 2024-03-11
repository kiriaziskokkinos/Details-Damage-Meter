
---@class df_table_functions
---@field find fun(tbl:table, value:any) : number? find the index of a value in a array
---@field addunique fun(tbl:table, index:any, value:any) : boolean add a value to an array if it doesn't exist yet, if the index is omitted the value will be added to the end of the array
---@field reverse fun(tbl:table) : table reverse the order of an array
---@field append fun(tbl1:table, tbl2:table) : table append the array of table2 to table1
---@field duplicate fun(tblReceiving:table, tblGiving:table) : table copy the values from table2 to table1 overwriting existing values, ignores __index and __newindex, keys pointing to a UIObject are preserved
---@field copy fun(tblReceiving:table, tblGiving:table) : table copy the values from table2 to table1 overwriting existing values, ignores __index and __newindex, threat UIObjects as regular tables
---@field deploy fun(tblReceiving:table, tblGiving:table) : table copy keys/values that does exist on tblGiving but not in tblReceiving
---@field copytocompress fun(tblReceiving:table, tblGiving:table) : table copy the values from table2 to table1 overwriting existing values, ignores __index, functions and tables with a 'GetObjectType' key
---@field removeduplicate fun(tbl1:table, tbl2:table) remove the keys from table1 which also exists in table2 with the same value
---@field getfrompath fun(tbl:table, path:string, subOffset:number?) : any get a value from a table using a path, e.g. getfrompath(tbl, "a.b.c") is the same as tbl.a.b.c; if subOffset is passed, return the subOffset'th value of the path
---@field setfrompath fun(tbl:table, path:string, value:any) : boolean set the value of a table using a path, e.g. setfrompath(tbl, "a.b.c", 10) is the same as tbl.a.b.c = 10
---@field dump fun(tbl:table, resultString:string, deep:number) : string dump a table to a string
---@field findsubtable fun(tbl:table, index:number, value:any) : integer|nil find the value passed inside a sub table, return the index of the main table where the sub table with the value found is located

---@class df_language : table
---@field Register fun(addonId:any, languageId:string, gameLanguageOnly:boolean?) : table
---@field GetLanguageTable fun(addonId:any, languageId:string?) : table
---@field GetText fun(addonId:any, phraseId:string, silent:boolean?) : string, string
---@field ShowOptionsHelp fun()
---@field SetOption fun(addonId:any, optionId:string, value:any)
---@field SetCurrentLanguage fun(addonId:any, languageId:string)
---@field CreateLanguageSelector fun(addonId:any, parent:frame, callback:function, selectedLanguage:string?) : df_dropdown
---@field SetFontForLanguageId fun(addonId:any, languageId:string, fontPath:string)
---@field SetFontByAlphabetOrRegion fun(addonId:any, latin_FontPath:string, cyrillic_FontPath:string, china_FontPath:string, korean_FontPath:string, taiwan_FontPath:string)
---@field RegisterObject fun(addonId:any, object:uiobject, phraseId:string, silent:boolean?, ...) : boolean
---@field UpdateObjectArguments fun(addonId:any, object:uiobject, ...) : boolean
---@field RegisterTableKey fun(addonId:any, table:table, key:any, phraseId:string, silent:boolean?, ...) : boolean
---@field UpdateTableKeyArguments fun(addonId:any, table:table, key:any, ...) : boolean
---@field RegisterObjectWithDefault fun(addonId:any, object:uiobject, phraseId:string, defaultText:string, ...) : boolean
---@field RegisterTableKeyWithDefault fun(addonId:any, table:table, key:any, phraseId:string, defaultText:string, ...) : boolean
---@field CreateLocTable fun(addonId:any, phraseId:string, shouldRegister:boolean?, ...) : table
---@field SetTextWithLocTable fun(object:uiobject, locTable:table)
---@field SetTextWithLocTableWithDefault fun(object:uiobject, locTable:table, defaultText:string)
---@field SetTextIfLocTableOrDefault fun(object:uiobject, locTable:table)
---@field RegisterTableKeyWithLocTable fun(table:table, key:any, locTable:table, silence:boolean?)
---@field RegisterObjectWithLocTable fun(object:uiobject, locTable:table, silence:boolean?)

---@class df_anttable : table
---@field Throttle number
---@field AmountParts number
---@field TexturePartsWidth number
---@field TexturePartsHeight number
---@field TextureWidth number
---@field TextureHeight number
---@field BlendMode string?
---@field Color any?
---@field Texture any

---df version of an atlasinfo from the game API, it include color and desaturation information
---a df atlas can be created using DetailsFramework:CreateAtlas() and then used with DetailsFramework:SetAtlas()
---@class df_atlasinfo : atlasinfo
---@field vertexRed number?
---@field vertexGreen number?
---@field vertexBlue number?
---@field vertexAlpha number?
---@field colorName string?
---@field nativeWidth number?
---@field nativeHeight number?
---@field desaturated boolean?
---@field desaturation number?
---@field atlas string?

---@alias df_templatename string

---a template is a table with keys and values that mandate how a widget should look like
---@class df_template : table
---@field width any
---@field height any
---@field backdrop any
---@field backdropcolor any
---@field backdropbordercolor any
---@field onentercolor any
---@field onleavecolor any
---@field onenterbordercolor any
---@field onleavebordercolor any
---@field icon any
---@field size any
---@field textsize any
---@field font any
---@field textfont any
---@field color any
---@field textcolor any
---@field textalign any
---@field rounded_corner any
---@field thumbtexture any
---@field slider_left any
---@field slider_right any
---@field slider_middle any
---@field thumbwidth any
---@field thumbheight any
---@field thumbcolor any
---@field amount_color any
---@field amount_outline any
---@field amount_size any
---@field enabled_backdropcolor any
---@field disabled_backdropcolor any
---@field is_checkbox any
---@field checked_texture any
---@field checked_xoffset any
---@field checked_yoffset any
---@field checked_size_percent any
---@field checked_color any



---@class df_widgets : table
---@field type string
---@field dframework boolean
---@field container frame
---@field widget frame

---@alias templatecategory
---| "font"
---| "dropdown"
---| "button"
---| "switch"
---| "slider"


---@class detailsframework
---@field dversion number
---@field internalFunctions table
---@field OptionsFunctions df_optionsmixin
---@field GlobalWidgetControlNames table
---@field DefaultRoundedCornerPreset table
---@field RoundedCornerPanelMixin df_roundedcornermixin
---@field Schedules df_schedule
---@field HeaderFunctions df_headerfunctions
---@field Language df_language
---@field KeybindMixin df_keybindmixin
---@field ScriptHookMixin df_scripthookmixin
---@field EditorMixin df_editormixin
---@field ScrollBoxFunctions df_scrollboxmixin
---@field ClassCache {ID:number, Name:string, FileString:string, Texture:string, TexCoord:number[]}[] only available after calling GetClassList()
---@field Math df_math
---@field FontOutlineFlags table<outline, boolean>
---@field table df_table_functions
---@field AnchorPoints string[]
---@field alias_text_colors table<string, number[]>
---@field ClassFileNameToIndex table<string, number> engClass -> classIndex
---@field ClientLanguage string
---@field dropdown_templates table<df_templatename, df_template>
---@field switch_templates table<df_templatename, df_template>
---@field button_templates table<df_templatename, df_template>
---@field slider_templates table<df_templatename, df_template>
---@field font_templates table<df_templatename, df_template>
---@field FrameWorkVersion string the version of the framework
---@field LabelNameCounter number when no name is given, a string plus an incremental number is used instead
---@field PictureNameCounter number when no name is given, a string plus an incremental number is used instead
---@field BarNameCounter number when no name is given, a string plus an incremental number is used instead
---@field DropDownCounter number when no name is given, a string plus an incremental number is used instead
---@field PanelCounter number when no name is given, a string plus an incremental number is used instead
---@field SimplePanelCounter number when no name is given, a string plus an incremental number is used instead
---@field ButtonCounter number when no name is given, a string plus an incremental number is used instead
---@field SliderCounter number when no name is given, a string plus an incremental number is used instead
---@field SwitchCounter number when no name is given, a string plus an incremental number is used instead
---@field SplitBarCounter number when no name is given, a string plus an incremental number is used instead
---@field FormatNumber fun(number:number) : string abbreviate a number, e.g. 1000 -> 1k 1000 -> 1천, depending on the client language
---@field UnitGroupRolesAssigned fun(unitId: unit, bUseSupport:boolean?, specId: specializationid?) : string there's no self here
---@field LoadSpellCache fun(self:table, hashMap:table, indexTable:table, allSpellsSameName:table) : hashMap:table, indexTable:table, allSpellsSameName:table load all spells in the game and add them into the passed tables
---@field UnloadSpellCache fun(self:table) wipe the table contents filled with LoadSpellCache()
---@field GetCurrentClassName fun(self:table) : string return the name of the class the player is playing
---@field GetCurrentSpecName fun(self:table) : string return the name of the spec the player is playing
---@field GetSpellCaches fun(self:table) : table, table, table return the tables filled with LoadSpellCache()
---@field GetCurrentSpec fun(self:table):number?
---@field GetCurrentSpecId fun(self:table):number? return the specId of the current spec, retuns nil if the expansion the player is playing does not support specs
---@field GetClassSpecIds fun(self:table, engClass:string):number[]
---@field IsValidSpecId fun(self:table, specId:number):boolean check if the passed specId is valid for the player class, also return false for tutorial specs
---@field GetClassList fun(self:table):{ID:number, Name:string, FileString:string, Texture:string, TexCoord:number[]}[]
---@field DebugVisibility fun(self:table, object:uiobject) print the reason why the frame isn't shown in the screen
---@field Dispatch fun(self:table, callback:function, ...) : any dispatch a function call using xpcall, print to chat if the function passed is invalid
---@field QuickDispatch fun(self:table, callback:function, ...) : any dispatch a function call without errors if the function passed is invalid
---@field CoreDispatch fun(self:table, context:string, callback:function, ...) : any dispatch a function using xpcall, make an error if the function passed is invalid
---@field GetDefaultBackdropColor fun(self:table) : red, green, blue, alpha return the standard backdrop color used by blizzard on their own frames
---@field Msg fun(self:table, message:string, ...) show a message in the chat frame
---@field MsgWarning fun(self:table, message:string, ...) show a warning message in the chat frame
---@field CreateButton fun(self:table, parent:frame, func:function, width:number, height:number, text:any, param1:any, param2:any, texture:atlasname|texturepath|textureid|nil, member:string?, name:string?, shortMethod:any, buttonTemplate:table?, textTemplate:table?) : df_button
---@field CreateCloseButton fun(self:table, parent:frame, frameName:string?) : df_closebutton
---@field CreateTabButton fun(self:table, parent:frame, frameName:string?) : df_tabbutton
---@field CreateRoundedPanel fun(self:table, parent:frame, frameName:string?, optionsTable:df_roundedpanel_options?) : df_roundedpanel
---@field CreateScaleBar fun(self:table, parent:frame, config:table<scale,number>) : df_scalebar
---@field AddRoundedCornersToFrame fun(self:table, frame:frame, optionsTable:df_roundedpanel_preset?)
---@field ParseColors fun(self:table, red:any, green:number?, blue:number?, alpha:number?) : red, green, blue, alpha
---@field Mixin fun(self:table, target:table, ...) : table
---@field SetButtonTexture fun(self:table, button:button|df_button, texture:atlasname|texturepath|textureid)
---@field CreateFadeAnimation fun(self:table, UIObject:uiobject, fadeInTime:number?, fadeOutTime:number?, fadeInAlpha:number?, fadeOutAlpha:number?)
---@field SetFontSize fun(self:table, fontstring:fontstring, size:number)
---@field GetFontSize fun(self:table, fontstring:fontstring) : number return the font size of the fontstring
---@field SetFontColor fun(self:table, fontstring:fontstring, red:any, green:number?, blue:number?, alpha:number?)
---@field SetFontFace fun(self:table, fontstring:fontstring, font:string)
---@field SetFontDefault fun(self:table, fontstring:fontstring)
---@field GetFontFace fun(self:table, fontstring:fontstring) : string return the font face of the fontstring
---@field SetFontShadow fun(self:table, fontstring:fontstring, red:any, green:number?, blue:number?, alpha:number?, offsetX:number?, offsetY:number?)
---@field SetFontOutline fun(self:table, fontstring:fontstring, outline:outline)
---@field RemoveRealmName fun(self:table, name:string) : string, number remove the realm name from the player name, must be in the format of "name-realm"
---@field RemoveOwnerName fun(self:table, name:string) : string, number removes the owner name from a name string, the owner name must be between < and >
---@field CleanUpName fun(self:table, name:string) : string removes the realm name and owner name from a name string
---@field IntegerToTimer fun(self:table, time:number) : string convert a number to a timer string, e.g. 150 -> 2:30
---@field GroupIterator fun(self:table, callback:function, ...) iterate over the group, calling the callback function for each group member
---@field CommaValue fun(self:table, value:number) : string convert a number to a string with commas, e.g. 1000000 -> 1,000,000
---@field SplitTextInLines fun(self:table, text:string) : string[] split a text into lines
---@field SetAnchor fun(self:table, widget:uiobject, anchorTable:df_anchor, anchorTo:uiobject?) only adjust the anchors of a widget, does not save values
---@field AddTextureToText fun(self:table, text:string, textureInfo:table, bAddSpace:boolean?, bAddAfterText:any) : string textureInfo is a table with .texture .width .height .coords{left, right, top, bottom}
---@field CreateTextureInfo fun(self:table, texture:atlasname|texturepath|textureid, width:number?, height:number?, left:number?, right:number?, top:number?, bottom:number?, imageWidthnumber?, imageHeightnumber?) : table deprecated, use: DetailsFramework:CreateAtlas()
---@field ApplyStandardBackdrop fun(self:table, frame:frame, bUseSolidColor:boolean?, alphaScale:number?)
---@field NewLabel fun(self:table, parent:frame, container:frame, name:string?, member:string?, text:string|table, font:string?, size:any?, color:any?, layer:drawlayer?) : df_label
---@field CreateLabel fun(self:table, parent:frame, text:string, size:any?, color:any?, font:string?, member:string?, name:string?, layer:drawlayer?) : df_label
---@field CreateDropDown fun(self:table, parent:frame, func:function, default:any, width:number?, height:number?, member:string?, name:string?, template:table?) : df_dropdown
---@field CreateFontDropDown fun(self:table, parent:frame, func:function, default:any, width:number?, height:number?, member:string?, name:string?, template:table?) : df_dropdown
---@field CreateColorDropDown fun(self:table, parent:frame, func:function, default:any, width:number?, height:number?, member:string?, name:string?, template:table?) : df_dropdown
---@field CreateOutlineDropDown fun(self:table, parent:frame, func:function, default:any, width:number?, height:number?, member:string?, name:string?, template:table?) : df_dropdown
---@field CreateAnchorPointDropDown fun(self:table, parent:frame, func:function, default:any, width:number?, height:number?, member:string?, name:string?, template:table?) : df_dropdown
---@field CreateFontListGenerator fun(self:table, callback:function) : function return a function which when called returns a table filled with all fonts available and ready to be used on dropdowns
---@field CreateTextEntry fun(self:table, parent:frame, textChangedCallback:function, width:number, height:number, member:string?, name:string?, labelText:string?, textentryTemplate:table?, labelTemplate:table?) : df_textentry
---@field ReskinSlider fun(self:table, slider:frame)
---@field GetAvailableSpells fun(self:table) : table<spellid, boolean>
---@field NewColor fun(self:table, colorName:string, red:number, green:number, blue:number, alpha:number?) : table
---@field CreateKeybindFrame fun(self:table, parent:frame, name:string?, options:table?, setKeybindCallback:function?, keybindData:table?) : df_keybindframe
---@field CreateStatusBar fun(self:table, parent:frame, options:table?) : frame
---@field GetTemplate fun(self:table, templatecategory:templatecategory, templateName:string) : table
---@field UpdateLoadConditionsTable fun(self:table, loadConditionsTable:table)
---@field IconPick fun(self:table, callback:function, bCloseWhenSelect:boolean?, param1:any?, param2:any?)
---@field OpenLoadConditionsPanel fun(self:table, optionsTable:table, callback:function, frameOptions:table?)
---@field InstallTemplate fun(self:table, widgetType:string, templateName:string, template:table, parentName:any) : table
---@field NewSpecialLuaEditorEntry fun(self:table, parent:frame, width:number, height:number, member:string?, name:string?, nointent:boolean?, showLineNumbers:boolean?, bNoName:boolean?) : df_luaeditor
---@field PassLoadFilters fun(self:table, loadTable:table, encounterID:number?) : boolean, string
---@field CreateLoadFilterParser fun(self:table, callback:fun(encounterId:number?)) create a helper which will callback when encounterId, spec, talent, role, combatstate changes
---@field CreateSwitch fun(self:table, parent:frame, onSwitch:function, defaultValue:boolean, width:number?, height:number?, leftText:string?, rightText:string?, member:string?, name:string?, colorInverted:boolean?, switchFunc:function?, returnFunc:function?, withLabel:string?, switch_template:table?, label_template:table?) : df_checkbox, df_label?
---@field CreateCheckboxGroup fun(self:table, parent:frame, radioOptions:df_radiooptions[], name:string?, options:table?, anchorOptions:table?) : df_checkboxgroup
---@field CreateRadioGroup fun(self:table, parent:frame, radioOptions:df_radiooptions[], name:string?, options:table?, anchorOptions:table?) : df_radiogroup
---@field CreateScrollBox fun(self:table, parent:frame, name:string, refreshFunc:function, data:table, width:number, height:number, lineAmount:number, lineHeight:number, createLineFunc:function?, autoAmount:boolean?, noScroll:boolean?, noBackdrop:boolean?) : df_scrollbox
---@field CreateAuraScrollBox fun(self:table, parent:frame, name:string?, data:table?, onRemoveCallback:function?, options:table?) : df_aurascrollbox
---@field CreateGridScrollBox fun(self:table, parent:frame, name:string?, refreshFunc:function, data:table?, createColumnFrameFunc:function, options:table?) : df_gridscrollbox
---@field CreateCanvasScrollBox fun(self:table, parent:frame, child:frame?, name:string?, options:table?) : df_canvasscrollbox
---@field CreateTabContainer fun(self:table, parent:frame, title:string, frameName:string, tabList:df_tabinfotable[], optionsTable:table?, hookList:table?, languageInfo:table?) : df_tabcontainer
---@field GetSizeFromPercent fun(self:table, uiObject:uiobject, percent:number) : number get the min size of a uiObject and multiply it by the percent passed
---@field BuildMenu fun(self:table, parent:frame, menuOptions:df_menu_table[], xOffset:number?, yOffset:number?, height:number?, useColon:boolean?, textTemplate:table?, dropdownTemplate:table?, switchTemplate:table?, switchIsCheckbox:boolean?, sliderTemplate:table?, buttonTemplate:table?, valueChangeHook:function?)
---@field BuildMenuVolatile fun(self:table, parent:frame, menuOptions:df_menu_table[], xOffset:number?, yOffset:number?, height:number?, useColon:boolean?, textTemplate:table?, dropdownTemplate:table?, switchTemplate:table?, switchIsCheckbox:boolean?, sliderTemplate:table?, buttonTemplate:table?, valueChangeHook:function?)
---@field GetColorBrightness fun(self:table, r:number, g:number, b:number) : number return the brightness of a color from zero to one
---@field GetColorHue fun(self:table, r:number, g:number, b:number) : number return the hue of a color from red to blue to green to  yellow and back to red
---@field IsHtmlColor fun(self:table, colorName:any) : unknown return true if DF.alias_text_colors has the colorName as a key
---@field CreateColorTable fun(self:table, r:number, g:number, b:number, a:number) : table return a table with {r, g, b, a}
---@field FormatColor fun(self:table, newFormat:string, r:number|string|table, g:number?, b:number?, a:number?, decimalsAmount:number?) : string|table|number|nil, number|nil, number|nil, number|nil takes in a color in one format and converts it to another specified format.
---@field CreateEditor fun(self:table, parent:frame, name:string?, options:df_editor_defaultoptions?) : df_editor
---@field RandomBool fun(self:table, odds: number?) : boolean return a random boolean
---@field CreateHighlightTexture fun(self:table, parent:frame, parentKey:string?, alpha:number?, name:string?) : texture
---@field CreateIconRowGeneric fun(self:table, parent:frame, name:string?, options:table?)
---@field CreateColorPickButton fun(self:table, parent:frame, name:string?, member:string?, callback:function, alpha:number?, buttonTemplate:table?) : df_button
---@field CreateSlider fun(self:table, parent:frame, width:number?, height:number?, minValue:number?, maxValue:number?, step:number?, defaultv:number?, isDecemal:boolean?, member:string?, name:string?, label:string?, sliderTemplate:string|table?, labelTemplate:string|table?) : df_slider, df_label?
---@field CreateFrameContainer fun(self:table, parent:frame, options:table?, frameName:string?) : df_framecontainer create a frame container, which is a frame that envelops another frame, and can be moved, resized, etc.
---@field CreateAnimation fun(self:table, animationGroup:animationgroup, animationType:animationtype, order:number, duration:number, arg1:any, arg2:any, arg3:any, arg4:any, arg5:any, arg6:any, arg7:any, arg8:any) : animation
---@field NewImage fun(self:table, parent:frame, texture:atlasname|texturepath|textureid|df_gradienttable|nil, width:number?, height:number?, layer:drawlayer?, texCoord:table?, member:string?, name:string?) : df_image
---@field CreateTexture fun(self:table, parent:frame, texture:atlasname|texturepath|textureid|nil, width:number?, height:number?, layer:drawlayer?, coords:table?, member:string?, name:string?) : df_image
---@field CreateImage fun(self:table, parent:frame, texture:atlasname|texturepath|textureid|nil, width:number?, height:number?, layer:drawlayer?, coords:table?, member:string?, name:string?) : df_image
---@field CreateFrameShake fun(self:table, parent:uiobject, duration:number?, amplitude:number?, frequency:number?, absoluteSineX:boolean?, absoluteSineY:boolean?, scaleX:number?, scaleY:number?, fadeInTime:number?, fadeOutTime:number?, anchorPoints:table?) : df_frameshake
---@field SetTexCoordFromAtlasInfo fun(self:table, texture:texture, atlasInfo:atlasinfo) : nil
---@field TruncateNumber fun(self:table, number:number, fractionDigits:number) : number
---@field GetNpcIdFromGuid fun(self:table, GUID:string) : number
---@field SortOrder1 fun(t1:table, t2:table) : boolean
---@field SortOrder2 fun(t1:table, t2:table) : boolean
---@field SortOrder3 fun(t1:table, t2:table) : boolean
---@field SortOrder1R fun(t1:table, t2:table) : boolean
---@field SortOrder2R fun(t1:table, t2:table) : boolean
---@field SortOrder3R fun(t1:table, t2:table) : boolean
---@field Trim fun(self:table, string:string) : string
---@field trim fun(self:table, string:string) : string
---@field TruncateTextBinarySearch fun(self:table, fontString:fontstring, maxWidth:number) : nil
---@field TruncateTextSafeBinarySearch fun(self:table, fontString:fontstring, maxWidth:number) : nil
---@field TruncateTextSafe fun(self:table, fontString:fontstring, maxWidth:number) : nil
---@field TruncateText fun(self:table, fontString:fontstring, maxWidth:number) : nil
---@field CleanTruncateUTF8String fun(self:table, text:string) : string
---@field GetSpellBookSpells fun(self:table) : table<string, boolean>, spellid[] return a list of spells from the player spellbook
---@field PreviewTexture fun(self:table, texture:atlasname|texturepath|textureid, left:number?, right:number?, top:number?, bottom:number?) : nil
---@field SetAtlas fun(self:table, textureObject:texture, atlas:atlasinfo|atlasname, useAtlasSize:boolean?, filterMode:texturefilter?, resetTexCoords:boolean?) : nil
---@field CreateAtlas fun(self:table, file:texturepath|textureid, width:number?, height:number?, leftTexCoord:number?, rightTexCoord:number?, topTexCoord:number?, bottomTexCoord:number?, tilesHorizontally:boolean?, tilesVertically:boolean?, vertexRed:any, vertexGreen:number?, vertexBlue:number?, vertexAlpha:number?, desaturated:boolean?, desaturation:number?, alpha:number) : atlasinfo
---@field ParseTexture fun(self:table, texture:texturepath|textureid|atlasname|atlasinfo, width: number?, height: number?, leftTexCoord: number?, rightTexCoord: number?, topTexCoord: number?, bottomTexCoord: number?, vertexRed:number|string?, vertexGreenvertexRed:number?, vertexBluevertexRed:number?, vertexAlphavertexRed:number?) : any, number?, number?, number?, number?, number?, number?, number?, number?, number?, number?, number?, number?
---@field IsTexture fun(self:table, texture:any, bCheckTextureObject: boolean?) : boolean
---@field CreateAtlasString fun(self:table, atlas:atlasinfo|atlasname, textureHeight:number?, textureWidth:number?) : string
---@field SetMask fun(self:table, texture:texture, maskTexture:atlasname|texturepath|textureid) : nil
---@field GetClientRegion fun(self:table) : string
---@field GetBestFontPathForLanguage fun(self:table, languageId:string) : string
---@field SetTemplate fun(self:table, frame:uiobject, template:string)
---@field ParseTemplate fun(self:table, templateCategory:string, template:string|table) : table
---@field GetParentName fun(self:table, frame:uiobject) : string
---@field IsLatinLanguage fun(self:table, languageId:string) : boolean
---@field PrintVersion fun(self:table) : nil print to chat the version of the framework
---@field GetParentKeyPath fun(self:table, object:uiobject) : string
---@field GetParentNamePath fun(self:table, object:uiobject) : string
---@field GetAsianNumberSymbols fun(self:table) : string, string, string return the abbreviation for 1,000 10,000 and 100,000,000
---@field GetBestFontForLanguage fun(self:table, languageId:string?, western:string?, cyrillic:string?, china:string? korean:string?, taiwan:string?) : string
---@field CreateGlowOverlay fun(self:table, parent:frame, antsColor:any, glowColor:any) : frame
---@field CreateAnts fun(self:table, parent:frame, antTable:df_anttable, leftOffset:number?, rightOffset:number?, topOffset:number?, bottomOffset:number?) : frame
---@field CreateBorder fun(self:table, parent:frame, alpha1:number?, alpha2:number?, alpha3:number?) : frame
---@field
---@field
---@field




--[=[
    Wrapped objects: when using the following functions, the object will be wrapped in a table, e.g. detailsFramework:CreateButton() will return a table with the button, the button will be accessible through the "button" key.
    The wrapper table will have the same metatable as the wrapped object, so you can call methods on the wrapper table as if it was the wrapped object.
    Example: local myButton = detailsFramework:CreateButton(); myButton:SetSize(100, 100) => will call SetSize(100, 100) on the button wrapped.
    The wrapped object will be accessible through the "widget" key, e.g. local myButton = detailsFramework:CreateButton(); local actualButtonUIObject = myButton.widget.
    Wrapped objects can give errors when used in some situations, like when passing them to the game API, in this case, you can use the "widget" key to access the actual object. This is very common on SetPoint calls where the game API expects a frame, not a table. Error exammple with SetPoints: "SetPoint(): Wrong object type for function".

    The following functions will return a wrapped object:
    - CreateButton, NewButton
    - CreateColorPickButton
    - CreateTexture, CreateImage, NewImage
    - CreateSearchBox, NewSpellEntry, NewTextEntry, CreateTextEntry
    - NewDropDown, CreateDropDown, CreateFontDropDown, CreateColorDropDown, CreateOutlineDropDown, CreateAnchorPointDropDown
    - NewPanel, CreatePanel
    - CreateSwitch, NewSwitch, NewSlider, CreateSlider
    - NewLabel, CreateLabel
    - NewSplitBar, CreateSplitBar
    - CreateTimeBar
--]=]