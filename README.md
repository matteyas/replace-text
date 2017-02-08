# replace-text
Simple AutoHotkey based text to symbol replacement.

## Installation instructions
1. Clone this repository
2. Run enable_replacements.cmd

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
hello, this line has no tab in it, so this is just a comment.
pi  π this will make any occurence of "pi" be replace with "π"! No quotes of course. Notice that this comment is separated by a tab, not a space.
derpmerp  merpderp  this looks quite different, but it follows the format so this will replace derpmerp with merpderp
```

Anything that does not follow this format in the replacement table will be ignored.

## Extra tools
### desktop_shortcut.cmd
Run this to script to create a shortcut on the desktop that points to the script
