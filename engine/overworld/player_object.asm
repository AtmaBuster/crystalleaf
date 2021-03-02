BlankScreen:
	call DisableSpriteUpdates
	xor a
	ldh [hBGMapMode], a
	call ClearBGPalettes
	call ClearSprites
	hlcoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, wAttrmapEnd - wAttrmap
	ld a, $7
	call ByteFill
	call WaitBGMap2
	call SetPalettes
	ret

SpawnPlayer:
	ld a, -1
	ld [wObjectFollow_Leader], a
	ld [wObjectFollow_Follower], a
	ld a, PLAYER
	ld hl, PlayerObjectTemplate
	call CopyPlayerObjectTemplate

	call CheckFollowerLoaded
	jr c, .skip_follower
	ld hl, FollowObjTemplateLeaf
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, .got_follower_template
	ld hl, FollowObjTemplateRed
.got_follower_template
	ld a, FOLLOWER
	call CopyPlayerObjectTemplate
	ld b, FOLLOWER
	call PlayerSpawn_ConvertCoords
	xor a
	ld [wFollowerNextMovement], a

.skip_follower
	ld b, PLAYER_OBJECT
	call PlayerSpawn_ConvertCoords
	ld a, PLAYER_OBJECT
	call GetMapObject
	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ln e, PAL_NPC_RED, OBJECTTYPE_SCRIPT
	ln d, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT
	ld a, [wFollowerFlags]
	bit FOLLOWER_SWAPPED_F, a
	jr z, .ok
	ln e, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT
	ln d, PAL_NPC_RED, OBJECTTYPE_SCRIPT

.ok
	ld [hl], e
	ld hl, MAPOBJECT_COLOR + MAPOBJECT_LENGTH
	add hl, bc
	ld [hl], d
	ld a, PLAYER_OBJECT
	ldh [hMapObjectIndex], a
	ld bc, wMapObjects
	ld a, PLAYER_OBJECT
	ldh [hObjectStructIndex], a
	ld de, wObjectStructs
	call CopyMapObjectToObjectStruct
	ld a, PLAYER
	ld [wCenteredObject], a
	ret

PlayerObjectTemplate:
; A dummy map object used to initialize the player object.
; Shorter than the actual amount copied by two bytes.
; Said bytes seem to be unused.
_NUM_OBJECT_EVENTS = 0
	object_event -4, -4, SPRITE_CHRIS, SPRITEMOVEDATA_PLAYER, 15, 15, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, 0, -1

FollowObjTemplateLeaf:
	object_event -4, -4, SPRITE_KRIS, SPRITEMOVEDATA_FOLLOWEROBJ, 15, 15, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, _FollowerScript, -1

FollowObjTemplateRed:
_NUM_OBJECT_EVENTS = 1
	object_event -4, -4, SPRITE_CHRIS, SPRITEMOVEDATA_FOLLOWEROBJ, 15, 15, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, _FollowerScript, -1

PUSHS
SECTION "Follower Script Home", ROM0
_FollowerScript:
	farjump FollowerScript
POPS

CheckFollowerLoaded:
	xor a
	ret
	ld hl, wObjectStructs + 1
	ld bc, MAPOBJECT_LENGTH
	ld d, NUM_OBJECT_STRUCTS
.loop
	ld a, [hl]
	add hl, bc
	cp FOLLOWER
	jr z, .loaded
	dec d
	jr nz, .loop
	xor a
	ret

.loaded
	scf
	ret

CopyDECoordsToMapObject::
	push de
	ld a, b
	call GetMapObject
	pop de
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld [hl], d
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld [hl], e
	ret

PlayerSpawn_ConvertCoords:
	push bc
	ld a, [wXCoord]
	add 4
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	pop bc
	call CopyDECoordsToMapObject
	ret

WriteObjectXY::
	ld a, b
	call CheckObjectVisibility
	ret c

	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ldh a, [hMapObjectIndex]
	ld b, a
	call CopyDECoordsToMapObject
	and a
	ret

RefreshPlayerCoords:
	call _RefreshPlayerCoords
	ret

MapPlayerCoordWarped:
	call _RefreshPlayerCoords
	ld b, PLAYER
	ld c, FOLLOWER
	call MoveToObject
;	call UpdateFollowerPositionAfterWarp
	call MatchFollowerDirection
	ret

MapPlayerCoordConnected:
	call _RefreshPlayerCoords
	ld b, PLAYER
	ld c, FOLLOWER
	call MoveToObject
	ld b, FOLLOWER
	call GetObjectCoord

	ld a, [wPlayerStepDirection]
	and a
	jr z, .south
	dec a
	jr z, .north
	dec a
	jr z, .west
	dec a
	jr z, .east
	jr .none

.south
	dec c
	jr .ok
.north
	inc c
	jr .ok
