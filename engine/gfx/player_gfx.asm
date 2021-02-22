MovePlayerPicRight:
	hlcoord 6, 4
	ld de, 1
	jr MovePlayerPic

MovePlayerPicLeft:
	hlcoord 13, 4
	ld de, -1
	; fallthrough

MovePlayerPic:
; Move player pic at hl by de * 7 tiles.
	ld c, $8
.loop
	push bc
	push hl
	push de
	xor a
	ldh [hBGMapMode], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ldh [hBGMapThird], a
	call WaitBGMap
	call DelayFrame
	pop de
	pop hl
	add hl, de
	pop bc
	dec c
	ret z
	push hl
	push bc
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	lb bc, 7, 7
	call ClearBox
	pop bc
	pop hl
	jr .loop

ShowPlayerNamingChoices:
	ld hl, ChrisNameMenuHeader
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, .got_header
	ld hl, KrisNameMenuHeader
.got_header
	call LoadMenuHeader
	call VerticalMenu
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	ret

INCLUDE "data/player_names.asm"

GetPlayerNameArray: ; unreferenced
	ld hl, wPlayerName
	ld de, MalePlayerNameArray
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, .got_array
	ld de, FemalePlayerNameArray
.got_array
	call InitName
	ret

GetPlayerIcon:
	ld de, ChrisSpriteGFX
	ld b, BANK(ChrisSpriteGFX)
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, .got_gfx
	ld de, KrisSpriteGFX
	ld b, BANK(KrisSpriteGFX)
.got_gfx
	ret

GetCardPic:
	ld hl, ChrisCardPic
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, .got_pic
	ld hl, KrisCardPic
.got_pic
	ld de, vTiles2 tile $00
	ld bc, $23 tiles
	ld a, BANK(ChrisCardPic) ; aka BANK(KrisCardPic)
	call FarCopyBytes
	ld hl, TrainerCardGFX
	ld de, vTiles2 tile $23
	ld bc, 6 tiles
	ld a, BANK(TrainerCardGFX)
	call FarCopyBytes
	ret

ChrisCardPic:
INCBIN "gfx/trainer_card/chris_card.2bpp"

KrisCardPic:
INCBIN "gfx/trainer_card/kris_card.2bpp"

TrainerCardGFX:
INCBIN "gfx/trainer_card/trainer_card.2bpp"

GetPlayerBackpic:
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, GetChrisBackpic
	jp GetKrisBackpic

GetChrisBackpic:
	ld hl, ChrisBackpic
	ld b, BANK(ChrisBackpic)
	ld de, vTiles2 tile $31
	ld c, 7 * 7
	predef DecompressGet2bpp
	ret

HOF_GetTrainerBackpics:
	ld hl, ChrisBackpic
	ld b, BANK(ChrisBackpic)
	ld de, vTiles2
	ld c, 7 * 7
	predef DecompressGet2bpp

	ld hl, KrisBackpic
	ld b, BANK(KrisBackpic)
	ld de, vTiles2 tile $31
	ld c, 7 * 7
	predef DecompressGet2bpp
	ret

HOF_LoadTrainerFrontpics:
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a

	ld de, ChrisCardPic
	ld b, BANK(ChrisCardPic)
	ld hl, vTiles2
	ld c, 5 * 7
	call Get2bpp
	
	ld de, KrisCardPic
	ld b, BANK(KrisCardPic)
	ld hl, vTiles2 + $23 tiles
	ld c, 5 * 7
	call Get2bpp

	call WaitBGMap
	ld a, $1
	ldh [hBGMapMode], a
	ret
;	call WaitBGMap
;	xor a
;	ldh [hBGMapMode], a
;
;; Get class
;	ld e, CHRIS
;	ld a, [wFollowerFlags]
;	bit FOLLOWER_SWAPPED_F, a
;	jr z, .got_class
;	ld e, KRIS
;.got_class
;	ld a, e
;	ld [wTrainerClass], a
;
;; Load pic
;	ld de, ChrisPic
;	ld a, [wFollowerFlags]
;	bit FOLLOWER_SWAPPED_F, a
;	jr z, .got_pic
;	ld de, KrisPic
;.got_pic
;	ld hl, vTiles2
;	ld b, BANK(ChrisPic) ; aka BANK(KrisPic)
;	ld c, 7 * 7
;	call Get2bpp
;
;	call WaitBGMap
;	ld a, $1
;	ldh [hBGMapMode], a
;	ret

DrawIntroPlayerPic:
;; Draw the player pic at (6,4).
;
;; Get class
;	ld e, CHRIS
;	ld a, [wFollowerFlags]
;	bit FOLLOWER_SWAPPED_F, a
;	jr z, .got_class
;	ld e, KRIS
;.got_class
;	ld a, e
;	ld [wTrainerClass], a
;
;; Load pic
;	ld de, ChrisPic
;	ld a, [wFollowerFlags]
;	bit FOLLOWER_SWAPPED_F, a
;	jr z, .got_pic
;	ld de, KrisPic
;.got_pic
;	ld hl, vTiles2
;	ld b, BANK(ChrisPic) ; aka BANK(KrisPic)
;	ld c, 7 * 7 ; dimensions
;	call Get2bpp

; Get Red pic
	ld a, CHRIS
	ld [wTrainerClass], a
	ld de, ChrisPic
	ld hl, vTiles2
	ld b, BANK(ChrisPic)
	ld c, 7 * 7
	call Get2bpp
; Get Leaf pic
	ld a, KRIS
	ld [wTrainerClass], a
	ld de, KrisPic
	ld hl, vTiles2 + 49 tiles
	ld b, BANK(KrisPic)
	ld c, 7 * 7
	call Get2bpp

; Draw Red
	xor a
	ldh [hGraphicStartTile], a
	hlcoord 3, 4
	lb bc, 7, 7
	predef PlaceGraphic
; Draw Leaf
	ld a, 7 * 7
	ldh [hGraphicStartTile], a
	hlcoord 10, 4
	lb bc, 7, 7
	predef PlaceGraphic
	ret

ChrisPic:
INCBIN "gfx/player/chris.2bpp"

KrisPic:
INCBIN "gfx/player/kris.2bpp"

GetKrisBackpic:
	ld hl, KrisBackpic
	ld b, BANK(KrisBackpic)
	ld de, vTiles2 tile $31
	ld c, 7 * 7
	predef DecompressGet2bpp
	ret

KrisBackpic:
INCBIN "gfx/player/kris_back.2bpp.lz"
