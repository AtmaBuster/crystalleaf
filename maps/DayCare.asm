	object_const_def
	const DAYCARE_GRAMPS
	const DAYCARE_GRANNY

DayCare_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EggCheckCallback

.EggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	endcallback

DayCareManScript_Inside:
	faceplayer
	opentext
	checkevent EVENT_GOT_ODD_EGG
	iftrue .AlreadyHaveOddEgg
	writetext DayCareManText_GiveOddEgg
	promptbutton
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	special GiveOddEgg
	waitsfx
	writetext DayCareText_GotOddEgg
	playsound SFX_KEY_ITEM
	waitsfx
	writetext DayCareText_DescribeOddEgg
	waitbutton
	closetext
	setevent EVENT_GOT_ODD_EGG
	end

.PartyFull:
	opentext
	writetext DayCareText_PartyFull
	waitbutton
	closetext
	end

.AlreadyHaveOddEgg:
	special DayCareMan
	waitbutton
	closetext
	end

DayCareLadyScript:
	faceplayer
	opentext
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .HusbandWasLookingForYou
	checkevent EVENT_CLEARED_RADIO_TOWER
	iffalse .Skip
	checkevent EVENT_GOT_DAYCARE_STARTER_EGG
	iftrue .Skip
	writetext DayCareLadyText_GiveStarterEgg
	promptbutton
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	; Cyndaquil
	giveegg CHIKORITA, EGG_LEVEL
	sjump .Join

.Totodile
	giveegg CYNDAQUIL, EGG_LEVEL
	sjump .Join

.Chikorita
	giveegg TOTODILE, EGG_LEVEL
.Join
	waitsfx
	writetext DayCareText_GotEgg
	playsound SFX_KEY_ITEM
	waitsfx
	writetext DayCareText_DescribeOddEgg
	waitbutton
	closetext
	setevent EVENT_GOT_DAYCARE_STARTER_EGG
	end

.PartyFull
	opentext
	writetext DayCareText_PartyFull
	waitbutton
	closetext
	end

.Skip
	special DayCareLady
	waitbutton
	closetext
	end

.HusbandWasLookingForYou:
	writetext Text_GrampsLookingForYou
	waitbutton
	closetext
	end

DayCareBookshelf:
	jumpstd DifficultBookshelfScript

Text_GrampsLookingForYou:
	text "Gramps was looking"
	line "for you."
	done

Text_DayCareManTalksAboutEggTicket: ; unreferenced
	text "I'm the DAY-CARE"
	line "MAN."

	para "There's something"
	line "new in GOLDENROD"

	para "called the TRADE"
	line "CORNER."

	para "I was given an EGG"
	line "TICKET that can be"

	para "traded in for a"
	line "ODD EGG."

	para "But since we run a"
	line "DAY-CARE, we don't"

	para "need it. You may"
	line "as well have it."
	done

DayCareLadyText_GiveStarterEgg:
	text "I'm the DAY-CARE"
	line "LADY."

	para "Do you know about"
	line "EGGS?"

	para "My husband and I"
	line "were raising some"
	cont "#MON, you see."

	para "We were shocked to"
	line "find an EGG!"

	para "How incredible is"
	line "could that be?"

	para "Well, wouldn't you"
	line "like this EGG?"

	para "Then fine, this is"
	line "yours to keep!"
	done

DayCareManText_GiveOddEgg:
	text "I'm the DAY-CARE"
	line "MAN."

	para "Do you know about"
	line "EGGS?"

	para "I was raising"
	line "#MON with my"
	cont "wife, you see."

	para "We were shocked to"
	line "find an EGG!"

	para "How incredible is"
	line "that?"

	para "Well, wouldn't you"
	line "like this EGG?"

	para "Then fine, this is"
	line "yours to keep!"
	done

DayCareText_ComeAgain: ; unreferenced
	text "Come again."
	done

DayCareText_GotEgg:
	text "<PLAYER> received"
	line "EGG!"
	done

DayCareText_GotOddEgg:
	text "<PLAYER> received"
	line "ODD EGG!"
	done

DayCareText_DescribeOddEgg:
	text "I found that when"
	line "I was caring for"

	para "someone's #MON"
	line "before."

	para "But the trainer"
	line "didn't want the"

	para "EGG, so I'd kept"
	line "it around."
	done

DayCareText_PartyFull:
	text "You've no room for"
	line "this."
	done

DayCare_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  5, ROUTE_34, 3
	warp_event  0,  6, ROUTE_34, 4
	warp_event  2,  7, ROUTE_34, 5
	warp_event  3,  7, ROUTE_34, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, DayCareBookshelf
	bg_event  1,  1, BGEVENT_READ, DayCareBookshelf

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Inside, EVENT_DAY_CARE_MAN_IN_DAY_CARE
	object_event  5,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DayCareLadyScript, -1
