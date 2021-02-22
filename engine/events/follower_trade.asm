;safeswapteam: MACRO
;if BANK(FollowerTrade) == BANK(FollowerSwapTeam)
;	call FollowerSwapTeam
;else
;	farcall FollowerSwapTeam
;endm
safeswapteam EQUS "call FollowerSwapTeam"

FollowerTrade::
; select player party mon
	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	jr c, .cancel
	ld a, [wCurPartyMon]
	ldh [hPlayerTrademonSlot], a

; select follower party mon
	safeswapteam
	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	jr c, .cancel2
	ld a, [wCurPartyMon]
	ldh [hFollowerTrademonSlot], a

; copy follower mon to buffer 2
	ld a, %011
	call CopyPartyTrademon

; copy player mon to buffer 1
	safeswapteam
	ld a, %000
	call CopyPartyTrademon

; copy buffer 2 (follower mon) to player party
	ld a, %101
	call CopyPartyTrademon

; copy buffer 1 (party mon) to follower party
	safeswapteam
	ld a, %110
	call CopyPartyTrademon

; update follower party species
	ldh a, [hFollowerTrademonSlot]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, [hl]
	ld hl, wPartySpecies
	ldh a, [hFollowerTrademonSlot]
	ld c, a
	ld b, 0
	add hl, bc
	ld [hl], d

; swap teams back
	safeswapteam

; update player party species
	ldh a, [hPlayerTrademonSlot]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, [hl]
	ld hl, wPartySpecies
	ldh a, [hPlayerTrademonSlot]
	ld c, a
	ld b, 0
	add hl, bc
	ld [hl], d

	call .CopyBufferDataToTrademons

	call .TradeAnimation

	call RestartMapMusic

	call FollowerTradeCheckAndDoEvo
	ret

.cancel2
	safeswapteam
.cancel
	ld a, FALSE
	ld [wScriptVar], a
	ret

.TradeAnimation:
	call DisableSpriteUpdates
	ld a, [wJumptableIndex]
	push af
	predef TradeAnimation
	pop af
	ld [wJumptableIndex], a
	call ReturnToMapWithSpeechTextbox
	ret

.CopyBufferDataToTrademons:
	ld a, [wPlayerFTrademonSpecies]
	ld [wPlayerTrademonSpecies], a
	ld de, wPlayerTrademonSpeciesName
	call .get_trademon_name
	ld a, [wFollowerTrademonSpecies]
	ld [wOTTrademonSpecies], a
	ld de, wOTTrademonSpeciesName
	call .get_trademon_name
	ld hl, wPlayerFTrademonOT
	ld de, wPlayerTrademonOTName
	call .copy_trade_name
	ld hl, wFollowerTrademonOT
	ld de, wOTTrademonOTName
	call .copy_trade_name
	ld hl, wPlayerFTrademonID
	ld de, wPlayerTrademonID
	call .copy_two_bytes
	ld hl, wFollowerTrademonID
	ld de, wOTTrademonID
	call .copy_two_bytes
	ld hl, wPlayerFTrademonDVs
	ld de, wPlayerTrademonDVs
	call .copy_two_bytes
	ld hl, wFollowerTrademonDVs
	ld de, wOTTrademonDVs
	call .copy_two_bytes
	ld a, CAUGHT_BY_UNKNOWN
	ld [wPlayerTrademonCaughtData], a
	ld [wOTTrademonCaughtData], a
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	ld hl, .red_name
	ld de, .leaf_name
	jr z, .got_names
	ld hl, .leaf_name
	ld de, .red_name
.got_names
	push de
	ld de, wPlayerTrademonSenderName
	call .copy_trade_name
	pop hl
	ld de, wOTTrademonSenderName
	call .copy_trade_name
	ret

.red_name
	db "RED@"

.leaf_name
	db "LEAF@"

.get_trademon_name
	push de
	ld [wNamedObjectIndex], a
	call GetBasePokemonName
	ld hl, wStringBuffer1
	pop de
.copy_trade_name
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

.copy_two_bytes
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

CopyPartyTrademon:
; a: bit 0 set -> buffer 2, else buffer 1
;    bit 1 set -> follower party, else player party
;    bit 2 set -> buffer to party, else party to buffer
	bit 2, a
	jr nz, .BufferToParty

.PartyToBuffer:
	ld de, .addr_buffer1
	bit 0, a
	jr z, .got_addr_p2b
	ld de, .addr_buffer2
.got_addr_p2b
	ld hl, .addr_party
	bit 1, a
	ldh a, [hPlayerTrademonSlot]
	jr z, .got_slot_p2b
	ldh a, [hFollowerTrademonSlot]
.got_slot_p2b
	call .CopyData
	ret

.BufferToParty:
	ld hl, .addr_buffer1
	bit 0, a
	jr z, .got_addr_b2p
	ld hl, .addr_buffer2
.got_addr_b2p
	ld de, .addr_party
	bit 1, a
	ldh a, [hPlayerTrademonSlot]
	jr z, .got_slot_b2p
	ldh a, [hFollowerTrademonSlot]
.got_slot_b2p
	call .CopyData
	ret

.CopyData:
	ldh [hFollowerTradeSlotBuffer], a
	push hl
	push de
	call .get_pointers
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	pop de
	pop hl
rept 4
	inc hl
	inc de
endr
	push hl
	push de
	call .get_pointers
	ld bc, NAME_LENGTH
	call CopyBytes
	pop de
	pop hl
rept 4
	inc hl
	inc de
endr
	call .get_pointers
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ret

.get_pointers
	ldh a, [hFollowerTradeSlotBuffer]
	push af
	call .get_1_pointer
	pop af
	push hl
	ld h, d
	ld l, e
	call .get_1_pointer
	ld d, h
	ld e, l
	pop hl
	ret

.get_1_pointer
	push af
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call AddNTimes
	ret

	; length                    location
.addr_party
	; party
	dw PARTYMON_STRUCT_LENGTH, wPartyMons
	dw NAME_LENGTH,            wPartyMonOT
	dw MON_NAME_LENGTH,        wPartyMonNicknames
.addr_buffer1
	; buffer 1
	dw 0,                      wPlayerFTrademonData
	dw 0,                      wPlayerFTrademonOT
	dw 0,                      wPlayerFTrademonNick
.addr_buffer2
	; buffer 2
	dw 0,                      wFollowerTrademonData
	dw 0,                      wFollowerTrademonOT
	dw 0,                      wFollowerTrademonNick

FollowerTradeCheckAndDoEvo:
	ld a, 1
	ldh [hFollowerTradeMode], a
	ldh a, [hPlayerTrademonSlot]
	ld [wCurPartyMon], a
	farcall EvolvePokemon
	call ReturnToMapWithSpeechTextbox
	safeswapteam
	ldh a, [hFollowerTrademonSlot]
	ld [wCurPartyMon], a
	farcall EvolvePokemon
	call ReturnToMapWithSpeechTextbox
	safeswapteam
	xor a
	ldh [hFollowerTradeMode], a
	ret
