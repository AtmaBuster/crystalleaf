_Diploma:
	call PlaceDiplomaOnScreen
	call WaitPressAorB_BlinkCursor
	call PlaceDiplomaPageExtra
	call WaitPressAorB_BlinkCursor
	ret

PlaceDiplomaOnScreen:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, vTiles2
	call Decompress
	ld hl, DiplomaPage1Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .Player
	hlcoord 2, 5
	call PlaceString
	ld de, .EmptyString
	hlcoord 15, 5
	call PlaceString
	ld de, wPlayerName
	hlcoord 9, 5
	call PlaceString
	ld de, .Certification
	hlcoord 2, 8
	call PlaceString
	call EnableLCD
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	ret

.Player:
	db "PLAYER@"

.EmptyString:
	db "@"

.Certification:
	db   "This certifies"
	next "that you have"
	next "completed the"
	next "new #DEX."
	next "Congratulations!"
	db   "@"

PrintDiplomaPage2:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	call ByteFill
	ld hl, DiplomaPage2Tilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	ld de, .GameFreak
	hlcoord 8, 0
	call PlaceString
	ld de, .PlayTime
	hlcoord 3, 15
	call PlaceString
	hlcoord 12, 15
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	ld [hl], $67 ; colon
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ret

.PlayTime: db "PLAY TIME@"
.GameFreak: db "GAME FREAK@"

PUSHS
SECTION "Miki GFX", ROMX
DiplomaExtGFX:
INCBIN "gfx/diploma/redleaf.2bpp"
DiplomaExtGFX_End:
POPS
DIPLOMA_EXT_TILE_CT EQU (DiplomaExtGFX_End - DiplomaExtGFX) / 16

PlaceDiplomaPageExtra:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD

if DIPLOMA_EXT_TILE_CT < $80
	ld de, DiplomaExtGFX
	ld b, BANK(DiplomaExtGFX)
	ld hl, vTiles2
	ld c, DIPLOMA_EXT_TILE_CT
	call Get2bpp
else
	ld de, DiplomaExtGFX
	ld b, BANK(DiplomaExtGFX)
	ld hl, vTiles2
	ld c, $80
	call Get2bpp
if DIPLOMA_EXT_TILE_CT < $100
	ld de, DiplomaExtGFX + $80 tiles
	ld b, BANK(DiplomaExtGFX)
	ld hl, vTiles1
	ld c, DIPLOMA_EXT_TILE_CT - $80
	call Get2bpp
else
	ld de, DiplomaExtGFX + $80 tiles
	ld b, BANK(DiplomaExtGFX)
	ld hl, vTiles1
	ld c, $80
	call Get2bpp

	ldh a, [rVBK]
	push af
	ld a, BANK(vTiles5)
	ldh [rVBK], a
	ld de, DiplomaExtGFX + $100 tiles
	ld b, BANK(DiplomaExtGFX)
	ld hl, vTiles5
	ld c, DIPLOMA_EXT_TILE_CT - $100
	call Get2bpp
	pop af
	ldh [rVBK], a
endc
endc

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld de, MikiTilemap
.loop1
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop1

	ld hl, wAttrmap
	ld de, MikiAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop2
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop2

	call EnableLCD
	call WaitBGMap2
	call WaitBGMap
	ld b, SCGB_DIPLOMA_EXTRA
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	ret

DiplomaGFX:
INCBIN "gfx/diploma/diploma.2bpp.lz"

DiplomaPage1Tilemap:
INCBIN "gfx/diploma/page1.tilemap"

DiplomaPage2Tilemap:
INCBIN "gfx/diploma/page2.tilemap"

Diploma_DummyFunction: ; unreferenced
	ret

MikiTilemap:
INCBIN "gfx/diploma/redleaf.tilemap"
MikiAttrmap:
INCBIN "gfx/diploma/redleaf.attrmap"
