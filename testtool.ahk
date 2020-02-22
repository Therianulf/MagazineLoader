#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

clickObject := {AmmoArray: {x: [] , y: []} , modalPos: {x: 0 , y: 0}}

clickObject.AmmoArray.x.Push(22)
clickObject.AmmoArray.y.Push(33)


MsgBox % "object inside of object " . clickObject.AmmoArray.x[1]
MsgBox % "object inside of object " . clickObject.AmmoArray.y[1]
