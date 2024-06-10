	object_const_def
	const ROUTE21_SWIMMER_GIRL_NIKKI
	const ROUTE21_SWIMMER_GIRL_CHELAN
	const ROUTE21_SWIMMER_GIRL_LULU
	const ROUTE21_FISHER_ARNOLD
	const ROUTE21_FISHER_WADE
	const ROUTE21_FISHER_SKOVORODA
	const ROUTE21_FISHER_MURPHY
	const ROUTE21_SWIMMER_GUY_SETH
	const ROUTE21_SWIMMER_GUY_ESTEBAN
	const ROUTE21_SWIMMER_GUY_TYSON
	const ROUTE21_SWIMMER_GUY_DUANE
	const ROUTE21_BIRDKEEPER_GIDEON
	const ROUTE21_BIRDKEEPER_EASTON
	const ROUTE21_BIRDKEEPER_LEON

Route21_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RaveParty

.RaveParty:
	farscall RavePartyFlag
	endcallback

TrainerSwimmerfNikki:
	trainer SWIMMERF, NIKKI, EVENT_BEAT_SWIMMERF_NIKKI, SwimmerfNikkiSeenText, SwimmerfNikkiBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfNikkiAfterBattleText

TrainerSwimmerfChelan:
	trainer SWIMMERF, CHELAN, EVENT_BEAT_SWIMMERF_CHELAN, SwimmerfChelanSeenText, SwimmerfChelanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfChelanAfterBattleText

TrainerSwimmerfLulu:
	trainer SWIMMERF, LULU, EVENT_BEAT_SWIMMERF_LULU, SwimmerfLuluSeenText, SwimmerfLuluBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfLuluAfterBattleText

TrainerFisherArnold:
	trainer FISHER, ARNOLD, EVENT_BEAT_FISHER_ARNOLD, FisherArnoldSeenText, FisherArnoldBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherArnoldAfterBattleText

TrainerFisherWade:
	trainer FISHER, WADE, EVENT_BEAT_FISHER_WADE, FisherWadeSeenText, FisherWadeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherWadeAfterBattleText

TrainerFisherSkovoroda:
	trainer FISHER, SKOVORODA, EVENT_BEAT_FISHER_SKOVORODA, FisherSkovorodaSeenText, FisherSkovorodaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherSkovorodaAfterBattleText

TrainerFisherMurphy:
	trainer FISHER, MURPHY, EVENT_BEAT_FISHER_MURPHY, FisherMurphyBattleText, FisherMurphyBattleText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherMurphyBattleText

TrainerSwimmermSeth:
	trainer SWIMMERM, SETH, EVENT_BEAT_SWIMMERM_SETH, SwimmermSethSeenText, SwimmermSethBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermSethAfterBattleText

TrainerSwimmermEsteban:
	trainer SWIMMERM, ESTEBAN, EVENT_BEAT_SWIMMERM_ESTEBAN, SwimmermEstebanSeenText, SwimmermEstebanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermEstebanAfterBattleText

TrainerSwimmermTyson:
	trainer SWIMMERM, TYSON, EVENT_BEAT_SWIMMERM_TYSON, SwimmermTysonSeenText, SwimmermTysonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermTysonAfterBattleText

TrainerSwimmermDuane:
	trainer SWIMMERM, DUANE, EVENT_BEAT_SWIMMERM_DUANE, SwimmermDuaneSeenText, SwimmermDuaneBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermDuaneAfterBattleText

TrainerBirdKeeperGideon:
	trainer BIRD_KEEPER, GIDEON, EVENT_BEAT_BIRDKEEPER_GIDEON, BirdKeeperGideonSeenText, BirdKeeperGideonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperGideonAfterBattleText

TrainerBirdKeeperEaston:
	trainer BIRD_KEEPER, EASTON, EVENT_BEAT_BIRDKEEPER_EASTON, BirdKeeperEastonSeenText, BirdKeeperEastonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperEastonAfterBattleText

TrainerBirdKeeperLeon:
	trainer BIRD_KEEPER, LEON, EVENT_BEAT_BIRDKEEPER_LEON, BirdKeeperLeonSeenText, BirdKeeperLeonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperLeonAfterBattleText

SwimmermSethSeenText:
	text "Land ho! Gotta"
	line "keep going!"
	done

SwimmermSethBeatenText:
	text "Glug…"
	done

SwimmermSethAfterBattleText:
	text "This arrogant guy"
	line "was at CINNABAR's"
	cont "volcano."
	done

SwimmermDuaneSeenText:
	text "Check out my rare"
	line "#MON!"
	done

SwimmermDuaneBeatenText:
	text "Impressed?"
	done

SwimmermDuaneAfterBattleText:
	text "The volcano spat"
	line "some fossils from"
	
	para "the bottom of the"
	line "ocean."
	done

SwimmermTysonSeenText:
	text "I used to be"
	line "an athlete…"
	done

SwimmermTysonBeatenText:
	text "I got soft…"
	done

SwimmermTysonAfterBattleText:
	text "I couldn't train"
	line "during the"
	cont "pandemic."

	para "Now I'm training"
	line "twice as much."
	done

