; object constants
PLAYER      EQU  0
LAST_TALKED EQU -2

; string buffer constants
	const_def
	const STRING_BUFFER_3 ; use wStringBuffer3
	const STRING_BUFFER_4 ; use wStringBuffer4
	const STRING_BUFFER_5 ; use wStringBuffer5
NUM_STRING_BUFFERS EQU const_value

STRING_BUFFER_LENGTH EQU 19

; checkmoney/takemoney accounts
	const_def
	const YOUR_MONEY ; 0
	const MOMS_MONEY ; 1

; checkmoney/checkcoins return values
	const_def
	const HAVE_MORE   ; 0
	const HAVE_AMOUNT ; 1
	const HAVE_LESS   ; 2

; checkpokemail return values
	const_def
	const POKEMAIL_WRONG_MAIL ; 0
	const POKEMAIL_CORRECT    ; 1
	const POKEMAIL_REFUSED    ; 2
	const POKEMAIL_NO_MAIL    ; 3
	const POKEMAIL_LAST_MON   ; 4

; askforphonenumber return values
	const_def
	const PHONE_CONTACT_GOT     ; 0
	const PHONE_CONTACTS_FULL   ; 1
	const PHONE_CONTACT_REFUSED ; 2

; trainertext arguments
	const_def
	const TRAINERTEXT_SEEN
	const TRAINERTEXT_WIN
	const TRAINERTEXT_LOSS

; readvar/writevar/loadvar arguments
; _GetVarAction.VarActionTable indexes (see engine/overworld/variables.asm)
	const_def
	const VAR_STRINGBUFFER2    ; 00
	const VAR_PARTYCOUNT       ; 01
	const VAR_BATTLERESULT     ; 02
	const VAR_BATTLETYPE       ; 03
	const VAR_TIMEOFDAY        ; 04
	const VAR_DEXCAUGHT        ; 05
	const VAR_DEXSEEN          ; 06
	const VAR_BADGES           ; 07
	const VAR_MOVEMENT         ; 08
	const VAR_FACING           ; 09
	const VAR_HOUR             ; 0a
	const VAR_WEEKDAY          ; 0b
	const VAR_MAPGROUP         ; 0c
	const VAR_MAPNUMBER        ; 0d
	const VAR_UNOWNCOUNT       ; 0e
	const VAR_ENVIRONMENT      ; 0f
	const VAR_BOXSPACE         ; 10
	const VAR_CONTESTMINUTES   ; 11
	const VAR_XCOORD           ; 12
	const VAR_YCOORD           ; 13
	const VAR_SPECIALPHONECALL ; 14
	const VAR_BT_WIN_STREAK    ; 15
	const VAR_KURT_APRICORNS   ; 16
	const VAR_CALLERID         ; 17
	const VAR_BLUECARDBALANCE  ; 18
	const VAR_BUENASPASSWORD   ; 19
	const VAR_KENJI_BREAK      ; 1a
NUM_VARS EQU const_value           ; 1b

; variable action types
RETVAR_STRBUF2 EQU 0 << 6
RETVAR_ADDR_DE EQU 1 << 6
RETVAR_EXECUTE EQU 2 << 6

; PlayerEventScriptPointers indexes (see engine/overworld/events.asm)
	const_def -1
	const PLAYEREVENT_MAPSCRIPT
	const PLAYEREVENT_NONE
	const PLAYEREVENT_SEENBYTRAINER
	const PLAYEREVENT_TALKTOTRAINER
	const PLAYEREVENT_ITEMBALL
	const PLAYEREVENT_CONNECTION
	const PLAYEREVENT_WARP
	const PLAYEREVENT_FALL
	const PLAYEREVENT_WHITEOUT
	const PLAYEREVENT_HATCH
	const PLAYEREVENT_JOYCHANGEFACING
NUM_PLAYER_EVENTS EQU const_value

