INCLUDE "engine/gfx/sgb_layouts.asm"

SHINY_ATK_BIT EQU 5
SHINY_DEF_VAL EQU 10
SHINY_SPD_VAL EQU 10
SHINY_SPC_VAL EQU 10

CheckShininess:
; Check if a mon is shiny by DVs at bc.
; Return carry if shiny.

	ld l, c
	ld h, b

; Attack
	ld a, [hl]
	and 1 << SHINY_ATK_BIT
	jr z, .not_shiny

; Defense
	ld a, [hli]
	and $f
	cp  SHINY_DEF_VAL
	jr nz, .not_shiny

; Speed
	ld a, [hl]
	and $f0
	cp  SHINY_SPD_VAL << 4
	jr nz, .not_shiny

; Special
	ld a, [hl]
	and $f
	cp  SHINY_SPC_VAL
	jr nz, .not_shiny

; shiny
	scf
	ret

.not_shiny
	and a
	ret

Unused_CheckShininess:
; Return carry if the DVs at hl are all 10 or higher.

; Attack
	ld a, [hl]
	cp 10 << 4
	jr c, .not_shiny

; Defense
	ld a, [hli]
	and $f
	cp 10
	jr c, .not_shiny

; Speed
	ld a, [hl]
	cp 10 << 4
	jr c, .not_shiny

; Special
	ld a, [hl]
	and $f
	cp 10
	jr c, .not_shiny

; shiny
	scf
	ret

.not_shiny
	and a
	ret

SGB_ApplyCreditsPals: ; unreferenced
	push de
	push bc
	ld hl, PalPacket_Pal01
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop bc
	pop de
	ld a, c
	ld [wSGBPals + 3], a
	ld a, b
	ld [wSGBPals + 4], a
	ld a, e
	ld [wSGBPals + 5], a
	ld a, d
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	call PushSGBPals
	ld hl, BlkPacket_AllPal0
	call PushSGBPals
	ret

InitPartyMenuPalettes:
	ld hl, PalPacket_PartyMenu + 1
	call CopyFourPalettes
	call InitPartyMenuOBPals
	call WipeAttrmap
	ret

; SGB layout for SCGB_PARTY_MENU_HP_BARS
SGB_ApplyPartyMenuHPPals:
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, $5
	jr z, .okay
	dec a
	ld e, $a
	jr z, .okay
	ld e, $f
.okay
	push de
	ld hl, wSGBPals + 10
	ld bc, $6
	ld a, [wSGBPals]
	call AddNTimes
	pop de
	ld [hl], e
	ret

Intro_LoadMagikarpPalettes: ; unreferenced
	call CheckCGB
	ret z

; CGB only
	ld hl, .MagikarpBGPal
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM

	ld hl, .MagikarpOBPal
	ld de, wOBPals1
	ld bc, 1 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM

	call ApplyPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.MagikarpBGPal:
INCLUDE "gfx/intro/gs_magikarp_bg.pal"

.MagikarpOBPal:
INCLUDE "gfx/intro/gs_magikarp_ob.pal"

Intro_LoadAllPal0: ; unreferenced
	call CheckCGB
	ret nz
	ldh a, [hSGB]
	and a
	ret z
	ld hl, BlkPacket_AllPal0
	jp PushSGBPals

Intro_LoadBetaIntroVenusaurPalettes: ; unreferenced
	call CheckCGB
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z
	ld hl, PalPacket_BetaIntroVenusaur
	jp PushSGBPals

.cgb
	ld de, wOBPals1
	ld a, PREDEFPAL_BETA_INTRO_VENUSAUR
	call GetPredefPal
	jp LoadHLPaletteIntoDE

Intro_LoadPackPalettes: ; unreferenced
	call CheckCGB
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z
	ld hl, PalPacket_Pack
	jp PushSGBPals

.cgb
	ld de, wOBPals1
	ld a, PREDEFPAL_PACK
	call GetPredefPal
	jp LoadHLPaletteIntoDE

GSIntro_LoadMonPalette: ; unreferenced
	call CheckCGB
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z
	ld a, c
	push af
	ld hl, PalPacket_Pal01
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop af
	call GetMonPalettePointer
	ld a, [hli]
	ld [wSGBPals + 3], a
	ld a, [hli]
	ld [wSGBPals + 4], a
	ld a, [hli]
	ld [wSGBPals + 5], a
	ld a, [hl]
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	jp PushSGBPals

.cgb
	ld de, wOBPals1
	ld a, c
	call GetMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ret

LoadTrainerClassPaletteAsNthBGPal:
	ld a, [wTrainerClass]
	call GetTrainerPalettePointer
	ld a, e
	jr LoadNthMiddleBGPal

