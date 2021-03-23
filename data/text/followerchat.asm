;FollowerChatText_Leaf_
; chat list for debugging
if DEF(_DEBUG2)
FollowerChatList:
	dw FollowerChatText_Red_Generic
	dw FollowerChatText_Red_SilverCave
	dw FollowerChatText_Leaf_RocketsInRadioTower
	dw FollowerChatText_Leaf_ExpnCardHint
	dw FollowerChatText_Leaf_MagnetTrainPassHint
	dw FollowerChatText_Leaf_NewBarkTownComment
	dw FollowerChatText_Leaf_CherrygroveMysticWaterHint
	dw FollowerChatText_Leaf_CherrygroveGuideGentHint
	dw FollowerChatText_Leaf_VioletEggHint
	dw FollowerChatText_Leaf_VioletGymHint
	dw FollowerChatText_Leaf_VioletSproutTowerHint
	dw FollowerChatText_Leaf_UnionCaveLaprasHint
	dw FollowerChatText_Leaf_AzaleaSlowpokeComment
	dw FollowerChatText_Leaf_AzaleaRocketComment
	dw FollowerChatText_Leaf_IlexForestCelebiComment
	dw FollowerChatText_Leaf_IlexForestGenericComment
	dw FollowerChatText_Leaf_GoldenrodSquirtBottleHint
	dw FollowerChatText_Leaf_GoldenrodBikeHint
	dw FollowerChatText_Leaf_BugCatchingContestComment
	dw FollowerChatText_Leaf_NationalParkComment
	dw FollowerChatText_Leaf_EcruteakTinTowerHint
	dw FollowerChatText_Leaf_EcruteakSurfHint
	dw FollowerChatText_Leaf_EcruteakGymHint
	dw FollowerChatText_Leaf_EcruteakBurnedTowerHint
	dw FollowerChatText_Leaf_Route39MilkComment
	dw FollowerChatText_Leaf_Route39MoomooHint
	dw FollowerChatText_Leaf_OlivineShipHint
	dw FollowerChatText_Leaf_OlivineAmphyHint
	dw FollowerChatText_Leaf_OlivineMedicineHint
	dw FollowerChatText_Leaf_OlivineLighthouseHint
	dw FollowerChatText_Leaf_BattleTowerComment
	dw FollowerChatText_Leaf_CianwoodFlyHint
	dw FollowerChatText_Leaf_CianwoodMedicineHint
	dw FollowerChatText_Leaf_CianwoodStrengthHint
	dw FollowerChatText_Leaf_MahoganyGymHint
	dw FollowerChatText_Leaf_MahoganyRocketHint
	dw FollowerChatText_Leaf_MahoganyRadioHint
	dw FollowerChatText_Leaf_LakeOfRageRocketHint
	dw FollowerChatText_Leaf_LakeOfRageLanceHint
	dw FollowerChatText_Leaf_LakeOfRageGyaradosHint
	dw FollowerChatText_Leaf_BlackthornLeagueHint
	dw FollowerChatText_Leaf_BlackthornDragonsDenHint
	dw FollowerChatText_Leaf_BlackthornGymHint
	dw FollowerChatText_Leaf_RuinsOfAlphUnownComment
	dw FollowerChatText_Leaf_RuinsOfAlphGenericComment
	dw FollowerChatText_Leaf_TohjoFallsWaterfallHint
	dw FollowerChatText_Leaf_VictoryRoadComment
	dw FollowerChatText_Leaf_IndigoPlateauComment
	dw FollowerChatText_Leaf_IndigoPlateauFirstTimeComment
	dw FollowerChatText_Leaf_PalletTownComment
	dw FollowerChatText_Leaf_VermilionRadioHint
	dw FollowerChatText_Leaf_SilverCaveComment
	dw FollowerChatText_Leaf_GenericTown1
	dw FollowerChatText_Leaf_GenericTown2
	dw FollowerChatText_Leaf_GenericRoute1
	dw FollowerChatText_Leaf_GenericRoute2
	dw FollowerChatText_Leaf_GenericRoute3
	dw FollowerChatText_Leaf_GenericDungeon1
FollowerChatListEnd:
	db -1
endc

FollowerChatText_Red_Generic:
	text "…"
	done

FollowerChatText_Red_SilverCave:
	text "…"

	para "(He looks"
	line "excited.)"
	done

FollowerChatText_Leaf_RocketsInRadioTower:
	text "Let's take down"
	line "TEAM ROCKET once"
	cont "and for all!"
	done

FollowerChatText_Leaf_ExpnCardHint:
	text "We should visit"
	line "the RADIO TOWER in"
	cont "LAVENDER TOWN."

	para "I bet someone will"
	line "be thankful that"
	cont "the POWER PLANT is"
	cont "running again."
	done

FollowerChatText_Leaf_MagnetTrainPassHint:
	text "I saw a poster for"
	line "a missing #"
	cont "DOLL."

	para "I think we should"
	line "help find it!"

	para "Let's talk to the"
	line "COPYCAT in SAFFRON"
	cont "CITY."
	done

