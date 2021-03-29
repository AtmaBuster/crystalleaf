CheckGSBallPhoneCall:
; if a special call is queued, don't overwrite it
	ld a, [wSpecialPhoneCallID]
	and a
	ret nz
; if already got call, don't get it again
	ld de, EVENT_GOT_GS_BALL_PHONE_CALL
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	ret nz
; don't get the call unless Mt. Silver is unlocked
	ld de, EVENT_OPENED_MT_SILVER
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	ret z
; check if caught all other legendaries (other than Mew)
	ld hl, .LegendaryList
.dex_loop
	ld a, [hli]
	cp -1
	jr z, .done
	push hl
	call CheckCaughtMon
	pop hl
	ret z
	jr .dex_loop
.done
; get phone call and set flag
	ld a, SPECIALCALL_GSBALL
	ld [wSpecialPhoneCallID], a
	xor a
	ld [wSpecialPhoneCallID + 1], a
	ld de, EVENT_GOT_GS_BALL_PHONE_CALL
	ld b, SET_FLAG
	call EventFlagAction
	ret

.LegendaryList
	db ARTICUNO - 1
	db ZAPDOS   - 1
	db MOLTRES  - 1
	db MEWTWO   - 1
	db RAIKOU   - 1
	db ENTEI    - 1
	db SUICUNE  - 1
	db HO_OH    - 1
	db LUGIA    - 1
	db -1
