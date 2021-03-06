#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;this is a super hacky version, honestly cause it works and idk if there is any interest in it.
;also, silly ahk, arrays start at 0! but ahk thinks they start at 1 so be aware of that
;todo dynamic groups, easier init proccess, more mags, ammo pile reloads
; bug, init doesnt stop you from adding bullets you dont want.
start:
Global myClickObject := {ammoPos: {x: [] , y: []}, spacePos: {x: [] , y: []} , magPos: {x: 0 , y: 0}}
Global magObject := {group: [], total: 0 , Tutorial: 0}
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
magObject.group[1] := firstGroup
magObject.group[2] := secondGroup
magObject.group[3] := thirdGroup
magObject.group[4] := LastGroup
magObject.total := TotalRounds
magObject.Tutorial := HelpMessages
Goto, Main
return

}

Main:
if (magObject.Tutorial = 1){
MsgBox % "inside of main, our magobject total rounds: " . magObject.total . " our first group " . magObject.group[1] . " our second group " . magObject.group[2] . " our third group " . magObject.group[3] . " our last group " . magObject.group[4]
MsgBox % "mag object max index " . magObject.group.maxIndex()
}
mainInc := 1

while (mainInc <= magObject.group.maxIndex())
{
if (mainInc < 2){
if (magObject.Tutorial = 1)
	MsgBox % "inside of clickstore while, mag first, press f8"
KeyWait, F8, D
MouseGetPos, xpos, ypos 
myClickObject.magPos.x := xpos
myClickObject.magPos.y := ypos
if (magObject.Tutorial = 1)
	MsgBox % "mag stored press f5 on first cartridge " . myClickObject.magPos.x . " " . myClickObject.magPos.y
}else{
	if (magObject.Tutorial = 1)
		MsgBox % "Don't need to store the mag this time, right to press f5 on cartridge"
}
KeyWait, F5, D
MouseGetPos, xpos, ypos 
myClickObject.ammoPos.x.Push(xpos)
myClickObject.ammoPos.y.Push(ypos)
if (magObject.Tutorial = 1)
MsgBox % "cartridge stored press f6 on space " . myClickObject.ammoPos.x[mainInc] . " " . myClickObject.ammoPos.y[mainInc]
KeyWait, F6, D
MouseGetPos, xpos, ypos 
myClickObject.spacePos.x.Push(xpos)
myClickObject.spacePos.y.Push(ypos)
if (magObject.Tutorial = 1)
MsgBox % "space stored, bring up modal and hit f7 to store the modal " . myClickObject.spacePos.x[mainInc] . " " . myClickObject.spacePos.y[mainInc]
if (mainInc > 3){
msgBox % "were done! press f9 to load"
}
mainInc++
}
return

f9::
gosub, loadMag
return

loadMag:
roundsLoaded := 0
while (roundsLoaded < magObject.total){
if (roundsLoaded <= 0 AND magObject.group[4] >= 1){
loadRound(4)
roundsLoaded := roundsLoaded + magObject.group[4]
}
if (magObject.group[1] >= 1){
loadRound(1)
roundsLoaded := roundsLoaded + magObject.group[1]
if(roundsLoaded >= magObject.total){
break
}
}
if (magObject.group[2] >= 1){
loadRound(2)
roundsLoaded := roundsLoaded + magObject.group[2]
if(roundsLoaded >= magObject.total){
break
}
}
if (magObject.group[3] >= 1){
loadRound(3)
roundsLoaded := roundsLoaded + magObject.group[3]
if(roundsLoaded >= magObject.total){
break
}
}
}
return


;function to invidual rounds, give it the group were loading
loadRound(cart){
;move mouse to round
MouseMove, myClickObject.ammoPos.x[cart], myClickObject.ammoPos.y[cart], 40
sleep, 226
;control click the round to split
send {Ctrl down}
sleep, 226
Click, Down
sleep, 226
;move round to empty space
MouseMove, myClickObject.spacePos.x[cart], myClickObject.spacePos.y[cart], 40
sleep, 226
;release mouse and ctrl to bring up the modal
Click, up
sleep, 226
send {Ctrl up}
;input how many rounds we want in this group
send % magObject.group[cart]
sleep, 198
;move the cursor right to prevent bug of enter giving only the rounds before cursor.
send {right}
sleep, 100
send {right}
sleep, 220
;submit and wait for modal to close
send {enter}
sleep, 840
;put round into mag.
MouseMove, myClickObject.spacePos.x[cart], myClickObject.spacePos.y[cart], 40
sleep, 276
click, down
sleep, 276
MouseMove, myClickObject.magPos.x, myClickObject.magPos.y, 40
sleep, 276
click, up
return
}

#f4::
exitApp
return

f12::
Gui, Destroy
goto,start
return
