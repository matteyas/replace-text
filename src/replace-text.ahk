;;; NOTES
;
; dictionary style arrays cannot be used, since this does not guarantee replacement order,
; which potentially messes up some replacements that overlap, e.g. <=> being replaced with
; ≤> instead of the expected ⇔
;
; this means indexed arrays are used, for ordering purposes, and a Tuple class is defined
; to hold find/replace pairs
;
;;;

#NoTrayIcon
#SingleInstance

;;; VARIABELS

; file with replacement definitions
fName = symbol_table.txt

; internal array used for replacements
table := Object()

; time of last modification to the symbol table
last_update := 18000102132435 ; (initialized to the past for first check)

;;;;;;;;;
return ;; INITIALIZATION COMPLETE
;;;;;;;;;

;;; CLASS DEFINITIONS
class Tuple
{
	item1 := ""
	item2 := ""

	__New(a, b)
	{
		this.item1 := a
		this.item2 := b
	}
}

class FindReplacePair extends Tuple
{
	find {
		get {
			return this.item1
		}
		set {
			return this.item1 := value
		}
	}
	replace {
		get {
			return this.item2
		}
		set {
			return this.item2 := value
		}
	}
}

;;; FUNCTION
; Clip from https://github.com/berban/Clip/blob/master/Clip.ahk
Clip(Text="", Reselect="")
{
	Static BackUpClip, Stored, LastClip
	If (A_ThisLabel = A_ThisFunc) {
		If (Clipboard == LastClip)
			Clipboard := BackUpClip
		BackUpClip := LastClip := Stored := ""
	} Else {
		If !Stored {
			Stored := True
			BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
		} Else
			SetTimer, %A_ThisFunc%, Off
		LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
		If (Text = "") {
			SendInput, ^c
			ClipWait, LongCopy ? 0.6 : 0.2, True
		} Else {
			Clipboard := LastClip := Text
			ClipWait, 10
			SendInput, ^v
		}
		SetTimer, %A_ThisFunc%, -700
		Sleep 20 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
		If (Text = "")
			Return LastClip := Clipboard
		Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
			SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
	}
	Return
	Clip:
	Return Clip()
}

;;; SUBROUTINE DEFINITIONS

; update replacement definitions from disk
update_replacements:
table := Object()

; load from symbol table
Loop, Read, %fName%
{
	; skip empty lines
	if (A_LoopReadLine = "")
		continue
	
	StringSplit, findrepl, A_LoopReadLine, %A_Tab%
	
	; skip any line without at least one tab
	if (findrepl0 < 2)
		continue

	; store the replacement
	t := new FindReplacePair(findrepl1, findrepl2)
	table.Push(t)
}

FileGetTime, last_update, %fName%, M
return

check_update_needed:
; latest modification date of symbol table
FileGetTime, update_needed, %fName%, M

; time subtraction with last *known* file modification
update_needed -= %last_update%, Seconds

; load the symbol table if necessary
if (update_needed > 0)
	Gosub, update_replacements

return

;;; SHORTCUT KEY DEFINITIONS

; shift+ctrl+c replace from text to symbols
^+c::
Gosub, check_update_needed

fetch_text := Clip()

loop % table.Length()
{
	fetch_text := StrReplace(fetch_text, table[A_Index].find, table[A_Index].replace)
}

Clip(fetch_text)

return

; shift+ctrl+z reverse replacement from symbols to text
^+z::
Gosub, check_update_needed

fetch_text := Clip()

; note, find/reverse reversal for inverse replacement
loop % table.Length()
{
	fetch_text := StrReplace(fetch_text, table[A_Index].replace, table[A_Index].find)
}

Clip(fetch_text)

return

; shift+ctrl+h open the symbol table
^+h::
Run, notepad %fName%
return