LoadMonPaletteAsNthBGPal:
	ld a, [wCurPartySpecies]
	call _GetMonPalettePointer
	ld a, e
	bit 7, a
	jr z, LoadNthMiddleBGPal
	and $7f
	inc hl
	inc hl
	inc hl
	inc hl

LoadNthMiddleBGPal:
	push hl
	ld hl, wBGPals1
	ld de, 1 palettes
.loop
	and a
	jr z, .got_addr
	add hl, de
	dec a
	jr .loop

.got_addr
	ld e, l
	ld d, h
	pop hl
	call LoadPalette_White_Col1_Col2_Black
	ret

LoadBetaPokerPalettes: ; unreferenced
	ldh a, [hCGB]
	and a
	jr nz, .cgb
	ld hl, wBetaPokerSGBPals
	jp PushSGBPals

.cgb
	ld a, [wBetaPokerSGBCol]
	ld c, a
	ld a, [wBetaPokerSGBRow]
	hlcoord 0, 0, wAttrmap
	ld de, SCREEN_WIDTH
.loop
	and a
	jr z, .done
	add hl, de
	dec a
	jr .loop

.done
	ld b, 0
	add hl, bc
	lb bc, 6, 4
	ld a, [wBetaPokerSGBAttr]
	and $3
	call FillBoxCGB
	call CopyTilemapAtOnce
	ret

ApplyMonOrTrainerPals:
	call CheckCGB
	ret z
	ld a, e
	and a
	jr z, .get_trainer
	ld a, [wCurPartySpecies]
	call GetMonPalettePointer
	jr .load_palettes

.get_trainer
	ld a, [wTrainerClass]
	call GetTrainerPalettePointer

.load_palettes
	ld de, wBGPals1
	call LoadPalette_White_Col1_Col2_Black
	call WipeAttrmap
	call ApplyAttrmap
	call ApplyPals
	ret

ApplyHPBarPals:
	ld a, [wWhichHPBar]
	and a
	jr z, .Enemy
	cp $1
	jr z, .Player
	cp $2
	jr z, .PartyMenu
	ret

.Enemy:
	ld de, wBGPals2 palette PAL_BATTLE_BG_ENEMY_HP color 1
	jr .okay

.Player:
	ld de, wBGPals2 palette PAL_BATTLE_BG_PLAYER_HP color 1

.okay
	ld l, c
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarPals
	add hl, bc
	ld bc, 4
	ld a, BANK(wBGPals2)
	call FarCopyWRAM
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.PartyMenu:
	ld e, c
	inc e
	hlcoord 11, 1, wAttrmap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wCurPartyMon]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop

.done
	lb bc, 2, 8
	ld a, e
	call FillBoxCGB
	ret

LoadStatsScreenPals:
	call CheckCGB
	ret z
	ld hl, StatsScreenPals
	ld b, 0
	dec c
	add hl, bc
	add hl, bc
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, [hli]
	ld [wBGPals1 palette 0], a
	ld [wBGPals1 palette 2], a
	ld a, [hl]
	ld [wBGPals1 palette 0 + 1], a
	ld [wBGPals1 palette 2 + 1], a
	pop af
	ldh [rSVBK], a
	call ApplyPals
	ld a, $1
	ret

LoadMailPalettes:
	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, .MailPals
	add hl, de
	call CheckCGB
	jr nz, .cgb
	push hl
	ld hl, PalPacket_Pal01
	ld de, wSGBPals
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop hl
	inc hl
	inc hl
	ld a, [hli]
	ld [wSGBPals + 3], a
	ld a, [hli]
	ld [wSGBPals + 4], a
	ld a, [hli]
	ld [wSGBPals + 5], a
	ld a, [hli]
	ld [wSGBPals + 6], a
	ld hl, wSGBPals
	call PushSGBPals
	ld hl, BlkPacket_AllPal0
	call PushSGBPals
	ret

.cgb
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	call ApplyPals
	call WipeAttrmap
	call ApplyAttrmap
	ret

.MailPals:
INCLUDE "gfx/mail/mail.pal"

INCLUDE "engine/gfx/cgb_layouts.asm"

CopyFourPalettes:
	ld de, wBGPals1
	ld c, 4

CopyPalettes:
.loop
	push bc
	ld a, [hli]
	push hl
	call GetPredefPal
	call LoadHLPaletteIntoDE
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

GetPredefPal:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PredefPals
	add hl, bc
	ret

LoadHLPaletteIntoDE:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld c, 1 palettes
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

