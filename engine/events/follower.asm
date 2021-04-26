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
	ifequal 1, FollowerScript_Leaf_Chat
	ifequal 2, FollowerScript_Leaf_Trade
	ifequal 3, FollowerScript_Leaf_Battle
	ifequal 4, FollowerScript_Leaf_Switch
if DEF(_DEBUG2)
	ifequal 6, FollowerScript_ChatDebug
endc
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
	ifequal 1, FollowerScript_Red_Chat
	ifequal 2, FollowerScript_Red_Trade
	ifequal 3, FollowerScript_Red_Battle
	ifequal 4, FollowerScript_Red_Switch
if DEF(_DEBUG2)
	ifequal 6, FollowerScript_ChatDebug
endc
	writetext Follower_Text_Red_AllDone
	waitbutton
	closetext
	end

FollowerScript_Red_Switch::
	callasm CanSwapFollower
	iffalse .done
	closetext
	jumpstd SwapFollowerScript

.done
	writetext Follower_Text_Red_CantSwitch
	waitbutton
	closetext
	end

FollowerScript_Leaf_Switch::
	callasm CanSwapFollower
	iffalse .done
	closetext
	jumpstd SwapFollowerScript

.done
	writetext Follower_Text_Leaf_CantSwitch
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
	readvar VAR_PARTYCOUNT
	ifequal 0, FollowerScript_Leaf_CantBattleNoMons
	writetext Follower_Text_Leaf_LetsBattle
	waitbutton
	winlosstext Follower_Text_Leaf_BattleWin, Follower_Text_Leaf_BattleLoss
	sjump Follower_Battle

FollowerScript_Leaf_CantBattleNoMons::
	writetext Follower_Text_Leaf_CantBattleNoMons
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
	readvar VAR_PARTYCOUNT
	ifequal 0, FollowerScript_Red_CantBattleNoMons
	writetext Follower_Text_Red_LetsBattle
	waitbutton
	winlosstext Follower_Text_Red_BattleWin, Follower_Text_Red_BattleLoss
	sjump Follower_Battle

FollowerScript_Red_CantBattleNoMons::
	writetext Follower_Text_Red_CantBattleNoMons
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
	sjump FollowerChatRed

FollowerScript_Leaf_Chat::
	sjump FollowerChatLeaf

if DEF(_DEBUG2)
FollowerScript_ChatDebug:
	callasm .inittext
.loop
	callasm .setuptext
	iffalse .chatdebugdone
	writetext hDebugStringBuffer
	waitbutton
	waitsfx
	playsound SFX_PUSH_BUTTON
	waitsfx
	sjump .loop

.chatdebugdone
	closetext
	end

.inittext
	xor a
	ld hl, hDebugTextIndex
	ld [hli], a
	ld a, TX_FAR
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld a, "@"
	ld [hl], a
	ret

.setuptext
	ld hl, hDebugTextIndex
	ld a, [hl]
	inc [hl]
	ld hl, FollowerChatList
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK(FollowerChatList)
	call GetFarWord
	ld a, l
	cp -1
	jr z, .setupdone
	ldh [hDebugStringBuffer + 1], a
	ld a, h
	ldh [hDebugStringBuffer + 2], a
	ld a, BANK(FollowerChatList)
	ldh [hDebugStringBuffer + 3], a
	ld a, 1
	ld [wScriptVar], a
	ret

.setupdone
	xor a
	ld [wScriptVar], a
	ret
endc

Follower_ActionMenuHeader:
	db MENU_BACKUP_TILES ; flags
if DEF(_DEBUG2)
	menu_coords 10, 0, 19, 13
else
	menu_coords 10, 0, 19, 11
endc
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
if DEF(_DEBUG2)
	db 6 ; items
else
	db 5 ; items
endc
	db "Chat@"
	db "Trade@"
	db "Battle@"
	db "Switch@"
	db "Nothing@"
if DEF(_DEBUG2)
	db "Debug@"
endc

Follower_Text_Leaf_Intro::
	text "Hey! What's up?"
	done

Follower_Text_Leaf_AllDone::
	text "Ok, let's go!"
	done

Follower_Text_Leaf_CantTradeLocation::
	text "In order to trade,"
	line "we need special"
	cont "equipment in a"
	cont "#MON CENTER."
	done

Follower_Text_Leaf_LetsTrade::
	text "Ok!"
	line "Let's trade!"
	done

Follower_Text_Leaf_TradeDone::
	text "All done!"
	done

Follower_Text_Leaf_TradeNevermind::
	text "Next time, then."
	done

Follower_Text_Leaf_BattleWin::
	text "Darn, I lost."

	para "That was a good"
	line "battle!"
	done

Follower_Text_Leaf_BattleLoss::
	text "Yay, I won!"
	done

Follower_Text_Leaf_CantBattleNoMons::
	text "We can't battle."

	para "We don't have any"
	line "#MON!"
	done

Follower_Text_Leaf_CantBattleRoute::
	text "We should battle"
	line "near a #MON"
	cont "CENTER in case our"
	cont "#MON get hurt."
	done

Follower_Text_Leaf_CantBattleIndoor::
	text "We shouldn't battle"
	line "indoors."

	para "It's too cramped!"
	done

Follower_Text_Leaf_LetsBattle::
	text "Ok, let's battle!"
	line "I won't go easy!"
	done

Follower_Text_Red_Intro::
Follower_Text_Red_AllDone::
Follower_Text_Red_LetsTrade::
Follower_Text_Red_TradeDone::
Follower_Text_Red_TradeNevermind::
Follower_Text_Red_BattleWin::
Follower_Text_Red_BattleLoss::
Follower_Text_Red_LetsBattle::
	text "…"
	done

Follower_Text_Red_CantBattleNoMons::
	text "Can't."

	para "Don't have any"
	line "#MON."
	done

Follower_Text_Red_CantTradeLocation::
	text "Can't."

	para "Only at a #MON"
	line "CENTER."
	done

Follower_Text_Red_CantBattleRoute::
	text "Can't."

	para "Only in a city."
	done

Follower_Text_Red_CantBattleIndoor::
	text "Can't."

	para "No battling"
	line "indoors."
	done

Follower_Battle::
	special BackupPartyHeldItems
	callasm .battlemode
	loadtrainer TRAINER_FROM_RAM, 0
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	callasm .battlemode
	reloadmap
	special RestorePartyHeldItems
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

Follower_Text_Red_CantSwitch:
	text "Can't right now."
	done

Follower_Text_Leaf_CantSwitch:
	text "We can't change"
	line "places right now."
	done
