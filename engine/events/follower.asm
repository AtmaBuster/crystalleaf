SECTION "Follower Script", ROMX
FollowerScript::
	callasm FollowerScript_CheckFollowerSwapped
	iftrue FollowerScript_Red
FollowerScript_Leaf::
	faceplayer
	opentext
	writetext Follower_Text_Leaf_Intro
	loadmenu Follower_ActionMenuHeader
	verticalmenu
	closewindow
	ifequal 1, FollowerScript_Leaf_Trade
	ifequal 2, FollowerScript_Leaf_Battle
	ifequal 3, FollowerScript_Leaf_Chat
	writetext Follower_Text_Leaf_AllDone
	waitbutton
	closetext
	end

FollowerScript_Red::
	faceplayer
	opentext
	writetext Follower_Text_Red_Intro
	loadmenu Follower_ActionMenuHeader
	verticalmenu
	closewindow
	ifequal 1, FollowerScript_Red_Trade
	ifequal 2, FollowerScript_Red_Battle
	ifequal 3, FollowerScript_Red_Chat
	writetext Follower_Text_Red_AllDone
	waitbutton
	closetext
	end

FollowerScript_Leaf_Trade::
; can only trade in Pokemon Centers, check the tileset
	readvar VAR_CUR_TILESET
	ifnotequal TILESET_POKECENTER, FollowerScript_Leaf_CantTradeLocation
	writetext Follower_Text_Leaf_LetsTrade
	waitbutton
	scall Follower_TradeMons
	iffalse FollowerScript_Leaf_TradeNevermind
	writetext Follower_Text_Leaf_TradeDone
	waitbutton
	closetext
	end

FollowerScript_Leaf_TradeNevermind::
	writetext Follower_Text_Leaf_TradeNevermind
	waitbutton
	closetext
	end

FollowerScript_Leaf_CantTradeLocation::
	writetext Follower_Text_Leaf_CantTradeLocation
	waitbutton
	closetext
	end

FollowerScript_Red_Trade::
; can only trade in Pokemon Centers, check the tileset
	readvar VAR_CUR_TILESET
	ifnotequal TILESET_POKECENTER, FollowerScript_Red_CantTradeLocation
	writetext Follower_Text_Red_LetsTrade
	waitbutton
	scall Follower_TradeMons
	iffalse FollowerScript_Red_TradeNevermind
	writetext Follower_Text_Red_TradeDone
	waitbutton
	closetext
	end

FollowerScript_Red_TradeNevermind::
	writetext Follower_Text_Red_TradeNevermind
	waitbutton
	closetext
	end

FollowerScript_Red_CantTradeLocation::
	writetext Follower_Text_Red_CantTradeLocation
	waitbutton
	closetext
	end

FollowerScript_Leaf_Battle::
	readvar VAR_CUR_ENVIRONMENT
	ifequal ROUTE, FollowerScript_Leaf_CantBattleRoute
	ifequal INDOOR, FollowerScript_Leaf_CantBattleIndoor
	ifequal CAVE, FollowerScript_Leaf_CantBattleRoute
	ifequal GATE, FollowerScript_Leaf_CantBattleIndoor
	ifequal DUNGEON, FollowerScript_Leaf_CantBattleRoute
	ifnotequal TOWN, FollowerScript_Leaf_CantBattleRoute
	writetext Follower_Text_Leaf_LetsBattle
	waitbutton
	winlosstext Follower_Text_Leaf_BattleWin, Follower_Text_Leaf_BattleLoss
	scall Follower_Battle
	writetext Follower_Text_Leaf_BattleDone
	waitbutton
	closetext
	end

FollowerScript_Leaf_CantBattleRoute::
	writetext Follower_Text_Leaf_CantBattleRoute
	waitbutton
	closetext
	end

FollowerScript_Leaf_CantBattleIndoor::
	writetext Follower_Text_Leaf_CantBattleIndoor
	waitbutton
	closetext
	end

FollowerScript_Red_Battle::
	readvar VAR_CUR_ENVIRONMENT
	ifequal ROUTE, FollowerScript_Red_CantBattleRoute
	ifequal INDOOR, FollowerScript_Red_CantBattleIndoor
	ifequal CAVE, FollowerScript_Red_CantBattleRoute
	ifequal GATE, FollowerScript_Red_CantBattleIndoor
	ifequal DUNGEON, FollowerScript_Red_CantBattleRoute
	ifnotequal TOWN, FollowerScript_Red_CantBattleRoute
	writetext Follower_Text_Red_LetsBattle
	waitbutton
	winlosstext Follower_Text_Red_BattleWin, Follower_Text_Red_BattleLoss
	scall Follower_Battle
	writetext Follower_Text_Red_BattleDone
	waitbutton
	closetext
	end

