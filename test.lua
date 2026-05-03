local d = require("dusk")
local codes = getmetatable(d)._codes

-- multi chaining
assert(d.red.bold("test") == ""
	.. codes.red.open
	.. codes.bold.open
	.. "test"
	.. codes.bold.close
	.. codes.red.close,
	"multi chaining")

-- chain reuse
local redBold = d.red.bold
assert(redBold.strikethrough("test") == ""
	.. codes.red.open
	.. codes.bold.open
	.. codes.strikethrough.open
	.. "test"
	.. codes.strikethrough.close
	.. codes.bold.close
	.. codes.red.close,
	"chain reuse strikethrough")
assert(redBold.underline("test") == ""
	.. codes.red.open
	.. codes.bold.open
	.. codes.underline.open
	.. "test"
	.. codes.underline.close
	.. codes.bold.close
	.. codes.red.close,
	"chain reuse")