LoadPalette_White_Col1_Col2_Black:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld a, LOW(PALRGB_WHITE)
	ld [de], a
	inc de
	ld a, HIGH(PALRGB_WHITE)
	ld [de], a
	inc de

	ld c, 2 * PAL_COLOR_SIZE
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop

	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de

	pop af
	ldh [rSVBK], a
	ret

FillBoxCGB:
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

ResetBGPals:
	push af
	push bc
	push de
	push hl

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld hl, wBGPals1
	ld c, 1 palettes
.loop
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .loop

	pop af
	ldh [rSVBK], a

	pop hl
	pop de
	pop bc
	pop af
	ret

WipeAttrmap:
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ret

ApplyPals:
	ld hl, wBGPals1
	ld de, wBGPals2
	ld bc, 16 palettes
	ld a, BANK(wGBCPalettes)
	call FarCopyWRAM
	ret

ApplyAttrmap:
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jr z, .UpdateVBank1
	ldh a, [hBGMapMode]
	push af
	ld a, $2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	ret

.UpdateVBank1:
	hlcoord 0, 0, wAttrmap
	debgcoord 0, 0
	ld b, SCREEN_HEIGHT
	ld a, $1
	ldh [rVBK], a
.row
	ld c, SCREEN_WIDTH
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
	ld a, BG_MAP_WIDTH - SCREEN_WIDTH
	add e
	jr nc, .okay
	inc d
.okay
	ld e, a
	dec b
	jr nz, .row
	ld a, $0
	ldh [rVBK], a
	ret

; CGB layout for SCGB_PARTY_MENU_HP_BARS
CGB_ApplyPartyMenuHPPals:
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	inc a
	ld e, a
	hlcoord 11, 2, wAttrmap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wSGBPals]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop
.done
	lb bc, 2, 8
	ld a, e
	call FillBoxCGB
	ret

InitPartyMenuOBPals:
	ld hl, PartyMenuOBPals
	ld de, wOBPals1
	ld bc, 8 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
	ret

GetBattlemonBackpicPalettePointer:
	push de
	farcall GetPartyMonDVs
	ld c, l
	ld b, h
	ld a, [wTempBattleMonSpecies]
	call GetPlayerOrMonPalettePointer
	pop de
	ret

GetEnemyFrontpicPalettePointer:
	push de
	farcall GetEnemyMonDVs
	ld c, l
	ld b, h
	ld a, [wTempEnemyMonSpecies]
	call GetFrontpicPalettePointer
	pop de
	ret

GetPlayerOrMonPalettePointer:
	and a
	jp nz, GetMonNormalOrShinyPalettePointer
	ld a, [wPlayerSpriteSetupFlags]
	bit PLAYERSPRITESETUP_FEMALE_TO_MALE_F, a
	jr nz, .male
	ld a, [wPlayerGender]
	and a
	jr z, .male
	ld hl, KrisPalette
	ret

.male
	ld hl, PlayerPalette
	ret

GetFrontpicPalettePointer:
	and a
	jp nz, GetMonNormalOrShinyPalettePointer
	ld a, [wTrainerClass]

GetTrainerPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, TrainerPalettes
	add hl, bc
	ret

GetMonPalettePointer:
	call _GetMonPalettePointer
	ret

CGBCopyBattleObjectPals: ; unreferenced
; dummied out
	ret
	call CheckCGB
	ret z
	ld hl, BattleObjectPals
	ld a, (1 << rOBPI_AUTO_INCREMENT) | $10
	ldh [rOBPI], a
	ld c, 6 palettes
.loop
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .loop
	ld hl, BattleObjectPals
	ld de, wOBPals1 palette 2
	ld bc, 2 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
	ret

BattleObjectPals:
INCLUDE "gfx/battle_anims/battle_anims.pal"

CGBCopyTwoPredefObjectPals: ; unreferenced
	call CheckCGB
	ret z
	ld a, (1 << rOBPI_AUTO_INCREMENT) | $10
	ldh [rOBPI], a
	ld a, PREDEFPAL_TRADE_TUBE
	call GetPredefPal
	call .PushPalette
	ld a, PREDEFPAL_RB_GREENMON
	call GetPredefPal
	call .PushPalette
	ret

.PushPalette:
	ld c, 1 palettes
.loop
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .loop
	ret

_GetMonPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PokemonPalettes
	add hl, bc
	ret

GetMonNormalOrShinyPalettePointer:
	push bc
	call _GetMonPalettePointer
	pop bc
	push hl
	call CheckShininess
	pop hl
	ret nc
rept 4
	inc hl
endr
	ret

