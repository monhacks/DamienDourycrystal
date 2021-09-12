	object_const_def
	const PLAYERSHOUSE1F_MOM1
	const PLAYERSHOUSE1F_MOM2
	const PLAYERSHOUSE1F_MOM3
	const PLAYERSHOUSE1F_MOM4
	const PLAYERSHOUSE1F_POKEFAN_F
	const PLAYERSHOUSE1F_WALL

PlayersHouse1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks

.DummyScene0:
	end

.DummyScene1:
	end

MeetMomLeftScript:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

MeetMomRightScript:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	turnobject PLAYER, LEFT
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .OnRight
	applymovement PLAYERSHOUSE1F_MOM1, MomTurnsTowardPlayerMovement
	sjump MeetMomScript

.OnRight:
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksToPlayerMovement
MeetMomScript:
	opentext
	writetext ElmsLookingForYouText
	promptbutton
	getstring STRING_BUFFER_4, PokegearName
	scall PlayersHouse1FReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene SCENE_FINISHED
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext MomGivesPokegearText
	promptbutton
	special SetDayOfWeek
.SetDayOfWeek:
	writetext IsItDSTText
	yesorno
	iffalse .WrongDay
	special InitialSetDSTFlag
	yesorno
	iffalse .SetDayOfWeek
	sjump .DayOfWeekDone

.WrongDay:
	special InitialClearDSTFlag
	yesorno
	iffalse .SetDayOfWeek
.DayOfWeekDone:
	writetext ComeHomeForDSTText
	yesorno
	iffalse .ExplainPhone
	sjump .KnowPhone

.KnowPhone:
	writetext KnowTheInstructionsText
	promptbutton
	sjump .FinishPhoneForReal

.ExplainPhone:
	writetext DontKnowTheInstructionsText
	promptbutton
	sjump .FinishPhone

.FinishPhone:
	writetext InstructionsNextText
	promptbutton
.FinishPhoneForReal:
	writetext CovidIntroText
	playsound SFX_ITEM
	waitsfx
	writetext CovidNextText
	waitbutton
	closetext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .FromRight
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iffalse .FromLeft
	sjump .Finish

.FromRight:
	applymovement PLAYERSHOUSE1F_MOM1, MomTurnsBackMovement
	sjump .Finish

.FromLeft:
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksBackMovement
	sjump .Finish

.Finish:
	special RestartMapMusic
	turnobject PLAYERSHOUSE1F_MOM1, LEFT
	end

MeetMomTalkedScript:
	playmusic MUSIC_MOM
	sjump MeetMomScript

PokegearName:
	db "#GEAR@"

PlayersHouse1FReceiveItemStd:
	jumpstd ReceiveItemScript
	end

FakeMomMornScript:
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .quit
	checktime MORN
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM2
	showemote EMOTE_QUESTION, PLAYERSHOUSE1F_MOM2, 15
	faceplayer
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	end
.quit:
	opentext
	writetext SmellText
	promptbutton
	closetext
	end

FakeMomDayScript:
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .meet
	checktime DAY
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM3
	showemote EMOTE_QUESTION, PLAYERSHOUSE1F_MOM3, 15
	faceplayer
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	end
.meet
	setlasttalked PLAYERSHOUSE1F_MOM1
	sjump MomScript
	end
.quit:
	opentext
	writetext MomsSeatText
	promptbutton
	closetext
	end

FakeMomNiteScript:
	checkevent EVENT_PLAYERS_HOUSE_MOM_1
	iffalse .quit
	checktime NITE
	iffalse .quit
	setlasttalked PLAYERSHOUSE1F_MOM4
	showemote EMOTE_QUESTION, PLAYERSHOUSE1F_MOM4, 15
	faceplayer
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	end
.quit:
	opentext
	writetext SmellText
	promptbutton
	closetext
	end

FakeNeighborScript:
	checkevent EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
	iftrue .quit
	setlasttalked PLAYERSHOUSE1F_POKEFAN_F
	sjump NeighborScript
	end
.quit:
	opentext
	writetext PlayerSeatText
	promptbutton
	closetext
	end

WallScript:
	opentext
	writetext SocialDistancingText
	promptbutton
	closetext
	end

MomScript:
	faceplayer
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	checkscene
	iffalse MeetMomTalkedScript ; SCENE_DEFAULT
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .FirstTimeBanking
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .GaveMysteryEgg
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .GotAPokemon
	writetext HurryUpElmIsWaitingText
	waitbutton
	closetext
	end

.GotAPokemon:
	writetext SoWhatWasProfElmsErrandText
	waitbutton
	closetext
	end

.FirstTimeBanking:
	writetext ImBehindYouText
	waitbutton
	closetext
	end

.GaveMysteryEgg:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special BankOfMom
	waitbutton
	closetext
	end

NeighborScript:
	faceplayer
	opentext
	checktime MORN
	iftrue .MornScript
	checktime DAY
	iftrue .DayScript
	checktime NITE
	iftrue .NiteScript

.MornScript:
	writetext NeighborMornIntroText
	promptbutton
	sjump .Main

.DayScript:
	writetext NeighborDayIntroText
	promptbutton
	sjump .Main

.NiteScript:
	writetext NeighborNiteIntroText
	promptbutton
	sjump .Main

.Main:
	writetext NeighborText
	waitbutton
	closetext
	turnobject PLAYERSHOUSE1F_POKEFAN_F, UP
	end

PlayersHouse1FTVScript:
	jumptext PlayersHouse1FTVText

PlayersHouse1FStoveScript:
	jumptext PlayersHouse1FStoveText

PlayersHouse1FSinkScript:
	jumptext PlayersHouse1FSinkText

