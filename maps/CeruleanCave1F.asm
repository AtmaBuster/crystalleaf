	object_const_def
	const CERULEAN_CAVE_1F_BALL_1
	const CERULEAN_CAVE_1F_BALL_2
	const CERULEAN_CAVE_1F_BALL_3
	const CERULEAN_CAVE_1F_BALL_4

CeruleanCave1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .VisitedFlag

.VisitedFlag:
	setflag ENGINE_CERULEAN_CAVE_UNLOCKED
	endcallback

CeruleanCave1F_Nugget:
	itemball NUGGET

CeruleanCave1F_FullRestore:
	itemball FULL_RESTORE

CeruleanCave1F_MaxElixer:
	itemball MAX_ELIXER

CeruleanCave1F_RareCandy:
	itemball RARE_CANDY

CeruleanCave1F_UltraBall:
	itemball ULTRA_BALL

CeruleanCave1F_MaxRevive:
	itemball MAX_REVIVE

CeruleanCave1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 27, 19, CERULEAN_CITY, 7
	warp_event 25,  9, CERULEAN_CAVE_2F, 1
	warp_event 29,  3, CERULEAN_CAVE_2F, 2
	warp_event  9,  3, CERULEAN_CAVE_2F, 3
	warp_event 20, 11, CERULEAN_CAVE_2F, 4
	warp_event  5, 13, CERULEAN_CAVE_2F, 5
	warp_event  3,  5, CERULEAN_CAVE_2F, 6
	warp_event  2,  8, CERULEAN_CAVE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_Nugget, EVENT_CERULEAN_CAVE_1F_NUGGET_1
	object_event  9, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_FullRestore, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE_1
	object_event 21,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_MaxElixer, EVENT_CERULEAN_CAVE_1F_MAX_ELIXER_1

CeruleanCave1F_RG_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 27, 19, CERULEAN_CITY, 7
	warp_event 25,  9, CERULEAN_CAVE_2F, 1
	warp_event 29,  3, CERULEAN_CAVE_2F, 2
	warp_event  9,  3, CERULEAN_CAVE_2F, 3
	warp_event 20, 11, CERULEAN_CAVE_2F, 4
	warp_event  5, 13, CERULEAN_CAVE_2F, 5
	warp_event  3,  5, CERULEAN_CAVE_2F, 6
	warp_event  2,  8, CERULEAN_CAVE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_Nugget, EVENT_CERULEAN_CAVE_1F_NUGGET_2
	object_event  9, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_FullRestore, EVENT_CERULEAN_CAVE_1F_FULL_RESTORE_2
	object_event 21,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_MaxElixer, EVENT_CERULEAN_CAVE_1F_MAX_ELIXER_2

CeruleanCave1F_Y_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 27, 19, CERULEAN_CITY, 7
	warp_event 25,  9, CERULEAN_CAVE_2F, 1
	warp_event 29,  3, CERULEAN_CAVE_2F, 2
	warp_event  9,  3, CERULEAN_CAVE_2F, 3
	warp_event 20, 11, CERULEAN_CAVE_2F, 4
	warp_event  5, 13, CERULEAN_CAVE_2F, 5
	warp_event  3,  5, CERULEAN_CAVE_2F, 6
	warp_event  2,  8, CERULEAN_CAVE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_MaxElixer, EVENT_CERULEAN_CAVE_1F_MAX_ELIXER_3
	object_event 31,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_RareCandy, EVENT_CERULEAN_CAVE_1F_RARE_CANDY
	object_event 20,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_UltraBall, EVENT_CERULEAN_CAVE_1F_ULTRA_BALL
	object_event 31, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave1F_MaxRevive, EVENT_CERULEAN_CAVE_1F_MAX_REVIVE
