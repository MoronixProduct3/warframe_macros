#NoEnv
#Warn

SendMode Input
SetWorkingDir %A_ScriptDir%

/*
  Ivara prowl bullet jump macro
*/

/*
	Keybinds:
	Go to https://autohotkey.com/docs/KeyList.htm to find the list of controls
	Modifiers are listed here : https://autohotkey.com/docs/Hotkeys.htm#Symbols
*/
triggerKey := "LCtrl"
crouchKey := "LCtrl"
jumpKey := "Space"
disableKey := "8"

;Setup
disabled := false

Hotkey, *%triggerKey%, bulletJump
Hotkey, *%disableKey%, toggleLock

bulletJump:
	Send, {%crouchKey% down}
	Send, {%jumpKey%}
	Send, {%crouchKey% up}
return

toggleLock:
	if (disabled){
		disabled := false
		SoundBeep, 400, 100
		sleep, 50
		SoundBeep, 440, 100
		Hotkey, *%triggerKey%, On
	}
	else{
		disabled := true
		SoundBeep, 440, 100
		sleep, 50
		SoundBeep, 400, 100
		Hotkey, *%triggerKey%, Off
	}
return