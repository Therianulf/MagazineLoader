#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; make a simple gui that will take in our pattern
MsgBox % "Welcome to the automatic magazine loader. once you close this window another window will open asking for rounds in a group. This may be confusing how it loads the rounds. The last group is the last rounds that will be in your magazine, but the first rounds to load. This is so you can place Tracers or something like that in the last few rounds. Next the first group will be loaded, then the second group, and last the third group. the number entered will be how many of that round to put in before switching to the next group. Total rounds is the capacity of the magazine."
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

Instructions:
Gui, Show , w260 h300, Instructions
Gui, Add, Text, x20 y10 w90 Left, our next piece of data
Gui, Add, Edit, w50 h19 x30 y40 vNextData Left,
Gui, Add, Button, x130 y30 w120 h25 vInstructionButton gPromptUser , Start
return

StoreMag:
{
Gui, Submit, Hide
Gui, Destroy
magObject := {group1: firstGroup , group2: secondGroup , group3: thirdGroup , groupL: LastGroup, total: TotalRounds , Tutorial: HelpMessages}
Goto, Instructions
return
}

PromptUser:
{
Gui, Submit, Hide
clicksObject := {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}}
MsgBox % "We now need to save the location of The ammo, The Empty Location were moving it to, and the Ctrl-click popup modal. if you choose help messages, with each step a popup with come up to help you. Press F3 to continue after closing this window"
KeyWait, F3, D

return
}


;Run the code again using the same bullet pattern
F2::
MouseGetPos, PosX, PosY
Send, +{LButton down}
MouseMove, XVal, YVal
Send, +{LButton up}
MouseMove, %PosX%, %PosY%
return

GuiClose:
ExitApp

F12::
ExitApp
return
