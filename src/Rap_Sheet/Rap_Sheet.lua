--[[
	Inclusion of WoD data, and other tips I found necessary
	Modified by AnthonyG70 (Bogdan-Proudmoore)
    Thanks to Zenh for Needy; their release has not been updated since 2010.
	Rap_Sheet ver 3.3.1
	Created APR 2013, Last update 16 NOV 17
]]

---- menu start test

-- RapSheet.Interface = {};
--  RapSheet.panel = CreateFrame( "Frame", "RapSheetPanel", UIParent );
 -- Register in the Interface Addon Options GUI
 -- Set the name for the Category for the Options Panel
--  RapSheet.panel.name = "Rap Sheet";
 -- Add the panel to the Interface Options
--  InterfaceOptions_AddCategory(RapSheet.panel);

-- CONFIGURATION START
-- change from true to false to hide data output

local options = {
    showRespecs = true,
    showDualSpec = true,
    showLevel = true,
	showScore = true,
	showHK = true,
	showBgs = true,
	showBosses = true,
    showInCombat = false,
	showCounts = true
}

-- CONFIGURATION END

local ids = {
    rollsGreed = 1043,
    rollsNeed = 1044,
--	rollsDE = 181,
    respecNum = 1149,
    dualSpec = 2716,
    maxLevel = 10671,
-- PvP
	honorKills = 588,
	bgsPlayed = 839,
	arenaWins = 837,
	arenaTwo = 370,
	arenaThree = 595,
	arenaFive = 596,
	arenaThreeTeam = 590,
	arenaTwoTeam = 374,

-- Emerald Nightmare Boss
	bossLXaviusKills = 10936,
	bossXaviusKills = 10937,
	bossHXaviusKills = 10938,
	bossMXaviusKills = 10939,
	bossXaviusDate = 10820,
	bossMXaviusDate = 10827,
-- Trial of Valor Boss
	bossLHelyaKills = 11415,
	bossHelyaKills = 11416,
	bossHHelyaKills = 11417,
	bossMHelyaKills = 11418,
	bossHelyaDate = 11394,
	bossMHelyaDate = 11398,
--	The Nighthold Boss
	bossLGuldanKills = 10977,
	bossGuldanKills = 10978,
	bossHGuldanKills = 10979,
	bossMGuldanKills = 10980,
	bossGuldanDate = 10839,
	bossMGuldanDate = 10850,
--	Tomb of Sargeras Boss
	bossLKiljaedenKills = 11909,
	bossKiljaedenKills = 11910,
	bossHKiljaedenKills = 11911,
	bossMKiljaedenKills = 11912,
	bossKiljaedenDate = 11790,
	bossMKiljaedenDate = 11781,
-- Antorus the Burning Throne
	bossLArgusKills = 12127,
	bossArgusKills = 11984,
	bossHArgusKills = 11985,
	bossMArgusKills = 11986,
	bossArgusDate = 12266,
	bossMArgusDate = 12002
}

CreateFrame('Frame', 'RapSheet', UIParent)

RapSheet:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
RapSheet:RegisterEvent('MODIFIER_STATE_CHANGED')

if TinyTip then
    TinyTip.HookOnTooltipSetUnit(GameTooltip, RapSheet.UPDATE_MOUSEOVER_UNIT)
else
    RapSheet:RegisterEvent('UPDATE_MOUSEOVER_UNIT')
end

-- Inspect Achievements