.west
	inc b
	jr .ok
.east
	dec b
.ok
	ld a, FOLLOWER
	call MoveToCoord
	call MatchFollowerDirection
.none
	call RefreshFollowingCoords
	ret

MatchFollowerDirection:
	ld a, FOLLOWER
	call GetObjectStruct
	push bc
	ld a, PLAYER
	call GetObjectStruct
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	pop bc
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret

UpdateFollowerPositionAfterWarp:
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a
	push de
	call GetCoordTile
	pop de
	cp COLL_WARP_CARPET_UP
	jr z, .up_down
	cp COLL_WARP_CARPET_DOWN
	jr z, .up_down
	cp COLL_WARP_CARPET_LEFT
	jr z, .left_right
	cp COLL_WARP_CARPET_RIGHT
	ret nz
.left_right
	inc e
	push de
	push af
	dec e
	dec e
	jr .check

.up_down
	inc d
	push de
	push af
	dec d
	dec d
.check
	push de
	call GetCoordTile
	pop de
	ld b, a
	pop af
	cp b
	jr z, .move_follower_1
	pop de
	push af
	push de
	call GetCoordTile
	pop de
	ld b, a
	pop af
	cp b
	jr z, .move_follower
	ret

.move_follower_1
	pop bc
.move_follower
	ld a, FOLLOWER
	call GetMapObject
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld [hl], d
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld [hl], e
	ret

_RefreshPlayerCoords:
	ld a, [wXCoord]
	add 4
	ld d, a
	ld hl, wPlayerStandingMapX
	sub [hl]
	ld [hl], d
	ld hl, wMapObjects + MAPOBJECT_X_COORD
	ld [hl], d
	ld hl, wPlayerLastMapX
	ld [hl], d
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	ld hl, wPlayerStandingMapY
	sub [hl]
	ld [hl], e
	ld hl, wMapObjects + MAPOBJECT_Y_COORD
	ld [hl], e
	ld hl, wPlayerLastMapY
	ld [hl], e
	ld e, a
; the next three lines are useless
	ld a, [wObjectFollow_Leader]
	cp PLAYER
	ret nz
	ret

RefreshFollowingCoords::
	ld b, PLAYER
	ld c, FOLLOWER
	call FollowNotExact
	ret c
	ld a, FOLLOWER
	call GetObjectStruct
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, de
	ld [hl], SPRITEMOVEDATA_FOLLOWEROBJ
	ret

CopyObjectStruct::
	call CheckObjectMask
	and a
	ret nz ; masked

; if follower object, force into wObject1Struct
	ldh a, [hMapObjectIndex]
	cp FOLLOWER
	jr z, .follower

	ld hl, wObjectStructs + OBJECT_LENGTH * 2
	ld a, 2
	ld de, OBJECT_LENGTH
.loop
	ldh [hObjectStructIndex], a
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	scf
	ret ; overflow

.follower
	ld hl, wObject1Struct
	ld a, FOLLOWER
	ldh [hObjectStructIndex], a

.done
	ld d, h
	ld e, l
	call CopyMapObjectToObjectStruct
	ld hl, wVramState
	bit 7, [hl]
	ret z

	ld hl, OBJECT_FLAGS2
	add hl, de
	set 5, [hl]
	ret

CopyMapObjectToObjectStruct:
	call .CopyMapObjectToTempObject
	call CopyTempObjectToObjectStruct
	ret

.CopyMapObjectToTempObject:
	ldh a, [hObjectStructIndex]
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld [hl], a

	ldh a, [hMapObjectIndex]
	ld [wTempObjectCopyMapObjectIndex], a

	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	ld [wTempObjectCopySprite], a

	call GetSpriteVTile
	ld [wTempObjectCopySpriteVTile], a

	ld a, [hl]
	call GetSpritePalette
	ld [wTempObjectCopyPalette], a

	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and $f0
	jr z, .skip_color_override
	swap a
	and PALETTE_MASK
	ld [wTempObjectCopyPalette], a

.skip_color_override
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	ld [wTempObjectCopyMovement], a

	ld hl, MAPOBJECT_RANGE
	add hl, bc
	ld a, [hl]
	ld [wTempObjectCopyRange], a

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	ld [wTempObjectCopyX], a

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	ld [wTempObjectCopyY], a

	ld hl, MAPOBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	ld [wTempObjectCopyRadius], a
	ret

InitializeVisibleSprites:
	ld bc, wMap1Object
	ld a, 1
.loop
	ldh [hMapObjectIndex], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next

	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub d
	jr c, .next

	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next

	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next

	push bc
	call CopyObjectStruct
	pop bc
	jp c, .ret

.next
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.ret
	ret

CheckObjectEnteringVisibleRange::
	nop
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	ld hl, .dw
	rst JumpTable
	ret

