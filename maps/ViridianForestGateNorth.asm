ViridianForestGateNorth_MapScripts:
	def_scene_scripts

	def_callbacks

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
