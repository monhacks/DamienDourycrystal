command: MACRO
	const \1_command
\1 EQUS "db \1_command"
ENDM

; BattleCommandPointers indexes (see data/battle/effect_command_pointers.asm)
	const_def 1
	command checkturn               ; 01
	command checkobedience          ; 02
	command usedmovetext            ; 03
	command doturn                  ; 04
	command critical                ; 05
	command damagestats             ; 06
	command stab                    ; 07
	command damagevariation         ; 08
	command checkhit                ; 09
	command lowersub                ; 0a
	command moveanimnosub           ; 0b
	command raisesub                ; 0c
	command failuretext             ; 0d
	command applydamage             ; 0e
	command criticaltext            ; 0f
	command supereffectivetext      ; 10
	command checkfaint              ; 11
	command buildopponentrage       ; 12
	command poisontarget            ; 13
	command sleeptarget             ; 14
	command draintarget             ; 15
	command eatdream                ; 16
	command burntarget              ; 17
	command freezetarget            ; 18
	command paralyzetarget          ; 19
	command selfdestruct            ; 1a
	command mirrormove              ; 1b
	command statup                  ; 1c
	command statdown                ; 1d
	command payday                  ; 1e
	command conversion              ; 1f
	command resetstats              ; 20
	command storeenergy             ; 21
	command unleashenergy           ; 22
	command forceswitch             ; 23
	command endloop                 ; 24
	command flinchtarget            ; 25
	command ohko                    ; 26
	command recoil                  ; 27
	command mist                    ; 28
	command focusenergy             ; 29
	command confuse                 ; 2a
	command confusetarget           ; 2b
	command heal                    ; 2c
	command transform               ; 2d
	command screen                  ; 2e
	command poison                  ; 2f
	command paralyze                ; 30
	command substitute              ; 31
	command rechargenextturn        ; 32
	command mimic                   ; 33
	command metronome               ; 34
	command leechseed               ; 35
	command splash                  ; 36
	command disable                 ; 37
	command cleartext               ; 38
	command charge                  ; 39
	command checkcharge             ; 3a
	command traptarget              ; 3b
	command struggle	            ; 3c
	command rampage                 ; 3d
	command checkrampage            ; 3e
	command constantdamage          ; 3f
	command counter                 ; 40
	command encore                  ; 41
	command painsplit               ; 42
	command snore                   ; 43
	command conversion2             ; 44
	command lockon                  ; 45
	command mindreader              ; 46
	command sketch                  ; 47
	command defrostopponent         ; 48
	command sleeptalk               ; 49
	command destinybond             ; 4a
	command spite                   ; 4b
	command falseswipe              ; 4c
	command healbell                ; 4d
	command kingsrock               ; 4e
	command triplekick              ; 4f
	command kickcounter             ; 50
	command thief                   ; 51
	command arenatrap               ; 52
	command nightmare               ; 53
	command defrost                 ; 54
	command curse                   ; 55
	command protect                 ; 56
	command spikes                  ; 57
	command foresight               ; 58
	command perishsong              ; 59
	command startsandstorm          ; 5a
	command endure                  ; 5b
	command checkcurl               ; 5c
	command rolloutpower            ; 5d
	command checkpowder             ; 5e
	command furycutter              ; 5f
	command attract                 ; 60
	command happinesspower          ; 61
	command present                 ; 62
	command damagecalc              ; 63
	command frustrationpower        ; 64
	command safeguard               ; 65
	command checksafeguard          ; 66
	command getmagnitude            ; 67
	command batonpass               ; 68
	command pursuit                 ; 69
	command clearhazards            ; 6a
	command healmorn                ; 6b
	command healday                 ; 6c
	command healnite                ; 6d
	command hiddenpower             ; 6e
	command startrain               ; 6f
	command startsun                ; 70
	command attackup                ; 71
	command defenseup               ; 72
	command speedup                 ; 73
	command specialattackup         ; 74
	command specialdefenseup        ; 75
	command accuracyup              ; 76
	command evasionup               ; 77
	command attackup2               ; 78
	command defenseup2              ; 79
	command speedup2                ; 7a
	command specialattackup2        ; 7b
	command specialdefenseup2       ; 7c
	command accuracyup2             ; 7d
	command evasionup2              ; 7e
	command attackdown              ; 7f
	command defensedown             ; 80
	command speeddown               ; 81
	command specialattackdown       ; 82
	command specialdefensedown      ; 83
	command accuracydown            ; 84
	command evasiondown             ; 85
	command attackdown2             ; 86
	command defensedown2            ; 87
	command speeddown2              ; 88
	command specialattackdown2      ; 89
	command specialdefensedown2     ; 8a
	command accuracydown2           ; 8b
	command evasiondown2            ; 8c
	command statupmessage           ; 8d
	command statdownmessage         ; 8e
	command statupfailtext          ; 8f
	command statdownfailtext        ; 90
	command effectchance            ; 91
	command statdownanim            ; 92
	command statupanim              ; 93
	command switchturn              ; 94
	command fakeout                 ; 95
	command bellydrum               ; 96
	command psychup                 ; 97
	command rage                    ; 98
	command doubleflyingdamage      ; 99
	command doubleundergrounddamage ; 9a
	command mirrorcoat              ; 9b
	command checkfuturesight        ; 9c
	command futuresight             ; 9d
	command doubleminimizedamage    ; 9e
	command skipsuncharge           ; 9f
	command thunderaccuracy         ; a0
	command teleport                ; a1
	command beatup                  ; a2
	command ragedamage              ; a3
	command resettypematchup        ; a4
	command allstatsup              ; a5
	command bidefailtext            ; a6
	command raisesubnoanim          ; a7
	command lowersubnoanim          ; a8
	command beatupfailtext          ; a9
	command clearmissdamage         ; aa
	command movedelay               ; ab
	command moveanim                ; ac
	command tristatuschance         ; ad
	command supereffectivelooptext  ; ae
	command startloop               ; af
	command curl                    ; b0
	command starthail               ; b1
	command checkrestrictedweather  ; b2
	command growth                  ; b3
NUM_EFFECT_COMMANDS EQU const_value - 1

	const_def -1, -1
	command endmove                 ; ff
	command endturn                 ; fe