; PlayerMovementPointers indexes (see engine/overworld/events.asm)
	const_def
	const PLAYERMOVEMENT_NORMAL
	const PLAYERMOVEMENT_WARP
	const PLAYERMOVEMENT_TURN
	const PLAYERMOVEMENT_FORCE_TURN
	const PLAYERMOVEMENT_FINISH
	const PLAYERMOVEMENT_CONTINUE
	const PLAYERMOVEMENT_EXIT_WATER
	const PLAYERMOVEMENT_JUMP
NUM_PLAYER_MOVEMENTS EQU const_value

; script data sizes (see macros/scripts/maps.asm)
SCENE_SCRIPT_SIZE EQU  2 ; scene_script
CALLBACK_SIZE     EQU  3 ; callback
WARP_EVENT_SIZE   EQU  5 ; warp_event
COORD_EVENT_SIZE  EQU  6 ; coord_event
BG_EVENT_SIZE     EQU  5 ; bg_event
OBJECT_EVENT_SIZE EQU 13 ; object_event

; coord_event types
; See CheckCurrentMapCoordEvents in home/map.asm
	const_def
	const CE_SCENE_ID
	const CE_EVENT_FLAG_CLEARED
	const CE_EVENT_FLAG_SET
	const CE_GOT_ITEM
	const CE_MISSING_ITEM

	const_next 15
	const CE_ALWAYS
NUM_COORD_EVENT_TYPES EQU const_value
assert NUM_COORD_EVENT_TYPES - 1 <= $f

; bg_event types
; BGEventJumptable indexes (see engine/overworld/events.asm)
	const_def
	const BGEVENT_READ
	const BGEVENT_UP
	const BGEVENT_DOWN
	const BGEVENT_RIGHT
	const BGEVENT_LEFT
	const BGEVENT_IFSET
	const BGEVENT_IFNOTSET
	const BGEVENT_ITEM
	const BGEVENT_COPY
	const BGEVENT_CLOSED_DOOR
NUM_BGEVENTS EQU const_value

; object_event types
; ObjectEventTypeArray indexes (see engine/overworld/events.asm)
	const_def
	const OBJECTTYPE_SCRIPT
	const OBJECTTYPE_ITEMBALL
	const OBJECTTYPE_TRAINER
	const OBJECTTYPE_3
	const OBJECTTYPE_4
	const OBJECTTYPE_5
	const OBJECTTYPE_6
NUM_OBJECT_TYPES EQU const_value

; command queue members
CMDQUEUE_TYPE  EQU 0
CMDQUEUE_ADDR  EQU 1
CMDQUEUE_02    EQU 2
CMDQUEUE_03    EQU 3
CMDQUEUE_04    EQU 4
CMDQUEUE_05    EQU 5
CMDQUEUE_ENTRY_SIZE EQU 6
CMDQUEUE_CAPACITY EQU 4

; HandleQueuedCommand.Jumptable indexes (see engine/overworld/events.asm)
	const_def
	const CMDQUEUE_NULL
	const CMDQUEUE_TYPE1
	const CMDQUEUE_STONETABLE
	const CMDQUEUE_TYPE3
	const CMDQUEUE_TYPE4
	const CMDQUEUE_SOKOBAN
NUM_CMDQUEUE_TYPES EQU const_value

; elevfloor macro values
; ElevatorFloorNames indexes (see data/events/elevator_floors.asm)
	const_def
	const FLOOR_B4F
	const FLOOR_B3F
	const FLOOR_B2F
	const FLOOR_B1F
	const FLOOR_1F
	const FLOOR_2F
	const FLOOR_3F
	const FLOOR_4F
	const FLOOR_5F
	const FLOOR_6F
	const FLOOR_7F
	const FLOOR_8F
	const FLOOR_9F
	const FLOOR_10F
	const FLOOR_11F
	const FLOOR_ROOF
NUM_FLOORS EQU const_value

