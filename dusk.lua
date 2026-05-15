--[[
    Dusk - A rich text formatting library

    Author:   Praise Jacob <iampraisejacob@gmail.com>
    Repo:     https://github.com/felix-kyun/dusk

    SPDX-License-Identifier: MIT
    Copyright (c) 2026 Praise Jacob
]]

--- @class Dusk
--- @overload fun(...: string) string
--- @field reset 			Dusk
--- @field bold 			Dusk
--- @field dim 				Dusk
--- @field italic 			Dusk
--- @field overline 		Dusk
--- @field underline 		Dusk
--- @field blink 			Dusk
--- @field inverse 			Dusk
--- @field hidden 			Dusk
--- @field strikethrough 	Dusk
--- @field black 			Dusk
--- @field red 				Dusk
--- @field green 			Dusk
--- @field yellow 			Dusk
--- @field blue 			Dusk
--- @field magenta 			Dusk
--- @field cyan 			Dusk
--- @field white 			Dusk
--- @field gray 			Dusk
--- @field grey 			Dusk
--- @field blackBright 		Dusk
--- @field redBright 		Dusk
--- @field greenBright 		Dusk
--- @field yellowBright 	Dusk
--- @field blueBright 		Dusk
--- @field magentaBright 	Dusk
--- @field cyanBright 		Dusk
--- @field whiteBright 		Dusk
--- @field bgBlack 			Dusk
--- @field bgRed 			Dusk
--- @field bgGreen 			Dusk
--- @field bgYellow 		Dusk
--- @field bgBlue 			Dusk
--- @field bgMagenta 		Dusk
--- @field bgCyan 			Dusk
--- @field bgWhite 			Dusk
--- @field bgGray 			Dusk
--- @field bgGrey 			Dusk
--- @field bgBlackBright 	Dusk
--- @field bgRedBright 		Dusk
--- @field bgGreenBright 	Dusk
--- @field bgYellowBright 	Dusk
--- @field bgBlueBright 	Dusk
--- @field bgMagentaBright 	Dusk
--- @field bgCyanBright 	Dusk
--- @field bgWhiteBright 	Dusk
--- @field rgb 				fun(r: number, g: number, b: number): Dusk
--- @field bgRgb 			fun(r: number, g: number, b: number): Dusk
--- @field hex 				fun(color: string): Dusk
--- @field bgHex 			fun(color: string): Dusk
--- @field ansi 			fun(code: number): Dusk
--- @field bgAnsi 			fun(code: number): Dusk

--- @class Codeset
--- @field enable string
--- @field disable string

--- @param code number
--- @param disableCode? number
--- @return Codeset
local function mod(code, disableCode)
	assert(type(code) == "number")
	disableCode = disableCode or code + 20
	return {
		enable = ("\x1b[%dm"):format(code),
		disable = ("\x1b[%dm"):format(disableCode),
	}
end

--- @param code number
--- @return Codeset
local function fg(code)
	assert(type(code) == "number")
	return {
		enable = ("\x1b[%dm"):format(code),
		disable = "\x1b[39m",
	}
end

--- @param code number
--- @return Codeset
local function buildBg(code)
	assert(type(code) == "number")
	return {
		enable = ("\x1b[%dm"):format(code),
		disable = "\x1b[49m",
	}
end

--- @type table<string, (function | Codeset)>
local codes = {
	--- mods
	reset           = mod(0, 0),
	bold            = mod(1, 22),
	dim             = mod(2, 22),
	overline        = mod(53, 55),
	italic          = mod(3),
	underline       = mod(4),
	blink           = mod(5),
	inverse         = mod(7),
	hidden          = mod(8),
	strikethrough   = mod(9),

	--- fg
	black           = fg(30),
	red             = fg(31),
	green           = fg(32),
	yellow          = fg(33),
	blue            = fg(34),
	magenta         = fg(35),
	cyan            = fg(36),
	white           = fg(37),
	gray            = fg(90),
	grey            = fg(90),

	--- bright fg
	blackBright     = fg(90),
	redBright       = fg(91),
	greenBright     = fg(92),
	yellowBright    = fg(93),
	blueBright      = fg(94),
	magentaBright   = fg(95),
	cyanBright      = fg(96),
	whiteBright     = fg(97),

	--- bg
	bgBlack         = buildBg(40),
	bgRed           = buildBg(41),
	bgGreen         = buildBg(42),
	bgYellow        = buildBg(43),
	bgBlue          = buildBg(44),
	bgMagenta       = buildBg(45),
	bgCyan          = buildBg(46),
	bgWhite         = buildBg(47),
	bgGray          = buildBg(100),
	bgGrey          = buildBg(100),

	--- bright bg
	bgBlackBright   = buildBg(100),
	bgRedBright     = buildBg(101),
	bgGreenBright   = buildBg(102),
	bgYellowBright  = buildBg(103),
	bgBlueBright    = buildBg(104),
	bgMagentaBright = buildBg(105),
	bgCyanBright    = buildBg(106),
	bgWhiteBright   = buildBg(107),
}

