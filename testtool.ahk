#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

clickObject := {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}}

;MsgBox % "object inside of object " . clickObject.AmmoArray.x[1]
;MsgBox % "object inside of object " . clickObject.AmmoArray.y[1]

~LButton::
KeyWait, LButton  ; Wait for user to physically release it.
MouseGetPos, xpos, ypos 
clickObject.AmmoArray.x.Push(xpos)
clickObject.AmmoArray.y.Push(ypos)

MsgBox % "our Xpos is: " . clickObject.AmmoArray.x[clickObject.AmmoArray.x.MaxIndex()] . " our Ypos is: " . clickObject.AmmoArray.y[clickObject.AmmoArray.y.MaxIndex()]
return

F11::
for index, value in clickObject.AmmoArray.x
{
MsgBox % "index number " . index . " is " . value
}


F12::
ExitApp
return
