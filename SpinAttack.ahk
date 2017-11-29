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
meleeKey := "e"
crouchKey := "LCtrl"
triggerKey := "XButton2" ; This is the mouse forward button
increaseKey := "!WheelUp" ; This is Alt+scroll up
decreaseKey := "!WheelDown"



/*
	Attack options:
*/
semiAuto := false ; write true to make it one click, one hit
defaultSpeed := 3 ; Default number of hits/seconds see list of weapons tested
maxSpeed := 10 ; Range  of the max / min attack speed
minSpeed := 0.5 
minDelay := 0 ; Time between slide and spin attack
increment := 0.05 ;Increase in attack speed for every step (in percentage)

/* 	Weapon attack speeds (with berserker)
Telos Boltace: 2.04 (3.54)
Atterax: 1.76 (3.02)
Secura Lecta: 2.39(4.11) ; not tested
Galatine Prime: 1.03 (1.76)
*/

/*
	User interface options
*/
mute := false
showSpeed := false
; Pixel position of the screen that has the start button from the top left
; The default setting will position the text at the the top center of a 1080p monitor
; This display cannot be seen while in-game putting it on a secondary monitor is advised
xUI := -200
yUI := 0
timeUI = 5000 ; Time the attack speed is displayed in ms. 0 or a negative will keep  it up forever


















; Internal variables
attackSpeed := defaultSpeed
period := (1/attackSpeed)*1000
playing := false
beepDur := 50

; Setup
Hotkey, *%triggerKey%, trigger
Hotkey, %increaseKey%, increase
Hotkey, %decreaseKey%, decrease 
CoordMode, ToolTip, Screen

updateSpeed(nSpeed)
{
	global attackSpeed, period
	
	attackSpeed := nSpeed
	period := (1/nSpeed)*1000
	
	display(attackSpeed)
}

display(message)
{
	global showSpeed, xUI, yUI , timeUI
	if(showSpeed)
		ToolTip, %message%, xUI, yUI
	if(timeUI > 0)
		SetTimer, RemoveToolTip, %timeUI%
}
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return

spin:
	if(GetKeyState(triggerKey,"P"))
		gosub attack
	else{
		semiAuto := false
		SetTimer, spin, Off
	}
return

attack:
	Send, {%crouchKey% down}
	Sleep, minDelay
	Send, %meleeKey%
	Send, {%crouchKey% up}
return

trigger:
	gosub attack
	if (not semiAuto){
		semiAuto := true
		SetTimer, spin, %period%
	}
Return

increase:
	newSpeed := attackSpeed * (1+increment)
	if (newSpeed > maxSpeed){
		gosub deny
		return
	}
	updateSpeed(newSpeed)
	if(not mute)
		SoundBeep, 440, 50
return

decrease:
	newSpeed := attackSpeed / (1+increment)
	if (newSpeed < minSpeed){
		gosub deny
		return
	}
	updateSpeed(newSpeed)
	if(not mute)
		SoundBeep, 400, 50
return
	
deny:
	display("Limit Reached")
	if(not mute){
		SoundBeep, 200, 70
		sleep, 50
		SoundBeep, 200, 150
	}
return
