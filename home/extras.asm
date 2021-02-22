_FollowerSwapTeam::
	push af
	push bc
	push de
	push hl
	farcall FollowerSwapTeam
	pop hl
	pop de
	pop bc
	pop af
	ret