function RapSheet:INSPECT_ACHIEVEMENT_READY()
    self:UnregisterEvent('INSPECT_ACHIEVEMENT_READY')
    self.line:SetText()

    if GameTooltip:GetUnit() == self.unit then
        local stats, text = {}, ''

        stats.needs = tonumber(GetComparisonStatistic(ids.rollsNeed)) or 0
        stats.greeds = tonumber(GetComparisonStatistic(ids.rollsGreed)) or 0
		
		stats.honorablekills = tonumber(GetComparisonStatistic(ids.honorKills)) or 0
		
        stats.respecNum = GetComparisonStatistic(ids.respecNum)
        stats.dualSpec = GetAchievementComparisonInfo(ids.dualSpec)
		
		stats.bgsPlayed = tonumber(GetComparisonStatistic(ids.bgsPlayed)) or 0
		stats.arenaWins = tonumber(GetComparisonStatistic(ids.arenaWins)) or 0
		stats.arenaTwo = tonumber(GetComparisonStatistic(ids.arenaTwo)) or 0
		stats.arenaThree = tonumber(GetComparisonStatistic(ids.arenaThree)) or 0
		stats.arenaFive = tonumber(GetComparisonStatistic(ids.arenaFive)) or 0
		stats.arenaThreeTeam = tonumber(GetComparisonStatistic(ids.arenaThreeTeam)) or 0
		stats.arenaTwoTeam = tonumber(GetComparisonStatistic(ids.arenaTwoTeam)) or 0
		
		stats.bossLXaviusKills = GetComparisonStatistic(ids.bossLXaviusKills)
		stats.bossXaviusKills = GetComparisonStatistic(ids.bossXaviusKills)
		stats.bossHXaviusKills = GetComparisonStatistic(ids.bossHXaviusKills)
		stats.bossMXaviusKills = GetComparisonStatistic(ids.bossMXaviusKills)
		
		stats.bossLHelyaKills = GetComparisonStatistic(ids.bossLHelyaKills)
		stats.bossHelyaKills = GetComparisonStatistic(ids.bossHelyaKills)
		stats.bossHHelyaKills = GetComparisonStatistic(ids.bossHHelyaKills)
		stats.bossMHelyaKills = GetComparisonStatistic(ids.bossMHelyaKills)
		
		stats.bossLGuldanKills = GetComparisonStatistic(ids.bossLGuldanKills)
		stats.bossGuldanKills = GetComparisonStatistic(ids.bossGuldanKills)
		stats.bossHGuldanKills = GetComparisonStatistic(ids.bossHGuldanKills)
		stats.bossMGuldanKills = GetComparisonStatistic(ids.bossMGuldanKills)
		
		stats.bossLKiljaedenKills = GetComparisonStatistic(ids.bossLKiljaedenKills)
		stats.bossKiljaedenKills = GetComparisonStatistic(ids.bossKiljaedenKills)
		stats.bossHKiljaedenKills = GetComparisonStatistic(ids.bossHKiljaedenKills)
		stats.bossMKiljaedenKills = GetComparisonStatistic(ids.bossMKiljaedenKills)
		
		stats.bossLArgusKills = GetComparisonStatistic(ids.bossLArgusKills)
		stats.bossArgusKills = GetComparisonStatistic(ids.bossArgusKills)
		stats.bossHArgusKills = GetComparisonStatistic(ids.bossHArgusKills)
		stats.bossMArgusKills = GetComparisonStatistic(ids.bossMArgusKills)
		
-- check boss dates Highmaul

        if options.showBosses then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.bossXaviusDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossXaviusDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
		end
		
        if options.showBosses then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.bossMXaviusDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossMXaviusDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
        end