FollowerChatText_Leaf_NewBarkTownComment:
	text "It's so calm and"
	line "peaceful here."

	para "I could spend all"
	line "day just walking"
	cont "around."
	done

FollowerChatText_Leaf_CherrygroveMysticWaterHint:
	text "Do you see that"
	line "island offshore?"

	para "I wonder what's on"
	line "it."
	done

FollowerChatText_Leaf_CherrygroveGuideGentHint:
	text "There's a strange"
	line "man over by the"
	cont "#MON CENTER."

	para "What could he"
	line "want?"
	done

FollowerChatText_Leaf_VioletEggHint:
	text "PROFESSOR ELM's"
	line "AIDE is waiting"
	cont "for us at the"
	cont "#MON CENTER."

	para "Let's go see what"
	line "he wants."
	done

FollowerChatText_Leaf_VioletGymHint:
	text "<PLAYER>, let's go"
	line "check out the GYM!"
	done

FollowerChatText_Leaf_VioletSproutTowerHint:
	text "We should try to"
	line "climb up SPROUT"
	cont "TOWER!"

	para "I wonder what's at"
	line "the top."
	done

FollowerChatText_Leaf_UnionCaveLaprasHint:
	text "Let's go look in"
	line "the lower levels"
	cont "of the cave."

	para "There might be"
	line "rare #MON down"
	cont "there!"
	done

FollowerChatText_Leaf_AzaleaSlowpokeComment:
	text "SLOWPOKE is so"
	line "cute! Don't you"
	cont "think so?"
	done

FollowerChatText_Leaf_AzaleaRocketComment:
	text "What's with these"
	line "weirdos dressed"
	cont "in black?"
	done

FollowerChatText_Leaf_IlexForestCelebiComment:
	text "What in the world"
	line "could be causing"
	cont "the forest to go"
	cont "crazy like this?"
	done

FollowerChatText_Leaf_IlexForestGenericComment:
	text "It's very quiet in"
	line "here."

	para "The #MON must"
	line "enjoy it."
	done

FollowerChatText_Leaf_GoldenrodSquirtBottleHint:
	text "I want to go visit"
	line "the flower shop!"

	para "I think it's over"
	line "by the GYM."
	done

FollowerChatText_Leaf_GoldenrodBikeHint:
	text "We should go visit"
	line "the bike shop!"

	para "I think it's behind"
	line "the DEPT. STORE."
	done

FollowerChatText_Leaf_BugCatchingContestComment:
	text "Let's catch a super"
	line "good #MON."

	para "I want to get"
	line "first place!"
	done

FollowerChatText_Leaf_NationalParkComment:
	text "It's so peaceful"
	line "here."

	para "Let's just take it"
	line "easy for a bit."
	done

FollowerChatText_Leaf_EcruteakTinTowerHint:
	text "Let's go to the"
	line "TIN TOWER."
	done

FollowerChatText_Leaf_EcruteakSurfHint:
	text "I want to go to"
	line "the dance hall!"

	para "I'd like to see"
	line "the KIMONO GIRLS"
	cont "in action."
	done

FollowerChatText_Leaf_EcruteakGymHint:
	text "MORTY should be in"
	line "his GYM now."

	para "Let's go challenge"
	line "him!"
	done

FollowerChatText_Leaf_EcruteakBurnedTowerHint:
	text "Let's go see the"
	line "BURNED TOWER."

	para "I want to learn"
	line "more about the"
	cont "history of"
	cont "ECRUTEAK CITY."
	done

FollowerChatText_Leaf_Route39MilkComment:
	text "MOOMOO MILK is so"
	line "yummy!"
	done

FollowerChatText_Leaf_Route39MoomooHint:
	text "Poor MOOMOO."

	para "We should save a"
	line "BERRY or two for"
	cont "her."
	done

FollowerChatText_Leaf_OlivineShipHint:
	text "Let's head over to"
	line "the port."

	para "We can take the"
	line "S.S. AQUA to"
	cont "KANTO!"
	done

FollowerChatText_Leaf_OlivineAmphyHint:
	text "Let's climb the"
	line "LIGHTHOUSE again."

	para "We need to help"
	line "AMPHY!"
	done

FollowerChatText_Leaf_OlivineMedicineHint:
	text "I'm worried about"
	line "AMPHY."

	para "We should hurry"
	line "and find some"
	cont "medicine."
	done

FollowerChatText_Leaf_OlivineLighthouseHint:
	text "It's the GLITTER"
	line "LIGHTHOUSE!"

	para "I've always wanted"
	line "to go inside."
	done

FollowerChatText_Leaf_BattleTowerComment:
	text "I've heard that the"
	line "best of the best"
	cont "come here to"
	cont "battle."

	para "Do you think we"
	line "stand a chance?"
	done

