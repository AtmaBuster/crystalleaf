FollowerChatRed:
	getcurlandmark
	ifequal LANDMARK_SILVER_CAVE, .SilverCave
	farjumptext FollowerChatText_Red_Generic

.SilverCave:
	farjumptext FollowerChatText_Red_SilverCave

FollowerChatLeaf:
; if rockets in radio tower
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .RocketsInRadioTower
	getregion
	ifnotequal KANTO_REGION, .CheckLandmark
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .CheckLandmark
	checkflag ENGINE_EXPN_CARD
	iffalse .ExpnCardHint
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iffalse .MagnetTrainPassHint
.CheckLandmark
	random 4
	iffalse .GetGenericText
	getcurlandmark
	ifequal LANDMARK_NEW_BARK_TOWN, .NewBarkTownComment
	ifequal LANDMARK_CHERRYGROVE_CITY, .CherrygroveCheck
	ifequal LANDMARK_VIOLET_CITY, .VioletCheck
	ifequal LANDMARK_UNION_CAVE, .UnionCaveCheck
	ifequal LANDMARK_AZALEA_TOWN, .AzaleaCheck
	ifequal LANDMARK_ILEX_FOREST, .IlexForestCheck
	ifequal LANDMARK_GOLDENROD_CITY, .GoldenrodCheck
	ifequal LANDMARK_NATIONAL_PARK, .NationalParkCheck
	ifequal LANDMARK_ECRUTEAK_CITY, .EcruteakCheck
	ifequal LANDMARK_ROUTE_39, .Route39Check
	ifequal LANDMARK_OLIVINE_CITY, .OlivineCheck
	ifequal LANDMARK_BATTLE_TOWER, .BattleTowerComment
	ifequal LANDMARK_CIANWOOD_CITY, .CianwoodCheck
	ifequal LANDMARK_MAHOGANY_TOWN, .MahoganyCheck
	ifequal LANDMARK_LAKE_OF_RAGE, .LakeOfRageCheck
	ifequal LANDMARK_BLACKTHORN_CITY, .BlackthornCheck
	ifequal LANDMARK_RUINS_OF_ALPH, .RuinsOfAlphCheck
	ifequal LANDMARK_TOHJO_FALLS, .TohjoFallsCheck
	ifequal LANDMARK_VICTORY_ROAD, .VictoryRoadCheck
	ifequal LANDMARK_INDIGO_PLATEAU, .IndigoPlateauCheck
	ifequal LANDMARK_PALLET_TOWN, .PalletTownComment
	ifequal LANDMARK_VERMILION_CITY, .VermilionCheck
	ifequal LANDMARK_SILVER_CAVE, .SilverCaveComment
	sjump .GetGenericText

.CherrygroveCheck:
	checkflag ENGINE_MAP_CARD
	iffalse .CherrygroveGuideGentHint
	checkevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	iffalse .CherrygroveMysticWaterHint
	sjump .GetGenericText

.VioletCheck:
	checkevent EVENT_GOT_HM05_FLASH
	iffalse .VioletSproutTowerHint
	checkevent EVENT_ELMS_AIDE_IN_VIOLET_POKEMON_CENTER
	iftrue .VioletEggHint
	checkflag ENGINE_ZEPHYRBADGE
	iffalse .VioletGymHint
	sjump .GetGenericText

.UnionCaveCheck:
	checkflag ENGINE_FOGBADGE
	iffalse .GetGenericText
	checkevent EVENT_GOT_HM03_SURF
	iffalse .GetGenericText
	sjump .UnionCaveLaprasHint

.AzaleaCheck:
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .AzaleaSlowpokeComment
	sjump .AzaleaRocketComment

.IlexForestCheck:
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue .IlexForestCelebiComment
	sjump .IlexForestGenericComment

.GoldenrodCheck:
	checkflag ENGINE_PLAINBADGE
	iffalse .GoldenrodCheck2
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iffalse .GoldenrodSquirtBottleHint
.GoldenrodCheck2:
	checkevent EVENT_GOT_BICYCLE
	iffalse .GoldenrodBikeHint
	sjump .GetGenericText

