_GetHospitalRoomNumber::
	ld a, FALSE
	ld [wSickMonIsInThisRoom], a

	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM
	ld a, [sHospitalBoxCount]
	call CloseSRAM
	ld c, a

	push bc
	call GetActualRoomNumber ; Now we check if the number -5 is above the number of sick Pokémon.
	pop bc
	sub 5
	ret c

	ld b, a
	ld a, c
	cp b
	ret c
	ret z

	ld a, TRUE
	ld [wSickMonIsInThisRoom], a
	ret

GetActualRoomNumber: ; Writes down the number of the hospital room in wScriptVar and in A.
	ld de, 0

	ld a, [wMapNumber]
	cp MAP_GOLDENROD_HOSPITAL_ROOM
	jr z, .hospital_room

	ld a, [wYCoord]
	cp 5 ; Arbitrary value that represents about half the map height.
	jr c, .corridor_top_row

; corridor bottom row.
	ld de, 4 * HOSPITAL_CORRIDOR_LENGTH

.corridor_top_row
	ld hl, 0
	ld bc, 4 ; 4 rooms per corridor row.
	ld a, [wGoldenrodHospitalCorridorNumber]
	dec a
	call AddNTimes
	add hl, de

	ld a, [wXCoord]
	sub 2
	srl a
	srl a
	add 1 ; NUMBER ONE
	add l ; LETTER "L" (2 pixels difference, almost delete it because I thought it was a duplicate).
	ld [wScriptVar], a
	ret

.hospital_room
	ld a, [wPrevWarp]
	sub 8
	cp 5
	jr c, .room_top_row

; room bottom row.
	ld de, 4 * HOSPITAL_CORRIDOR_LENGTH
	sub 4
	
.room_top_row
	push af

	ld hl, 0
	ld bc, 4 ; 4 rooms per corridor row.
	ld a, [wGoldenrodHospitalCorridorNumber]
	dec a
	call AddNTimes
	add hl, de

	pop af
	add l
	ld [wScriptVar], a
	ret

_GetQuantityOfHospitalizedMons::
	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM
	ld a, [sHospitalBoxCount]
	call CloseSRAM
	ld [wScriptVar], a
	ret

_CountHospitalMonsReadyToLeave::
	ld hl, sHospitalBoxMon1PokerusStatus
	ld de, BOXMON_STRUCT_LENGTH

	xor a
	ld [wScriptVar], a

	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM

	ld a, [sHospitalBoxCount]
	and a
	jr z, .loop_end

	ld c, a

	ld a, [wPartyCount]
	ld b, a
	ld a, PARTY_LENGTH
	sub b
	ld b, a ; == number of available spots in our party.

.loop
	ld a, [hl]
	add hl, de
	and POKERUS_DURATION_MASK

	cp POKERUS_IMMUNITY_DURATION + 1
	jr nc, .loop_end ; This Pokémon is not ready to leave, and Pokémon leave in chronological order (queue). Therefore, we can leave the loop as soon as a Pokémon is wrong.

	ld a, [wScriptVar]
	inc a
	ld [wScriptVar], a

	dec c
	jr z, .loop_end ; Leave the loop is there is no further mon in the box.

	dec b
	jr z, .loop_end ; Leave the loop after 5 mons, as the player cannot receive more than 5 mons in its party (he must carry 1 at first).

	jr .loop

.loop_end
	call CloseSRAM
	ret

_CountHospitalMonsReadyToLeave2::
	xor a
	ld [wScriptVar], a

	ld a, BANK(sHospitalBoxCount)
	call OpenSRAM

	ld a, [sHospitalBoxCount]
	and a
	jr z, .end

	ld a, [sHospitalBoxMon1PokerusStatus]
	and POKERUS_DURATION_MASK

	cp POKERUS_IMMUNITY_DURATION + 1
	jr nc, .end ; This Pokémon is not ready to leave, and Pokémon leave in chronological order (queue). Therefore, we can leave the loop as soon as a Pokémon is wrong.

	ld a ,1
	ld [wScriptVar], a

.end
	call CloseSRAM
	ret