SwimmermEstebanSeenText:
	text "I used to be a"
	line "SCIENTIST at the"
	cont "CINNABAR LAB."
	done

SwimmermEstebanBeatenText:
	text "I enjoyed this"
	line "battle. Thanks!"
	done

SwimmermEstebanAfterBattleText:
	text "My colleagues were"
	line "assigned to other"
	cont "workplaces after"
	cont "the eruption."

	para "Most of them in"
	line "SAFFRON CITY."
	done

SwimmerfNikkiSeenText:
	text "If I win, you have"
	line "to help me with my"
	cont "suntan lotion!"
	done

SwimmerfNikkiBeatenText:
	text "I'm worried about"
	line "sunburn…"
	done

SwimmerfNikkiAfterBattleText:
	text "The day CINNABAR's"
	line "volcano erupted,"

	para "I saw a majestic"
	line "blue bird #MON"

	para "fly over my head"
	line "in a straight line"
	
	para "coming from"
	line "SEAFOAM ISLANDS."
	done

SwimmerfChelanSeenText:
	text "Are you also"
	line "coming for it?"
	done

SwimmerfChelanBeatenText:
	text "Come on, you're"
	line "no fun."
	done

SwimmerfChelanAfterBattleText:
	text "I'm waiting for it."
	line "You know, right?"

	para "I recall it starts"
	line "at 9 PM. But on"
	cont "what day?"
	done

SwimmerfLuluSeenText:
	text "Who knew I could"
	line "become such a"
	cont "good SWIMMER?!"
	done

SwimmerfLuluBeatenText:
	text "I'll have better"
	line "luck next time…"
	done

SwimmerfLuluAfterBattleText:
	text "I never tried"
	line "swimming when I"
	cont "was younger."

	para "It's such a blast!"

	para "I should've tried"
	line "sooner!"
	done

FisherArnoldSeenText:
	text "I'm bored by fish-"
	line "ing. Let's battle!"
	done

FisherArnoldBeatenText:
	text "Utter failure…"
	done

FisherArnoldAfterBattleText:
	text "I'll just go back"
	line "to fishing…"
	done

FisherWadeSeenText:
	text "I got a big haul!"
	line "Wanna go for it?"
	done

FisherWadeBeatenText:
	text "Darn MAGIKARP!"
	done

FisherWadeAfterBattleText:
	text "I seem to only"
	line "catch MAGIKARP!"
	done

FisherMurphyBattleText:
	text "Hi, my name is"
	line "MURPHY!"
	done

FisherSkovorodaSeenText:
	text "I used to lose"
	line "all battles."

	para "But it didn't"
	line "discourage me."
	done

FisherSkovorodaBeatenText:
	text "Well played!"
	line "I learned a lot."
	done

FisherSkovorodaAfterBattleText:
	text "Good things come"
	line "to those who"
	cont "persevere."

	para "Waiting doesn't"
	line "help much."

	para "Except when"
	line "fishing."
	done

BirdKeeperGideonSeenText:
	text "Looking at my"
	line "#MON flying"
	cont "in circles is"
	cont "making me dizzy."

	para "I need to focus my"
	line "gaze on a fixed"
	cont "point."
	cont "It'll be you."
	done

BirdKeeperGideonBeatenText:
	text "I'm feeling even"
	line "more dizzy now."
	done

BirdKeeperGideonAfterBattleText:
	text "The sky is so"
	line "beautiful here."

	para "I missed it during"
	line "the lockdown."
	done

BirdKeeperEastonSeenText:
	text "Flying in the"
	line "blue sky is"
	cont "freedom to me."

	para "But it's dangerous."
	done

BirdKeeperEastonBeatenText:
	text "Life goes on."
	done

BirdKeeperEastonAfterBattleText:
	text "Is security worth"
	line "sacrificing"
	cont "freedom?"
	done

BirdKeeperLeonSeenText:
	text "I collect colorful"
	line "FLYING #MON."

	para "Wanna see'em?"
	done

BirdKeeperLeonBeatenText:
	text "Hmmm… what"
	line "happened?"
	done

BirdKeeperLeonAfterBattleText:
	text "Taking care of all"
	line "my FLYING #MON"
	cont "is hard work."

	para "But looking at all"
	line "these colors fly-"
	cont "ing around makes"
	cont "it worth it!"
	done

Route21_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11, 16, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfNikki, -1
	object_event 11, 84, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfChelan, EVENT_CINNABAR_RAVE_PARTY
	object_event 14, 66, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 1, 4, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfLulu, -1
	object_event 14, 60, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerFisherArnold, -1
	object_event  6, 27, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFisherWade, -1
	object_event  4, 26, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerFisherSkovoroda, -1
	object_event  8,  9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerFisherMurphy, -1
	object_event  1, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermSeth, -1
	object_event 14, 29, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerSwimmermEsteban, -1
	object_event  6, 45, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerSwimmermTyson, -1
	object_event  7, 49, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerSwimmermDuane, -1
	object_event 10,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperGideon, -1
	object_event  7, 26, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerBirdKeeperEaston, -1
	object_event 15, 61, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperLeon, -1