.NationalParkCheck:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugCatchingContestComment
	sjump .NationalParkComment

.EcruteakCheck:
	checkevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	iffalse .EcruteakCheck2
	checkevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	iffalse .EcruteakCheck2
	checkevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	iffalse .EcruteakCheck2
	checkevent EVENT_GOT_CLEAR_BELL
	iffalse .EcruteakCheck2
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse .EcruteakTinTowerHint
.EcruteakCheck2:
	checkflag ENGINE_FOGBADGE
	iffalse .EcruteakCheck3
	checkevent EVENT_GOT_HM03_SURF
	iffalse .EcruteakSurfHint
	sjump .GetGenericText

.EcruteakCheck3
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue .EcruteakGymHint
	sjump .EcruteakBurnedTowerHint

.Route39Check:
	checkevent EVENT_HEALED_MOOMOO
	iftrue .Route39MilkComment
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .Route39MoomooHint
	sjump .GetGenericText

.OlivineCheck:
	checkevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
	iftrue .OlivineCheck2
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue .OlivineShipHint
.OlivineCheck2:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue .GetGenericText
	checkevent EVENT_GOT_SECRETPOTION_FROM_PHARMACY
	iftrue .OlivineAmphyHint
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue .OlivineMedicineHint
	sjump .OlivineLighthouseHint

.CianwoodCheck:
	checkflag ENGINE_STORMBADGE
	iffalse .CianwoodCheck2
	checkevent EVENT_GOT_HM02_FLY
	iffalse .CianwoodFlyHint
.CianwoodCheck2:
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue .CianwoodMedicineHint
	checkevent EVENT_BEAT_BLACKBELT_NOB
	iffalse .GetGenericText
	checkevent EVENT_GOT_HM04_STRENGTH
	iffalse .CianwoodStrengthHint
	sjump .GetGenericText

.MahoganyCheck:
	checkflag ENGINE_ROCKETS_IN_MAHOGANY
	iftrue .MahoganyCheck2
	checkflag ENGINE_GLACIERBADGE
	iffalse .MahoganyGymHint
	sjump .GetGenericText

.MahoganyCheck2:
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue .MahoganyRocketHint
	checkflag ENGINE_RADIO_CARD
	iftrue .MahoganyRadioHint
	sjump .GetGenericText

.LakeOfRageCheck:
	checkflag ENGINE_ROCKETS_IN_MAHOGANY
	iftrue .GetGenericText
	checkevent EVENT_DECIDED_TO_HELP_LANCE
	iftrue .LakeOfRageRocketHint
	checkevent EVENT_LAKE_OF_RAGE_RED_GYARADOS
	iftrue .LakeOfRageLanceHint
	sjump .LakeOfRageGyaradosHint

.BlackthornCheck:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .GetGenericText
	checkflag ENGINE_RISINGBADGE
	iftrue .BlackthornLeagueHint
	checkevent EVENT_BEAT_CLAIR
	iftrue .BlackthornDragonsDenHint
	checkevent EVENT_BLACKTHORN_CITY_SUPER_NERD_BLOCKS_GYM
	iffalse .BlackthornGymHint
	sjump .GetGenericText

.RuinsOfAlphCheck:
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .RuinsOfAlphUnownComment
	sjump .RuinsOfAlphGenericComment

.TohjoFallsCheck:
	checkflag ENGINE_RISINGBADGE
	iffalse .GetGenericText
	checkevent EVENT_GOT_HM07_WATERFALL
	iffalse .TohjoFallsWaterfallHint
	sjump .GetGenericText

.VictoryRoadCheck:
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .VictoryRoadComment
	sjump .GetGenericText

.IndigoPlateauCheck:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .IndigoPlateauFirstTimeComment
	sjump .IndigoPlateauComment

.VermilionCheck:
	checkflag ENGINE_EXPN_CARD
	iffalse .GetGenericText
	checkflag ENGINE_RADIO_CARD
	iftrue .GetGenericText
	sjump .VermilionRadioHint

