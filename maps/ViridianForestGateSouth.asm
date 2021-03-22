ViridianForestGateSouth_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianForestGateSouth_GuardScript:
	jumptextfaceplayer ViridianForestGateSouth_GuardText

ViridianForestGateSouth_BugCatcherScript:
	jumptextfaceplayer ViridianForestGateSouth_BugCatcherText

ViridianForestGateSouth_GuardText:
	text "VIRIDIAN FOREST"
	line "can be scary for"
	cont "new trainers."

	para "You seem to be"
	line "experienced, so"
	cont "you shouldn't have"
	cont "any trouble."
	done

ViridianForestGateSouth_BugCatcherText:
	text "I want to catch"
	line "some bug #MON,"
	cont "but I'm worried I'll"
	cont "get lost."
	done

ViridianForestGateSouth_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, VIRIDIAN_FOREST, 2
	warp_event  5,  0, VIRIDIAN_FOREST, 3
	warp_event  4,  7, ROUTE_2, 8
	warp_event  5,  7, ROUTE_2, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianForestGateSouth_GuardScript, -1
	object_event  6,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, 0, 0, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ViridianForestGateSouth_BugCatcherScript, -1
