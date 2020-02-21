Gui, Show , w260 h300, Magazine Loader
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
; GUI add notes, x100, is the pos, y30 is the pos, w90 is the width of the text box, h20 is the height of the text box
; vMYBUTTON is the variable the input will be stored into. i dont think there is any input from a button, so this might  be pointless
;gDOUBLE calls a subroutine by the name DOUBLE, number is the text we entered.
Gui, Add, Button, x130 y30 w120 h25 vSubmitButton gStoreMag ,Submit Round info

return

StoreMag:
{
Gui, Submit, Hide
magObject := {group1: firstGroup , group2: secondGroup , group3: thirdGroup , groupL: LastGroup, total: TotalRounds}
MsgBox % "Mag object first group is " . magObject.group1
return
}

;StoreClickAreas:
;{
;Gui, Submit, Hide
;clicksObject := {group1: firstGroup , group2: secondGroup , group3: thirdGroup , groupL: LastGroup, total: TotalRounds}
;return
;}


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