.GetGenericText:
	getcurlandmark
	ifequal LANDMARK_NEW_BARK_TOWN, .GenericTownNoPMC
	ifequal LANDMARK_PALLET_TOWN, .GenericTownNoPMC
	callasm GetLandmarkType
	ifequal 1, .GenericTown
	ifequal 2, .GenericRoute
	ifequal 3, .GenericDungeon
	sjump .Generic

.GenericTown:
	random 2
	ifequal 0, .GenericTown1
	ifequal 1, .GenericTown2
	sjump .Generic

.GenericTownNoPMC:
	sjump .GenericTown2

.GenericRoute:
	random 3
	ifequal 0, .GenericRoute1
	ifequal 1, .GenericRoute2
	ifequal 2, .GenericRoute3
	sjump .Generic

.GenericDungeon:
	random 4
	ifequal 0, .GenericRoute1
	ifequal 1, .GenericRoute2
	ifequal 2, .GenericRoute3
	ifequal 3, .GenericDungeon1
	sjump .Generic

.GenericTown1:
	farjumptext FollowerChatText_Leaf_GenericTown1
.GenericTown2:
	farjumptext FollowerChatText_Leaf_GenericTown2
.GenericRoute1:
	farjumptext FollowerChatText_Leaf_GenericRoute1
.GenericRoute2:
	farjumptext FollowerChatText_Leaf_GenericRoute2
.GenericRoute3:
	farjumptext FollowerChatText_Leaf_GenericRoute3
.GenericDungeon1:
	farjumptext FollowerChatText_Leaf_GenericDungeon1
.Generic:
	farjumptext FollowerChatText_Leaf_Generic

.RocketsInRadioTower:
	farjumptext FollowerChatText_Leaf_RocketsInRadioTower
.ExpnCardHint:
	farjumptext FollowerChatText_Leaf_ExpnCardHint
.MagnetTrainPassHint:
	farjumptext FollowerChatText_Leaf_MagnetTrainPassHint
.NewBarkTownComment:
	farjumptext FollowerChatText_Leaf_NewBarkTownComment
.CherrygroveMysticWaterHint:
	farjumptext FollowerChatText_Leaf_CherrygroveMysticWaterHint
.CherrygroveGuideGentHint:
	farjumptext FollowerChatText_Leaf_CherrygroveGuideGentHint
.VioletEggHint:
	farjumptext FollowerChatText_Leaf_VioletEggHint
.VioletGymHint:
	farjumptext FollowerChatText_Leaf_VioletGymHint
.VioletSproutTowerHint:
	farjumptext FollowerChatText_Leaf_VioletSproutTowerHint
.UnionCaveLaprasHint:
	farjumptext FollowerChatText_Leaf_UnionCaveLaprasHint
.AzaleaSlowpokeComment:
	farjumptext FollowerChatText_Leaf_AzaleaSlowpokeComment
.AzaleaRocketComment:
	farjumptext FollowerChatText_Leaf_AzaleaRocketComment
.IlexForestCelebiComment:
	farjumptext FollowerChatText_Leaf_IlexForestCelebiComment
.IlexForestGenericComment:
	farjumptext FollowerChatText_Leaf_IlexForestGenericComment
.GoldenrodSquirtBottleHint:
	farjumptext FollowerChatText_Leaf_GoldenrodSquirtBottleHint
.GoldenrodBikeHint:
	farjumptext FollowerChatText_Leaf_GoldenrodBikeHint
.BugCatchingContestComment:
	farjumptext FollowerChatText_Leaf_BugCatchingContestComment
.NationalParkComment:
	farjumptext FollowerChatText_Leaf_NationalParkComment
.EcruteakTinTowerHint:
	farjumptext FollowerChatText_Leaf_EcruteakTinTowerHint
.EcruteakSurfHint:
	farjumptext FollowerChatText_Leaf_EcruteakSurfHint
.EcruteakGymHint:
	farjumptext FollowerChatText_Leaf_EcruteakGymHint
