#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
xpos := 0
ypos := 0
xstart := 0
ystart := 0
xend := 0
yend := 0
targetx := 0
targety := 0


;pixel search testing
;color to look for 0x4f5857


;set the target
f5::
MouseGetPos, xpos, ypos 
;create a box 100 x 100 px around target
xstart := xpos - 50
ystart := ypos - 50 
xend := xpos + 50
yend := ypos + 50

;msgbox % xstart . "  " . ystart . "  " . xend . "  " . yend
return
;find the color
f6::
pixelSearch,targetx,targety,xstart,ystart,xend,yend,0x4f5857,10,fast
if ErrorLevel
    MsgBox, That color was not found in the specified region.
else
    MsgBox, A color within 10 shades of variation was found at X%targetx% Y%targety%.
return


;move mouse to target
f7::
mousemove, targetx, targety,69
return
;get color of thing mouse is on
f8::
pixelgetcolor,colorid,xpos,ypos
msgbox % colorid
return
