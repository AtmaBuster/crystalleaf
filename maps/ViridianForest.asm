	object_const_def
	const VIRIDIAN_FOREST_BUG_CATCHER_1
	const VIRIDIAN_FOREST_BUG_CATCHER_2
	const VIRIDIAN_FOREST_BUG_CATCHER_3
	const VIRIDIAN_FOREST_POKE_BALL1
	const VIRIDIAN_FOREST_POKE_BALL2

ViridianForest_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBugCatcherHuey:
	trainer BUG_CATCHER, HUEY, EVENT_BEAT_BUG_CATCHER_HUEY, BugCatcherHueySeenText, BugCatcherHueyBeatenText, 0, .Script

.Script
	endifjustbattled
	opentext
	writetext BugCatcherHueyAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherDewey:
	trainer BUG_CATCHER, DEWEY, EVENT_BEAT_BUG_CATCHER_DEWEY, BugCatcherDeweySeenText, BugCatcherDeweyBeatenText, 0, .Script

.Script
	endifjustbattled
	opentext
	writetext BugCatcherDeweyAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherLouie:
	trainer BUG_CATCHER, LOUIE, EVENT_BEAT_BUG_CATCHER_LOUIE, BugCatcherLouieSeenText, BugCatcherLouieBeatenText, 0, .Script

.Script
	endifjustbattled
	opentext
	writetext BugCatcherLouieAfterBattleText
	waitbutton
	closetext
	end

ViridianForestDireHit:
	itemball DIRE_HIT

ViridianForestMaxPotion:
	itemball MAX_POTION

ViridianForestHiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_VIRIDIAN_FOREST_HIDDEN_MAX_ETHER

ViridianForestHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_VIRIDIAN_FOREST_HIDDEN_FULL_HEAL

ViridianForestHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_VIRIDIAN_FOREST_HIDDEN_FULL_RESTORE

ViridianForestHiddenRevive:
	hiddenitem REVIVE, EVENT_VIRIDIAN_FOREST_HIDDEN_REVIVE

ViridianForestSign1:
	jumptext ViridianForestSign1Text

ViridianForestSign2:
	jumptext ViridianForestSign2Text

BugCatcherHueySeenText:
	text "Check out my rare"
	line "bug #MON!"
	done

BugCatcherHueyBeatenText:
	text "No!"
	line "My precious bugs!"
	done

BugCatcherHueyAfterBattleText:
	text "Some researchers"
	line "think there might"
	cont "be a link between"
	cont "PINSIR and"
	cont "HERACROSS."

	para "Nobody has found"
	line "any proof, yet."
	done

BugCatcherLouieSeenText:
	text "Not all bug"
	line "#MON evolve"
	cont "so easily."
	done

BugCatcherLouieBeatenText:
	text "You've pierced my"
	line "ironclad defense!"
	done

BugCatcherLouieAfterBattleText:
	text "Evolving my"
	line "SCYTHER into a"
	cont "SCIZOR took a lot"
	cont "of work."
	done

BugCatcherDeweySeenText:
	text "Attack! My army of"
	line "bugs!"
	done

BugCatcherDeweyBeatenText:
	text "I lost the war…"
	done

BugCatcherDeweyAfterBattleText:
	text "The bug-type isn't"
	line "very powerful on"
	cont "its own, but when"
	cont "paired with some"
	cont "other type it can"
	cont "really stand out!"
	done

ViridianForestSign1Text:
	text "Leaving"
	line "VIRIDIAN FOREST"
	cont "PEWTER CITY ahead"
	done

ViridianForestSign2Text:
	text "South"
	line "VIRIDIAN CITY"
	done

ViridianForest_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  3, VIRIDIAN_FOREST_GATE_NORTH, 3
	warp_event 19, 43, VIRIDIAN_FOREST_GATE_SOUTH, 1
	warp_event 20, 43, VIRIDIAN_FOREST_GATE_SOUTH, 2

	def_coord_events

	def_bg_events
	bg_event 21, 42, BGEVENT_READ, ViridianForestSign1
	bg_event  5,  5, BGEVENT_READ, ViridianForestSign2
	bg_event 24,  6, BGEVENT_ITEM, ViridianForestHiddenMaxEther
	bg_event 19, 39, BGEVENT_ITEM, ViridianForestHiddenFullHeal
	bg_event  2, 13, BGEVENT_ITEM, ViridianForestHiddenFullRestore
	bg_event  3, 37, BGEVENT_ITEM, ViridianForestHiddenRevive

	def_object_events
	object_event  6, 39, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherLouie, -1
	object_event 34, 23, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 5, TrainerBugCatcherDewey, -1
	object_event  5, 13, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherHuey, -1
	object_event 29, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestDireHit, EVENT_VIRIDIAN_FOREST_DIRE_HIT
	object_event 13, 25, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, ViridianForestMaxPotion, EVENT_VIRIDIAN_FOREST_MAX_POTION