.EcruteakBurnedTowerHint:
	farjumptext FollowerChatText_Leaf_EcruteakBurnedTowerHint
.Route39MilkComment:
	farjumptext FollowerChatText_Leaf_Route39MilkComment
.Route39MoomooHint:
	farjumptext FollowerChatText_Leaf_Route39MoomooHint
.OlivineShipHint:
	farjumptext FollowerChatText_Leaf_OlivineShipHint
.OlivineAmphyHint:
	farjumptext FollowerChatText_Leaf_OlivineAmphyHint
.OlivineMedicineHint:
	farjumptext FollowerChatText_Leaf_OlivineMedicineHint
.OlivineLighthouseHint:
	farjumptext FollowerChatText_Leaf_OlivineLighthouseHint
.BattleTowerComment:
	farjumptext FollowerChatText_Leaf_BattleTowerComment
.CianwoodFlyHint:
	farjumptext FollowerChatText_Leaf_CianwoodFlyHint
.CianwoodMedicineHint:
	farjumptext FollowerChatText_Leaf_CianwoodMedicineHint
.CianwoodStrengthHint:
	farjumptext FollowerChatText_Leaf_CianwoodStrengthHint
.MahoganyGymHint:
	farjumptext FollowerChatText_Leaf_MahoganyGymHint
.MahoganyRocketHint:
	farjumptext FollowerChatText_Leaf_MahoganyRocketHint
.MahoganyRadioHint:
	farjumptext FollowerChatText_Leaf_MahoganyRadioHint
.LakeOfRageRocketHint:
	farjumptext FollowerChatText_Leaf_LakeOfRageRocketHint
.LakeOfRageLanceHint:
	farjumptext FollowerChatText_Leaf_LakeOfRageLanceHint
.LakeOfRageGyaradosHint:
	farjumptext FollowerChatText_Leaf_LakeOfRageGyaradosHint
.BlackthornLeagueHint:
	farjumptext FollowerChatText_Leaf_BlackthornLeagueHint
.BlackthornDragonsDenHint:
	farjumptext FollowerChatText_Leaf_BlackthornDragonsDenHint
.BlackthornGymHint:
	farjumptext FollowerChatText_Leaf_BlackthornGymHint
.RuinsOfAlphUnownComment:
	farjumptext FollowerChatText_Leaf_RuinsOfAlphUnownComment
.RuinsOfAlphGenericComment:
	farjumptext FollowerChatText_Leaf_RuinsOfAlphGenericComment
.TohjoFallsWaterfallHint:
	farjumptext FollowerChatText_Leaf_TohjoFallsWaterfallHint
.VictoryRoadComment:
	farjumptext FollowerChatText_Leaf_VictoryRoadComment
.IndigoPlateauComment:
	farjumptext FollowerChatText_Leaf_IndigoPlateauComment
.IndigoPlateauFirstTimeComment:
	farjumptext FollowerChatText_Leaf_IndigoPlateauFirstTimeComment
.PalletTownComment:
	farjumptext FollowerChatText_Leaf_PalletTownComment
.VermilionRadioHint:
	farjumptext FollowerChatText_Leaf_VermilionRadioHint
.SilverCaveComment:
	farjumptext FollowerChatText_Leaf_SilverCaveComment

GetLandmarkType:
; returns 0 for unknown
;         1 for city/town
;         2 for route
;         3 for dungeon
	ld a, [wScriptVar]
	ld c, a
	xor a
	ld [wScriptVar], a
	ld hl, LandmarkTypes
.loop1
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	cp -1
	jr z, .unknown
	ld a, [wScriptVar]
	inc a
	ld [wScriptVar], a
.loop2
	ld a, [hli]
	cp c
	jr z, .found
	cp -1
	jr nz, .loop2
	pop hl
	inc hl
	inc hl
	jr .loop1

.unknown
	xor a
	ld [wScriptVar], a
.found
	pop hl
	ret

INCLUDE "data/maps/landmark_types.asm"