FollowerScript_Red_CantBattleRoute::
	writetext Follower_Text_Red_CantBattleRoute
	waitbutton
	closetext
	end

FollowerScript_Red_CantBattleIndoor::
	writetext Follower_Text_Red_CantBattleIndoor
	waitbutton
	closetext
	end

FollowerScript_Red_Chat::
FollowerScript_Leaf_Chat::
	writetext Follower_Text_NYI
	waitbutton
	closetext
	end

Follower_ActionMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 0, 19, 9
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "Trade@"
	db "Battle@"
	db "Chat@"
	db "Nothing@"

Follower_Text_Leaf_Intro::
	text "Follower Text"
	line "Leaf:Intro"
	done

Follower_Text_Leaf_AllDone::
	text "Follower Text"
	line "Leaf:All Done"
	done

Follower_Text_Leaf_CantTradeLocation::
	text "Follower Text"
	line "Leaf:Can't Trade"
	cont "Not in PMC"
	done

Follower_Text_Leaf_LetsTrade::
	text "Follower Text"
	line "Leaf:Let's Trade"
	done

Follower_Text_Leaf_TradeDone::
	text "Follower Text"
	line "Leaf:Done Trade"
	done

Follower_Text_Leaf_TradeNevermind::
	text "Follower Text"
	line "Leaf:Done NVM"
	done

Follower_Text_Leaf_BattleWin::
	text "Follower Text"
	line "Leaf:Battle Win"
	done

Follower_Text_Leaf_BattleLoss::
	text "Follower Text"
	line "Leaf:Battle Loss"
	done

Follower_Text_Leaf_BattleDone::
	text "Follower Text"
	line "Leaf:Battle Done"
	done

Follower_Text_Leaf_CantBattleRoute::
	text "Follower Text"
	line "Leaf:Can't Battle"
	cont "In route"
	done

Follower_Text_Leaf_CantBattleIndoor::
	text "Follower Text"
	line "Leaf:Can't Battle"
	cont "Indoor"
	done

Follower_Text_Leaf_LetsBattle::
	text "Follower Text"
	line "Leaf:Let's Battle"
	done

Follower_Text_NYI:: ; debugging
	text "Follower Text"
	line "Feature NYI"
	done

Follower_Text_Red_Intro::
	text "Follower Text"
	line "Red:Intro"
	done

Follower_Text_Red_AllDone::
	text "Follower Text"
	line "Red:All Done"
	done

Follower_Text_Red_CantTradeLocation::
	text "Follower Text"
	line "Red:Can't Trade"
	cont "Not in PMC"
	done

Follower_Text_Red_LetsTrade::
	text "Follower Text"
	line "Red:Let's Trade"
	done

Follower_Text_Red_TradeDone::
	text "Follower Text"
	line "Red:Done Trade"
	done

Follower_Text_Red_TradeNevermind::
	text "Follower Text"
	line "Red:Done NVM"
	done

Follower_Text_Red_BattleWin::
	text "Follower Text"
	line "Red:Battle Win"
	done

Follower_Text_Red_BattleLoss::
	text "Follower Text"
	line "Red:Battle Loss"
	done

Follower_Text_Red_BattleDone::
	text "Follower Text"
	line "Red:Battle Done"
	done

Follower_Text_Red_CantBattleRoute::
	text "Follower Text"
	line "Red:Can't Battle"
	cont "In route"
	done

Follower_Text_Red_CantBattleIndoor::
	text "Follower Text"
	line "Red:Can't Battle"
	cont "Indoor"
	done

Follower_Text_Red_LetsBattle::
	text "Follower Text"
	line "Red:Let's Battle"
	done

Follower_Battle::
	callasm .battlemode
	loadtrainer TRAINER_FROM_RAM, 0
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	callasm .battlemode
	reloadmap
	opentext
	end

.battlemode
	ldh a, [hFollowerBattleMode]
	xor 1
	ldh [hFollowerBattleMode], a
	ret

Follower_TradeMons::
	special FollowerTrade
	end

_SwapFollowerScript::
	callasm CanSwapFollower
	iffalse .done
	jumpstd SwapFollowerScript

.done
	end

FollowerScript_CheckFollowerSwapped:
	ld a, TRUE
	ld hl, wFollowerFlags
	bit FOLLOWER_SWAPPED_F, [hl]
	jr nz, .ok
	ld a, FALSE
.ok
	ld [wScriptVar], a
	ret

