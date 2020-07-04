#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;this is a super hacky version, honestly cause it works and idk if there is any interest in it.
;also, silly ahk, arrays start at 0! but ahk thinks they start at 1 so be aware of that
;todo dynamic groups, easier init proccess, more mags, ammo pile reloads
start:
Global myClickObject := {ammoPos: {x: [] , y: []}, spacePos: {x: [] , y: []} , magPos: {x: 0 , y: 0}, modalPos: {x: [] , y: []}}
Global magObject := {group: [], total: 0 , Tutorial: 0}
MsgBox % "Welcome to the automatic magazine loader by Horkus Porkus."  
MsgBox % "AutoLoader allows up to 4 kinds of bullets to be loaded into a magazine at a time, with any number of bullets in each group. what it then does is split up the bullets set aside in a stack, with how many it grabs out of the stack being up to the user. I recommend you make a bit of space in the Stash compartment of your Character before actually starting the script"
MsgBox % "After you activate the script and click OK on the intro,you will be brought into a pop-up window that will ask for for: how many bullets do you want the script to take out of the stack at a time, how many kinds of bullets you will be using, and how many times you want to auto-load. put in how many bullets you want to take out of a stack at a time, and if you have less than 4 kinds of bullets for it, simply leave the remaining groups blank "
MsgBox % "For the Action Input total, put in how many times you want to do an action, an action being splitting a number of bullets from a stack. for example, if you want to put a bullet of 2 or 4 kinds into a 30-round mag, and you want to do it 1 bullet at a time, the total number of actions should be 30. if you want to put 2 bullets of one kind and 1 bullet of another kind, the total should then be 20."
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
MsgBox % "Thank you for looking at the tutorial. There are several things needed to be done so that this script can do its work right, so please read caerfully."
MsgBox % "First, press F8 while your mouse is over the magazine. The way it works is that it uses the position your mouse is at on the screen and does the movements for you when you ask it to, regardless of whether there is a real mag there or not, so make sure there is one. It will then want the first kind of bullet you want in your mag. Hit F5 when your mouse is over your desired kind of bullet."
MsgBox % "Hit F6 on the space you want the stack of bullets to split to. Lastly, it will want a way to split the stack. To do this, hold the Ctrl key, drag the bullet group to the empty space, and there will be a pop-up where you will be able to split the stack of bullets. While not moving the popup, put the mouse over the number box and hit F7. Then close out of the window."
MsgBox % "Repeat steps one and two for any other stacks of bullets. When you have done that for the bullet stacks you want to use, simply hit F9 to start the auto-loading process. Don't touch the mouse or keyboard while its working or it will throw it off and try to start loading the mag as if it just started. The script will stop naturally after it has ran through its actions, though if you want to stop it at any time, press F12 and it will restart on the script. This concludes the tutorial pages. Good luck!"
MsgBox % "inside of main, our magobject total rounds: " . magObject.total . " our first group " . magObject.group[1] . " our second group " . magObject.group[2] . " our third group " . magObject.group[3] . " our last group " . magObject.group[4]
MsgBox % "The number of bullet groups is " . magObject.group.maxIndex()

}
mainInc := 1

while (mainInc <= magObject.group.maxIndex())
{
if (mainInc < 2){
KeyWait, F8, D
MouseGetPos, xpos, ypos 
myClickObject.magPos.x := xpos
myClickObject.magPos.y := ypos
KeyWait, F5, D
MouseGetPos, xpos, ypos 
myClickObject.ammoPos.x.Push(xpos)
myClickObject.ammoPos.y.Push(ypos)
KeyWait, F6, D
MouseGetPos, xpos, ypos 
myClickObject.spacePos.x.Push(xpos)
myClickObject.spacePos.y.Push(ypos)
KeyWait, F7, D
MouseGetPos, xpos, ypos 
myClickObject.modalPos.x.Push(xpos)
myClickObject.modalPos.y.Push(ypos)
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
;wait a bit for modal to pop, then move mouse to modal num input
;since the modal likes to move around for some weird reason, we need to find the correct pixels and target them.
;we will search within a 100 x 100 rectangle centered on the input spot given by the user,
xstart := myClickObject.modalPos.x[cart] - 50
ystart := myClickObject.modalPos.y[cart] - 50 
xend := myClickObject.modalPos.x[cart] + 50
yend := myClickObject.modalPos.y[cart] + 50
targetx := 0
targety := 0
pixelSearch,targetx,targety,xstart,ystart,xend,yend,0x4f5857,10,fast
if ErrorLevel
    MsgBox % "Modal was not found, it may have moved itself outside of targeting range."
else
    ;MsgBox, A color within 10 shades of variation was found at X%targetx% Y%targety%.
sleep, 440
MouseMove, targetx, targety, 40
sleep, 176
;click input spot
Click
sleep, 180
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