--- shallow copy
local function copy(t)
	local result = {}
	for k, v in pairs(t) do
		result[k] = v
	end
	return result
end

--- validate rgb values
local function parseRgb(r, g, b)
	if (r == nil or g == nil or b == nil)
		or (r < 0 or g < 0 or b < 0)
		or (r > 255 or g > 255 or b > 255) then
		error(("Dusk: invalid rgb value (%d, %d, %d)"):format(r, g, b))
	end
	return true
end

--- fg rgb
function codes.rgb(collector)
	return function(r, g, b)
		local ok, ret = pcall(parseRgb, r, g, b)
		if not ok then
			error(ret)
			return collector
		end

		return collector + {
			enable = ("\x1b[38;2;%d;%d;%dm"):format(r, g, b),
			disable = "\x1b[39m"
		}
	end
end

--- bg rgb
function codes.bgRgb(collector)
	return function(r, g, b)
		local ok, ret = pcall(parseRgb, r, g, b)
		if not ok then
			error(ret)
			return collector
		end

		return collector + {
			enable = ("\x1b[48;2;%d;%d;%dm"):format(r, g, b),
			disable = "\x1b[49m"
		}
	end
end

--- validate hex values
local function parseHex(hex)
	local val = hex:gsub("^#", "")
	if (#val ~= 6) then
		error("Dusk: invalid hex value: " .. tostring(hex))
	end

	local rgb = {
		tonumber(val:sub(1, 2), 16),
		tonumber(val:sub(3, 4), 16),
		tonumber(val:sub(5, 6), 16),
	}

	local ok, ret = pcall(parseRgb, table.unpack(rgb))
	if not ok then
		error("Dusk: invalid hex value: " .. tostring(hex))
	end

	return rgb
end

function codes.hex(collector)
	return function(hex)
		local ok, ret = pcall(parseHex, hex)
		if not ok then
			error(ret)
			return collector
		end

		return collector + {
			enable = ("\x1b[38;2;%d;%d;%dm"):format(table.unpack(ret)),
			disable = "\x1b[39m"
		}
	end
end

function codes.bgHex(collector)
	return function(hex)
		local ok, ret = pcall(parseHex, hex)
		if not ok then
			error(ret)
			return collector
		end

		return collector + {
			enable = ("\x1b[48;2;%d;%d;%dm"):format(table.unpack(ret)),
			disable = "\x1b[49m"
		}
	end
end

local function parseAnsi(code)
	assert(type(code) == "number", "Dusk: expected number, got " .. type(code))
	assert(code >= 0 and code <= 255, "Dusk: expected ansi code in range 0-255, got " .. tostring(code))
	return code
end

function codes.ansi(collector)
	return function(code)
		local ok, err = pcall(parseAnsi, code)
		if not ok then
			error(err)
			return collector
		end

		return collector + {
			enable = ("\x1b[38;5;%dm"):format(code),
			disable = "\x1b[39m"
		}
	end
end

function codes.bgAnsi(collector)
	return function(code)
		local ok, err = pcall(parseAnsi, code)
		if not ok then
			error(err)
			return collector
		end

		return collector + {
			enable = ("\x1b[48;5;%dm"):format(code),
			disable = "\x1b[49m"
		}
	end
end

--- @type table<Dusk, Codeset>
local registry = setmetatable({}, {
	__mode = "k"
})

local dusk = setmetatable({}, {
	--- Creates a new collector with the style appended.
	--- @param collector Dusk
	--- @param key string
	--- @return Dusk
	__index = function(collector, key)
		if (type(key) == "number") then
			return rawget(collector, key)
		end

		if not codes[key] then
			error("Dusk: unknown style '" .. key .. "'")
			return collector
		end

		if type(codes[key]) == "function" then
			return codes[key](collector)
		end

		return collector + codes[key]
	end,

	--- Returns the styled string.
	--- @param collector Dusk
	--- @param ... string
	--- @return string
	__call = function(collector, ...)
		local target = table.concat(table.pack(...), " ")
		local codeset = registry[collector]
		return codeset.enable .. target .. codeset.disable
	end,

	--- Creates a new collector with the codeset.
	--- @param collector Dusk
	--- @param codeset { enable: string, disable: string }
	--- @return Dusk
	__add = function(collector, codeset)
		local newCollector = copy(collector)

		local oldCodeset = registry[collector]
		registry[newCollector] = {
			enable = oldCodeset.enable .. codeset.enable,
			disable = codeset.disable .. oldCodeset.disable,
		}

		return setmetatable(newCollector, getmetatable(collector))
	end,

}) --[[ @as Dusk ]]

registry[dusk] = { enable = "", disable = "" }
if os.getenv("ENV") == "test" then
	getmetatable(dusk)._internals = {
		codes = codes,
		registry = registry
	}
end
return dusk