PushSGBPals:
	ld a, [wJoypadDisable]
	push af
	set JOYPAD_DISABLE_SGB_TRANSFER_F, a
	ld [wJoypadDisable], a
	call _PushSGBPals
	pop af
	ld [wJoypadDisable], a
	ret

_PushSGBPals:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop
	push bc
	xor a
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	ld b, $10
.loop2
	ld e, $8
	ld a, [hli]
	ld d, a
.loop3
	bit 0, d
	ld a, $10
	jr nz, .okay
	ld a, $20
.okay
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .loop3
	dec b
	jr nz, .loop2
	ld a, $20
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	pop bc
	dec b
	jr nz, .loop
	ret

InitSGBBorder:
	call CheckCGB
	ret nz

; SGB/DMG only
	di
	ld a, [wJoypadDisable]
	push af
	set JOYPAD_DISABLE_SGB_TRANSFER_F, a
	ld [wJoypadDisable], a

	xor a
	ldh [rJOYP], a
	ldh [hSGB], a
	call PushSGBBorderPalsAndWait
	jr nc, .skip
	ld a, $1
	ldh [hSGB], a
	call _InitSGBBorderPals
	call SGBBorder_PushBGPals
	call SGBDelayCycles
	call SGB_ClearVRAM
	call PushSGBBorder
	call SGBDelayCycles
	call SGB_ClearVRAM
	ld hl, MaskEnCancelPacket
	call _PushSGBPals

.skip
	pop af
	ld [wJoypadDisable], a
	ei
	ret

InitCGBPals::
	call CheckCGB
	ret z

; CGB only
	ld a, BANK(vTiles3)
	ldh [rVBK], a
	ld hl, vTiles3
	ld bc, $200 tiles
	xor a
	call ByteFill
	ld a, BANK(vTiles0)
	ldh [rVBK], a
	ld a, 1 << rBGPI_AUTO_INCREMENT
	ldh [rBGPI], a
	ld c, 4 * 8
.bgpals_loop
	ld a, LOW(PALRGB_WHITE)
	ldh [rBGPD], a
	ld a, HIGH(PALRGB_WHITE)
	ldh [rBGPD], a
	dec c
	jr nz, .bgpals_loop
	ld a, 1 << rOBPI_AUTO_INCREMENT
	ldh [rOBPI], a
	ld c, 4 * 8
.obpals_loop
	ld a, LOW(PALRGB_WHITE)
	ldh [rOBPD], a
	ld a, HIGH(PALRGB_WHITE)
	ldh [rOBPD], a
	dec c
	jr nz, .obpals_loop
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	call .LoadWhitePals
	ld hl, wBGPals2
	call .LoadWhitePals
	pop af
	ldh [rSVBK], a
	ret

.LoadWhitePals:
	ld c, 4 * 16
.loop
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
	dec c
	jr nz, .loop
	ret

_InitSGBBorderPals:
	ld hl, .PacketPointerTable
	ld c, 9
.loop
	push bc
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call _PushSGBPals
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

.PacketPointerTable:
	dw MaskEnFreezePacket
	dw DataSndPacket1
	dw DataSndPacket2
	dw DataSndPacket3
	dw DataSndPacket4
	dw DataSndPacket5
	dw DataSndPacket6
	dw DataSndPacket7
	dw DataSndPacket8

UpdateSGBBorder: ; unreferenced
	di
	xor a
	ldh [rJOYP], a
	ld hl, MaskEnFreezePacket
	call _PushSGBPals
	call PushSGBBorder
	call SGBDelayCycles
	call SGB_ClearVRAM
	ld hl, MaskEnCancelPacket
	call _PushSGBPals
	ei
	ret

PushSGBBorder:
	call .LoadSGBBorderPointers
	push de
	call SGBBorder_YetMorePalPushing
	pop hl
	call SGBBorder_MorePalPushing
	ret

.LoadSGBBorderPointers:
	ld hl, SGBBorderGFX
	ld de, SGBBorderMapAndPalettes
	ret

SGB_ClearVRAM:
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	xor a
	call ByteFill
	ret

PushSGBBorderPalsAndWait:
	ld hl, MltReq2Packet
	call _PushSGBPals
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	ld a, $20
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $10
	ldh [rJOYP], a
rept 6
	ldh a, [rJOYP]
endr
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	call .FinalPush
	and a
	ret

.carry
	call .FinalPush
	scf
	ret

.FinalPush:
	ld hl, MltReq1Packet
	call _PushSGBPals
	jp SGBDelayCycles

