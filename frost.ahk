#NoEnv
#Warn 

SendMode Input
SetWorkingDir %A_ScriptDir%  



/*
	Keybinds:
	Go to https://autohotkey.com/docs/KeyList.htm to find the list of controls
	Modifiers are listed here : https://autohotkey.com/docs/Hotkeys.htm#Symbols
	LCtrl is the default slide key, change it if you need to.
*/
crouchKey := "LAlt"
mKey:="2"
toggleKey := "6"



/*
	Macro options:
*/
tempo := 125
duration := 155.0
toggleMetronome := false
crequ := 6




; Internal variables
metroActive := false
ccounter := 0 
abDur := 3500
bfDur := 140.0*duration


; Setup
Hotkey, *%toggleKey%, togg
return

togg:
	if(metroActive){
		metroActive := false
		SoundBeep, 440, 100
		sleep, 50
		SoundBeep, 400, 100
		
		
		SetTimer, refreshAbility, Off

	}
	else{
		metroActive := true
		SoundBeep, 400, 100
		sleep, 50
		SoundBeep, 440, 100
		
		Gosub, refreshAbility
		SetTimer, refreshAbility,%abDur%
	}
return

refreshAbility:
	send %mKey%
return