; showemote arguments
; Emotes indexes (see data/sprites/emotes.asm)
	const_def
	const EMOTE_SHOCK
	const EMOTE_QUESTION
	const EMOTE_HAPPY
	const EMOTE_SAD
	const EMOTE_HEART
	const EMOTE_BOLT
	const EMOTE_SLEEP
	const EMOTE_FISH
	const EMOTE_SHADOW
	const EMOTE_ROD
	const EMOTE_BOULDER_DUST
	const EMOTE_GRASS_RUSTLE
	const EMOTE_SPRINKLE_1
	const EMOTE_SPRINKLE_2
	const EMOTE_SPRINKLE_3
	const EMOTE_SPRINKLE_4
NUM_EMOTES EQU const_value
EMOTE_FROM_MEM EQU -1
EMOTE_LENGTH EQU 6

; fruittree arguments
; FruitTreeItems indexes (see data/items/fruit_trees.asm)
	const_def 1
	const FRUITTREE_ROUTE_29      		; 01
	const FRUITTREE_ROUTE_30_1    		; 02
	const FRUITTREE_ROUTE_38      		; 03
	const FRUITTREE_ROUTE_46_1    		; 04
	const FRUITTREE_ROUTE_30_2    		; 05
	const FRUITTREE_ROUTE_33      		; 06
	const FRUITTREE_ROUTE_31      		; 07
	const FRUITTREE_ROUTE_43      		; 08
	const FRUITTREE_VIOLET_CITY   		; 09
	const FRUITTREE_ROUTE_46_2    		; 0a
	const FRUITTREE_ROUTE_35      		; 0b
	const FRUITTREE_ROUTE_45      		; 0c
	const FRUITTREE_ROUTE_36      		; 0d
	const FRUITTREE_ROUTE_26      		; 0e
	const FRUITTREE_ROUTE_39      		; 0f
	const FRUITTREE_ROUTE_44      		; 10
	const FRUITTREE_ROUTE_37_1    		; 11
	const FRUITTREE_ROUTE_37_2    		; 12
	const FRUITTREE_ROUTE_37_3    		; 13
	const FRUITTREE_AZALEA_TOWN   		; 14
	const FRUITTREE_ROUTE_42_1    		; 15
	const FRUITTREE_ROUTE_42_2    		; 16
	const FRUITTREE_ROUTE_42_3    		; 17
	const FRUITTREE_ROUTE_11      		; 18
	const FRUITTREE_ROUTE_1       		; 19
	const FRUITTREE_ROUTE_8       		; 1a
	const FRUITTREE_PEWTER_CITY_1 		; 1b
	const FRUITTREE_PEWTER_CITY_2 		; 1c
	const FRUITTREE_FUCHSIA_CITY  		; 1d
	const FRUITTREE_ROUTE_12  	  		; 1e
	const FRUITTREE_VIRIDIAN_FOREST_1   ; 1f
	const FRUITTREE_VIRIDIAN_FOREST_2   ; 20
	const FRUITTREE_VIRIDIAN_FOREST_3   ; 21
	const FRUITTREE_VIRIDIAN_FOREST_4   ; 22
	const FRUITTREE_VIRIDIAN_FOREST_5   ; 23
	const FRUITTREE_VIRIDIAN_FOREST_6   ; 24
	const FRUITTREE_ROUTE_15        	; 25
	const FRUITTREE_ROUTE_11_2      	; 26
	const FRUITTREE_SAFARI_ZONE        	; 27
	const FRUITTREE_PEWTER_CITY_3   	; 28
NUM_FRUIT_TREES EQU const_value - 1

; describedecoration arguments
; DescribeDecoration.JumpTable indexes (see engine/overworld/decorations.asm)
	const_def
	const DECODESC_POSTER     ; 0
	const DECODESC_LEFT_DOLL  ; 1
	const DECODESC_RIGHT_DOLL ; 2
	const DECODESC_BIG_DOLL   ; 3
	const DECODESC_CONSOLE    ; 4
NUM_DECODESCS EQU const_value

; swarm arguments
; StoreSwarmMapIndices arguments
	const_def
	const SWARM_DUNSPARCE ; 0
	const SWARM_YANMA     ; 1

; ActivateFishingSwarm setval arguments
	const_def
	const FISHSWARM_NONE     ; 0
	const FISHSWARM_QWILFISH ; 1
	const FISHSWARM_REMORAID ; 2

