# replace-text
Simple AutoHotkey based text to symbol replacement.

## Installation instructions
1. Clone / download this repository
2. Run enable_replacements.cmd whenever you want to use the script

If you have AutoHotkey installed, the .ahk script will be used, otherwise the compiled binary will be used.
## Usage
First make sure that the script is running (see installation instructions)

### Replacement
1. Highlight some text for replacement, e.g. `\tau def= 2*\pi`
2. Press ctrl+shift+c

Result: `τ ≡ 2·π`

### Inverse replacement
1. Highlight some text for replacement, e.g. `λ(x) = x₀² + x₁²`
2. Press ctrl+shift+z

Result: `\l(x) = x_0^2 + x_1^2`

### Edit the replacement table
**WARNING: Make sure to save the replacement table with the correct encoding (Unicode) or some replacements will be irreversably lost.**

1. Press ctrl+shift+h

This will bring up the replacement table in notepad.

## Replacement table format
The format in the replacement table is simple:
{text}{tab}{symbol}{optional tab}{optional comment}

Anything in the replacement table that does not follow this format will be ignored.

Examples:
```
this line has no tab in it, so it's ignored
pi  π this is an optional comment
derpmerp  merpderp
```
The second line enables pi ↔ π replacement (this is supported with \pi in the supplied replacement table) and the third line enables derpmerp ↔ merpderp replacements.

## Extra tools
### desktop_shortcut.cmd
Run this to script to create a shortcut on the desktop that points to the replacement script
