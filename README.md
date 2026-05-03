# dusk

A rich text formatting library for lua.

## Installation

The library can be installed using luarocks.

```bash
luarocks install dusk
```

## Usage

```lua
local d = require("dusk")

-- chain on the fly
print(d.red.bold("Hello, World!"))

-- store a style for reuse
local boldRed = d.red.bold
print(boldRed("Hii there"))

-- chain stored styles
print(boldRed.underline("I'm underlined"))
print(boldRed.strikethrough("I'm striked"))
```
