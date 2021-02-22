	object_const_def
	const CERULEAN_CAVE_MEWTWO
	const CERULEAN_CAVE_B1F_BALL_1
	const CERULEAN_CAVE_B1F_BALL_2
	const CERULEAN_CAVE_B1F_BALL_3
	const CERULEAN_CAVE_B1F_BALL_4

CeruleanCaveB1F_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanCaveB1F_Mewtwo:
	faceplayer
	opentext
	writetext MewtwoText
	cry MEWTWO
	pause 15
	closetext
	loadwildmon MEWTWO, 70
	startbattle
	disappear CERULEAN_CAVE_MEWTWO
	reloadmapafterbattle
	end

MewtwoText:
	text "Mew!"
	done

CeruleanCaveB1F_MaxElixer:
	itemball MAX_ELIXER

CeruleanCaveB1F_UltraBall:
	itemball ULTRA_BALL

CeruleanCaveB1F_MaxRevive:
	itemball MAX_REVIVE

CeruleanCaveB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  8, CERULEAN_CAVE_1F, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event 29, 15, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanCaveB1F_Mewtwo, EVENT_CERULEAN_CAVE_MEWTWO
	object_event 18, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_UltraBall, EVENT_CERULEAN_CAVE_B1F_ULTRA_BALL_1
	object_event 20,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_MaxRevive, EVENT_CERULEAN_CAVE_B1F_MAX_REVIVE_1

CeruleanCaveB1F_RG_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  8, CERULEAN_CAVE_1F, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7, 12, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanCaveB1F_Mewtwo, EVENT_CERULEAN_CAVE_MEWTWO
	object_event 26,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_UltraBall, EVENT_CERULEAN_CAVE_B1F_ULTRA_BALL_2
	object_event 26,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_MaxRevive, EVENT_CERULEAN_CAVE_B1F_MAX_REVIVE_2

CeruleanCaveB1F_Y_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  8, CERULEAN_CAVE_1F, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event 29, 15, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanCaveB1F_Mewtwo, EVENT_CERULEAN_CAVE_MEWTWO
	object_event  4, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_UltraBall, EVENT_CERULEAN_CAVE_B1F_ULTRA_BALL_3
	object_event 28,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_UltraBall, EVENT_CERULEAN_CAVE_B1F_ULTRA_BALL_4
	object_event  5, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_MaxRevive, EVENT_CERULEAN_CAVE_B1F_MAX_REVIVE_3
	object_event 17,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, CeruleanCaveB1F_MaxElixer, EVENT_CERULEAN_CAVE_B1F_MAX_ELIXER