.dw
	dw .Down
	dw .Up
	dw .Left
	dw .Right

.Up:
	ld a, [wYCoord]
	sub 1
	jr .Vertical

.Down:
	ld a, [wYCoord]
	add 9
.Vertical:
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld bc, wMap1Object
	ld a, 1
.loop_v
	ldh [hMapObjectIndex], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_v
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, d
	cp [hl]
	jr nz, .next_v
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_v
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next_v
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next_v
	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de

.next_v
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_v
	ret

.Left:
	ld a, [wXCoord]
	sub 1
	jr .Horizontal

.Right:
	ld a, [wXCoord]
	add 10
.Horizontal:
	ld e, a
	ld a, [wYCoord]
	ld d, a
	ld bc, wMap1Object
	ld a, 1
.loop_h
	ldh [hMapObjectIndex], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_h
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, e
	cp [hl]
	jr nz, .next_h
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_h
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub d
	jr c, .next_h
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next_h
	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de

.next_h
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_h
	ret

CopyTempObjectToObjectStruct:
	ld a, [wTempObjectCopyMapObjectIndex]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld [hl], a

	ld a, [wTempObjectCopyMovement]
	call CopySpriteMovementData

	ld a, [wTempObjectCopyPalette]
	ld hl, OBJECT_PALETTE
	add hl, de
	or [hl]
	ld [hl], a

	ld a, [wTempObjectCopyY]
	call .InitYCoord

	ld a, [wTempObjectCopyX]
	call .InitXCoord

	ld a, [wTempObjectCopySprite]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld [hl], a

	ld a, [wTempObjectCopySpriteVTile]
	ld hl, OBJECT_SPRITE_TILE
	add hl, de
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, de
	ld [hl], STEP_TYPE_RESET

	ld hl, OBJECT_FACING_STEP
	add hl, de
	ld [hl], STANDING

	ld a, [wTempObjectCopyRadius]
	call .InitRadius

	ld a, [wTempObjectCopyRange]
	ld hl, OBJECT_RANGE
	add hl, de
	ld [hl], a

	and a
	ret