-- check boss dates Blackrock Foundry
		
        if options.showBosses then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.bossHelyaDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossHelyaDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
		end
		
        if options.showBosses then
			local completed, month, day, year = GetAchievementComparisonInfo(ids.bossMHelyaDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossMHelyaDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
        end
		
-- check boss dates Hellfire Citadel
		
        if options.showBosses then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.bossGuldanDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossGuldanDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
		end
		
        if options.showBosses then
			local completed, month, day, year = GetAchievementComparisonInfo(ids.bossMGuldanDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossMGuldanDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
        end
		
-- check boss dates Tomb of Sargeras
		
        if options.showBosses then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.bossKiljaedenDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossKiljaedenDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
		end
		
        if options.showBosses then
			local completed, month, day, year = GetAchievementComparisonInfo(ids.bossMKiljaedenDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossMKiljaedenDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
        end
		
-- check boss dates Antorus The Burning Throne
		
        if options.showBosses then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.bossArgusDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossArgusDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
		end
		
        if options.showBosses then
			local completed, month, day, year = GetAchievementComparisonInfo(ids.bossMArgusDate)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.bossMArgusDate = completed and month .. '/' .. day .. '/' .. year or '|cffff0000None'
        end

-- Verify level 110 account wide

        if options.showLevel then
            local completed, month, day, year = GetAchievementComparisonInfo(ids.maxLevel)

            if completed then
                year = year < 10 and 0 .. year or year
                day = day < 10 and 0 .. day or day
            end

            stats.levelhundred = completed and month .. '/' .. day .. '/' .. year or '|cffff0000No Lvl 110 toons'
        end

-- math for greed/need stats
		
        if stats.needs > 0 then
            percentNeeds = math.floor((stats.needs / (stats.greeds + stats.needs)) * 100)
            text = text .. '\n|cFFF1C502Needs:  |cFFFFFFFF' .. (percentNeeds > 50 and '|cFFFF0000' .. percentNeeds or percentNeeds) .. '%  (' .. stats.needs .. ')'
        else
            percentNeeds = 0
        end

-- Ctrl pressed, then show full sheet
		
        if IsControlKeyDown() then
            if stats.greeds > 0 then
                percentGreeds = 100 - percentNeeds
                text = text .. '\n|cFFF1C502Greeds:  |cFFFFFFFF' .. (percentGreeds > 50 and '|cFF00FF00' .. percentGreeds or percentGreeds) .. '%  (' .. stats.greeds .. ')'
            end

            if options.showRespecs and UnitLevel('mouseover') >= 10 then
                text = text .. '\n|cFFF1C502Respecs:  |cFFFFFFFF' .. (stats.respecNum == '--' and 'None' or stats.respecNum)
            end

            if options.showDualSpec and UnitLevel('mouseover') >= 40 then
                text = text .. '\n|cFFF1C502Dual Spec:  |cFFFFFFFF' .. (stats.dualSpec and 'Yes' or 'No')
            end
			
			if options.showHK and stats.honorablekills > 0 then
				text = text .. '\n|cFFF1C502HKs:  |cFFFFFFFF' .. stats.honorablekills
			end
			
			if options.showBgs then
				text = text .. '\n \n|cff00ff00--- PvP Info |cFFFFFFFF'
			end
			if options.showBgs then
				text = text .. '\n|cFFF1C502BGs played:  |cFFFFFFFF' .. stats.bgsPlayed
			end
			
			if options.showScore then
				text = text .. '\n \n|cff00ff00--- Arena Info |cFFFFFFFF'
			end
			if options.showScore and stats.arenaWins > 0 then
				text = text .. '\n|cFFF1C502Arena Wins:  |cFFFFFFFF' .. stats.arenaWins
			end
			if options.showScore and stats.arenaTwo > 0 then
				text = text .. '\n|cFFF1C5022 Man Personal Rating:  |cFFFFFFFF' .. stats.arenaTwo
			end
			if options.showScore and stats.arenaThree > 0 then
				text = text .. '\n|cFFF1C5023 Man Personal Rating:  |cFFFFFFFF' .. stats.arenaThree
			end
			if options.showScore and stats.arenaFive > 0 then
				text = text .. '\n|cFFF1C5025 Man Personal Rating:  |cFFFFFFFF' .. stats.arenaFive
			end
			if options.showScore and stats.arenaTwoTeam > 0 then
			text = text .. '\n|cFFF1C5022 Man Team Rating:  |cFFFFFFFF' .. stats.arenaTwoTeam
			end
			if options.showScore and stats.arenaThreeTeam > 0 then
			text = text .. '\n|cFFF1C5023 Man Team Rating:  |cFFFFFFFF' .. stats.arenaThreeTeam
			end

-- show current content boss kills

			if options.showCounts then
			text = text .. '\n \n|cff00ff00--- Raid Info |cFFFFFFFF'
			text = text .. '\n|cFFF1C502Xavius Kills'
				text = text .. '\n|cff40c840LFR: ' .. (stats.bossLXaviusKills == '--' and '0' or  stats.bossLXaviusKills) .. '|cffffffff / ' .. '|cff206edcNorm: ' .. (stats.bossXaviusKills == '--' and '0' or stats.bossXaviusKills)  .. '|cffffffff / ' .. '|cffc030c0 Hero: ' .. (stats.bossHXaviusKills == '--' and '0' or stats.bossHXaviusKills)  .. '|cffffffff / ' .. '|cffff8000 Mythic: ' .. (stats.bossMXaviusKills == '--' and '0' or stats.bossMXaviusKills)

			text = text .. '\n|cFFF1C502Helya Kills'
				text = text .. '\n|cff40c840LFR: ' .. (stats.bossLHelyaKills == '--' and '0' or  stats.bossLHelyaKills) .. '|cffffffff / ' .. '|cff206edcNorm: ' .. (stats.bossHelyaKills == '--' and '0' or stats.bossHelyaKills)  .. '|cffffffff / ' .. '|cffc030c0 Hero: ' .. (stats.bossHHelyaKills == '--' and '0' or stats.bossHHelyaKills)  .. '|cffffffff / ' .. '|cffff8000 Mythic: ' .. (stats.bossMHelyaKills == '--' and '0' or stats.bossMHelyaKills)	

			text = text .. '\n|cFFF1C502Guldan Kills'
				text = text .. '\n|cff40c840LFR: ' .. (stats.bossLGuldanKills == '--' and '0' or  stats.bossLGuldanKills) .. '|cffffffff / ' .. '|cff206edcNorm: ' .. (stats.bossGuldanKills == '--' and '0' or stats.bossGuldanKills)  .. '|cffffffff / ' .. '|cffc030c0 Hero: ' .. (stats.bossHGuldanKills == '--' and '0' or stats.bossHGuldanKills)  .. '|cffffffff / ' .. '|cffff8000 Mythic: ' .. (stats.bossMGuldanKills == '--' and '0' or stats.bossMGuldanKills)
				
			text = text .. '\n|cFFF1C502Kil\'Jaeden Kills'
				text = text .. '\n|cff40c840LFR: ' .. (stats.bossLKiljaedenKills == '--' and '0' or  stats.bossLKiljaedenKills) .. '|cffffffff / ' .. '|cff206edcNorm: ' .. (stats.bossKiljaedenKills == '--' and '0' or stats.bossKiljaedenKills)  .. '|cffffffff / ' .. '|cffc030c0 Hero: ' .. (stats.bossHKiljaedenKills == '--' and '0' or stats.bossHKiljaedenKills)  .. '|cffffffff / ' .. '|cffff8000 Mythic: ' .. (stats.bossMKiljaedenKills == '--' and '0' or stats.bossMKiljaedenKills)
				
			text = text .. '\n|cFFF1C502Argus Kills'
				text = text .. '\n|cff40c840LFR: ' .. (stats.bossLArgusKills == '--' and '0' or  stats.bossLArgusKills) .. '|cffffffff / ' .. '|cff206edcNorm: ' .. (stats.bossArgusKills == '--' and '0' or stats.bossArgusKills)  .. '|cffffffff / ' .. '|cffc030c0 Hero: ' .. (stats.bossHArgusKills == '--' and '0' or stats.bossHArgusKills)  .. '|cffffffff / ' .. '|cffff8000 Mythic: ' .. (stats.bossMArgusKills == '--' and '0' or stats.bossMArgusKills)
				
			end

 -- account wide info		
			
			text = text .. '\n \n|cff00ff00--- Account Wide |cFFFFFFFF'

            if options.showLevel then
                text = text .. '\n|cFFF1C502Level 110 Credit:  |cFFFFFFFF' .. stats.levelhundred
            end

-- current boss kill credits

			if options.showBosses then
				text = text .. '\n'
				text = text .. '\n|cFFF1C502Xavius Kill Credit:  |cFFFFFFFF' .. stats.bossXaviusDate
				text = text .. '\n|cFFF1C502Mythic Xavius Kill Credit:  |cFFFFFFFF' .. stats.bossMXaviusDate
				
				text = text .. '\n|cFFF1C502Helya Kill Credit:  |cFFFFFFFF' .. stats.bossHelyaDate
				text = text .. '\n|cFFF1C502Mythic Helya Kill Credit:  |cFFFFFFFF' .. stats.bossMHelyaDate
				
				text = text .. '\n|cFFF1C502Guldan Kill Credit:  |cFFFFFFFF' .. stats.bossGuldanDate
				text = text .. '\n|cFFF1C502Mythic Guldan Kill Credit:  |cFFFFFFFF' .. stats.bossMGuldanDate
				
				text = text .. '\n|cFFF1C502Kil\'Jaeden Kill Credit:  |cFFFFFFFF' .. stats.bossKiljaedenDate
				text = text .. '\n|cFFF1C502Mythic Kil\'Jaeden Kill Credit:  |cFFFFFFFF' .. stats.bossMKiljaedenDate
				
				text = text .. '\n|cFFF1C502Argus Kill Credit:  |cFFFFFFFF' .. stats.bossArgusDate
				text = text .. '\n|cFFF1C502Mythic Argus Kill Credit:  |cFFFFFFFF' .. stats.bossMArgusDate
            end

       end

        if text ~= '' then
            self.line:SetText(text)
        end
    end

    GameTooltip:Show()

    if not UnitName('mouseover') then
        GameTooltip:FadeOut()
    end

-- cleanup achievement lookup
	
    ClearAchievementComparisonUnit()

    if _G.GearScore then
        _G.GearScore:RegisterEvent('INSPECT_ACHIEVEMENT_READY')
    end

    if Elite then
        Elite:RegisterEvent('INSPECT_ACHIEVEMENT_READY')
    end

    if AchievementFrameComparison then
        AchievementFrameComparison:RegisterEvent('INSPECT_ACHIEVEMENT_READY')
    end

    self:RegisterEvent('UPDATE_MOUSEOVER_UNIT')
end

-- look for shifted key type

function RapSheet:MODIFIER_STATE_CHANGED()
    if arg1 == 'LCTRL' or arg1 == 'RCTRL' then
        if self.line and UnitName('mouseover') == self.unit then
            self:UPDATE_MOUSEOVER_UNIT(true)
        end
    end
end

-- refresh

function RapSheet:UPDATE_MOUSEOVER_UNIT(refresh)
    if not refresh then
        self.unit, self.line = nil, nil
    end

    if (not options.showInCombat and UnitAffectingCombat('player')) or UnitIsDead('player') or not UnitExists('mouseover')
    or not UnitIsPlayer('mouseover') or not UnitIsConnected('mouseover') or UnitIsDead('mouseover') then
        return
    end

    self.unit = UnitName('mouseover')

    local text = '\nRap Sheep - working..'

    if refresh then
        self.line:SetText(text)
    else
        GameTooltip:AddLine(text)
        self.line = _G['GameTooltipTextLeft' .. GameTooltip:NumLines()]
    end

    GameTooltip:Show()

    if _G.GearScore then
        _G.GearScore:UnregisterEvent('INSPECT_ACHIEVEMENT_READY')
    end

    if Elite then
        Elite:UnregisterEvent('INSPECT_ACHIEVEMENT_READY')
    end

    if AchievementFrameComparison then
        AchievementFrameComparison:UnregisterEvent('INSPECT_ACHIEVEMENT_READY')
    end

    self:UnregisterEvent('UPDATE_MOUSEOVER_UNIT')
    self:RegisterEvent('INSPECT_ACHIEVEMENT_READY')

    SetAchievementComparisonUnit('mouseover')
end