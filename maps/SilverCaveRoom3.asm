	object_const_def
	const SILVERCAVEROOM3_GOLD
	const SILVERCAVEROOM3_KRIS

MAX_GOLD_KRIS_LOSSES EQU 3 + 1

SilverCaveRoom3_MapScripts:
	def_scene_scripts

	def_callbacks

Kris:
	readvar VAR_FACING
	ifequal UP, .from_below
	ifequal LEFT, .from_right
; from above
	applymovement PLAYER, GoldKris_KrisFromAbove
	turnobject FOLLOWER, UP
	sjump GoldKris

.from_right
	applymovement PLAYER, GoldKris_KrisFromRight
	turnobject FOLLOWER, UP
	sjump GoldKris

.from_below
	applymovement PLAYER, GoldKris_KrisFromBelow
	turnobject FOLLOWER, UP
	sjump GoldKris

Gold:
	readvar VAR_FACING
	ifequal UP, .from_below
	ifequal RIGHT, .from_left
; from above
	applymovement PLAYER, GoldKris_GoldFromAbove
	applymovement FOLLOWER, GoldKris_GoldFollowerLeft
	sjump GoldKris

.from_left
	applymovement PLAYER, GoldKris_GoldFromLeft
	applymovement FOLLOWER, GoldKris_GoldFollowerLeft
	sjump GoldKris

.from_below
	faceobject FOLLOWER, PLAYER
	readvar VAR_FOLLOWER_FACING
	ifequal RIGHT, .follower_from_left
	ifequal UP, .follower_from_below
; from right
	turnobject FOLLOWER, UP
	sjump GoldKris

.follower_from_left
	applymovement FOLLOWER, GoldKris_GoldFollowerLeft
	sjump GoldKris

.follower_from_below
	applymovement FOLLOWER, GoldKris_GoldFollowerBelow
	sjump GoldKris

GoldKris:
	special FadeOutMusic
	turnobject SILVERCAVEROOM3_GOLD, DOWN
	turnobject SILVERCAVEROOM3_KRIS, DOWN
	opentext
	writetext GoldSeenText
	waitbutton
	closetext
	callasm .increment_fight_counter
	winlosstext GoldWinLossText, GoldWinLossText
	loadtrainer GOLD_NPC, GOLD1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special FadeOutMusic
	readvar VAR_GOLD_KRIS_LOSS_COUNTER
	ifless MAX_GOLD_KRIS_LOSSES, .skip_ask_to_swap
	opentext
	writetext GoldKrisAskSwap
	yesorno
	closetext
	iffalse .skip_swap
.skip_ask_to_swap
	callstd SwapFollowerScript
	turnobject PLAYER, UP
	turnobject FOLLOWER, UP
.skip_swap
	scall SwapGoldAndKris
	pause 15
	opentext
	writetext GoldSeenText
	waitbutton
	closetext
	winlosstext GoldWinLossText, GoldWinLossText
	loadtrainer KRIS_NPC, KRIS1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special FadeOutMusic
	opentext
	writetext GoldLeavesText
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_GOLD
	disappear SILVERCAVEROOM3_KRIS
	loadvar VAR_GOLD_KRIS_LOSS_COUNTER, 0
	pause 15
	special FadeInQuickly
	pause 30
	special HealParty
	refreshscreen
	credits
	end

.increment_fight_counter
	ld hl, wGoldKrisLossCounter
	ld a, [hl]
	cp MAX_GOLD_KRIS_LOSSES
	ret nc
	inc [hl]
	ret

SwapGoldAndKris:
	faceobject SILVERCAVEROOM3_GOLD, SILVERCAVEROOM3_KRIS
	playsound SFX_JUMP_OVER_LEDGE
	applymovement SILVERCAVEROOM3_KRIS, KrisHop
	applymovement SILVERCAVEROOM3_GOLD, GoldMoveAway
	turnobject SILVERCAVEROOM3_GOLD, DOWN
	turnobject SILVERCAVEROOM3_KRIS, DOWN
	end

GoldSeenText:
	text "<……>"
	line "<……>"
	done

GoldWinLossText:
	text "…"
	done

GoldLeavesText:
	text "<……>"
	line "<……>"
	done

GoldKrisAskSwap:
	text "Will <PLAYER> swap"
	line "with <FOLLOW>?"
	done

KrisHop:
	short_jump LEFT
	step_end

GoldMoveAway:
	step RIGHT
	step_end

GoldKris_GoldFromAbove:
	step LEFT
	step DOWN
GoldKris_GoldFromLeft:
	step DOWN
	step RIGHT
	turn_head UP
	step_end

GoldKris_GoldFollowerLeft:
	step DOWN
	step RIGHT
GoldKris_GoldFollowerBelow:
	step RIGHT
	step UP
	step_end

GoldKris_KrisFromAbove:
	step RIGHT
	step DOWN
GoldKris_KrisFromRight:
	step DOWN
	step LEFT
GoldKris_KrisFromBelow:
	step LEFT
	turn_head UP
	step_end

SilverCaveRoom3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 33, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 10, SPRITE_GOLDNPC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Gold, EVENT_GOLD_KRIS_IN_MT_SILVER
	object_event 10, 10, SPRITE_KRISNPC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Kris, EVENT_GOLD_KRIS_IN_MT_SILVER
