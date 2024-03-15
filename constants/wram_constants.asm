; wInputType::
AUTO_INPUT EQU $ff

; wDebugFlags::
	const_def
	const DEBUG_BATTLE_F
	const DEBUG_FIELD_F

; wCurDexMode::
	const_def
	const DEXMODE_NEW
	const DEXMODE_OLD
	const DEXMODE_ABC
	const DEXMODE_UNOWN

; wMonType::
	const_def
	const PARTYMON    ; 0
	const OTPARTYMON  ; 1
	const BOXMON      ; 2
	const TEMPMON     ; 3
	const WILDMON     ; 4
	const HOSPITALMON ; 5

; wGameTimerPaused::
GAME_TIMER_PAUSED_F EQU 0
GAME_TIMER_MOBILE_F EQU 7

; wJoypadDisable::
JOYPAD_DISABLE_MON_FAINT_F    EQU 6
JOYPAD_DISABLE_SGB_TRANSFER_F EQU 7

; wOptions1::
TEXT_DELAY_MASK EQU %111
	const_def 3
	const FAST_BOOT      ; 3
	const NO_TEXT_SCROLL ; 4
	const STEREO         ; 5
	const BATTLE_SHIFT   ; 6
	const BATTLE_SCENE   ; 7

TEXT_DELAY_FAST EQU %000 ; 0
TEXT_DELAY_MED  EQU %001 ; 1
TEXT_DELAY_SLOW EQU %011 ; 3

; wTextboxFrame::
	const_def
	const FRAME_1 ; 0
	const FRAME_2 ; 1
	const FRAME_3 ; 2
	const FRAME_4 ; 3
	const FRAME_5 ; 4
	const FRAME_6 ; 5
	const FRAME_7 ; 6
	const FRAME_8 ; 7
NUM_FRAMES EQU const_value

; wTextboxFlags::
	const_def
	const FAST_TEXT_DELAY_F ; 0
	const NO_TEXT_DELAY_F   ; 1

; wGBPrinterBrightness::
GBPRINTER_LIGHTEST EQU $00
GBPRINTER_LIGHTER  EQU $20
GBPRINTER_NORMAL   EQU $40
GBPRINTER_DARKER   EQU $60
GBPRINTER_DARKEST  EQU $7f

; wOptions2::
	const_def
	const MENU_ACCOUNT ; 0
	const FIELD_MOVES  ; 1

; wWalkingDirection::
	const_def -1
	const STANDING ; -1
	const DOWN     ; 0
	const UP       ; 1
	const LEFT     ; 2
	const RIGHT    ; 3
NUM_DIRECTIONS EQU const_value

DOWN_MASK  EQU 1 << DOWN
UP_MASK    EQU 1 << UP
LEFT_MASK  EQU 1 << LEFT
RIGHT_MASK EQU 1 << RIGHT

; wFacingDirection::
	const_def NUM_DIRECTIONS - 1, -1
	shift_const FACE_DOWN  ; 8
	shift_const FACE_UP    ; 4
	shift_const FACE_LEFT  ; 2
	shift_const FACE_RIGHT ; 1
FACE_CURRENT EQU 0

; wPokemonWithdrawDepositParameter::
PC_WITHDRAW       EQU 0
PC_DEPOSIT        EQU 1
REMOVE_PARTY      EQU 0
REMOVE_BOX        EQU 1
REMOVE_HOSPITAL   EQU 2
DAY_CARE_WITHDRAW EQU 2
DAY_CARE_DEPOSIT  EQU 3
HOSPITAL_WITHDRAW EQU 4
HOSPITAL_DEPOSIT  EQU 5

; wPlayerStepFlags::
	const_def 4
	const PLAYERSTEP_MIDAIR_F   ; 4
	const PLAYERSTEP_CONTINUE_F ; 5
	const PLAYERSTEP_STOP_F     ; 6
	const PLAYERSTEP_START_F    ; 7

; wInitListType::
INIT_ENEMYOT_LIST    EQU 1
INIT_BAG_ITEM_LIST   EQU 2
INIT_OTHER_ITEM_LIST EQU 3
INIT_PLAYEROT_LIST   EQU 4
INIT_MON_LIST        EQU 5

; wTimeOfDay::
	const_def
	const MORN_F     ; 0
	const DAY_F      ; 1
	const NITE_F     ; 2
	const DARKNESS_F ; 3
NUM_DAYTIMES EQU const_value

MORN     EQU 1 << MORN_F
DAY      EQU 1 << DAY_F
NITE     EQU 1 << NITE_F
DARKNESS EQU 1 << DARKNESS_F

