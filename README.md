# replace-text
Simple AutoHotkey based text to symbol replacement.

## Installation instructions
1. Clone this repository
2. Run enable_replacements.cmd whenever you want to use the script

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
1. Press ctrl+shift+h

This will bring up the replacement table in notepad

## Replacement table format
The format in the replacement table is simple:
{text}{tab}{symbol}{optional tab}{optional comment}

Examples:
```
hello, this line has no tab in it, so it's ignored
pi  π this is an optional comment
derpmerp  merpderp
```

Anything in the replacement table that does not follow this format will be ignored.

## Extra tools
### desktop_shortcut.cmd
Run this to script to create a shortcut on the desktop that points to the script
