	object_const_def
	const CERULEAN_CAVE_2F_BALL_1
	const CERULEAN_CAVE_2F_BALL_2
	const CERULEAN_CAVE_2F_BALL_3
	const CERULEAN_CAVE_2F_BALL_4

CeruleanCave2F_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanCave2F_FullRestore:
	itemball FULL_RESTORE

CeruleanCave2F_PPUp:
	itemball FULL_RESTORE

CeruleanCave2F_UltraBall:
	itemball ULTRA_BALL

CeruleanCave2F_MaxRevive:
	itemball MAX_REVIVE

CeruleanCave2F_RareCandy:
	itemball RARE_CANDY

CeruleanCave2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 24,  8, CERULEAN_CAVE_1F, 2
	warp_event 31,  3, CERULEAN_CAVE_1F, 3
	warp_event 11,  3, CERULEAN_CAVE_1F, 4
	warp_event 21,  9, CERULEAN_CAVE_1F, 5
	warp_event  5, 13, CERULEAN_CAVE_1F, 6
	warp_event  3,  5, CERULEAN_CAVE_1F, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event 15,  8, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_FullRestore, EVENT_CERULEAN_CAVE_2F_FULL_RESTORE_1
	object_event  6, 17, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_UltraBall, EVENT_CERULEAN_CAVE_2F_ULTRA_BALL_1
	object_event 31, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_PPUp, EVENT_CERULEAN_CAVE_2F_PP_UP_1

CeruleanCave2F_RG_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 24,  8, CERULEAN_CAVE_1F, 2
	warp_event 31,  3, CERULEAN_CAVE_1F, 3
	warp_event 11,  3, CERULEAN_CAVE_1F, 4
	warp_event 21,  9, CERULEAN_CAVE_1F, 5
	warp_event  5, 13, CERULEAN_CAVE_1F, 6
	warp_event  3,  5, CERULEAN_CAVE_1F, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event 31, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_FullRestore, EVENT_CERULEAN_CAVE_2F_FULL_RESTORE_2
	object_event 27, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_UltraBall, EVENT_CERULEAN_CAVE_2F_ULTRA_BALL_2
	object_event  7, 17, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_PPUp, EVENT_CERULEAN_CAVE_2F_PP_UP_2

CeruleanCave2F_Y_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 24,  8, CERULEAN_CAVE_1F, 2
	warp_event 31,  3, CERULEAN_CAVE_1F, 3
	warp_event 11,  3, CERULEAN_CAVE_1F, 4
	warp_event 21,  9, CERULEAN_CAVE_1F, 5
	warp_event  5, 13, CERULEAN_CAVE_1F, 6
	warp_event  3,  5, CERULEAN_CAVE_1F, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event 13, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_MaxRevive, EVENT_CERULEAN_CAVE_2F_MAX_REVIVE
	object_event 29, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_FullRestore, EVENT_CERULEAN_CAVE_2F_FULL_RESTORE_3
	object_event 18,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_UltraBall, EVENT_CERULEAN_CAVE_2F_ULTRA_BALL_3
	object_event  2, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCave2F_RareCandy, EVENT_CERULEAN_CAVE_2F_RARE_CANDY
