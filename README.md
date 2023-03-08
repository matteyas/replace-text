# replace-text
Simple AutoHotkey based text replacement tool, using ctrl+shift+c. \
Easily configurable; comes with a pre-made symbol_table.txt that can be edited in any texteditor.

Using Unicode symbols, the pre-configured use cases work in most places on the internet these days, including forums, Twitter, messaging apps, etcetera.

Comes with about 100 preconfigured unicode replacements, but this can be used for any type of replacement, like enabling IMO ↔ in my opinion, and so on.

## Showcase
2⁻¹ + 2⁻² + 2⁻³ + 2⁻⁴ + ⋯ = 1 \
∃f : ∀n ∈ ℕ, f(n) ≥ 0 \
f ≡ (a,b) ↦ √(a² + b²) \
⌈a⌉ = ⌊a⌋ ⇔ a ∈ ℤ \
aₖ₊₁ = aₖ + aₖ₋₁ \
ᵢ₌₀∫ⁱ⁼¹ i² = 0.333… ≈ 0.333 \
✗❎✓✅🙂😉😀😆😂💩🤡 (more available, also, you can add your own from: https://unicode.org/emoji/charts/full-emoji-list.html)

## Installation instructions
✅ Clone / download this repository \
✅ Double-click enable_replacements.cmd

(You can run desktop_shortcut.cmd to create a shortcut on your desktop for easy access.)

When first running the text replacement tool, you'll get to configure whether you have AHK installed or not. Note that if you do not, it will run the compiled version of the script. This configuration is only done once (though can be reconfigured, by deleting the file firstrun.z, which gets created during configuration).

Note: The replacement tool will be enabled indefinitely, until you reboot the computer, or force close it from the task manager. It has no visible components.
## Usage
First make sure that the script is running (see installation instructions)

### Replacement
1. Highlight some text for replacement, e.g. `\tau \def 2\pi`
2. Press ctrl+shift+c

Result: `τ ≡ 2π`

### Inverse replacement
1. Highlight some text for replacement, e.g. `λ(x) = x₀² + x₁²`
2. Press ctrl+shift+z

Result: `\l(x) = x_0^2 + x_1^2`

### Edit the replacement table
**WARNING: Make sure to save the replacement table with the correct encoding (unicode) or some replacements will be irreversably lost.**

1. Press ctrl+shift+h

This will bring up the replacement table in notepad.

## Replacement table format
The format in the replacement table is simple:
{text}{tab}{replacement}{optional tab}{optional comment}

Anything in the replacement table that does not follow this format will be ignored.

Examples of replacement table:
```
this line has no tab in it, so it's ignored
pi  π this is an optional comment
derpmerp  merpderp
```
The second line enables pi ↔ π replacement (this is supported with \pi in the pre-made replacement table) and the third line enables derpmerp ↔ merpderp replacements.

## Extra tools
### desktop_shortcut.cmd
Run this to script to create a shortcut on the desktop that points to the replacement script