SGBBorder_PushBGPals:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld hl, PredefPals
	ld de, vTiles1
	ld bc, $100 tiles
	call CopyData
	call DrawDefaultTiles
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld hl, PalTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_MorePalPushing:
	call DisableLCD
	ld a, $e4
	ldh [rBGP], a
	ld de, vTiles1
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld b, SCREEN_HEIGHT
.loop
	push bc
	ld bc, 6 * 2
	call CopyData
	ld bc, SCREEN_WIDTH * 2
	call ClearBytes
	ld bc, 6 * 2
	call CopyData
	pop bc
	dec b
	jr nz, .loop
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld bc, $100
	call ClearBytes
	ld bc, 16 palettes
	call CopyData
	call DrawDefaultTiles
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld hl, PctTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_YetMorePalPushing:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld de, vTiles1
	ld b, $80
.loop
	push bc
	ld bc, 1 tiles
	call CopyData
	ld bc, 1 tiles
	call ClearBytes
	pop bc
	dec b
	jr nz, .loop
	call DrawDefaultTiles
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ld hl, ChrTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

CopyData:
; copy bc bytes of data from hl to de
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

ClearBytes:
; clear bc bytes of data starting from de
.loop
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

DrawDefaultTiles:
; Draw 240 tiles (2/3 of the screen) from tiles in VRAM
	hlbgcoord 0, 0 ; BG Map 0
	ld de, BG_MAP_WIDTH - SCREEN_WIDTH
	ld a, $80 ; starting tile
	ld c, 12 + 1
.line
	ld b, 20
.tile
	ld [hli], a
	inc a
	dec b
	jr nz, .tile
; next line
	add hl, de
	dec c
	jr nz, .line
	ret

SGBDelayCycles:
	ld de, 7000
.wait
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .wait
	ret

INCLUDE "gfx/sgb/blk_packets.asm"
INCLUDE "gfx/sgb/pal_packets.asm"
INCLUDE "data/sgb_ctrl_packets.asm"

PredefPals:
INCLUDE "gfx/sgb/predef.pal"

SGBBorderMapAndPalettes:
; interleaved tile ids and palette ids, without the center 20x18 screen area
INCBIN "gfx/sgb/sgb_border.sgb.tilemap"
; four SGB palettes of 16 colors each; only the first 4 colors are used
INCLUDE "gfx/sgb/sgb_border.pal"

SGBBorderGFX:
INCBIN "gfx/sgb/sgb_border.2bpp"

HPBarPals:
INCLUDE "gfx/battle/hp_bar.pal"

ExpBarPalette:
INCLUDE "gfx/battle/exp_bar.pal"

INCLUDE "data/pokemon/palettes.asm"

INCLUDE "data/trainers/palettes.asm"

LoadMapPals:
	farcall LoadSpecialMapPalette
	jr c, .got_bg_pals

	; Which palette group is based on whether we're outside or inside
	ld a, [wEnvironment]
	and 7
	ld e, a
	ld d, 0
	ld hl, EnvironmentColorsPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Further refine by time of day
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1
	ld b, 8
.outer_loop
	ld a, [de] ; lookup index for TilesetBGPalette
	push de
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, TilesetBGPalette
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld c, 1 palettes
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop de
	inc de
	dec b
	jr nz, .outer_loop
	pop af
	ldh [rSVBK], a

.got_bg_pals
	ld a, FALSE
	ld [wMustRefreshPaletteNow], a
	call _ForceTimeOfDayPaletteSmoothing
	ld de, MapObjectPals
	call GetPurpleMaps
	jr nc, .normal_sprite_palette
	ld de, MapObjectPalsPurple
.normal_sprite_palette:
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	ld bc, 8 palettes
	ld h, d
	ld l, e
	call AddNTimes
	ld de, wOBPals1
	ld bc, 8 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM

	ld a, [wEnvironment]
	cp TOWN
	jr z, .outside
	cp ROUTE
	ret nz
.outside
	ld a, [wMapGroup]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, RoofPals
	add hl, de
	ld a, [wTimeOfDayPal]
	maskbits NUM_DAYTIMES
	cp NITE_F
	jr c, .morn_day
rept 4
	inc hl
endr
.morn_day
	ld de, wBGPals1 palette PAL_BG_ROOF color 1
	ld bc, 4
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	ret



GetPurpleMaps:
	ld hl, PurpleMapList
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
.loop
	ld a, [hli] ; group
	and a ; unsets the carry flag.
	ret z ; end.
	cp b
	ld a, [hli] ; map
	jr nz, .loop
	cp c
	jr nz, .loop
	scf ; set carry flag.
	ret










