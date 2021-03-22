ViridianForestGateNorth_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianForestGateNorth_GuardScript:
	jumptextfaceplayer ViridianForestGateNorth_GuardText

ViridianForestGateNorth_GuardText:
	text "If you have CUT,"
	line "you can take the"
	cont "path around the"
	cont "forest."

	para "If you do that you"
	line "might miss out on"
	cont "some rare #MON,"
	cont "though!"
	done

ViridianForestGateNorth_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, ROUTE_2, 6
	warp_event  5,  0, ROUTE_2, 7
	warp_event  4,  7, VIRIDIAN_FOREST, 1
	warp_event  5,  7, VIRIDIAN_FOREST, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianForestGateNorth_GuardScript, -1
