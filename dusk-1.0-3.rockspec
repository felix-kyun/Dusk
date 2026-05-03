-- vim: ft=lua
package = "dusk"
version = "1.0-3"
source = {
	url = "https://github.com/felix-kyun/dusk.git"
}
description = {
	homepage = "https://github.com/felix-kyun/dusk",
	license = "MIT"
}
dependencies = {
}
build = {
	type = "builtin",
	modules = {
		dusk = "dusk.lua"
	}
}
