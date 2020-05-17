#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;this is a super hacky version, honestly cause it works and idk if there is any interest in it.
;also, silly ahk, arrays start at 0! but ahk thinks they start at 1 so be aware of that
Global myClickObject := {ammoPos: {x: [] , y: []}, spacePos: {x: [] , y: []} , magPos: {x: 0 , y: 0}, modalPos: {x: [] , y: []}}
Global magObject := {group1: 0 , group2: 0 , group3: 0 , groupL: 0, total: 0 , Tutorial: 0}

MsgBox % "Welcome to the automatic magazine loader by Horkus Porkus"
Gui, Show , w260 h320, Magazine Loader
Gui, Add, Text, x20 y10 w90 Left, Input how many in first group 
Gui, Add, Edit, w50 h19 x30 y40 vfirstGroup Left,
Gui, Add, Text, x20 y70 w90 Left, Input how many in second group 
Gui, Add, Edit, w50 h19 x30 y100 vsecondGroup Left,
Gui, Add, Text, x20 y130 w90 Left, Input how many in third group 
Gui, Add, Edit, w50 h19 x30 y160 vThirdGroup Left,
Gui, Add, Text, x20 y180 w90 Left,Input how many in last group
Gui, Add, Edit, w50 h19 x30 y210 vLastGroup Left,
Gui, Add, Text, x20 y230 w90 Left,Input how many total
Gui, Add, Edit, w50 h19 x30 y260 vTotalRounds Left,
Gui, Add, CheckBox, x30 y280 vHelpMessages Checked, Would you like help messages?
Gui, Add, Button, x130 y30 w120 h25 vSubmitButton gStoreMag ,Submit Round info
return

StoreMag:
{
Gui, Submit, Hide
Gui, Destroy
magObject.group1 := firstGroup
magObject.group2 := secondGroup
magObject.group3 := thirdGroup
magObject.groupL := LastGroup
magObject.total := TotalRounds
magObject.Tutorial := HelpMessages
Goto, Main
return

}

Main:
MsgBox % "inside of clickstore, mag first, press f5 mag object is " . magObject.group1
KeyWait, F5, D
MouseGetPos, xpos, ypos 
myClickObject.magPos.x := xpos
myClickObject.magPos.y := ypos
MsgBox % "pass 1, mag stored " . myClickObject.magPos.x . " " . myClickObject.magPos.y
KeyWait, F5, D
MouseGetPos, xpos, ypos 
myClickObject.ammoPos.x.Push(xpos)
myClickObject.ammoPos.y.Push(ypos)
MsgBox % "pass 2, first cartrige stored " . myClickObject.ammoPos.x[1] . " " . myClickObject.ammoPos.y[1]
KeyWait, F5, D
MouseGetPos, xpos, ypos 
myClickObject.spacePos.x.Push(xpos)
myClickObject.spacePos.y.Push(ypos)
MsgBox % "pass 3, first space stored " . myClickObject.spacePos.x[1] . " " . myClickObject.spacePos.y[1]
MsgBox % "f5 done, hit f6"
KeyWait, F6, D
MouseGetPos, xpos, ypos 
myClickObject.modalPos.x.Push(xpos)
myClickObject.modalPos.y.Push(ypos)
MsgBox % "f6 pressed, modal stored " . myClickObject.modalPos.x[1] . " " . myClickObject.modalPos.y[1]
msgBox % "were done! press f7 to load"
return


f7::
gosub, loadMag
return


loadMag:

;inc := 1
;while (inc <= myClickObject.ammoPos.x.maxIndex()){
MouseMove, myClickObject.ammoPos.x[1], myClickObject.ammoPos.y[1], 40
sleep, 400
send {Ctrl down}
sleep, 400
Click, Down
sleep, 400
MouseMove, myClickObject.spacePos.x[1], myClickObject.spacePos.y[1], 40
sleep, 400
Click, up
sleep, 400
send {Ctrl up}
sleep, 840
MouseMove, myClickObject.modalPos.x[1], myClickObject.modalPos.y[1], 40
sleep, 400
Click
sleep, 400
send {BS}
sleep, 900
sendplay % magObject.group1
sleep, 900
send {right}
sleep, 100
send {right}
sleep, 100
send {right}
sleep, 400
send {enter}
sleep, 400
MouseMove, myClickObject.spacePos.x[1], myClickObject.spacePos.y[1], 40
sleep, 400
click, down
sleep, 400
MouseMove, myClickObject.magPos.x, myClickObject.magPos.y, 40
sleep, 400
click, up

;inc++
;}

return

