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
	reset           = { enable = "\27[0m", disable = "\27[0m" },
	bold            = { enable = "\27[1m", disable = "\27[22m" },
	dim             = { enable = "\27[2m", disable = "\27[22m" },
	italic          = { enable = "\27[3m", disable = "\27[23m" },
	underline       = { enable = "\27[4m", disable = "\27[24m" },
	blink           = { enable = "\27[5m", disable = "\27[25m" },
	inverse         = { enable = "\27[7m", disable = "\27[27m" },
	hidden          = { enable = "\27[8m", disable = "\27[28m" },
	strikethrough   = { enable = "\27[9m", disable = "\27[29m" },

	--- fg
	black           = { enable = "\27[30m", disable = "\27[39m" },
	red             = { enable = "\27[31m", disable = "\27[39m" },
	green           = { enable = "\27[32m", disable = "\27[39m" },
	yellow          = { enable = "\27[33m", disable = "\27[39m" },
	blue            = { enable = "\27[34m", disable = "\27[39m" },
	magenta         = { enable = "\27[35m", disable = "\27[39m" },
	cyan            = { enable = "\27[36m", disable = "\27[39m" },
	white           = { enable = "\27[37m", disable = "\27[39m" },
	gray            = { enable = "\27[90m", disable = "\27[39m" },
	grey            = { enable = "\27[90m", disable = "\27[39m" },

	--- bright fg
	blackBright     = { enable = "\27[90m", disable = "\27[39m" },
	redBright       = { enable = "\27[91m", disable = "\27[39m" },
	greenBright     = { enable = "\27[92m", disable = "\27[39m" },
	yellowBright    = { enable = "\27[93m", disable = "\27[39m" },
	blueBright      = { enable = "\27[94m", disable = "\27[39m" },
	magentaBright   = { enable = "\27[95m", disable = "\27[39m" },
	cyanBright      = { enable = "\27[96m", disable = "\27[39m" },
	whiteBright     = { enable = "\27[97m", disable = "\27[39m" },

	--- bg
	bgBlack         = { enable = "\27[40m", disable = "\27[49m" },
	bgRed           = { enable = "\27[41m", disable = "\27[49m" },
	bgGreen         = { enable = "\27[42m", disable = "\27[49m" },
	bgYellow        = { enable = "\27[43m", disable = "\27[49m" },
	bgBlue          = { enable = "\27[44m", disable = "\27[49m" },
	bgMagenta       = { enable = "\27[45m", disable = "\27[49m" },
	bgCyan          = { enable = "\27[46m", disable = "\27[49m" },
	bgWhite         = { enable = "\27[47m", disable = "\27[49m" },
	bgGray          = { enable = "\27[100m", disable = "\27[49m" },
	bgGrey          = { enable = "\27[100m", disable = "\27[49m" },

	--- bright bg
	bgBlackBright   = { enable = "\27[100m", disable = "\27[49m" },
	bgRedBright     = { enable = "\27[101m", disable = "\27[49m" },
	bgGreenBright   = { enable = "\27[102m", disable = "\27[49m" },
	bgYellowBright  = { enable = "\27[103m", disable = "\27[49m" },
	bgBlueBright    = { enable = "\27[104m", disable = "\27[49m" },
	bgMagentaBright = { enable = "\27[105m", disable = "\27[49m" },
	bgCyanBright    = { enable = "\27[106m", disable = "\27[49m" },
	bgWhiteBright   = { enable = "\27[107m", disable = "\27[49m" },
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
			enable = ("\27[38;2;%d;%d;%dm"):format(r, g, b),
			disable = "\27[39m"
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
			enable = ("\27[48;2;%d;%d;%dm"):format(r, g, b),
			disable = "\27[49m"
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
			enable = ("\27[38;2;%d;%d;%dm"):format(table.unpack(ret)),
			disable = "\27[39m"
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
			enable = ("\27[48;2;%d;%d;%dm"):format(table.unpack(ret)),
			disable = "\27[49m"
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
			enable = ("\27[38;5;%dm"):format(code),
			disable = "\27[39m"
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
			enable = ("\27[48;5;%dm"):format(code),
			disable = "\27[49m"
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