; Damien
/*
Place this function in either:
[YES] engine/tilesets/timeofday_pals.asm:_TimeOfDayPals::					
	- called every frame (even when the start menu or a dialog is opened) by home/time_palettes.asm:TimeOfDayPals::.

[YES] engine/gfx/color.asm:LoadMapPals:: 
	- called when starting the game
	- entering or leaving a building
	- called when ending a battle
	- closing a full screen menu.

Now works correctly with:
- the bike (select button)
- battle transition
- start menu
- surfing
- the poison animation
- talking to NPCs and objects.
- changing route
- going out of a building
- coming out of a battle
- starting the game

Still not called correctly from: 
- probably when using warp (not tested).
*/

; Returns carry is a palette change has been made.
_TimeOfDayPaletteSmoothing::
; Update once per minute.
	ld a, [wLastPaletteTransitionMinute]
	ld b, a
	ldh a, [hMinutes]
	cp b
	ret z

; Don't update a non-standard palette order
	ldh a, [rBGP]
	cp %11100100
	ret nz

	ld a, TRUE
	ld [wMustRefreshPaletteNow], a
	; fallthrough

_ForceTimeOfDayPaletteSmoothing::
; Update only on outdoor maps.
	ld a, [wMapTimeOfDay]
	cp PALETTE_AUTO
	ret nz

; Checking that the hour is right before a time of day change.
	ldh a, [hHours]
	cp NITE_HOUR - 1
	jr z, .hour_is_adequate
	cp DAY_HOUR - 1
	jr z, .hour_is_adequate
	cp MORN_HOUR - 1
	ret nz
.hour_is_adequate

; Don't update the palette on DMG
	ldh a, [hCGB]
	and a
	ret z

; Smoothing happens only 8 minutes before a time of day transition.
	ldh a, [hMinutes] ; 0 <= hMinutes <= 59.
	cp 60 ; Note: hMinutes cannot go above 59, unless you cheat by setting wStartMinute above 59.
	ret nc
	cp 52
	jr nc, .end_checks
	xor a ; Removing the carry, in order to return the right value.
	ret

.end_checks
	ld [wLastPaletteTransitionMinute], a

	ld a, BANK(wBGPals1)
	ldh [hTempBank], a
	ldh a, [rSVBK]
	push af
	ldh a, [hTempBank]
	ldh [rSVBK], a

; Ready for BGPD input
;	ld b, (1 << rBGPI_AUTO_INCREMENT) palette 0
;	ld a, b
;	ldh [rBGPI], a

	ld hl, wBGPals1
	ld a, h
	ld [wAddressStorage], a
	ld a, l
	ld [wAddressStorage + 1], a

; We get the address of the palette indexes, according to the current time of day.
	ld hl, EnvironmentColorsPointers
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld h, d
	ld l, e

	; Further refine by time of day
	push hl
	farcall GetTimeOfDay
	pop hl
	ld a, [wTimeOfDay]
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de ; Now hl contains the address of the 8 indexes (1 byte each) of the current time of day palettes.


	ld b, h
	ld c, l

	cp NITE_F * 8
	jr nz, .not_night
; night: equivalent of sub bc, 16
	ld a, c
	sub a, 16
	ld c, a
	ld a, b
	sbc a, 0
	ld b, a
	jr .second_palette_found

.not_night; equivalent of add bc, 8
	ld a, c
	add a, 8
	ld c, a
	ld a, b
	adc a, 0
	ld b, a

.second_palette_found ; stored in BC.
; For each BG palette, get the current palette and the next time of day palette, then lerp the colors, then apply it.
	ld d, 7 ; 7 palettes.
.palette_loop
	push de ; We save the loop counter.

	push hl ; We save the first palette index address.

	; TODO: Do a special case for Roofs, using RoofPals:.
;	ld a, d
;	cp 7 - PAL_BG_ROOF
;	jr nz, .skip_roof
;; roof palette
;	ld hl, 
;
;.skip_roof
	ld a, [hl]
	call FindPaletteFirstColorOffsetInDE
	ld hl, TilesetBGPalette
	add hl, de ; We have the address of the high byte of the first color of the first palette in HL.

	push bc ; We save the second palette index address.
	ld a, [bc]
	call FindPaletteFirstColorOffsetInDE
	ld bc, TilesetBGPalette
	; equivalent of add bc, de (instruction not available on Game Boy Color).
	ld a, c
	add a, e
	ld c, a
	ld a, b
	adc a, d
	ld b, a ; We have the address of the high byte of the first color of the second palette in BC.



	call SinglePaletteTransition
	pop bc
	pop hl
	pop de

	; We can now move on to the next palette.
	inc bc
	inc hl

	dec d
	jp nz, .palette_loop

	pop af
	ldh [rSVBK], a

	; If the palette fade was triggered naturally by the time (and not forced), we need to apply now.
	ld a, [wMustRefreshPaletteNow]
	and a
	jr z, .skip_instant_refresh

	call ApplyPals ; Copy everything into wBGPals2 for display on the screen.
	ld a, TRUE
	ldh [hCGBPalUpdate], a ; Turn on the flag that triggers the palette refresh on screen.