; SpecialGameboyCheck return values
	const_def
	const GBCHECK_GB  ; 0
	const GBCHECK_SGB ; 1
	const GBCHECK_CGB ; 2

; CheckMagikarpLength return values
	const_def
	const MAGIKARPLENGTH_NOT_MAGIKARP ; 0
	const MAGIKARPLENGTH_REFUSED      ; 1
	const MAGIKARPLENGTH_TOO_SHORT    ; 2
	const MAGIKARPLENGTH_BEAT_RECORD  ; 3

; ReturnShuckie return values
	const_def
	const SHUCKIE_WRONG_MON ; 0
	const SHUCKIE_REFUSED   ; 1
	const SHUCKIE_RETURNED  ; 2
	const SHUCKIE_HAPPY     ; 3
	const SHUCKIE_FAINTED   ; 4

; CheckPartyFullAfterContest return values
	const_def
	const BUGCONTEST_CAUGHT_MON ; 0
	const BUGCONTEST_BOXED_MON  ; 1
	const BUGCONTEST_NO_CATCH   ; 2

; Bug-Catching Contest values
BUG_CONTEST_BALLS EQU 20
BUG_CONTEST_MINUTES EQU 20
BUG_CONTEST_SECONDS EQU 0
BUG_CONTEST_PLAYER EQU 1
NUM_BUG_CONTESTANTS EQU 10 ; not counting the player
BUG_CONTESTANT_SIZE EQU 4

; HealMachineAnim setval arguments
; HealMachineAnim.Pointers indexes (see engine/events/heal_machine_anim.asm)
	const_def
	const HEALMACHINE_POKECENTER   ; 0
	const HEALMACHINE_ELMS_LAB     ; 1
	const HEALMACHINE_HALL_OF_FAME ; 2

; UnownPuzzle setval arguments
; LoadUnownPuzzlePiecesGFX.LZPointers indexes (see engine/games/unown_puzzle.asm)
	const_def
	const UNOWNPUZZLE_KABUTO     ; 0
	const UNOWNPUZZLE_OMANYTE    ; 1
	const UNOWNPUZZLE_AERODACTYL ; 2
	const UNOWNPUZZLE_HO_OH      ; 3
NUM_UNOWN_PUZZLES EQU const_value

; DisplayUnownWords setval arguments
; UnownWalls and MenuHeaders_UnownWalls indexes (see data/events/unown_walls.asm)
	const_def
	const UNOWNWORDS_ESCAPE ; 0
	const UNOWNWORDS_LIGHT  ; 1
	const UNOWNWORDS_WATER  ; 2
	const UNOWNWORDS_HO_OH  ; 3

; MoveTutor setval arguments
	const_def 1
	const MOVETUTOR_FLAMETHROWER ; 1
	const MOVETUTOR_THUNDERBOLT  ; 2
	const MOVETUTOR_ICE_BEAM     ; 3

; selectmonforvaccination return values
	const_def 16

	const VACCINATION_CANCEL 				; 16: NOT ACCEPTABLE
	const VACCINATION_NEVER_GOT_COVID 		; 17: ACCEPTABLE
	const VACCINATION_PREVIOUSLY_GOT_COVID 	; 18: ACCEPTABLE
	const VACCINATION_GOT_FIRST_SHOT		; 19: ACCEPTABLE
	const VACCINATION_CURRENTLY_SICK    	; 20: NOT ACCEPTABLE
	const VACCINATION_FULLY_VACCINATED    	; 21: NOT ACCEPTABLE
	const VACCINATION_IS_EGG   				; 22: NOT ACCEPTABLE

; TellCovidVariant return values (in wScriptVar)
	const_def

	const VARIANT_TELLING_CANCEL							; 0
	const VARIANT_TELLING_NEVER_GOT_COVID_OR_TOO_LONG_AGO	; 1
	const VARIANT_TELLING_IS_VACCINATED						; 2
	const VARIANT_TELLING_TELL								; 3
