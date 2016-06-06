local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

hotkey.bind(
	{ "cmd", "alt" },
	"Left",
	function()
		local win = window.focusedwindow()
		if win == nil then return end
		local frm = win:frame()
		local scr = win:screen()
		local scr_out = scr:fullframe()
		local scr_in = scr:frame()
		frm.x = scr_out.w - scr_in.w
		frm.y = scr_out.h - scr_in.h
		frm.h = scr_in.h
		frm.w = scr_in.w / 2
		win:setframe(frm)
	end
)

hotkey.bind(
	{ "cmd", "alt" },
	"Right",
	function()
		local win = window.focusedwindow()
		if win == nil then return end
		local frm = win:frame()
		local scr = win:screen()
		local scr_out = scr:fullframe()
		local scr_in = scr:frame()
		frm.x = (scr_in.w / 2) + (scr_out.w - scr_in.w)
		frm.y = scr_out.h - scr_in.h
		frm.h = scr_in.h
		frm.w = scr_in.w / 2
		win:setframe(frm)
	end
)

hotkey.bind(
	{ "cmd", "alt" },
	"Up",
	function()
		local win = window.focusedwindow()
		if win == nil then return end
		local frm = win:frame()
		local scr_in = win:screen():frame()
		win:setframe(scr_in)
	end
)
