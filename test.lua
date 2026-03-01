local d = require("Dusk")

-- multi chaining
assert(d.red.bold("test") == "\27[31m\27[1mtest\27[22m\27[39m", "multi chaining")

-- chain reuse
local redBold = d.red.bold
assert(redBold.underline("test") == "\27[31m\27[1m\27[4mtest\27[24m\27[22m\27[39m", "chain reuse underline")
assert(redBold("test") == "\27[31m\27[1mtest\27[22m\27[39m", "chain reuse")
