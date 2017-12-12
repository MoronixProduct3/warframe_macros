#NoEnv
#Warn 

SendMode Input
SetWorkingDir %A_ScriptDir% 

/*
	Keybinds:
	Go to https://autohotkey.com/docs/KeyList.htm to find the list of controls
	Modifiers are listed here : https://autohotkey.com/docs/Hotkeys.htm#Symbols
*/
crouchKey := "LCtrl"
metronomeKey := "3"
forceNocturneKey := "XButton2"
enableKey := "6"

;Octavia Stats
abilityDuration := 306

;Crouch tuning
nbCrouch := 8

;Internal Variables
metronomeDuration_ms := ((3/4 * 20 * abilityDuration / 100) - 1) * 1000
nocturneDuration_ms := ((3/4 * 15 * abilityDuration / 100) - 1) * 1000
pressTime_ms := 10
crouchInterval_ms := (1000 / (4 * 125 / 60)) - pressTime_ms
disabled := true

;Setup
Hotkey, *%forceNocturneKey%, procNocturne
Hotkey, *%enableKey%, toggleEn
return

procNocturne:
	Loop, %nbCrouch%
	{
		Send, {%crouchKey% down}
		Sleep, %pressTime_ms%
		Send, {%crouchKey% up}
		Sleep, %crouchInterval_ms%
	}
return

bleepNocturne:
	gosub procNocturne
	SoundBeep, 660, 100
	sleep, 50
	SoundBeep, 660, 100
return

refreshMetronome:
	Send %metronomeKey%
return

bleepMetronome:
	gosub refreshMetronome
	SoundBeep, 440, 100
return
	
toggleEn:
	if (disabled){
		disabled := false
		SoundBeep, 400, 100
		sleep, 50
		SoundBeep, 440, 100
		
		SetTimer, bleepMetronome, %metronomeDuration_ms%
		SetTimer, bleepNocturne, %nocturneDuration_ms%
		
		gosub refreshMetronome
		Sleep 500
		gosub procNocturne
	}
	else{
		disabled := true
		SoundBeep, 440, 100
		sleep, 50
		SoundBeep, 400, 100
		
		SetTimer, bleepMetronome, Off
		SetTimer, bleepNocturne, Off
	}
return