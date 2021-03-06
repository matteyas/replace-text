;;; NOTES
; subroutines are used instead of functions, for easy access to vars from the outer scope
; the downside is one or two unnecessary global vars, less clean code
; the upside is simpler code, no byref passing to functions etc.
;
; dictionary style arrays cannot be used, since this does not guarantee replacement order,
; which potentially messes up some replacements that overlap, e.g. <=> being replaced with
; ≤> instead of the expected ⇔
;
; this means indexed arrays are used, for ordering purposes, and a Tuple class is defined
; to hold find/replace pairs
;
;;;

;;; VARIABELS

; file with replacement definitions
fName = symbol_table.txt

; internal array used for replacements
table := Object()

; time of last modification to the symbol table
last_update := 18000102132435 ; (initially set to 2nd jan 1800 at 13:24:35)

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

previous_clipboard := clipboard

; ctrl+c to copy highlighted text into memory (clipboard)
send ^c

; wait for clipboard to be ready
ClipWait, 1

loop % table.Length()
{
	clipboard := StrReplace(clipboard, table[A_Index].find, table[A_Index].replace)
}

; ctrl+v to replace highlighted text
send ^v

clipboard := previous_clipboard

return

; shift+ctrl+z replace from symbols to text, similar code as shift+ctrl+c above
^+z::
Gosub, check_update_needed
previous_clipboard := clipboard

send ^c

ClipWait, 1

; note, find/reverse reversal for inverse replacement
loop % table.Length()
{
	clipboard := StrReplace(clipboard, table[A_Index].replace, table[A_Index].find)
}

send ^v

clipboard := store_clipboard

return

; shift+ctrl+h open the symbol table
^+h::
Run, notepad %fName%
return