ANYTIME EQU MORN | DAY | NITE

; wTimeOfDayPalset::
DARKNESS_PALSET EQU (DARKNESS_F << 6) | (DARKNESS_F << 4) | (DARKNESS_F << 2) | DARKNESS_F

; wBattleAnimFlags::
	const_def
	const BATTLEANIM_STOP_F          ; 0
	const BATTLEANIM_IN_SUBROUTINE_F ; 1
	const BATTLEANIM_IN_LOOP_F       ; 2
	const BATTLEANIM_KEEPSPRITES_F   ; 3

; wPlayerSpriteSetupFlags::
PLAYERSPRITESETUP_FACING_MASK       EQU %11
PLAYERSPRITESETUP_FEMALE_TO_MALE_F  EQU 2
PLAYERSPRITESETUP_CUSTOM_FACING_F   EQU 5
PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F EQU 6
PLAYERSPRITESETUP_RESET_ACTION_F    EQU 7

; wPlayerGender::
PLAYERGENDER_FEMALE_F EQU 0

; wMapStatus::
	const_def
	const MAPSTATUS_START  ; 0
	const MAPSTATUS_ENTER  ; 1
	const MAPSTATUS_HANDLE ; 2
	const MAPSTATUS_DONE   ; 3

; wMapEventStatus::
	const_def
	const MAPEVENTS_ON  ; 0
	const MAPEVENTS_OFF ; 1

; wScriptFlags::
SCRIPT_RUNNING EQU 2

; wScriptMode::
	const_def
	const SCRIPT_OFF
	const SCRIPT_READ
	const SCRIPT_WAIT_MOVEMENT
	const SCRIPT_WAIT

; wSpawnAfterChampion::
SPAWN_LANCE EQU 1
SPAWN_RED   EQU 2

; wCurDay::
	const_def
	const SUNDAY    ; 0
	const MONDAY    ; 1
	const TUESDAY   ; 2
	const WEDNESDAY ; 3
	const THURSDAY  ; 4
	const FRIDAY    ; 5
	const SATURDAY  ; 6

; wStatusFlags::
	const_def
	const STATUSFLAGS_POKEDEX_F                  ; 0
	const STATUSFLAGS_UNOWN_DEX_F                ; 1
	const STATUSFLAGS_FLASH_F                    ; 2
	const STATUSFLAGS_CAUGHT_POKERUS_F           ; 3
	const STATUSFLAGS_ROCKET_SIGNAL_F            ; 4
	const STATUSFLAGS_NO_WILD_ENCOUNTERS_F       ; 5
	const STATUSFLAGS_HALL_OF_FAME_F             ; 6
	const STATUSFLAGS_MAIN_MENU_MOBILE_CHOICES_F ; 7

; wStatusFlags2::
	const_def
	const STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F ; 0
	const STATUSFLAGS2_SAFARI_GAME_F            ; 1
	const STATUSFLAGS2_BUG_CONTEST_TIMER_F      ; 2
	const STATUSFLAGS2_TRAINER_CARD             ; 3
	const STATUSFLAGS2_BIKE_SHOP_CALL_F         ; 4
	const STATUSFLAGS2_WEARING_FACE_MASK_F      ; 5
	const STATUSFLAGS2_REACHED_GOLDENROD_F      ; 6
	const STATUSFLAGS2_ROCKETS_IN_MAHOGANY_F    ; 7

; wMomSavingMoney::
MOM_SAVING_SOME_MONEY_F EQU 0
MOM_SAVING_HALF_MONEY_F EQU 1
MOM_SAVING_ALL_MONEY_F  EQU 2
MOM_ACTIVE_F            EQU 7

MOM_SAVING_MONEY_MASK EQU (1 << MOM_SAVING_SOME_MONEY_F) | (1 << MOM_SAVING_HALF_MONEY_F) | (1 << MOM_SAVING_ALL_MONEY_F)

; wJohtoBadges::
	const_def
	const ZEPHYRBADGE
	const HIVEBADGE
	const PLAINBADGE
	const FOGBADGE
	const MINERALBADGE
	const STORMBADGE
	const GLACIERBADGE
	const RISINGBADGE
NUM_JOHTO_BADGES EQU const_value

; wKantoBadges::
	const_def
	const BOULDERBADGE
	const CASCADEBADGE
	const THUNDERBADGE
	const RAINBOWBADGE
	const SOULBADGE
	const MARSHBADGE
	const VOLCANOBADGE
	const EARTHBADGE