PlayersHouse1FFridgeScript:
	jumptext PlayersHouse1FFridgeText

MomTurnsTowardPlayerMovement:
	turn_head RIGHT
	step_end

MomWalksToPlayerMovement:
	slow_step RIGHT
	step_end

MomTurnsBackMovement:
	turn_head LEFT
	step_end

MomWalksBackMovement:
	slow_step LEFT
	step_end

SmellText:
	text "Smells good!"
	line "Mom's a good cook!"
	done

PlayerSeatText:
	text "This is my seat"
	line "at the table."

	para "It has the best"
	line "view on the TV!"
	done

MomsSeatText:
	text "Mom's seat has"
	line "lovely cushions."
	done

SocialDistancingText:
	text "<PLAYER> what"
	line "did I tell you?"

	para "Stay 1 step away"
	line "when talking to"
	cont "someone. It is"
	cont "called social"
	cont "distancing."

	para "Move 1 step back"
	line "or I won't talk"
	cont "to you."
	done

ElmsLookingForYouText:
	text "Oh, <PLAYER>…! Our"
	line "neighbor, PROF."

	para "ELM, was looking"
	line "for you."

	para "He said he wanted"
	line "you to do some-"
	cont "thing for him."

	para "Oh! I almost for-"
	line "got! Your #MON"

	para "GEAR is back from"
	line "the repair shop."

	para "Here you go!"
	done

MomGivesPokegearText:
	text "#MON GEAR, or"
	line "just #GEAR."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
	done

IsItDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

ComeHomeForDSTText:
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."

	para "By the way, do you"
	line "know how to use"
	cont "the PHONE?"
	done

KnowTheInstructionsText:
	text "Great!"
	done

DontKnowTheInstructionsText:
	text "I'll read the"
	line "instructions."

	para "Turn the #GEAR"
	line "on and select the"
	cont "PHONE icon."
	done

InstructionsNextText:
	text "Phone numbers are"
	line "stored in memory."

	para "Just choose a name"
	line "you want to call."

	para "Gee, isn't that"
	line "convenient?"
	done

CovidIntroText:
	text "One last thing!"
	line "They are talking"
	cont "about a new virus"
	cont "on TV."

	para "I have a leftover"
	line "box of face masks"
	cont "from last time I"
	cont "got sick."

	para "You can have it!"

	para "<PLAYER> puts on"
	line "a FACE MASK!"
	done

CovidNextText:
	text "Better safe than"
	line "sorry, right?"

	para "Doctors on TV"
	line "recommended to"
	cont "stay 1 step away"
	cont "when talking to"
	cont "someone."

	para "Now people may not"
	line "want to talk to"
	cont "you if you do not"
	cont "respect this rule."

	para "Be careful"
	line "out there!"
	done

HurryUpElmIsWaitingText:
	text "PROF.ELM is wait-"
	line "ing for you."

	para "Hurry up, baby!"
	done

SoWhatWasProfElmsErrandText:
	text "So, what was PROF."
	line "ELM's errand?"

	para "…"

	para "That does sound"
	line "challenging."

	para "But, you should be"
	line "proud that people"
	cont "rely on you."
	done

ImBehindYouText:
	text "<PLAYER>, do it!"

	para "I'm behind you all"
	line "the way!"
	done

NeighborMornIntroText:
	text "Good morning,"
	line "<PLAY_G>!"

	para "I'm visiting!"
	done

NeighborDayIntroText:
	text "Hello, <PLAY_G>!"
	line "I'm visiting!"
	done

NeighborNiteIntroText:
	text "Good evening,"
	line "<PLAY_G>!"

	para "I'm visiting!"
	done

NeighborText:
	text "Have you heard?"
	line "Some people caught"

	para "a virus never seen"
	line "before."

	para "Nothing to worry"
	line "about, I'm sure"
	cont "we will be fine!"
	done

PlayersHouse1FStoveText:
	text "Mom's specialty!"

	para "CIANWOOD WHIRL"
	line "MAKIS!"
	done

PlayersHouse1FSinkText:
	text "The sink is spot-"
	line "less. Mom likes it"
	cont "clean."
	done

PlayersHouse1FFridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "FRESH WATER and"
	line "tasty LEMONADE!"
	done

PlayersHouse1FTVText:
	text "On the news,"
	line "a doctor debates"
	cont "with a politician"
	cont "about a newly"
	cont "discovered virus."

	para "The doctor seems"
	line "nervous."

	para "The politician"
	line "laughes and says"

	para "there is no need"
	line "to panic."

	para "…"

	para "I better"
	line "get going."
	done

PlayersHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, NEW_BARK_TOWN, 2
	warp_event  7,  7, NEW_BARK_TOWN, 2
	warp_event  9,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events
	coord_event  8,  4, SCENE_DEFAULT, MeetMomLeftScript
	coord_event  9,  4, SCENE_DEFAULT, MeetMomRightScript

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PlayersHouse1FStoveScript
	bg_event  1,  1, BGEVENT_READ, PlayersHouse1FSinkScript
	bg_event  2,  1, BGEVENT_READ, PlayersHouse1FFridgeScript
	bg_event  4,  1, BGEVENT_READ, PlayersHouse1FTVScript
	bg_event  2,  2, BGEVENT_READ, FakeMomMornScript
	bg_event  7,  4, BGEVENT_READ, FakeMomDayScript
	bg_event  0,  2, BGEVENT_READ, FakeMomNiteScript
	bg_event  4,  4, BGEVENT_READ, FakeNeighborScript

	def_object_events
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1
	object_event  2,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  0,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, NITE, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  4,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NeighborScript, EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
