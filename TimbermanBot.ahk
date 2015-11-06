/**
 * @Author: Stuart Bannerman
 * @Date:   2015-08-17 10:05:03
 * @Last Modified by: Stuart Bannerman
 * @Last Modified time: 2015-09-20 82:15:12
 * @Repository: https://github.com/m3talstorm/TimbermanBot
 * @License: MIT
 * @Description: A bot written in AutoHotKey to play the game Timberman (http://store.steampowered.com/app/398710/)
 */


; Standard keybinds
+^R::Reload      ; Reloads Script: Control + Shift + R
+^P::Pause       ; (Un)Pauses  Script: Control + Shift + P
Ins::Suspend     ; Suspend Script: Insert
Esc::ExitApp     ; Exit the Script: Escape

; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv
; Stop multiple bots from running
#SingleInstance force
; Recommended for new scripts due to its superior speed and reliability.
SendMode Input
; Ensures a consistent starting directory.
SetWorkingDir %A_ScriptDir%
; Speed up script execution...hopefully: http://ahkscript.org/docs/commands/SetBatchLines.htm
SetBatchLines -1

; Control + Shift + Right mouse button
Enter::
    ; Get the pixel colour at the mouse position and saves it in the clipboard
    MouseGetPos Xpos, Ypos
    PixelGetColor Colour, %Xpos%, %Ypos%, RGB

    clipboard = %Xpos% %Ypos%

    return

; Space bar
Space::

    ; Toggle the Running boolean so we can use the same short cut as an on/off switch
    Running := !Running

    PixelGetColor original_left, 783, 634, RGB
    PixelGetColor original_right, 1137, 634, RGB

    lll := true
    delay := 125

    while Running
    {
        PixelGetColor current_left, 783, 634, RGB
        PixelGetColor current_right, 1137, 634, RGB

        if(lll)
        {
            if(current_left == original_left)
            {
                send {Left}
                sleep delay
            }
            else
            {
                lll := false
            }
        }
        else
        {
            if(current_right == original_right)
            {
                send {Right}
                sleep delay
            }
            else
            {
                lll := true
            }
        }

    }

    ; Set Running to false ready for the next run
    Running := false
    return