.skip_instant_refresh

	; TODO: Do the same for map objects. Or not.
	; TODO: Do a special case for purple map objects from PurpleMapList: using the palette MapObjectPalsPurple:
	; Don't worry about maps from LoadSpecialMapPalette, as they all are indoor maps.
	scf
	ret

; Input in A: the ID of the palette.
; Output in DE: offset from the address of TilesetBGPalette to the address of the first color of the palette ID given in input.
FindPaletteFirstColorOffsetInDE:
	ldh [hMultiplicand], a
	xor a
	ldh [hMultiplicand + 1], a
	ldh [hMultiplicand + 2], a
	ld a, 8
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 1]
	ld e, a
	ldh a, [hProduct]
	ld d, a
	ret






















SinglePaletteTransition:
	; Fades a single palette between its current and its next time of day versions.
	; hl must contain the address of the first color of the first palette to fade from (address of a color within bg_tiles.pal).
	; bc must contain the address of the first color of the second palette to fade to (address of a color within bg_tiles.pal).
	
	push bc ; As we will edit B, we want to save the address of the first color byte of the second palette.

	; We store the ratios of each palette in DE.
	ldh a, [hMinutes] ; A has a value from 52 to 59.
	ld d, a
	ld a, 60
	sub d 
	ld d, a ; D now contains a value between 8 and 1.
	ld e, d ; Backup of the ratio D.

.palette_loop

; **** FIRST PALETTE ****
	; We split this color on 3 separate bytes then apply their ratio, each color having a value from 0 to 31 * 8 = 248.
	ld a, [hl]
	and %11111
	ld b, a
	xor a

.red_loop_1
	add b
	dec d
	jr nz, .red_loop_1
	ld [wTimeOfDayPal + 1], a ; Red.

	ld a, [hl]
	swap a
	srl a
	and %111
	ld b, a

	inc hl
	ld a, [hl] ; We get the second (high) byte of the color.
	and %11
	swap a
	srl a
	add b

	ld b, a
	xor a
	ld d, e
.green_loop_1
	add b
	dec d
	jr nz, .green_loop_1
	ld [wTimeOfDayPal + 2], a ; Green.

	ld a, [hl]
	srl a
	srl a
	and %11111

	ld b, a
	xor a
	ld d, e
.blue_loop_1
	add b
	dec d
	jr nz, .blue_loop_1
	ld [wTimeOfDayPal + 3], a ; Blue.

	;TimeOfDayPaletteSwap ; Getting the second palette ready.
	; Computing the opposite of E.
	ld a, 9
	sub e
	ld e, a ; E now contains the opposite of D, ranging from 1 to 8. This represents the ratio of the next palette.

	; We retrieve the offset to the next time of day palette.
	pop bc
	inc hl
	push hl ; We save hl back in the stack, to retrieve it faster.
	ld h, b
	ld l, c



	

; **** SECOND PALETTE ****
	; We split this color in 3 separate bytes, apply their ratio, then add it to the previously stored color components.
	ld a, [hl]
	and %11111

	ld b, a
	xor a
	ld d, e
.red_loop_2
	dec d
	jr z, .end_red_loop_2
	add b
	jr .red_loop_2
.end_red_loop_2

	ld b, a
	ld a, [wTimeOfDayPal + 1]
	add b
	srl a
	srl a
	srl a
	ld [wTimeOfDayPal + 1], a ; This is the final lerped Red color.

	ld a, [hl]
	swap a
	srl a
	and %111
	ld b, a ; We can afford to edit the value of C as we don't need it anymore.

	inc hl
	ld a, [hl]
	and %11
	swap a
	srl a
	add b

	ld b, a
	xor a
	ld d, e
.green_loop_2
	dec d
	jr z, .end_green_loop_2
	add b
	jr .green_loop_2
.end_green_loop_2

	ld b, a
	ld a, [wTimeOfDayPal + 2]
	add b
	srl a
	srl a
	srl a
	ld [wTimeOfDayPal + 2], a ; This is the final lerped Green color.

	ld a, [hl]
	srl a
	srl a
	and %11111

	ld b, a
	xor a
	ld d, e
