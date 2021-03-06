-------------------------------------------------------------------------------
-- LuaDoc main function.
-- @release $Id: init.lua,v 1.4 2008/02/17 06:42:51 jasonsantos Exp $
-------------------------------------------------------------------------------

local require, pairs, string = require, pairs, string

local util = require "luadoc.util"

logger = {}

module ("luadoc")

-------------------------------------------------------------------------------
-- LuaDoc version number.

_COPYRIGHT = "Copyright (c) 2003-2007 The Kepler Project"
_DESCRIPTION = "Documentation Generator Tool for the Lua language"
_VERSION = "LuaDoc 3.1.0"

-------------------------------------------------------------------------------
-- Main function
-- @see luadoc.doclet.html, luadoc.doclet.formatter, luadoc.doclet.raw
-- @see luadoc.taglet.standard

function main (files, options)
	logger = util.loadlogengine(options)

	-- load config file
	if options.config ~= nil then
		-- load specified config file
		dofile(options.config)
	else
		-- load default config file
		require("luadoc.config")
	end

	local taglet = require(options.taglet)
	local doclet = require(options.doclet)

    -- fix bad windows paths (mix of / and \ in a path)
    -- standardize on forward slash
    if util.iswindows then
        for k, v in pairs(files) do
            files[k] = string.gsub(v, "\\", "/")
        end
    end

	-- analyze input
	taglet.options = options
	taglet.logger = logger
	local doc = taglet.start(files)

	-- generate output
	doclet.options = options
	doclet.logger = logger
	doclet.start(doc)
end
