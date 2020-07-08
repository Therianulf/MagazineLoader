#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

MsgBox, 4,, Welcome to the automatic magazine loader by Horkus Porkus.  would you like an introduction to the script?
IfMsgBox Yes
{
	msgbox, help text
	msgbox, help text part 2
}else{
	msgbox, go away
	msgbox, go away again
	}