FollowerChatText_Leaf_CianwoodFlyHint:
	text "Who is that woman"
	line "in front of the"
	cont "GYM?"
	done

FollowerChatText_Leaf_CianwoodMedicineHint:
	text "Let's find the"
	line "pharmacist."

	para "There's no time to"
	line "lose!"
	done

FollowerChatText_Leaf_CianwoodStrengthHint:
	text "Looks like we need"
	line "a new HM to get"
	cont "through the GYM."

	para "Maybe somebody in"
	line "OLIVINE can help."
	done

FollowerChatText_Leaf_MahoganyGymHint:
	text "Looks like the GYM"
	line "is open."

	para "Let's go collect"
	line "another BADGE!"
	done

FollowerChatText_Leaf_MahoganyRocketHint:
	text "Let's go help LANCE"
	line "deal with TEAM"
	cont "ROCKET!"
	done

FollowerChatText_Leaf_MahoganyRadioHint:
	text "Hmm…"

	para "The RADIO on the"
	line "#GEAR is making"
	cont "weird sounds."
	done

FollowerChatText_Leaf_LakeOfRageRocketHint:
	text "Let's go meet up"
	line "with LANCE in"
	cont "MAHOGANY TOWN."
	done

FollowerChatText_Leaf_LakeOfRageLanceHint:
	text "Who's that guy in"
	line "the cape?"

	para "I wonder what he"
	line "wants."
	done

FollowerChatText_Leaf_LakeOfRageGyaradosHint:
	text "What #MON is"
	line "that in the lake?"

	para "It looks like a"
	line "GYARADOS, but"
	cont "those are supposed"
	cont "to be blue, right?"
	done

FollowerChatText_Leaf_BlackthornLeagueHint:
	text "Now that we have"
	line "all 8 BADGES, it's"
	cont "time to go to the"
	cont "#MON LEAGUE!"

	para "Where is it at,"
	line "again?"
	done

FollowerChatText_Leaf_BlackthornDragonsDenHint:
	text "Why didn't CLAIR"
	line "give us the BADGE?"

	para "We beat her fair"
	line "and square!"

	para "Let's go to the"
	line "DRAGON'S DEN and"
	cont "figure this out."
	done

FollowerChatText_Leaf_BlackthornGymHint:
	text "Just one more GYM"
	line "to take down."

	para "Let's go!"
	done

FollowerChatText_Leaf_RuinsOfAlphUnownComment:
	text "The letters on the"
	line "walls were really"
	cont "#MON!"

	para "Who would've"
	line "guessed?"
	done

FollowerChatText_Leaf_RuinsOfAlphGenericComment:
	text "There's a lot of"
	line "history in this"
	cont "place."

	para "Let's look around."
	done

FollowerChatText_Leaf_TohjoFallsWaterfallHint:
	text "We must have"
	line "missed an HM"
	cont "somewhere."

	para "I remember seeing"
	line "an item in the"
	cont "ICE PATH."

	para "Maybe it was that?"
	done

FollowerChatText_Leaf_VictoryRoadComment:
	text "This is the last"
	line "stretch."

	para "Let's go for it!"
	done

FollowerChatText_Leaf_IndigoPlateauComment:
	text "Every time we're"
	line "here I get excited"
	cont "for the great"
	cont "battles we have!"
	done

FollowerChatText_Leaf_IndigoPlateauFirstTimeComment:
	text "Do you think we"
	line "stand a chance at"
	cont "beating the"
	cont "#MON LEAGUE?"

	para "Together, I think"
	line "we can do it!"
	done

FollowerChatText_Leaf_PalletTownComment:
	text "It's so peaceful"
	line "here."

	para "It reminds me of"
	line "NEW BARK TOWN."
	done

FollowerChatText_Leaf_VermilionRadioHint:
	text "We have this EXPN"
	line "CARD but no RADIO"
	cont "to use it with."

	para "Maybe we can get"
	line "one at the RADIO"
	cont "TOWER in"
	cont "GOLDENROD CITY."
	done

FollowerChatText_Leaf_SilverCaveComment:
	text "…"

	para "(She looks"
	line "excited.)"
	done

FollowerChatText_Leaf_GenericTown1:
	text "Let's go rest for"
	line "a bit at the"
	cont "#MON CENTER."
	done

FollowerChatText_Leaf_GenericTown2:
	text "Let's talk to the"
	line "people in town."
	done

FollowerChatText_Leaf_GenericRoute1:
	text "Let's try to catch"
	line "a #MON!"
	done

FollowerChatText_Leaf_GenericRoute2:
	text "Let's look for some"
	line "items."
	done

FollowerChatText_Leaf_GenericRoute3:
	text "Let's relax and"
	line "take a look at the"
	cont "scenery."
	done

FollowerChatText_Leaf_GenericDungeon1:
	text "Let's be careful"
	line "to not get lost."
	done

FollowerChatText_Leaf_Generic:
	text "Let's keep on going"
	line "together!"
	done