NUM_KANTO_BADGES EQU const_value
NUM_BADGES EQU NUM_JOHTO_BADGES + NUM_KANTO_BADGES

; wPokegearFlags::
	const_def
	const POKEGEAR_MAP_CARD_F   ; 0
	const POKEGEAR_RADIO_CARD_F ; 1
	const POKEGEAR_PHONE_CARD_F ; 2
	const POKEGEAR_EXPN_CARD_F  ; 3
	const DISPLAY_YEAR_AT_START_F ; 4 -> very hacky, but at least I'm using unused space.
	const CELEBIEVENT_FOREST_IS_RESTLESS_F ; 5 -> saves 1 byte in WRAM 1.
	const_skip
	const POKEGEAR_OBTAINED_F   ; 7

; wWhichRegisteredItem::
REGISTERED_POCKET EQU %11000000
REGISTERED_NUMBER EQU %00111111

; wPlayerState::
PLAYER_NORMAL    EQU 0
PLAYER_BIKE      EQU 1
PLAYER_SKATE     EQU 2
PLAYER_SURF      EQU 4
PLAYER_SURF_PIKA EQU 8

; wBikeFlags::
	const_def
	const BIKEFLAGS_STRENGTH_ACTIVE_F ; 0
	const BIKEFLAGS_ALWAYS_ON_BIKE_F  ; 1
	const BIKEFLAGS_DOWNHILL_F        ; 2

; wDailyFlags1::
	const_def
	const DAILYFLAGS1_KURT_MAKING_BALLS_F             ; 0
	const DAILYFLAGS1_BUG_CONTEST_F                   ; 1
	const DAILYFLAGS1_FISH_SWARM_F                    ; 2
	const DAILYFLAGS1_EON_MAIL_F                  	  ; 3
	const DAILYFLAGS1_UNUSED_2_F	                  ; 4
	const DAILYFLAGS1_GOT_SHUCKIE_TODAY_F             ; 5
	const DAILYFLAGS1_GOLDENROD_UNDERGROUND_BARGAIN_F ; 6
	const DAILYFLAGS1_TRAINER_HOUSE_F                 ; 7

; wDailyFlags2::
	const_def
	const DAILYFLAGS2_MT_MOON_SQUARE_CLEFAIRY_F           ; 0
	const DAILYFLAGS2_UNION_CAVE_LAPRAS_F                 ; 1
	const DAILYFLAGS2_GOLDENROD_UNDERGROUND_GOT_HAIRCUT_F ; 2
	const DAILYFLAGS2_GOLDENROD_DEPT_STORE_TM27_RETURN_F  ; 3
	const DAILYFLAGS2_DAISYS_GROOMING_F                   ; 4
	const DAILYFLAGS2_INDIGO_PLATEAU_RIVAL_FIGHT_F        ; 5
	const DAILYFLAGS2_MOVE_TUTOR_F                        ; 6
	const DAILYFLAGS2_BUENAS_PASSWORD_F                   ; 7

; wDailyFlags3::
	const_def
	const DAILYFLAGS3_TOOK_DRINK_FROM_FRIDGE_F	; 0
	const DAILYFLAGS3_PLAYER_SCARED_DAYCARE_F  	; 1
	const DAILYFLAGS3_SCALPER_F					; 2
	const DAILYFLAGS3_OLIVINE_CAFE_F  			; 3
	const DAILYFLAGS3_UNUSED_4_F                ; 4
	const DAILYFLAGS3_UNUSED_5_F        		; 5
	const DAILYFLAGS3_UNUSED_6_F                ; 6
	const DAILYFLAGS3_UNUSED_7_F                ; 7

; wSwarmFlags::
	const_def
	const SWARMFLAGS_BUENAS_PASSWORD_F           ; 0
	const SWARMFLAGS_GOLDENROD_DEPT_STORE_SALE_F ; 1
	const SWARMFLAGS_DUNSPARCE_SWARM_F           ; 2
	const SWARMFLAGS_YANMA_SWARM_F               ; 3
	const SWARMFLAGS_MOBILE_4_F                  ; 4

; wLuckyNumberShowFlag::
LUCKYNUMBERSHOW_GAME_OVER_F EQU 0

; wDayCareMan::
DAYCAREMAN_HAS_MON_F         EQU 0
DAYCAREMAN_MONS_COMPATIBLE_F EQU 5
DAYCAREMAN_HAS_EGG_F         EQU 6
DAYCAREMAN_ACTIVE_F          EQU 7

; wDayCareLady::
DAYCARELADY_HAS_MON_F        EQU 0
DAYCARELADY_ACTIVE_F         EQU 7
