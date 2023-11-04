	object_const_def
	const OLIVINEPUNISHMENTSPEECHHOUSE_POKEFAN_M
	const OLIVINEPUNISHMENTSPEECHHOUSE_LASS
	const OLIVINEPUNISHMENTSPEECHHOUSE_POKEFAN_M_LOCKDOWN
	const OLIVINEPUNISHMENTSPEECHHOUSE_COMPUTER

OlivinePunishmentSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad

.TilesLoad
	readmem wCurFreedomState
	ifnotequal 1 << LOCKDOWN, .end

	changeblock  4,  2, $35
.end
	endcallback

OlivinePunishmentSpeechHouseDad:
	jumptextfaceplayer OlivinePunishmentSpeechHouseDadText

OlivinePunishmentSpeechHouseDadLockdown:
	faceplayer
	opentext
	writetext OlivinePunishmentSpeechHouseDadLockdownText
	waitbutton
	closetext
	turnobject OLIVINEPUNISHMENTSPEECHHOUSE_POKEFAN_M_LOCKDOWN, RIGHT
	end

OlivinePunishmentSpeechHouseDaughter:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown

	jumptextfaceplayer OlivinePunishmentSpeechHouseDaughterText
.lockdown
	jumptextfaceplayer OlivinePunishmentSpeechHouseDaughterLockdownText

OlivinePunishmentSpeechHouseComputerScript:
	jumptext OlivinePunishmentSpeechHouseComputerText

OlivinePunishmentSpeechHouseBookshelf2:
	jumpstd PictureBookshelfScript

OlivinePunishmentSpeechHouseBookshelf1:
	jumpstd MagazineBookshelfScript

OlivinePunishmentSpeechHouseDadText:
	text "Along the way to"
	line "CIANWOOD, there"

	para "are four deserted"
	line "islands."

	para "Bad kids are taken"
	line "to the islands as"
	cont "punishment!"
	done

OlivinePunishmentSpeechHouseDadLockdownText:
	text "I give up."

	para "I'm ordering two"
	line "salads from"
	cont "OLIVINE CAFE."
	done

OlivinePunishmentSpeechHouseDaughterText:
	text "Whenever I get in"
	line "trouble, Daddy"
	cont "always scares me."
	done

OlivinePunishmentSpeechHouseDaughterLockdownText:
	text "I'm afraid Daddy's"
	line "no good cook…"
	done

OlivinePunishmentSpeechHouseComputerText:
	text "There's a 1 minute"
	line "video tutorial on"
	cont "how to boil pasta."
	done

OlivinePunishmentSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 5
	warp_event  3,  7, OLIVINE_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, OlivinePunishmentSpeechHouseBookshelf1
	bg_event  1,  1, BGEVENT_READ, OlivinePunishmentSpeechHouseBookshelf2

	def_object_events
	object_event  1,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePunishmentSpeechHouseDad, -1
	object_event  5,  5, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePunishmentSpeechHouseDaughter, -1
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePunishmentSpeechHouseDadLockdown, -1
	object_event  4,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePunishmentSpeechHouseComputerScript, -1
