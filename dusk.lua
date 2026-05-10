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

--- @class Codeset
--- @field enable string
--- @field disable string

--- @type table<string, (function | Codeset)>
local codes = {
	--- mods
	reset           = { enable = "\x1b[0m", disable = "\x1b[0m" },
	bold            = { enable = "\x1b[1m", disable = "\x1b[22m" },
	dim             = { enable = "\x1b[2m", disable = "\x1b[22m" },
	italic          = { enable = "\x1b[3m", disable = "\x1b[23m" },
	underline       = { enable = "\x1b[4m", disable = "\x1b[24m" },
	blink           = { enable = "\x1b[5m", disable = "\x1b[25m" },
	inverse         = { enable = "\x1b[7m", disable = "\x1b[27m" },
	hidden          = { enable = "\x1b[8m", disable = "\x1b[28m" },
	strikethrough   = { enable = "\x1b[9m", disable = "\x1b[29m" },

	--- fg
	black           = { enable = "\x1b[30m", disable = "\x1b[39m" },
	red             = { enable = "\x1b[31m", disable = "\x1b[39m" },
	green           = { enable = "\x1b[32m", disable = "\x1b[39m" },
	yellow          = { enable = "\x1b[33m", disable = "\x1b[39m" },
	blue            = { enable = "\x1b[34m", disable = "\x1b[39m" },
	magenta         = { enable = "\x1b[35m", disable = "\x1b[39m" },
	cyan            = { enable = "\x1b[36m", disable = "\x1b[39m" },
	white           = { enable = "\x1b[37m", disable = "\x1b[39m" },
	gray            = { enable = "\x1b[90m", disable = "\x1b[39m" },
	grey            = { enable = "\x1b[90m", disable = "\x1b[39m" },

	--- bright fg
	blackBright     = { enable = "\x1b[90m", disable = "\x1b[39m" },
	redBright       = { enable = "\x1b[91m", disable = "\x1b[39m" },
	greenBright     = { enable = "\x1b[92m", disable = "\x1b[39m" },
	yellowBright    = { enable = "\x1b[93m", disable = "\x1b[39m" },
	blueBright      = { enable = "\x1b[94m", disable = "\x1b[39m" },
	magentaBright   = { enable = "\x1b[95m", disable = "\x1b[39m" },
	cyanBright      = { enable = "\x1b[96m", disable = "\x1b[39m" },
	whiteBright     = { enable = "\x1b[97m", disable = "\x1b[39m" },

	--- bg
	bgBlack         = { enable = "\x1b[40m", disable = "\x1b[49m" },
	bgRed           = { enable = "\x1b[41m", disable = "\x1b[49m" },
	bgGreen         = { enable = "\x1b[42m", disable = "\x1b[49m" },
	bgYellow        = { enable = "\x1b[43m", disable = "\x1b[49m" },
	bgBlue          = { enable = "\x1b[44m", disable = "\x1b[49m" },
	bgMagenta       = { enable = "\x1b[45m", disable = "\x1b[49m" },
	bgCyan          = { enable = "\x1b[46m", disable = "\x1b[49m" },
	bgWhite         = { enable = "\x1b[47m", disable = "\x1b[49m" },
	bgGray          = { enable = "\x1b[100m", disable = "\x1b[49m" },
	bgGrey          = { enable = "\x1b[100m", disable = "\x1b[49m" },

	--- bright bg
	bgBlackBright   = { enable = "\x1b[100m", disable = "\x1b[49m" },
	bgRedBright     = { enable = "\x1b[101m", disable = "\x1b[49m" },
	bgGreenBright   = { enable = "\x1b[102m", disable = "\x1b[49m" },
	bgYellowBright  = { enable = "\x1b[103m", disable = "\x1b[49m" },
	bgBlueBright    = { enable = "\x1b[104m", disable = "\x1b[49m" },
	bgMagentaBright = { enable = "\x1b[105m", disable = "\x1b[49m" },
	bgCyanBright    = { enable = "\x1b[106m", disable = "\x1b[49m" },
	bgWhiteBright   = { enable = "\x1b[107m", disable = "\x1b[49m" },
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

return setmetatable({}, {

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
		local open, close = "", ""
		local target = table.concat(table.pack(...), " ")

		for _, code in ipairs(collector) do
			open = open .. code.enable
			close = code.disable .. close
		end

		return open .. target .. close
	end,

	--- Creates a new collector with the codeset.
	--- @param collector Dusk
	--- @param codeset { enable: string, disable: string }
	--- @return Dusk
	__add = function(collector, codeset)
		local newCollector = copy(collector)
		newCollector[#newCollector + 1] = codeset
		return setmetatable(newCollector, getmetatable(collector))
	end,

	--- For testing
	_codes = setmetatable({}, {
		__index = codes,
		__newindex = function(t, k, v)
			error("Dusk: Can't modify code table")
		end
	})
}) --[[ @as Dusk ]]

--- todo
--- strip
--- seperate metafield for storing codes
