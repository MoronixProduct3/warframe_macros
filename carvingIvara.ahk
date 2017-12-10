#NoEnv
#Warn

SendMode Input
SetWorkingDir %A_ScriptDir%

/*
  Ivara prowl bullet jump macro
  Combined with the carvingSpike macro
  Because they do not combine
*/

/*
	Keybinds:
	Go to https://autohotkey.com/docs/KeyList.htm to find the list of controls
	Modifiers are listed here : https://autohotkey.com/docs/Hotkeys.htm#Symbols
*/
triggerKey := "LCtrl"
crouchKey := "LCtrl"
jumpKey := "Space"
spamKey := "e"
meleeKey := "e"
forwardKey := "w"
disableKey := "7"

frequency := 100

;Setup
period  := (1/frequency)*1000
disabled := false

Hotkey, *%spamKey%, startSpam
Hotkey, *%triggerKey%, bulletJump
Hotkey, *%disableKey%, toggleLock

bulletJump:
	Send, {%crouchKey% down}
	Send, {%jumpKey%}
	Send, {%crouchKey% up}
return

loop:
	if(GetKeyState(spamKey,"P"))
		Send, %meleeKey%
	else{
		SetTimer, loop, Off
		if (not GetKeyState(forwardKey,"P"))
			Send, {%forwardKey% up}
	}
return

startSpam:
	SetTimer, loop, %period%
	Send, {%forwardKey% down}
return

toggleLock:
	if (disabled){
		disabled := false
		SoundBeep, 400, 100
		sleep, 50
		SoundBeep, 440, 100
		Hotkey, *%triggerKey%, On
		Hotkey, *%spamKey%, On
	}
	else{
		disabled := true
		SoundBeep, 440, 100
		sleep, 50
		SoundBeep, 400, 100
		Hotkey, *%triggerKey%, Off
		Hotkey, *%spamKey%, Off
	}
return