.InitYCoord:
	ld hl, OBJECT_INIT_Y
	add hl, de
	ld [hl], a

	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld [hl], a

	ld hl, wYCoord
	sub [hl]
	and $f
	swap a
	ld hl, wPlayerBGMapOffsetY
	sub [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld [hl], a
	ret

.InitXCoord:
	ld hl, OBJECT_INIT_X
	add hl, de
	ld [hl], a
	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld [hl], a
	ld hl, wXCoord
	sub [hl]
	and $f
	swap a
	ld hl, wPlayerBGMapOffsetX
	sub [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld [hl], a
	ret

.InitRadius:
	ld h, a
	inc a
	and $f
	ld l, a
	ld a, h
	add $10
	and $f0
	or l
	ld hl, OBJECT_RADIUS
	add hl, de
	ld [hl], a
	ret

TrainerWalkToPlayer:
	ldh a, [hLastTalked]
	call InitMovementBuffer
	ld a, movement_step_sleep
	call AppendToMovementBuffer
	ld a, [wWalkingIntoNPC]
	dec a
	jr z, .TerminateStep
	ldh a, [hLastTalked]
	ld b, a
	ld c, PLAYER
	ld d, 1
	call .GetPathToPlayer
	call DecrementMovementBufferCount

.TerminateStep:
	ld a, movement_step_end
	call AppendToMovementBuffer
	ret

.GetPathToPlayer:
	push de
	push bc
; get player object struct, load to de
	ld a, c
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld d, b
	ld e, c

; get last talked object struct, load to bc
	pop bc
	ld a, b
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	call GetObjectStruct

; get last talked coords, load to bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld c, [hl]
	ld b, a

; get player coords, load to de
	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld e, [hl]
	ld d, a

	pop af
	call ComputePathToWalkToPlayer
	ret

SurfStartStep:
	call InitMovementBuffer
	call .GetMovementData
	call AppendToMovementBuffer
	ld a, movement_step_end
	call AppendToMovementBuffer
	ret

.GetMovementData:
	ld a, [wPlayerDirection]
	srl a
	srl a
	maskbits NUM_DIRECTIONS
	ld e, a
	ld d, 0
	ld hl, .movement_data
	add hl, de
	ld a, [hl]
	ret

.movement_data
	slow_step DOWN
	slow_step UP
	slow_step LEFT
	slow_step RIGHT

MoveToObject:
	push bc
	ld a, c
	call GetMapObject
	ld d, b
	ld e, c
	pop bc
	ld a, b
	call GetMapObject
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	ld hl, MAPOBJECT_X_COORD
	add hl, de
	ld [hl], a
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	ld hl, MAPOBJECT_Y_COORD
	add hl, de
	ld [hl], a
	ret

GetObjectCoord:
	ld a, b
	call GetMapObject
	ld d, b
	ld e, c
	ld hl, MAPOBJECT_X_COORD
	add hl, de
	ld b, [hl]
	ld hl, MAPOBJECT_Y_COORD
	add hl, de
	ld c, [hl]
	ret

MoveToCoord:
	push bc
	call GetMapObject
	ld d, b
	ld e, c
	pop bc
	ld hl, MAPOBJECT_X_COORD
	add hl, de
	ld [hl], b
	ld hl, MAPOBJECT_Y_COORD
	add hl, de
	ld [hl], c
	ret

FollowNotExact::
	push bc
	ld a, c
	call CheckObjectVisibility
	ld d, b
	ld e, c
	pop bc
	ret c

	ld a, b
	call CheckObjectVisibility
	ret c

; object 2 is now in bc, object 1 is now in de
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld c, [hl]
	ld b, a

	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld a, [hl]
	cp b
	jr z, .same_x
	jr c, .to_the_left
	inc b
	jr .continue

.to_the_left
	dec b
	jr .continue

.same_x
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld a, [hl]
	cp c
	jr z, .continue
	jr c, .below
	inc c
	jr .continue

.below
	dec c

.continue
	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld [hl], b
	ld a, b
	ld hl, wXCoord
	sub [hl]
	and $f
	swap a
	ld hl, wPlayerBGMapOffsetX
	sub [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld [hl], a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld [hl], c
	ld a, c
	ld hl, wYCoord
	sub [hl]
	and $f
	swap a
	ld hl, wPlayerBGMapOffsetY
	sub [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld [hl], a
	ldh a, [hObjectStructIndex]
	ld hl, OBJECT_RANGE
	add hl, de
	ld [hl], a
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, de
	ld [hl], SPRITEMOVEDATA_FOLLOWNOTEXACT
	ld hl, OBJECT_STEP_TYPE
	add hl, de
	ld [hl], STEP_TYPE_RESET
	ret

GetRelativeFacing::
; Determines which way map object e would have to turn to face map object d.  Returns carry if it's impossible for whatever reason.
	ld a, d
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp NUM_OBJECT_STRUCTS
	jr nc, .carry
	ld d, a
	ld a, e
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp NUM_OBJECT_STRUCTS
	jr nc, .carry
	ld e, a
	call .GetFacing_e_relativeto_d
	ret

.carry
	scf
	ret

.GetFacing_e_relativeto_d:
; Determines which way object e would have to turn to face object d.  Returns carry if it's impossible.
; load the coordinates of object d into bc
	ld a, d
	call GetObjectStruct
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld c, [hl]
	ld b, a
	push bc
; load the coordinates of object e into de
	ld a, e
	call GetObjectStruct
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	pop bc
; |x1 - x2|
	ld a, b
	sub d
	jr z, .same_x_1
	jr nc, .b_right_of_d_1
	cpl
	inc a

.b_right_of_d_1
; |y1 - y2|
	ld h, a
	ld a, c
	sub e
	jr z, .same_y_1
	jr nc, .c_below_e_1
	cpl
	inc a

.c_below_e_1
; |y1 - y2| - |x1 - x2|
	sub h
	jr c, .same_y_1

.same_x_1
; compare the y coordinates
	ld a, c
	cp e
	jr z, .same_x_and_y
	jr c, .c_directly_below_e
; c directly above e
	ld d, DOWN
	and a
	ret

.c_directly_below_e
	ld d, UP
	and a
	ret

.same_y_1
	ld a, b
	cp d
	jr z, .same_x_and_y
	jr c, .b_directly_right_of_d
; b directly left of d
	ld d, RIGHT
	and a
	ret

.b_directly_right_of_d
	ld d, LEFT
	and a
	ret

.same_x_and_y
	scf
	ret

QueueFollowerFirstStep:
	call .QueueFirstStep
	jr c, .same
	ld [wFollowMovementQueue], a
	xor a
	ld [wFollowerMovementQueueLength], a
	ret

.same
	ld a, -1
	ld [wFollowerMovementQueueLength], a
	ret

.QueueFirstStep:
	ld a, [wObjectFollow_Leader]
	call GetObjectStruct
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld a, [wObjectFollow_Follower]
	call GetObjectStruct
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, d
	cp [hl]
	jr z, .check_y
	jr c, .left
	and a
	ld a, movement_step + RIGHT
	ret

.left
	and a
	ld a, movement_step + LEFT
	ret

.check_y
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, e
	cp [hl]
	jr z, .same_xy
	jr c, .up
	and a
	ld a, movement_step + DOWN
	ret

.up
	and a
	ld a, movement_step + UP
	ret

.same_xy
	scf
	ret