.blue_loop_2
	dec d
	jr z, .end_blue_loop_2
	add b
	jr .blue_loop_2
.end_blue_loop_2

	ld b, a
	ld a, [wTimeOfDayPal + 3]
	add b
	srl a
	srl a
	srl a
	ld [wTimeOfDayPal + 3], a ; This is the final lerped Blue color.  


; **** CONCATENATION OF COLORS INTO 2 BYTES ****
	ld a, [wTimeOfDayPal + 1]
	ld b, a

	ld a, [wTimeOfDayPal + 2]
	and %111
	swap a
	sla a
	add b
	ld d, a

	; Wait for VRAM to be writtable.
;	push hl
;	ld hl, rSTAT ; STAT Register
;.wait_vram:           ; https://elrindel.github.io/specifications-gameboy#accessingvramandoam
;	bit 1, [hl]       ; Wait until Mode is -NOT- 0 or 1
;	jr nz, .wait_vram  
;	pop hl 


	;ldh [rBGPD], a ; Writing the first byte of the color into OAM.
	ld a, [wAddressStorage]
	ld b, a
	ld a, [wAddressStorage + 1]
	ld c, a
	ld a, d
	ld [bc], a
	inc bc
	ld a, b
	ld [wAddressStorage], a
	ld a, c
	ld [wAddressStorage + 1], a

	ld a, [wTimeOfDayPal + 3]
	sla a
	sla a
	ld b, a

	ld a, [wTimeOfDayPal + 2]
	sla a
	swap a
	and %11
	add b
	ld d, a

	;ldh [rBGPD], a ; Writing the second byte of the color into OAM.
	ld a, [wAddressStorage]
	ld b, a
	;ld a, [wAddressStorage + 1]
	;ld c, a
	ld a, d
	ld [bc], a
	inc bc
	ld a, b
	ld [wAddressStorage], a
	ld a, c
	ld [wAddressStorage + 1], a




; We get back the first time of day palette.
	;TimeOfDayPaletteSwap
	; Computing the opposite of E.
	ld a, 9
	sub e
	ld e, a ; E now contains the opposite of D, ranging from 1 to 8. This represents the ratio of the next palette.
	ld d, e

	; We retrieve the offset to the next time of day palette.
	pop bc
	inc hl
	push hl ; We save hl back in the stack, to retrieve it faster.
	ld h, b
	ld l, c

	; We leave this loop once we've reached the last color of the current palette.
	; To check that, we know that the last nibble of the address of the palette must be a multiple of 8 (4 colors * 2 bytes per palette).
	; This works with both BG and OBJ palettes, as those are aligned in WRAM.
	ld a, [wAddressStorage + 1]
	and $F
	cp $0
	jr z, .end_loop
	cp $8
	jr z, .end_loop

	; We can now move on to the next color of this palette.
	jp .palette_loop

.end_loop
	pop bc ; Cleaning the stack, so it returns at the same address as before entering this function.
	ret


INCLUDE "data/sprites/maps_with_purple_objects.asm"

INCLUDE "data/maps/environment_colors.asm"

PartyMenuBGMobilePalette:
INCLUDE "gfx/stats/party_menu_bg_mobile.pal"

PartyMenuBGPalette:
INCLUDE "gfx/stats/party_menu_bg.pal"

TilesetBGPalette:
INCLUDE "gfx/tilesets/bg_tiles.pal"

MapObjectPals::
INCLUDE "gfx/overworld/npc_sprites.pal"

MapObjectPalsPurple::
INCLUDE "gfx/overworld/npc_sprites_purple.pal"

RoofPals:
	table_width PAL_COLOR_SIZE * 2 * 2, RoofPals
INCLUDE "gfx/tilesets/roofs.pal"
	assert_table_length NUM_MAP_GROUPS + 1

DiplomaPalettes:
INCLUDE "gfx/diploma/diploma.pal"

PartyMenuOBPals:
INCLUDE "gfx/stats/party_menu_ob.pal"

UnusedBattleObjectPals: ; unreferenced
INCLUDE "gfx/battle_anims/unused_battle_anims.pal"

UnusedGSTitleBGPals:
INCLUDE "gfx/title/unused_gs_bg.pal"

UnusedGSTitleOBPals:
INCLUDE "gfx/title/unused_gs_fg.pal"

MalePokegearPals:
INCLUDE "gfx/pokegear/pokegear.pal"

FemalePokegearPals:
INCLUDE "gfx/pokegear/pokegear_f.pal"

BetaPokerPals:
INCLUDE "gfx/beta_poker/beta_poker.pal"

SlotMachinePals:
INCLUDE "gfx/slots/slots.pal"
