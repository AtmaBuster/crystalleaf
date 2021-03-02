	object_const_def
	const CERULEANGYMBADGESPEECHHOUSE_POKEFAN_M

CeruleanGymBadgeSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanGymBadgeSpeechHousePokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BULBASAUR
	iftrue .GotBulbasaur
	writetext Text_WantABulbasaur
	yesorno
	iffalse .Refuse
	writetext Text_TakeBulbasaur
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	writetext ReceivedBulbasaurText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke BULBASAUR, 5
	setevent EVENT_GOT_BULBASAUR
	writetext Text_AfterGetBulbasaur
	waitbutton
	closetext
	end

.Refuse:
	writetext Text_RefusedBulbasaur
	waitbutton
	closetext
	end

.NoRoom:
	writetext Text_NoRoomBulbasaur
	waitbutton
	closetext
	end

.GotBulbasaur:
	writetext Text_HowIsBulbasaur
	waitbutton
	closetext
	end

Text_AfterGetBulbasaur:
	text "Please raise it to"
	line "be big and strong!"
	done

ReceivedBulbasaurText:
	text "<PLAYER> received"
	line "BULBASAUR!"
	done

Text_TakeBulbasaur:
	text "Oh! That's great!"

	para "BULBASAUR will be"
	line "so happy!"
	done

Text_HowIsBulbasaur:
	text "How is that cute"
	line "BULBASAUR doing?"
	done

Text_RefusedBulbasaur:
	text "Oh, I see."

	para "I wonder if"
	line "BULBASAUR will"
	cont "ever find a"
	cont "trainer…"
	done

Text_NoRoomBulbasaur:
	text "You don't have room"
	line "for a #MON."
	done

Text_WantABulbasaur:
	text "Hello. I used to"
	line "be a #MON"
	cont "caretaker."

	para "The only #MON"
	line "I have left is"
	cont "this BULBASAUR."

	para "I think it would"
	line "like to go with a"
	cont "strong trainer."

	para "Oh, you're the"
	line "CHAMPION?"

	para "Will you take this"
	line "BULBASAUR along?"
	done

CeruleanGymBadgeSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 1
	warp_event  3,  7, CERULEAN_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeruleanGymBadgeSpeechHousePokefanMScript, -1
