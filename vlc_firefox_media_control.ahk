#SingleInstance,Force

;############################################
; author : discretecourage#0179
;############################################
; How to use (works both with vlc and firefox)
;############################################
; f6 ==> change vlc into borderless
; F7 ==> rewind
; (Alt + Space) or F8 ==> pause 
; F9 ==> forward
; F10 ==> change the position of vlc if you saved the from tray icon
;############################################


SetWorkingDir %A_ScriptDir%
;~ Menu, Tray, Icon, play.ico
Menu,Tray, NoStandard


Menu, SaveCurrentPosID, add, Profile_1, Profile_1
Menu, SaveCurrentPosID, add, Profile_2, Profile_2
Menu, SaveCurrentPosID, add, Profile_3, Profile_3
Menu, SaveCurrentPosID, add, Profile_4, Profile_4
Menu, SaveCurrentPosID, add, Profile_5, Profile_5
Menu, Tray, add, Save Current Position, :SaveCurrentPosID
Menu, SetDefaultPosID, add, Set_1, Set_1
Menu, SetDefaultPosID, add, Set_2, Set_2
Menu, SetDefaultPosID, add, Set_3, Set_3
Menu, SetDefaultPosID, add, Set_4, Set_4
Menu, SetDefaultPosID, add, Set_5, Set_5
Menu, Tray, add, Set Default, :SetDefaultPosID
Menu, Tray, Add,  Restart, Reloadlbl
Menu, Tray, Add,  close, Terminate



IniRead,DefaultPos,VLCPowerTools.ini,Default,DefaultPos,1
Loop,5
IniRead,Pos_%A_Index%,VLCPowerTools.ini,Positons,Pos_%A_Index%,0|0|550|350
Menu, SetDefaultPosID, Check, Set_%DefaultPos%
return

Set_1:
Set_2:
Set_3:
Set_4:
Set_5:
loop,5
Menu, SetDefaultPosID, UnCheck, Set_%A_Index%
Menu, SetDefaultPosID, Check, %A_ThisLabel%
t:=SubStr(A_ThisLabel, 5)
DefaultPos:=t
IniWrite,%t%,VLCPowerTools.ini,Default,DefaultPos
t:=""
return


Profile_1:
Profile_2:
Profile_3:
Profile_4:
Profile_5:
t:=SubStr(A_ThisLabel, 9)
WinGetPos, tX, tY, tW, tH, ahk_exe vlc.exe
Temp:= tX "|" tY "|" tW "|" tH
if (tX!="") {
Pos_%t%:= tX "|" tY "|" tW "|" tH
IniWrite,%Temp%,VLCPowerTools.ini,Positons,Pos_%t%
}
Else
{
MsgBox, 16, VLC Not Found?, Cant get VLC Position from screen
}
return




Reloadlbl:
Reload
return

SaveCurrentPos:
WinGetPos, X, Y, W, H, ahk_exe vlc.exe
Temp:= X "|" Y "|" W "|" H
if (X!="") {

}

Return

Terminate:
ExitApp
return

F10::
DefaultPos:= (DefaultPos=5) ? 1 : DefaultPos+1
WinMove, ahk_exe vlc.exe,, strsplit(Pos_%DefaultPos%,"|")[1],strsplit(Pos_%DefaultPos%,"|")[2],strsplit(Pos_%DefaultPos%,"|")[3],strsplit(Pos_%DefaultPos%,"|")[4]
return

#If !WinActive("ahk_exe vlc.exe")
f6::

ControlSend,Qt5QWindowIcon7,^{h},ahk_exe vlc.exe
WinMove, ahk_exe vlc.exe,, strsplit(Pos_%DefaultPos%,"|")[1]-1,strsplit(Pos_%DefaultPos%,"|")[2],strsplit(Pos_%DefaultPos%,"|")[3]-1,strsplit(Pos_%DefaultPos%,"|")[4]
WinSet, Style,  ^0xC40000, ahk_exe vlc.exe
WinMove, ahk_exe vlc.exe,, strsplit(Pos_%DefaultPos%,"|")[1]+1,strsplit(Pos_%DefaultPos%,"|")[2],strsplit(Pos_%DefaultPos%,"|")[3]+1,strsplit(Pos_%DefaultPos%,"|")[4]

return
#if

#If WinActive("ahk_exe vlc.exe")
f6::

SendInput, ^h 
WinMove, ahk_exe vlc.exe,, strsplit(Pos_%DefaultPos%,"|")[1]-1,strsplit(Pos_%DefaultPos%,"|")[2],strsplit(Pos_%DefaultPos%,"|")[3]-1,strsplit(Pos_%DefaultPos%,"|")[4]
WinSet, Style,  ^0xC40000, ahk_exe vlc.exe
WinMove, ahk_exe vlc.exe,, strsplit(Pos_%DefaultPos%,"|")[1]+1,strsplit(Pos_%DefaultPos%,"|")[2],strsplit(Pos_%DefaultPos%,"|")[3]+1,strsplit(Pos_%DefaultPos%,"|")[4]
return
#if

#If (!WinActive("ahk_exe vlc.exe")) 
!Space::
F8:: ;Set your hotkey to play/pause here
ControlSend, ahk_parent, {Space}, ahk_exe firefox.exe
ControlSend,Qt5QWindowIcon7,{space},ahk_exe vlc.exe ;Send space to VLC player control
return

F9::
ControlSend,Qt5QWindowIcon7,+{Right},ahk_exe vlc.exe ;forward
ControlSend, ahk_parent, {Right}, ahk_exe firefox.exe
return

F7::
ControlSend, ahk_parent, {Left}, ahk_exe firefox.exe
ControlSend,Qt5QWindowIcon7,+{Left},ahk_exe vlc.exe ;backward
return
#if

#If WinActive("ahk_exe vlc.exe")
!Space::
F8::
SendInput, {Space}
return

F9::
SendInput, +{Right}
return

F7::
SendInput, +{Left}
return
#if

