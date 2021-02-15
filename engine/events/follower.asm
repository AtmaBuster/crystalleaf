SECTION "Follower Script", ROMX
FollowerScript::
	faceplayer
	opentext
	writetext .want_rare_candy
	yesorno
	iffalse .no_candy
	verbosegiveitem RARE_CANDY
	iffalse .no_room
	writetext .hope_this_helps
	waitbutton
.no_room
	closetext
	end

.no_candy
	writetext .ok_maybe_later
	waitbutton
	closetext
	end

.want_rare_candy
	text "Hey, <PLAYER>!"

	para "Would you like a"
	line "sweet treat?"
	done

.hope_this_helps
	text "I hope that helps"
	line "you on your way."

	para "I've got plenty,"
	line "just ask for more!"
	done

.ok_maybe_later
	text "Ok, maybe later."
	done
