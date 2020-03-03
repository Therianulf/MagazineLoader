#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
current := 1
clickObject := { group1: {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}} , group2: {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}} , group3: {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}} , group4: {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}}, MagPos: {x: 0 , y: 0}}
hotkey, LButton, clickSwitch, on
HKon := 1

clickSwitch:
KeyWait, LButton  ; Wait for user to physically release it.
MouseGetPos, xpos, ypos 
switch current
{
case 1:
clickObject.group1.AmmoArray.x.Push(xpos)
clickObject.group1.AmmoArray.y.Push(ypos)
case 2:
clickObject.group2.AmmoArray.x.Push(xpos)
clickObject.group2.AmmoArray.y.Push(ypos)
case 3:
clickObject.group3.AmmoArray.x.Push(xpos)
clickObject.group3.AmmoArray.y.Push(ypos)
case 4:
clickObject.group4.AmmoArray.x.Push(xpos)
clickObject.group4.AmmoArray.y.Push(ypos)
}
MsgBox % "our Xpos is: " . clickObject.group1.AmmoArray.x[clickObject.group1.AmmoArray.x.MaxIndex()] . " our Ypos is: " . clickObject.group1.AmmoArray.y[clickObject.group1.AmmoArray.y.MaxIndex()]
return

F8::
if (current <= 3){
current++
}
MsgBox % "Current is set to " . current
return

F9::
if (HKon){
Hotkey, LButton, off
HKon := 0
}else{
Hotkey, LButton, on
HKon := 1
}


return



F11::
for index, value in clickObject.group1.AmmoArray.x
{
MsgBox % "index number " . index . " is " . value
}


F12::
ExitApp
return