_HospitalVisit::
	call GetActualRoomNumber ; Returns the room number in A.
	;ld a, [wScriptVar]
	sub 5
	ret c
	cp MONS_PER_BOX + 1
	ret nc
	ld e, a

	ld a, BANK(sHospitalBox)
	call OpenSRAM

	; Get the happiness amount.
	ld hl, sHospitalBoxMon1Happiness
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	call AddNTimes
	ld a, [hl]
	
	ld d, a ; We save the happiness amount in D.
	ld a, e ; We give the index of the flag.
	push de
	push hl
	call PayVisit
	pop hl
	pop de
	ld a, d
	jr nc, .gain_applied

	; We increase the happiness level.
	add HAPPINESS_GAINED_WHEN_VISITED
	jr c, .cap_gain
	cp MAX_HAPPINESS_IN_HOSPITAL + 1
	jr nc, .cap_gain
	jr .happiness_doesnt_go_above_cap

.cap_gain
	ld a, MAX_HAPPINESS_IN_HOSPITAL

.happiness_doesnt_go_above_cap
	ld [hl], a ; We save the happiness. 

.gain_applied
	; Depending on the happiness level, we display a specific message.
	swap a
	srl a
	srl a
	and $3 ; We divide the byte by 64, so it gives a number between 0 and 3 included.

	call CloseSRAM
	push hl
	ld hl, Happiness_messages
	call DisplayMessageAtIndex ; This seems to close SRAM.
	pop hl

; Now, we check the remaining duration the Pokémon has to stay in the hospital.
	ld a, BANK(sHospitalBox)
	call OpenSRAM
	inc hl ; HL now points to PokerusStatus, which is conveniently located after Happiness.
	ld a, [hl]
	and POKERUS_DURATION_MASK
	sub POKERUS_IMMUNITY_DURATION
	jr c, .manage_underflow ; The pokémon is ready to leave, as its remaining duration is zero or below.
	cp 2 + 1
	jr c, .message_index_found
	ld a, 2 ; => MIN(a, 2). Upper cap is 2.
	jr .message_index_found

.manage_underflow
	xor a

.message_index_found
	push af
	push hl
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	lb bc, TEXTBOX_INNERH - 1, TEXTBOX_INNERW
	call ClearBox
	pop hl
	pop af

	call CloseSRAM
	ld hl, Duration_messages
	call DisplayMessageAtIndex
	ret



Happiness_messages:
	table_width 2, Happiness_messages
	dw .happiness_message_0 ; 0 to 63 happiness.
	dw .happiness_message_1 ; 64 to 127 happiness.
	dw .happiness_message_2 ; 128 to 191 happiness.
	dw .happiness_message_3 ; 192 to 200 happiness.
	assert_table_length 4

.happiness_message_0
	text_far _HospitalVisitHappiness0Text
	text_end

.happiness_message_1
	text_far _HospitalVisitHappiness1Text
	text_end

.happiness_message_2
	text_far _HospitalVisitHappiness2Text
	text_end

.happiness_message_3
	text_far _HospitalVisitHappiness3Text
	text_end



Duration_messages:
	table_width 2, Duration_messages
	dw .duration_message_0
	dw .duration_message_1
	dw .duration_message_2
	assert_table_length 3

.duration_message_0
	text_far _HospitalVisitDuration0Text
	text_end

.duration_message_1
	text_far _HospitalVisitDuration1Text
	text_end

.duration_message_2
	text_far _HospitalVisitDuration2Text
	text_end



; Input: the pokemon index in E.
; Output: carry if it is the first visit.
PayVisit:
	; Check if the Pokémon has already been visited today.
	; If so, it can't gain happiness again today, so we skip it.
	ld hl, wHospitalVisitsToday
	ld b, CHECK_FLAG
	ld d, 0
	;ld e, a
	push hl
	push de
	call FlagAction ; Returns the result of the check in c.
	pop de
	pop hl
	ld a, c
	and a
	jr nz, .no_gain ; This mon has already been visited today.

	; We set the visit flag/bit.
	ld b, SET_FLAG
	push de
	call FlagAction
	pop de
	scf
	ret

.no_gain
	xor a
	ret

; Input: the index of the message in A. HL points to the message array.
; Output: the address of the text in HL.
DisplayMessageAtIndex:
	add a ; x2.
	ld e, a
	ld d, 0
	add hl, de

	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	ld hl, 0
	add hl, de
	call PrintText
	ret

ResetHospitalVisits::
	xor a
	ld hl, wHospitalVisitsToday
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret